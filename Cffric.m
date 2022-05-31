function[R,Rcorte,Cf]=Cffric(aircraft,Lref,V)
        [~, a, ~, rho] = atmosisa( aircraft.gen.altitude*0.3048 );
        mu=1.139e-6;
        M=V/a;
        R=rho*V*Lref/mu;
        k=0.405e-5;
        
        Rcorte=38.21*(Lref/k)^1.053;
        if R>=Rcorte
            Cf=0.455/((log10(R))^2.58*(1+0.144*M^2)^0.65);
        else
            Cf=1.328/sqrt(R);
        end
end