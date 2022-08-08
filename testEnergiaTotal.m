function flag = testEnergiaTotal(EBajaMax, EAltaMax, Eventana)
% Si EBajaMax, EAltaMax o su suma menor que Eventana, suspende el test

%Definicion constantes c1, c2, c3
c1 = 1;
c2 = 1;
c3 = 1;

%Inicializacion del flag a true
flag = true;

%Ponderacion de las energias
EBajaMWeighted = EBajaMax * c1;
EAltaMWeighted = EAltaMax * c2;
ESumaWeighted = (EBajaMax + EAltaMax) * c3;

%Comparacion
if(EBajaMWeighted < Eventana || EAltaMWeighted < Eventana || ESumaWeighted < Eventana)
    flag = false;
end

end

