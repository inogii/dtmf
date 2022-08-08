function flag = testArmonico(fMax, Emax, x)
% calculamos con goertzel la magnitud y posteriormente la energía asociada
% al primer armónico de f, 2*f
% si no es suficientemente pequeña, digamos menos de la mitad, suspende el
% test

%Umbral
threshold = Emax/2;

%Inicializamos el flag a true
flag = true;

%Calculo armonico
fArmonico = 2 * fMax;
%Calculo magnitud armonico con Goertzel
magnitudArmonico = goertzel(fArmonico, 8000, x);
%Calculo energia armonico
EArmonico = abs(magnitudArmonico)^2;

%Comparacion
if (EArmonico > threshold)
    flag = false;
end

end

