% main
V=aircraft.aero.Vstall/1.94384:1:2*aircraft.aero.Vmax/1.94384;
CDt=[];
CDi=[];
CD0=[];
for i=1:length(V)
    cd=aerodynamics(aircraft,V(i),0,aircraft.gen.Wo*0.453592);
    CDt=[CDt cd.total];
    CDi=[CDi cd.induced];
    CD0=[CD0 cd.total-cd.induced];
end
figure
plot(V,0.5*V.^2.*CDt*aircraft.aero.wing.S*1.224,'LineWidth',1)
hold on
plot(V,0.5*V.^2.*CDi*aircraft.aero.wing.S*1.224,'LineWidth',1)
plot(V,0.5*V.^2.*CD0*aircraft.aero.wing.S*1.224,'LineWidth',1)
grid minor
xlabel('Velocidade [m/s]')
ylabel('Drag [N]')
legend('D Total','D Induzido','D Parasita')

%% Plot Sensibility
plot_sense = 'y';
if plot_sense == 'y'
   V=aircraft.aero.Vstall/1.94384:1:2*aircraft.aero.Vmax/1.94384;

    figure
    for h=0:2000*0.3048:14000*0.3048
        [rho,~,~,~,~,~,~] = atmos( h );
        CDt=[];
        CDi=[];
        CD0=[];
        for i=1:length(V)
            cd=aerodynamics(aircraft,V(i),h,aircraft.gen.Wo*0.453592);
            CDt=[CDt cd.total];
            CDi=[CDi cd.induced];
            CD0=[CD0 cd.total-cd.induced];
        end
        plot(V,0.5*V.^2.*CDt*aircraft.aero.wing.S*rho,'LineWidth',1)
        hold on
    end
    grid minor
    xlabel('Velocidade [m/s]')
    ylabel('Drag [N]')
    legend('Sea Level','2000 ft','4000 ft','6000 ft','8000 ft','10000 ft','12000 ft','14000 ft')
    
end


%% Plot Sensibility Power
plot_sense = 'y';
if plot_sense == 'y'
   V=aircraft.aero.Vstall/1.94384:1:2*aircraft.aero.Vmax/1.94384;

    figure
    for h=0:2000*0.3048:14000*0.3048
        [rho,~,~,~,~,~,~] = atmos( h );
        CDt=[];
        CDi=[];
        CD0=[];
        for i=1:length(V)
            cd=aerodynamics(aircraft,V(i),h,aircraft.gen.Wo*0.453592);
            CDt=[CDt cd.total];
            CDi=[CDi cd.induced];
            CD0=[CD0 cd.total-cd.induced];
        end
        TR=0.5*V.^2.*CDt*aircraft.aero.wing.S*rho;
        Pr=TR*V(i)*0.00134102;
        plot(V,Pr,'LineWidth',1)
        hold on
    end
    grid minor
    xlabel('Velocidade [m/s]')
    ylabel('Potência Requerida [hp]')
    legend('Sea Level','2000 ft','4000 ft','6000 ft','8000 ft','10000 ft','12000 ft','14000 ft')
    


%% HP Disponível
    V=aircraft.aero.Vstall/1.94384:1:2*aircraft.aero.Vmax/1.94384;
    h = 0:2000:26000;
    grid on
    hold on
    for i = 1:length(h)
        HP_avai = HP_disp(aircraft,V,h(i));
        plot(V,HP_avai)
    end
    xlabel('V (m/s)')
    ylabel('Potência (hp)')
    hold off
end