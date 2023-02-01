clc;
clear;
clear all;

amp = 0.1;          % amplitude value
fs = 8000;          % sampling frequency
duration = 0.3;     % key press time
N = duration*fs;  
t = 0:1/fs:0.25;    % sampling interval
numberSound = [];
phoneNumber = '05457292097';
for i=1:length(phoneNumber)
    digit = phoneNumber(i);     % digit keeps the char of current index 
    switch (digit)
        case '1'
            f1 = 697;
            f2 = 1209;
        case '2'
            f1 = 697;
            f2 = 1336;
        case '3'
            f1 = 697;
            f2 = 1477;
        case '4'
            f1 = 770;
            f2 = 1209;
        case '5'
            f1 = 770;
            f2 = 1336;
        case '6'
            f1 = 770;
            f2 = 1477;      
        case '7'
            f1 = 852;
            f2 = 1209;
        case '8'
            f1 = 852;
            f2 = 1336;
        case '9'
            f1 = 852;
            f2 = 1477;
        case '0'
            f1 = 941;
            f2 = 1336;  
    end
    row = amp*sin(2*pi*f1*t);
    col = amp*sin(2*pi*f2*t);

    bosluk = sin(0*t);      % to add spaces between numbers
    numberSound = [numberSound, row+col];
    numberSound = [numberSound, bosluk];  % adding spaces between number
end

audiowrite('05457292097.wav', numberSound, fs); % create the sound file

sound(1) = "Ornek.wav";
sound(2) = "05457292097.wav";

lengthDigit(1) = 11;
lengthDigit(2) = 11;

    for j = 1: 2
        [tel,fs] = audioread(sound(j));
        n=lengthDigit(j);
        d = floor(length(tel)/n);
        f=fs*(0:(d/2))/d;
        figure
            T = 100000/fs;
            x = 1:T:100000*(length(tel) / fs);
            x = x / 100000;
            nexttile
            plot(x,tel);
            title(j+ "th sound file continuous plot (Plot)");
            xlabel('Duration');
            ylabel('Intensity');
            hold on

            figure
            T = 100000/fs;
            x = 1:T:100000*(length(tel) / fs);
            x = x / 100000;
            stem(x,tel);
            title(j+ "th sound file discrete graph (Stem)");
            xlabel('Duration');
            ylabel('Amplitude');
        hold on
        fprintf("Phone Number in file %d = ",j);
        for i=1:n
            number = "null";
            Fourier = abs(fft(tel(1+((i-1)*d):i*d),fs));
            x2=(Fourier(1:floor(length(Fourier)/2)+1));
            
            [vals, freqs] = maxk(x2, 3);
            if(abs(freqs(1) - freqs(2))<=5)
                loc(1) = freqs(1);
                loc(2) = freqs(3);
            
                if(freqs(3)>freqs(1))
                    loc(1) = freqs(3);
                    loc(2) = freqs(1);
                end
        
            else
                loc(1) = freqs(1);
                loc(2) = freqs(2);
            
                if(freqs(2)>freqs(1))
                    loc(1) = freqs(2);
                    loc(2) = freqs(1);
                end
            end
        
            if(abs(loc(1)-1209)<=7)
                if(abs(loc(2)-697)<=7)
                    number = "1";
                elseif(abs(loc(2)-770)<=7)
                    number = "4";
                elseif(abs(loc(2)-852)<=7)
                    number = "7";
                end
            
            elseif(abs(loc(1)-1336)<=7)
                if(abs(loc(2)-697)<=7)
                    number = "2";
                elseif(abs(loc(2)-770)<=7)
                    number = "5";
                elseif(abs(loc(2)-852)<=7)
                    number = "8";
                elseif(abs(loc(2)-941)<=7)
                    number = "0";
                end
                 
            elseif(abs(loc(1)-1477)<=7)
                if(abs(loc(2)-697)<=7)
                    number = "3";
                elseif(abs(loc(2)-770)<=7)
                    number = "6";
                elseif(abs(loc(2)-852)<=7)
                    number = "9";
                end
            end
            if(number == "null")
            else
            fprintf("%s",number);
            figure
                nexttile
                plot(x2);
                title("Graph of key "+number);
                xlabel("Frequency");
                ylabel("Magnitude");
            hold on
            end
        end
        fprintf("\n");

    end
