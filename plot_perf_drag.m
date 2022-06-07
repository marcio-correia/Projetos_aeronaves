% main
V=aircraft.aero.Vstall/1.94384:1:aircraft.aero.Vmax/1.94384;
CDt=[];
CDi=[];
CD0=[];
for i=1:length(V)
    cd=aerodynamics(aircraft,V(i),0);
    CDt=[CDt cd.total];
    CDi=[CDi cd.induced];
    CD0=[CD0 cd.total-cd.induced];
end
figure
plot(V,0.5*V.^2.*CDt*aircraft.aero.wing.S*1.224,'LineWidth',1)
hold on
plot(V,0.5*V.^2.*CDi*aircraft.aero.wing.S*1.224,'LineWidth',1)
plot(V,0.5*V.^2.*CD0*aircraft.aero.wing.S*1.224,'LineWidth',1)
grid minor
xlabel('Velocidade [m/s]')
ylabel('Drag [N]')
legend('D Total','D Induzido','Drag0')