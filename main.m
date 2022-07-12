close all
clear
addpath('desempenho')
addpath('airfoil')

%% Inputs
%Sensibility
Sense = 'n' ; 
min_var = 0;
max_var = 2000;
inc_var = 50;


%Inputs Definition
aircraft_def;

if Sense =='y'
    Var=min_var:inc_var:max_var;
    Imax=length(Var);
    Weight_Data=[];
else
    Imax=1;
end
%% Definição de Peso
for i=1:Imax
    if Sense == 'y'
       aircraft_def;
       aircraft.gen.range = Var(i);
    end
    
iter_max=20;
iter_min=5;
erro_max=0.05;
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
    
    [aircraft.weights.Wf,v]=det_cruz(aircraft);
    aircraft.aero.Vcruz=v/1.68781; %knots
    [weights] = det_weight(aircraft);
    aircraft.weights=weights;
    aircraft.gen.fuelRate=aircraft.weights.Wf/aircraft.weights.Wo;
    
    erro=abs(aircraft.gen.Wo-weights.Wo);
    
    aircraft.gen.Wo=weights.Wo;
    
    
    
    Wo_data=[Wo_data aircraft.gen.Wo];
    if iter == iter_max || (erro < erro_max && iter >= iter_min)
        break
    end
end
    if Sense ~= 'y'
        iter
        erro
        aircraft.gen.Wo
        figure
        plot(0:iter,Wo_data,'LineWidth',1)
        grid minor
        xlabel('Iterações')
        ylabel('Peso Total [lbf]')
        title('Convergência de Peso')
        plot_perf_drag
        constrains
    elseif Sense == 'y'
        Weight_Data=[Weight_Data aircraft.weights.Wf];
    end
end   

if Sense == 'y'
    plot(Weight_Data,Var,'LineWidth',1)
    grid minor
    title('Análise de Sensibilidade')
    xlabel('Peso de Combustível [lbf]')
    ylabel('Alcance [Milhas Náuticas]')
end
