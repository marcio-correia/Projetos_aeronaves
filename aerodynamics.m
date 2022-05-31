function[CD]=aerodynamics(aircraft)
CD.misc;
CD.LeP;
CD.wing;
CD.tail;
CD.fuselage;

[R,Rcorte,Cf]=Cffric(aircraft,Lref,V);
%% Wing
Lref=aircraft.aero.wing.MAC;
[R,Rcorte,Cf]=Cffric(aircraft,Lref,V);
FF=(1+0.6/(xcm)*tc+100*tc^4)*(1.34*M^0.18*(cos(Enflm))^0.28);

CD.wing=Cf*FF*Qc*Swet/Sref;

%% Fuselage
f=Lref/sqrt(4/pi*Amax);
FF=(0.9+5/f^1.5+f/400);




end