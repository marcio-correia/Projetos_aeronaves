%% Aircraft Data

%% General
aircraft.gen.Wo=2805.8; %lb
aircraft.gen.altitude=0; %ft - DECOLAGEM
aircraft.gen.mu=1.5e-6;
aircraft.gen.Lf=25.32765; %ft
aircraft.gen.Dfmax=5.249; %ft
aircraft.gen.fuelRate=0.197; %wf/wo
aircraft.gen.LGHeight=2.625; %ft
aircraft.gen.payload=400; %lb (2 passageiros (340 lbf) + bagagens (60 lbf))
aircraft.gen.rho_mat=169.2422; %lb/ft3
aircraft.gen.range=661.16; %nm
% aircraft.gen.hcruz=0.85*17500; %ft
aircraft.gen.hcruz=14000; %ft
aircraft.gen.razsub=9.15; %m/s

% aircraft.gen.mu=


%% Aerodynamics
%General
aircraft.aero.fact_cor=0.8225;
% aircraft.aero.Vstall=51.57; %knots
aircraft.aero.Vstall=63.95; %knots
aircraft.aero.Vcruz=134.1; %knots
aircraft.aero.Vmax=160.9; %knots
aircraft.aero.CLmax_flap=2.1;


%Wing
aircraft.aero.wing.AR=7.37; %7.37
aircraft.aero.wing.taper=0.5;
aircraft.aero.wing.S=0; %m2
aircraft.aero.wing.b=0; %m
aircraft.aero.wing.Cr=0; %m
aircraft.aero.wing.Ct=0; %m
aircraft.aero.wing.MAC=0; %m
aircraft.aero.wing.prof.tc_max=0.12;
aircraft.aero.wing.prof.xc_max=0.23;
aircraft.aero.wing.Enfl=0; %deg.
% aircraft.aero.wing.prof.CL=

%Horizontal Tail
aircraft.aero.Htail.cht=0.7;
aircraft.aero.Htail.Lht=4.17; %m
aircraft.aero.Htail.AR=4;
aircraft.aero.Htail.taper=0.5;
aircraft.aero.Htail.S=0; %m2
aircraft.aero.Htail.b=0; %m
aircraft.aero.Htail.Cr=0; %m
aircraft.aero.Htail.Ct=0; %m
aircraft.aero.Htail.MAC=0; %m
aircraft.aero.Htail.prof.tc_max=0.12;
aircraft.aero.Htail.prof.xc_max=0.23;

%Vertical Tail
aircraft.aero.Vtail.cvt=0.04;
aircraft.aero.Vtail.Lvt=4.42; %m
aircraft.aero.Vtail.AR=2;
aircraft.aero.Vtail.taper=0.5;
aircraft.aero.Vtail.S=0; %m2
aircraft.aero.Vtail.b=0; %m
aircraft.aero.Vtail.Cr=0; %m
aircraft.aero.Vtail.Ct=0; %m
aircraft.aero.Vtail.MAC=0; %m
aircraft.aero.Vtail.prof.tc_max=0.12;
aircraft.aero.Vtail.prof.xc_max=0.23;
%% Propulsão
aircraft.prop.MotorWeight=446; %lb
aircraft.prop.FuelDensity=43.9; %lb/ft3
aircraft.prop.BladeEf=0.667;
aircraft.prop.Pot=315; %hp
aircraft.prop.RPM = 2700; 
% aircraft.prop.MaxT=aircraft.prop.Pot*745.7/(aircraft.aero.Vmax*0.514); %N


%% Position
aircraft.pos.wing = 11; %ft
aircraft.pos.fuselage = 13; %ft
aircraft.pos.Htail = 23; %ft
aircraft.pos.Vtail = 23; %ft
aircraft.pos.LandingGear = 9; %ft
aircraft.pos.motor_ins = 1; %ft
aircraft.pos.systems = 10; %ft
aircraft.pos.misc = 10; %ft
aircraft.pos.Wf = 11; %ft fuel
aircraft.pos.passenger = 11; %ft

%% Mission
% aircraft.mission= ;


