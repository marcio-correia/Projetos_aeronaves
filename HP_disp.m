function [HP_disp] = HP_disp(aircraft, V, h)
%Função para calcular a potência disponível no motor a uma dada altitude e
%velocidade

%Entradas: V array (1,n); h array (1,m), HP_nominal escalar
%Saidas: HP_disp array (m,n)

%Inputs para calculo da eficiência da hélice
D = 6.5; %Diamétro da hélice em ft
N_motor = aircraft.prop.RPM; %RPM do motor
G_ratio = 1; %Razão entre as rotações do motor e da hélice
N_prop = G_ratio*N_motor; %RPM da hélice
AF = 273;
CPx = 0.3484;
p = [-0.0017    0.0167   -0.0332   -0.1647    0.7696    0.0030];

% main
CDt=zeros(1,length(V));
HP_nom=zeros(length(h),length(V));
eta=zeros(length(h),length(V));
[rho_0,~,~,~,~,~,~] = atmos(0);

for i = 1:length(h)
    [rho,~,~,~,~,~,~] = atmos(h(i)*0.3048);
    sigma_0 = rho/rho_0; %Razão entre as densidades da altitude e do nível zero
    for j=1:length(V)
        cd=aerodynamics(aircraft,V(j),h*0.3048,aircraft.gen.Wo*0.453592);
        CDt(j)=cd.total;
    end

    Drag = 0.5*(V.^2).*CDt*aircraft.aero.wing.S*rho_0;
    HP = Drag.*V.*0.00135962; %Potência requerida em HP
    J = 88*V.*2.23694/(N_prop*D); %V em milhas/hr
    Cp = 0.5*(HP/1000)/(sigma_0*(N_prop/1000)^3*(D/10)^5);
    J_Cp_1_3 = J./(Cp.^(1/3));
    for j=1:length(V)
        eta(i,j) = sum(p.*[J_Cp_1_3(j)^5,J_Cp_1_3(j)^4,J_Cp_1_3(j)^3,J_Cp_1_3(j)^2,J_Cp_1_3(j)^1,1]);
    end
    HP_nom(i,:)=aircraft.prop.Pot*(sigma_0-(1-sigma_0)/7.55);
end

HP_disp = eta.*HP_nom;



