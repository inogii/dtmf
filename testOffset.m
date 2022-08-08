function flag = testOffset(E, EMax, index)
% Si la energía de alguno de los tonos de la banda es similar a la máxima,
% el test se suspende. Podemos poner un umbral de que todas las energías
% de cada banda sean como mucho la mitad de la Energía máxima
%Inicializamos el flag a true
flag = true;
%Valor del umbral 50% emax cada banda
Eumbral = EMax/2;
% Comparamos la energía máxima con el resto de la banda, exceptuando sus
% frecuencias +-1.5%
for i=1:length(E)
    if not(i==index-4) && not(i==index) && not(i==index+4)
        if E(i) > Eumbral
            flag = false;
        end
    end
end
end