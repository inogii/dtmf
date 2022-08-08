% DTMF
clear
clc
% 0.- cargar señal de test
TEST_02;
% 1.- Declaración de Variables

% Array de frecuencias bajas
freqBaja = [697,770,852,941];
% Array de frecuencias altas
freqAlta = [1209,1336,1477,1633];
% Arrays de frecuencias altas y bajas con márgen de +-1.5% de error
freqBajas = [freqBaja.*0.985, freqBaja, freqBaja.*1.015];
freqAltas = [freqAlta.*0.985, freqAlta, freqAlta*1.015];
% Frecuencia de muestreo en Hz
fs = 8000;
% Muestras por ventana
N = 102; 
% Variables de control del bucle que recorre todas las ventanas
inicioVentana = 1; 
finVentana = N;
finEjecucion = length(dtmf);
% Array donde almacenamos los resultados de la descodificación
memoria = [];
% Umbrales
% Analizando la energía de las señales que recibimos cuando transmiten
% ruido y cuando transmiten señal, el valor seleccionado es adecuado
umbralVentana = 10^8; 
% Matriz de descodificación, idéntica a la de la hoja de especificaciones y
% la de la memoria
Descodificar = ['1','2','3','A';
     '4','5','6','B';
     '7','8','9','C';
     '*','0','#','D'];

% 2.- Bucle Ventanas

% Analizamos ventanas de tamaño 102 muestras, cada una solapada al 50% con
% la anterior, mientras el valor de finVentana sea menor que el número de
% muestras en la señal que estamos analizando
while finVentana < finEjecucion
    % Muestras de la señal pertenecientes a la ventana
    x = dtmf(inicioVentana:finVentana);
    % Cálculo del nivel x(n) a las frecuencias de interés con goertzel
    % Para las frecuencias bajas
    magnitudBaja = goertzel(freqBajas, fs, x);
    % Para las frecuencias altas
    magnitudAlta = goertzel(freqAltas, fs, x);
    % Cálculo energías: E(n) = x(n)^2
    EBaja = abs(magnitudBaja).^2;
    EAlta = abs(magnitudAlta).^2;
    % Cálculo de la energía total de la señal en la ventana
    Eventana = sum(x.^2);
    % Si la energía de la señal en la ventana supera el umbral, 
    % estamos transmitiendo señal y no ruido, por lo que procedemos a
    % analizar qué está transmitiendo la señal
    
    if Eventana > umbralVentana
        
        % Obtenemos qué frecuencia tiene mayor energía en cada banda, la
        % energía máxima, y un booleano que indica si dicha energía supera
        % el umbral mínimo
        [fBajaMax, EBajaMax, flag1] = testMagnitud(EBaja, freqBajas);
        [fAltaMax, EAltaMax, flag2] = testMagnitud(EAlta, freqAltas);
        % Si alguno de los test anteriores ha fallado, flag = false, de ahí
        % la operación AND (&)
        flag = flag1 & flag2;
        % Ejecutamos el resto de tests. En el momento en que uno de ellos
        % falle, no ejecutamos el resto para ahorrar capacidad de cómputo
        % En cada test, actualizamos el valor de la variable flag para
        % analizar si continuamos con la ejecución
        
        if flag
            flag = testGiro(EBajaMax, EAltaMax);
        end
        
        if flag
            % Importante pasar el índice para que no se compare la energía
            % máxima con las del tono +-1.5%
            % Se analiza para las dos bandas y si alguna falla, flag=false
            i1 = find(freqBajas==fBajaMax);
            i2 = find(freqAltas==fAltaMax);
            flag1 = testOffset(EBaja, EBajaMax, i1);
            flag2 = testOffset(EAlta, EAltaMax, i2);
            flag = flag1 & flag2;
        end
        
        if flag
            flag = testEnergiaTotal(EBajaMax, EAltaMax, Eventana);
        end
        
        if flag
            % Ejecutamos el test armónico para la frecuencia de mayor
            % energia de cada banda por separado
            flag1 = testArmonico(fBajaMax, EBajaMax, x);
            flag2 = testArmonico(fAltaMax, EAltaMax, x);
            % Si alguno de los dos ha fallado, entonces flag = false
            flag = flag1 & flag2;
        end
        
        %Comprobamos si han pasado todos los test
        if flag
            % Si han pasado todos los test, descodificamos con los índices
            % de las frecuencias de cada banda en sus respectivos arrays
            % La matriz de descodificación está declarada en variables
            % Ejemplo: 1209, posición 4 de freqAlta, 941, posición 4 de
            % freqBaja, posición (4,4) --> '*'
            fila = find(freqBaja == fBajaMax);
            columna = find(freqAlta == fAltaMax);
            digito = Descodificar(fila, columna);
            % Cargamos el dígito descodificado en el array añadiendolo al
            % final (append en inglés)
            memoria = [memoria, digito];
        else
            % Si no se han pasado todos los test, no descodificamos y
            % cargamos un -1 
            memoria = [memoria, '-1'];
        end
    end
    % Actualización de Ventana, solapada al 50%, de ahí el N/2 en vez de N,
    % siendo N la longitud de la ventana ejemplo:
    % inicioVentana = 1 --> inicioVentana = 52
    % finVentana = 102 --> finVentana = 153
    % Las muestras 52-102 se solapan
    inicioVentana = inicioVentana + N/2;
    finVentana = finVentana + N/2;  
end
% Tratamos los datos obtenidos en memoria
secuencia = procesar(memoria);
% Imprimimos en consola los dígitos de señalización DTMF de la señal
disp(secuencia);
