% PDS - Generar patrons de interferencia (radiotelescopi)

% Autors:
% Guillermo Vidal
% Gerard Oliva
% Pere Mir

clear all;
close all;

% Definicio de parametres inicials
fs = 1000;          % frequencia de sampling(Hz)
t = 0:1/fs:1;       % Temps de simulacio (1 segon)

% Generar senyal aleatoria
random_signal = randn(size(t));

% Introduir el desfasament del radiotelescopis 1, 2, 3, i 4
delay1 = 0;    
delay2 = 0.1;       
delay3 = 0.15;      
delay4 = 0.05;     

% Generar les ones rebudes pels radiotelescopis 1, 2, 3, i 4 amb el soroll
soroll = 0.05;  % Amplitud del soroll
senyal_rebuda1 = [zeros(1, round(delay1*fs)) random_signal(1:end-round(delay1*fs))] + soroll * randn(size(t));
senyal_rebuda2 = [zeros(1, round(delay2*fs)) random_signal(1:end-round(delay2*fs))] + soroll * randn(size(t));
senyal_rebuda3 = [zeros(1, round(delay3*fs)) random_signal(1:end-round(delay3*fs))] + soroll * randn(size(t));
senyal_rebuda4 = [zeros(1, round(delay4*fs)) random_signal(1:end-round(delay4*fs))] + soroll * randn(size(t));

% Computa la correlacio entre parelles de senyals rebudes
visibilitat_12 = xcorr(senyal_rebuda1, senyal_rebuda2);
visibilitat_13 = xcorr(senyal_rebuda1, senyal_rebuda3);
visibilitat_14 = xcorr(senyal_rebuda1, senyal_rebuda4);
visibilitat_23 = xcorr(senyal_rebuda2, senyal_rebuda3);
visibilitat_24 = xcorr(senyal_rebuda2, senyal_rebuda4);
visibilitat_34 = xcorr(senyal_rebuda3, senyal_rebuda4);

% Dibuixar les grafiques del senyal original, dels senyals rebuts, i del
% patro de interferencies
% Hem omes les grafiques dels senyals rebuts dels radiotelescopis 3 i 4, ja
% que son molt semblants a les altres i no aporten informacio nova
subplot(4,1,1);
plot(t, random_signal);
title('Senyal original');
xlabel('Temps');
ylabel('Amplitud');

subplot(4,1,2);
plot(t, senyal_rebuda1);
title('Senyal rebuda - Radiotelescopi 1');
xlabel('Temps');
ylabel('Amplitud');

subplot(4,1,3);
plot(t, senyal_rebuda2);
title('Senyal rebuda - Radiotelescopi 2');
xlabel('Temps');
ylabel('Amplitud');

subplot(4,1,4);
plot(visibilitat_12);
hold on;
plot(visibilitat_13);
plot(visibilitat_14);
plot(visibilitat_23);
plot(visibilitat_24);
plot(visibilitat_34);
hold off;
title('Patro de interferencies');
xlabel('Time Lag');
ylabel('Correlacio');