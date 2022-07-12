main
W=aircraft.gen.Wo*0.454;
S=aircraft.aero.wing.S;

Vmax=aircraft.aero.Vmax*0.514;
v=1.3*aircraft.aero.Vstall*0.514;
t=0;
dt=1;
i=1;
x=0;
tol=1e-1;
hmax=10000;
h_dot=[];
lamb_data=[];
for h=0:100:hmax
    dCD=10;
    [~,~,~,rho]=atmosisa(h);
    ak=v;
    bk=Vmax;
    phi=1.618;
    erro=10;
    i=0;
    while erro>tol
        ck=ak+1/phi^2*(bk-ak);
        dk=ak+1/phi*(bk-ak);
        [CD1,~]=aerodynamics(aircraft,ck,h,W);
        [CD2,~]=aerodynamics(aircraft,dk,h,W);
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
%     if v>aircraft.aero.Vmax
%         v=aircraft.aero.Vmax*0.514;
%     end
    D=0.5*rho*v^2*CD1.total*S
    HP_avai = HP_disp(aircraft,v,h/0.3048);
    Ta=HP_avai*745.7/v
    lamb=(Ta-D)/(W*9.81);
%     lamb=h_dot/v;
%     Treq=W*lamb+D;
    h_dot=[h_dot v*lamb];
    lamb_data=[lamb_data lamb];
%     v_dot=Treq/W;
%     t=t+dt;
%     h=h_dot*dt+h;
%     v=v_dot*dt+v;
% %     m_dot=
% %     W=W-m_dot*dt;
% %     if v>Vmax
% %         v=Vmax;
% %     end
%     i=i+1;
%     x=v*dt+x;
%     info=[t;h;v;x;Treq];
%     data=[data info];
end
figure
plot(0:100:hmax,h_dot,'LineWidth',1)
ylabel('Razão de Subida [m/s]')
xlabel('Altitude [m]')
grid minor

figure
plot(0:100:hmax,lamb_data*180/pi,'LineWidth',1)
ylabel('Ângulo de Subida [º]')
xlabel('Altitude [m]')
grid minor