%% Main

function performance(aircraft)
    %Decolagem
    decolagem(aircraft)
    %Subida
    perf.asc = subida(aircraft,perf);
    %Cruzeiro
    perf.cruz = cruzeiro(aircraft,perf);
    %Descida
    perf.desc = descida(aircraft,perf)
    %Loiter
    perf.loit = loiter(aircraft,perf)
    %Pouso
    perf.pous = pouso(aircraft,perf)

end

%% Usefull Functions

function [Wf,vc] = det_vcruz(aircraft,h,w)
    R=aircraft.gen.range*6076.12; %ft
    v=aircraft.aero.Vcruz*0.514; %m/s
    [CD1,CL1]=aerodynamics(aircraft,v,h,w);

    tol=1e-1;
    erro=10;
    ak=aircraft.aero.Vstall*0.514; %m/s
    bk=aircraft.aero.Vmax*0.514; %m/s
    phi=1.618;
    i=0;
    while erro>tol
        ck=ak+1/phi^2*(bk-ak);
        dk=ak+1/phi*(bk-ak);
        [CD1,CL1]=aerodynamics(aircraft,ck,h,aircraft.gen.Wo*0.97*0.985*0.453592);
        [CD2,CL2]=aerodynamics(aircraft,dk,h,aircraft.gen.Wo*0.97*0.985*0.453592);
        erro=(bk-ak)/(abs(ck)+abs(dk));
        if CD1.total/CL1 > CD2.total/CL2
            ak=ck;
            v=(ck+bk)/2;
        else
            bk=dk;
            v=(ak+dk)/2;
        end
        i=i+1;
    end
    vc=v;
    v=v/0.514*1.68781; %ft/s - velocidade optimo cruzeiro

    C=0.4*v/(550*aircraft.prop.BladeEf*3600);
    f=exp(-R*C/(v*CL1/CD1.total));   
    Wf=w-w*f;
end

function [h_dot,va] = det_hdot(aircraft,h,w)
    v=aircraft.aero.Vstall*0.514;
    S=aircraft.aero.wing.S;
    [~,~,~,rho]=atmosisa(h);
    ak=v;
    bk=aircraft.aero.Vmax*0.514;
    phi=1.618;
    erro=10;
    tol=1e-1;
    i=0;
    while erro>tol
        ck=ak+1/phi^2*(bk-ak);
        dk=ak+1/phi*(bk-ak);
        [CD1,~]=aerodynamics(aircraft,ck,h,w);
        [CD2,~]=aerodynamics(aircraft,dk,h,w);
        erro=(bk-ak)/(abs(ck)+abs(dk));
        if ck^2*CD1.total > dk^2*CD2.total
            ak=ck;
            v=(ck+bk)/2;
        else
            bk=dk;
            v=(ak+dk)/2;
        end
        i=i+1;
    end
    if v>aircraft.aero.Vmax
        v=aircraft.aero.Vmax;
    end
    D=0.5*rho*v^2*CD1.total*S;
    HP_avai = HP_disp(aircraft,v,h/0.3048);
    Ta=HP_avai*745.7/v;
    lamb=(Ta-D)/(w*9.81);
    h_dot=v*lamb;
    va=v;
end

function w_dot = det_wdot(aircraft,h,v,T)
    P_disp = HP_disp(aircraft, v, h/0.3048);
    eta_p=P_disp/aircraft.prop.Pot;
    Cbhp = 0.068; %Raymer Table 3.4
    SFC=Cbhp*v/(550*eta_p);
    w_dot=T*SFC;

end

%% Mission Profile Calc

function decolagem(aircraft)




end

function asc = subida(aircraft,perf)
    n=length(perf.dec.x);
    x=perf.dec.x(n);
    t=perf.dec.t(n);
    h=perf.dec.h(n);
    w=perf.dec.w(n);
    v=perf.dec.v(n);
    dt=1;
    i=1;
    while h(i)<aircraft.gen.hcruz*0.3048
        [h_dot,va] = det_hdot(aircraft,h(i)/0.3048,w(i));
        T=HP_disp(aircraft, va, h(i));
        w_dot = det_wdot(aircraft,h,v,T);
        h=[h h(i)+dt*h_dot];
        v=[v va];
        t=[t t(i)+dt];
        x=[x x(i)+dt*v(i)];
        w=[w w(i)-dt*w_dot];   
        i=i+1;
    end
   asc.x=x;
   asc.t=t;
   asc.v=v;
   asc.h=h;
   asc.w=w;
end

function cruz = cruzeiro(aircraft,perf)
    n=length(perf.asc.x);
    [Wf,vc]=det_cruz(aircraft);
    cruz.x=[perf.asc.x(n) perf.asc.x(n)+aircraft.gen.range*1852];
    cruz.t=[perf.asc.t(n) perf.asc.t(n)+aircraft.gen.range*1852/vc];
    cruz.vc=[vc vc];
    cruz.h=[aircraft.gen.hcruz*0.3048 aircraft.gen.hcruz*0.3048];
    cruz.w=[perf.asc.w(n) perf.asc.w(n)-Wf];
end

function desc = descida(aircraft,perf)

end

function loit = loiter(aircraft,perf)
    tol=1e-1;
    erro=10;
    ak=aircraft.aero.Vstall*0.514; %m/s
    bk=aircraft.aero.Vmax*0.514; %m/s
    phi=1.618;
    i=0;
    while erro>tol
        ck=ak+1/phi^2*(bk-ak);
        dk=ak+1/phi*(bk-ak);
        [CD1,CL1]=aerodynamics(aircraft,ck,h,aircraft.gen.Wo*0.97*0.985*0.453592);
        [CD2,CL2]=aerodynamics(aircraft,dk,h,aircraft.gen.Wo*0.97*0.985*0.453592);
        erro=(bk-ak)/(abs(ck)+abs(dk));
        if CD1.total/CL1 > CD2.total/CL2
            ak=ck;
            v=(ck+bk)/2;
        else
            bk=dk;
            v=(ak+dk)/2;
        end
        i=i+1;
    end
    vc=v;
    v=v/0.514*1.68781; %ft/s - velocidade optimo cruzeiro

    C=0.4*v/(550*aircraft.prop.BladeEf*3600);
    Eloiter=1.14*(aircraft.gen.range*1852/perf.cruz.v(1));
    f_loi=exp(-Eloiter*C/LD);
    Wf=w-w*f;
end

function pous = pouso(aircraft,perf)

end
