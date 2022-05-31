function[weights] = det_weight(aircraft)
%% Wing
S=aircraft.aero.wing.S*10.7639; %ft2
MAC=aircraft.aero.wing.MAC/0.3048; %ft
tc_max=0.12;
rho_mat=aircraft.gen.rho_mat; %lb/ft3
Kp=0.0016;
AR=aircraft.aero.wing.AR;
n_ult=6;
Enfl=0;
taper=aircraft.aero.wing.taper;

weights.wing=S*MAC*tc_max*rho_mat*Kp*(AR*n_ult/cos(Enfl))^0.6*taper^0.04;

%% Fuselage
Lf=aircraft.gen.Lf;
Dfmax=aircraft.gen.Dfmax;
Kpf=0.0025;
n_ult=6;
Kinlet=1.25;

weights.fuselage=Lf*Dfmax^2*rho_mat*Kpf*n_ult^0.25*Kinlet;
%% Horizontal Tail
Sht=aircraft.aero.Htail.S*10.7639;
MACht=aircraft.aero.Htail.MAC/0.3048;
tc_maxht=0.12;
Kpht=0.025;
ARht=aircraft.aero.Htail.AR;
Enflht=0;
lambht=aircraft.aero.Htail.taper;
Vh=aircraft.aero.Htail.cht;
Ce=1;
CT=1;

weights.Htail=Sht*MACht*tc_maxht*rho_mat*Kpht*(ARht/(cos(Enflht)))^0.6*lambht^0.04*Vh^0.3*(Ce/CT)^0.4;
%% Vertical Tail
Svt=aircraft.aero.Vtail.S*10.7639;
MACvt=aircraft.aero.Vtail.MAC/0.3048;
tc_maxvt=0.12;
Kpvt=0.0715;
ARvt=aircraft.aero.Vtail.AR;
Enflvt=0;
lambvt=aircraft.aero.Vtail.taper;
Vv=aircraft.aero.Vtail.cvt;
Cr=1;
Cv=1;

weights.Vtail=Svt*MACvt*tc_maxvt*rho_mat*Kpvt*(ARvt/(cos(Enflvt)))^0.6*lambvt^0.04*Vv^0.2*(Cr/Cv)^0.4;

%% Landing Gear
KL=1;
Kret=1.07;
KLG=0.55;
WL=(1-aircraft.gen.fuelRate)/0.995*aircraft.gen.Wo; %lb
HLG=aircraft.gen.LGHeight;
b=aircraft.aero.wing.b/0.3048; %ft 
n_ult_land=1;

weights.LandingGear = KL*Kret*KLG*WL*HLG/b*n_ult_land^2;
%% Motor
KE=2.6;
NE=1;
WE=aircraft.prop.MotorWeight;

weights.motor_ins = KE*NE*WE^0.9;

%% Sists
Kfs=2;
Wfuel=aircraft.gen.Wo*aircraft.gen.fuelRate;
rho_f=aircraft.prop.FuelDensity;
n_fs=aircraft.prop.BladeEf;

weights.systems=Kfs*(Wfuel/rho_f)^n_fs;
%% Misc
weights.misc=54;


%% Total
weights.We=weights.fuselage+weights.Htail+weights.LandingGear+weights.motor_ins+weights.systems+weights.Vtail+weights.wing+weights.misc;
weights.Wf=weights.We*aircraft.gen.fuelRate;
weights.Wo=weights.We+weights.Wf+aircraft.gen.payload;


end