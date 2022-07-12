function[CD,CL]=aerodynamics(aircraft,V,h,w)

Sref=aircraft.aero.wing.S;
[rho,a,~,~,~,~,~] = atmos( h );
M=V/a;
% beta=sqrt(1-M^2);

%% Wing
xcw=aircraft.aero.wing.prof.xc_max;
tcw=aircraft.aero.wing.prof.tc_max;
Lref=aircraft.aero.wing.MAC;
[~,~,Cf]=Cffric(aircraft,Lref,V,h);

Sexp=Sref*0.9; %Como tirar área exposta a patir da de referencia? Checar Croqui.

if tcw<0.05
    Swet=2.003*Sexp;
else
    Swet=Sexp*(1.977+0.52*tcw);
end

Enflm=aircraft.aero.wing.Enfl;

FF=(1+0.6/(xcw)*tcw+100*tcw^4)*(1.34*M^0.18*(cos(Enflm))^0.28);
Qc=1.25; %???

CD.wing=Cf*FF*Qc*Swet/Sref;

%% Fuselage
Lref=aircraft.gen.Lf;
Amax=pi*(aircraft.gen.Dfmax/2)^2; %Tirar do Croqui, aproximação usando Max Dim
f=Lref/sqrt(4/pi*Amax);

[~,~,Cf]=Cffric(aircraft,Lref,V,h);
FF=(0.9+5/f^1.5+f/400);
Swet=3.4*(2.5*Sref+3*Sref)/2;
Qc=1;

CD.fus=Cf*FF*Qc*Swet/Sref;
%% Horizontal Tail
xcw=aircraft.aero.Htail.prof.xc_max;
tcw=aircraft.aero.Htail.prof.tc_max;
Lref=aircraft.aero.Htail.MAC;
[~,~,Cf]=Cffric(aircraft,Lref,V,h);

Sexp=aircraft.aero.Htail.S*0.9; %Como tirar área exposta a patir da de referencia? Checar Croqui.

if tcw<0.05
    Swet=2.003*Sexp;
else
    Swet=Sexp*(1.977+0.52*tcw);
end

Enflm=0;

FF=(1+0.6/(xcw)*tcw+100*tcw^4)*(1.34*M^0.18*(cos(Enflm))^0.28);
Qc=1.05;

CD.Htail=Cf*FF*Qc*Swet/Sref;

%% Vertical Tail
xcw=aircraft.aero.Vtail.prof.xc_max;
tcw=aircraft.aero.Vtail.prof.tc_max;
Lref=aircraft.aero.Vtail.MAC;
[~,~,Cf]=Cffric(aircraft,Lref,V,h);

Sexp=aircraft.aero.Vtail.S*0.9; %Como tirar área exposta a patir da de referencia? Checar Croqui.

if tcw<0.05
    Swet=2.003*Sexp;
else
    Swet=Sexp*(1.977+0.52*tcw);
end

Enflm=0;

FF=(1+0.6/(xcw)*tcw+100*tcw^4)*(1.34*M^0.18*(cos(Enflm))^0.28);
Qc=1.05;

CD.Vtail=Cf*FF*Qc*Swet/Sref;
%% Miscelaneous


CD.misc=0; %VERIFICAR!!

%% Induced Drag
EnfLE=atan((aircraft.aero.wing.Cr+aircraft.aero.wing.Ct)/aircraft.aero.wing.b);
e=4.61*(1-0.045*aircraft.aero.wing.AR^0.68)*(cos(EnfLE))^0.15-3.1;
CL=w*9.81/(0.5*rho*V^2*Sref);
CD.induced=CL^2/(pi*e*aircraft.aero.wing.AR);

if CL > aircraft.aero.CLmax_flap
    CL
    V
    h  
%     return
end

%% Total
CD.total=CD.wing+CD.fus+CD.Htail+CD.Vtail+CD.induced+CD.misc;



end