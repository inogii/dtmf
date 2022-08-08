function [fMax, EMax, flag] = testMagnitud(E, f)
% Valor de umbral, mínima energía para aprobar el test
threshold = 5*10^10;
% Inicializamos el flag a true
flag = true;
% Obtenemos la energía máxima y su índice
[EMax, index] = max(E);
% Obtenemos la frecuencia asociada a dicha Energía
fMax = f(index);
% Si la energía no supera el umbral, suspende el test
if EMax < threshold
    flag = false;
end
% Queremos obtener una frecuencia "real", no una de las pertenecientes a
% los márgenes, por lo que si por el muestreo la frecuencia de máxima 
% energía ha caído en el margen +-1.5%, la aproximamos por la "verdadera"
% En el array de frecuencias, las 4 primeras posiciones se corresponden con
% las frecuencias "verdaderas" * 0.985, si el índice es menor o igual que
% 4, aproximamos a las "verdaderas" (que están en el medio del array)
if index<=4
    fMax = f(index+4);
% Mismo planteamiento para las frecuencias "verdaderas" * 1.015
elseif index>=9
    fMax = f(index-4);
end


