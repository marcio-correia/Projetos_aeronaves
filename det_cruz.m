function[Wf,v]=det_cruz(aircraft)
x=0.97*0.985*0.995; %Definir porcentagens de dim. de massa devido ao gasto de combustivel
R=aircraft.gen.range*6076.12; %ft
v=aircraft.aero.Vcruz*0.514; %m/s
h=aircraft.gen.hcruz*0.3048; %m 
[CD1,CL1]=aerodynamics(aircraft,v,h,aircraft.gen.Wo*0.97*0.985*0.453592);

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
v=v/0.514*1.68781; %ft/s - velocidade optimo cruzeiro

C=0.4*v/(550*aircraft.prop.BladeEf*3600);
f=exp(-R*C/(v*CL1/CD1.total));
f=inv(f);
Wf=aircraft.gen.Wo*(1-x/f);

Eloiter=1.14*(R/v);




end