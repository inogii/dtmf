function flag = testGiro(EBajaMax, EAltaMax)
%Comprueba que el ratio entre la energia del tono de alta y el de baja
%frecuencia está entre -4 dB y 8 dB

%se inicializa flag a true
flag =true;

%se calcula el ratio en dB
relacion = 10*log10(EBajaMax/EAltaMax);

%si no esta en el rango el test falla, entonces flag = false
if relacion <-4 || relacion >8
    flag = false;
end
end

