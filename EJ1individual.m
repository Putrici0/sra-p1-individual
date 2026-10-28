
function [frecuencia, establecimiento, pico, error] = EJ1individual(t, y2, referencia)

t = t(:);
y2 = y2(:);

% valor final
valorFinal = y2(end);

% buscar los maximos de la señal
tiempos = [];

for i = 2:length(y2)-1
    if y2(i) > y2(i-1) && y2(i) > y2(i+1)
        tiempos(end+1) = t(i);
    end
end

% frecuencia amortiguada
if length(tiempos) >= 2
    periodo = tiempos(2) - tiempos(1);
    frecuencia = 1 / periodo;
else
    frecuencia = NaN;
end

% tiempo de establecimiento (5%)
limite = 0.05 * abs(valorFinal);
fuera = find(abs(y2 - valorFinal) > limite);

if isempty(fuera)
    establecimiento = t(1);
elseif fuera(end) == length(t)
    establecimiento = NaN;
else
    establecimiento = t(fuera(end) + 1);
end

% tiempo de pico
if ~isempty(tiempos)
    pico = tiempos(1);
else
    pico = NaN;
end

% error en regimen permanente
error = referencia - valorFinal;

end
