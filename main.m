close all
clear

%% Inputs

aircraft_def;


%% Definição de Peso

iter_max=20;
iter_min=5;
erro_max=5;
erro=1000;

Wo_data=[aircraft.gen.Wo];
for iter=1:iter_max
    [dim] = det_areas(aircraft);
    aircraft.aero.wing.S=dim.wing.S; %m2
    aircraft.aero.wing.b=dim.wing.b; %m
    aircraft.aero.wing.Cr=dim.wing.Cr; %m
    aircraft.aero.wing.Ct=dim.wing.Ct; %m
    aircraft.aero.wing.MAC=dim.wing.MAC; %m
    aircraft.aero.Htail.S=dim.Htail.S; %m2
    aircraft.aero.Htail.b=dim.Htail.b; %m
    aircraft.aero.Htail.Cr=dim.Htail.Cr; %m
    aircraft.aero.Htail.Ct=dim.Htail.Ct; %m
    aircraft.aero.Htail.MAC=dim.Htail.MAC; %m
    aircraft.aero.Vtail.S=dim.Vtail.S; %m2
    aircraft.aero.Vtail.b=dim.Vtail.b; %m
    aircraft.aero.Vtail.Cr=dim.Vtail.Cr; %m
    aircraft.aero.Vtail.Ct=dim.Vtail.Ct; %m
    aircraft.aero.Vtail.MAC=dim.Vtail.MAC; %m
   
    
    [weights] = det_weight(aircraft);
    aircraft.weights=weights;
    
    
    erro=abs(aircraft.gen.Wo-weights.Wo);
    
    aircraft.gen.Wo=weights.Wo;
    Wo_data=[Wo_data aircraft.gen.Wo];
    if iter == iter_max || (erro < erro_max && iter >= iter_min)
        break
    end
end

    iter
    erro
    aircraft.gen.Wo
    figure
    plot(0:iter,Wo_data,'LineWidth',1)
    grid minor
    xlabel('Iterações')
    ylabel('Peso Total [lbf]')
    title('Convergência de Peso')
    
    
    