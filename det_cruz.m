function[Wf]=det_cruz(aircraft,CD,CL)
x=0.97*0.985*0.995; %Definir porcentagens de dim. de massa devido ao gasto de combustivel
R=aircraft.gen.range*6076.12;
V=aircraft.aero.Vcruz*1.68781;

C=0.4*V/(550*aircraft.prop.BladeEf*3600);

f=exp(-R*C/(V*CL/CD.total));
f=inv(f);
Wf=aircraft.gen.Wo*(1-x/f);




end