WS=1000:1:2500;

%% Decolagem
beta=0.97;
Kto=1.2;
alpha=1;
Sg=400;
g=9.81;
[rho,~,~,~,~,~,~] = atmos(0);
CLmax=aircraft.aero.CLmax_flap;

TWdec=beta^2*Kto^2/(alpha*Sg*g*rho*CLmax)*WS;

figure
plot(WS,TWdec,'LineWidth',1)
hold on
%% Climb
beta=0.97*0.985;
V=1.3*aircraft.aero.Vstall;
[rho,~,~,~,~,~,~] = atmos(0);
[CD,CL]=aerodynamics(aircraft,V,0);
alpha=0.8;
CD0=CD.total-CD.induced;
q=0.5*rho*V^2;
k1=CD.induced/(CL^2);

dhdt=9.15;

TWCli=beta/alpha*(CD0./(beta/q*WS)+k1*beta/q*WS+1/V*dhdt);


plot(WS,TWCli,'LineWidth',1)
%% Cruzeiro
beta=(1-aircraft.gen.fuelRate)/0.995;
alpha=0.42;
V=aircraft.aero.Vcruz;
[rho,~,~,~,~,~,~] = atmos(aircraft.gen.hcruz);
q=0.5*rho*V^2;
CD0=aircraft.aero.CD.total-aircraft.aero.CD.induced;
k1=aircraft.aero.CD.induced/(aircraft.aero.CL^2);

TWcruz=beta/alpha*(CD0./(beta/q*WS)+k1*beta/q*WS);
plot(WS,TWcruz,'LineWidth',1)
%% Pouso
beta=1-aircraft.gen.fuelRate;
mu=0.3;
Kto=1.3;
g=9.81;
[rho,~,~,~,~,~,~] = atmos(0);
CLmax=aircraft.aero.CLmax_flap;

TWpos=beta*Kto^2/(mu*g*rho*CLmax)*100;
% plot(WS,TWpos)
TW_aircraft=aircraft.prop.Pot*745.7/(aircraft.aero.Vmax*0.514)/(9.81*aircraft.gen.Wo*0.454);
WS_aircraft=9.81*aircraft.gen.Wo*0.454/aircraft.aero.wing.S;
plot(WS_aircraft,TW_aircraft,'*')
grid minor
xlabel('Carga Alar [N/m²]')
ylabel('Tração/Peso')
legend('Decolagem','Climb','Cruzeiro','Aircraft')

