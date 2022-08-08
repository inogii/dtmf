function secuencia = procesar(memoria)
% Array para guardar la salida
secuencia=[];
% Variable de control
n = 1;
% Mientras la variable de control sea menor que la longitud de memoria -1
while n<length(memoria)-1
% Analizamos el valor actual (memoria(n))    
actual = memoria(n);
% Si actual es distinto de '-1'  --> hay que descodificar
if not(strcmp(actual,'-1'))
    % Si, además el valor actual y el siguiente son iguales, validamos
    % el dígito actual añadiendolo al final de secuencia (append)    
    if strcmp(actual, memoria(n+1))
        secuencia = [secuencia, actual];
        % Aumentamos el valor de n, hasta que encontremos un valor de
        % memoria(n) que sea distinto del actual
        while strcmp(actual,memoria(n+1)) && n<length(memoria)-1
            n = n+1;
        end
    end
end
% Incrementamos n en 1
n = n+1;
end