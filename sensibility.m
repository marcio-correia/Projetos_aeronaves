%% Sensibility Altitude de Cruzeiro
Sense = 'y' ; 
min_var = 0.5*17500;
max_var = 1.15*17500;
inc_var = 0.05*17500;
aircraft.gen.hcruz

%% Sensibility Velocidade Estol
Sense = 'y' ; 
min_var = 0.85*51.57;
max_var = 1.5*51.57;
inc_var = 0.01*51.57;
aircraft.aero.Vstall

%% Sensibility Velocidade Cruzeiro
Sense = 'y' ; 
min_var = 0.85*134.1;
max_var = 1.5*134.1;
inc_var = 0.05*134.1;
aircraft.aero.Vcruz

%% Sensibility Wing Aspect Ratio
Sense = 'y' ; 
min_var = 0.5*10;
max_var = 1.5*10;
inc_var = 0.05*10;
aircraft.aero.wing.AR

%% Sensibility Wing Taper Ratio
Sense = 'y' ; 
min_var = 0.5*0.5;
max_var = 2*0.5;
inc_var = 0.05*0.5;
aircraft.aero.wing.taper