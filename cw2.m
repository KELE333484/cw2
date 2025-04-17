% Qingyou Meng
% ssyqm1@nottinghsm.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

%a=arduino
for i=1:10
    writeDigitalPin(a,"D2",1);
    pause(0.25);
    writeDigitalPin(a,"D2",0);
    pause(0.25);
end
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

%a=arduino
duration = 600;
voltageData = zeros(1, duration);
temperatureData = zeros(1, duration);
TC = 0.01; 
V0C = 0.5;
for i = 1:duration
    voltageData(i) = readVoltage(a,'A1');
    temperatureData(i) = (voltageData(i) - V0C) / TC;
    pause(1);
end
minTemperature = min(temperatureData);
maxTemperature = max(temperatureData);
averageTemperature = mean(temperatureData);

fprintf('Minimum Temperature: %.2f C\n', minTemperature);
fprintf('Maximum Temperature: %.2f C\n', maxTemperature);
fprintf('Average Temperature: %.2f C\n', averageTemperature);
%c)
time= 1:600;
plot(time, temperatureData);
xlabel('Time(seconds)');

ylabel('Temperature(C)');

title('Temperature Vs Time');
grid on
%d)
date = datetime;
location = 'Nottingham';

header = sprintf('Data logging initiated - %s\nLocation - %s\n',date,location);
disp(header);
for i = 0:10
    index = i * 60;
    out=sprintf('Minute\t\t%d\nTemperature\t%.2fC\n', i, temperatureData(index));
    disp(out);
end
footer = sprintf('Data logging terminated');
disp(footer);
%e)
overwritten_content = rand(5,5);
save 'cabin_temperature.txt' overwritten_content -ascii;
file_id=fopen('cabin_temperature.txt','w');
if file_id ~= -1
    fprintf(file_id,'Data logging initiated - %s\nLocation - %s\n',date,location);
    for i = 0:10
    index = i * 60;
    fprintf('Minute\t\t%d\nTemperature\t%.2f C\n', i, temperatureData(index));
    end
    fprintf(file_id,'Minimum Temperature: %.2f C\n', minTemperature);
    fprintf(file_id,'Maximum Temperature: %.2f C\n', maxTemperature);
    fprintf(file_id,'Average Temperature: %.2f C\n', averageTemperature);
    fprintf(file_id,'Data logging terminated');
    fclose(file_id);
end
file_id = fopen('cabin_temperature.txt','r');
if file_id ~= -1
    my_text=fscanf('cabin_temperature.txt','%s','*');
    disp(my_text);
    fclose(file_id);
end


    

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here
%a=arduino
TC = 0.01; 
V0C = 0.5;
while true
    voltage = readVoltage(a,'A4');
    temperature=(voltage-V0C)/TC;
    if temperature>=18 && temperature<=24
         writeDigitalPin(a,"D2",1);
         writeDigitalPin(a,"D8",0);
         writeDigitalPin(a,"D10",0);
    elseif temperature<18
        writeDigitalPin(a,"D2",0);
        writeDigitalPin(a,"D10",0);
        writeDigitalPin(a,"D8",1);
         pause(0.25);
        writeDigitalPin(a,"D8",0);
        pause(0.25)
    else
        writeDigitalPin(a,"D2",0);
        writeDigitalPin(a,"D8",0);
        writeDigitalPin(a,"D10",1);
         pause(0.125);
        writeDigitalPin(a,"D10",0);
        pause(0.125);
    end
end






%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here