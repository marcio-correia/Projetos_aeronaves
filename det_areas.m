function [dim] = det_areas(aircraft)
%% Wing

Vs=aircraft.aero.Vstall/1.94384;
We=aircraft.gen.Wo*0.4546*9.81;
lamb=aircraft.aero.wing.taper;
[rho,~,~,~,~,~,~] = atmos( aircraft.gen.altitude*0.3048 );

dim.wing.S= We*aircraft.aero.fact_cor/(0.5*rho*Vs^2*aircraft.aero.CLmax_flap);
dim.wing.b=sqrt(aircraft.aero.wing.AR*dim.wing.S);
dim.wing.Cr=dim.wing.S/(dim.wing.b/2*(1+lamb));
dim.wing.Ct=dim.wing.Cr*lamb;
dim.wing.MAC=2/3*dim.wing.Cr*(1+lamb+lamb^2)/(1+lamb);
        
%% Htail
dim.Htail.S= dim.wing.S*aircraft.aero.Htail.cht*dim.wing.MAC/aircraft.aero.Htail.Lht;
dim.Htail.b=sqrt(aircraft.aero.Htail.AR*dim.Htail.S);
dim.Htail.Cr=dim.Htail.S/(dim.Htail.b/2*(1+lamb));
dim.Htail.Ct=dim.Htail.Cr*lamb;
dim.Htail.MAC=2/3*dim.Htail.Cr*(1+lamb+lamb^2)/(1+lamb);




%% Vtail

dim.Vtail.S= dim.wing.S*aircraft.aero.Vtail.cvt*dim.wing.b/aircraft.aero.Vtail.Lvt;
dim.Vtail.b=sqrt(aircraft.aero.Vtail.AR*dim.Vtail.S);
dim.Vtail.Cr=dim.Vtail.S/(dim.Vtail.b/2*(1+lamb));
dim.Vtail.Ct=dim.Vtail.Cr*lamb;
dim.Vtail.MAC=2/3*dim.Vtail.Cr*(1+lamb+lamb^2)/(1+lamb);




end