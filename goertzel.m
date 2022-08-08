function magnitud = goertzel(frecuencias,fs,x)
    % Número de muestras (102)
    N = length(x);
    % Array donde guardamos el valor de y(102)^2, para cada frecuencia de
    % interés
    ycuadrado(length(frecuencias)) = 0;
    % Para cada frecuencia de interés
    for i = 1:length(frecuencias)
        % k = N*fo/fs redondeamos para que sea entero
        k = round(N*frecuencias(i)/fs);
        wo = 2*pi*k/N;
        %condiciones iniciales nulas
        M2 = 0;
        M1 = 0;
        for n = 1:N
            % Cálculo de S, no es necesario calcular la salida para todas
            % las iteraciones, solo para la última, necesitamos S(102)
            % y S(101) por lo que no almacenamos ninguna iteración 
            % innecesaria en memoria
            S = x(n) + 2*cos(wo)*M1 - M2;
            M2 = M1;
            M1 = S;
        end
        % Calculamos la salida al cuadrado con la fórmula de la hoja de
        % especificaciones
        % |ycuadradofo(102)| = S(102)*S(102) + S(101)*S(101) - 2*cos(wo)*S(101)*S(102);
        % Tras la última iteración del bucle: S(102) = M1, S(101) = M2
        ycuadrado(i) = M1*M1 + M2*M2 - 2*cos(wo)*M1*M2;
    end
    % Obtenemos las magnitudes a cada frecuencia de interés con la raíz
    % cuadrada
    magnitud(length(frecuencias)) = 0;
    for j = 1:length(frecuencias)
        %y|fo = sqrt(|yfo|^2)
        magnitud(j) = sqrt(ycuadrado(j));
    end
end
