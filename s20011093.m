clc;
clear;
clear all;

% Getting inputs from user
n = input('Enter the length of X signal');
m = input('Enter the length of Y signal');
for i=1:1:2
    for j=1:1:n+m-1
        if j<=n
             x(i,j) = input('Enter the indexes and values of X signal(indexes first):')
        else
             x(i,j) = 0;
        end
    end
end
for i=1:1:2
    for j=1:1:m+n-1
        if j<=m
             y(i,j) = input('Enter the indexes and values of Y signal(indexes first):')
        else
             y(i,j) = 0;
        end
    end
end

for j=1:1:n
           x0(j) = x(2,j);
           xi(j) = x(1,j);
           
end

for j=1:1:m
           y0(j) = y(2,j);
           yi(j) = y(1,j);
end
Conv = myConv(x0, n, y0, m);
matlabConv= conv(x0, y0);
fprintf("myConv =");
fprintf(" %i",Conv);
fprintf('\nmatlabConv =');
fprintf(" %i",matlabConv);

%Plotting the results of Conv functions
subplot(2,2,3);
i=1:1:n+m-1;
stem (x(1,1)+i-1,Conv)
title('myConv')

subplot(2,2,1);
j=1:1:n;
stem (xi,x0)
title('x[n]')

subplot(2,2,2);
j=1:1:n;
stem (yi,y0)
title('y[m]')

subplot(2,2,4);
i=1:1:n+m-1;
stem (x(1,1)+i-1,matlabConv)
title('matlab')

fprintf('\nIndexes of X\n');
for j=1:1:n
    fprintf('%i',xi(j));
end
fprintf('\nValues of X\n');
for j=1:1:n
    fprintf('%i',x0(j));
end
fprintf('\nIndexes of Y\n');
for j=1:1:m
    fprintf('%i',yi(j));
end
fprintf('\nValues of \n');
for j=1:1:m
    fprintf('%i',y0(j));
end

% 5 seconds of audio recording
recObj = audiorecorder; %% kayıt başlatma nesnesi
disp('Start speaking(5 Sec).') %% ekrana mesaj
recordblocking(recObj, 5); %% kayıt işlemi
disp('End of Recording.'); %% ekrana mesaj
x1 = getaudiodata(recObj); %% kaydedilen sesi x değişkenine saklama 

% 10 seconds of audio recording
recObj = audiorecorder; %% kayıt başlatma nesnesi
disp('Start speaking(10 Sec).') %% ekrana mesaj
recordblocking(recObj, 10); %% kayıt işlemi
disp('End of Recording.'); %% ekrana mesaj
x2 = getaudiodata(recObj); %% kaydedilen sesi x değişkenine saklama

for i=1:3
M = input('Value of M: ');

y1_system = system(M);
myConv_y1 = myConv(x1, length(x1), y1_system, length(y1_system));
sound(myConv_y1);
conv_y1 = conv(x1, y1_system);

y2_system = system(M);
myConv_y2 = myConv(x2,length(x2), y2_system, length(y2_system));
sound(myConv_y2);
conv_y2 = conv(x2, y2_system);

% plot results for sound recording

figure;

subplot(4,1,1); stem(myConv_y1); 
xlabel('n'); ylabel('y1[n]'); grid on;

title('y1[n] Plot with myConv Function');

subplot(4,1,2); stem(conv_y1); 
xlabel('n'); ylabel('y1[n]'); grid on;

title('y1[n] Plot with conv Function');

subplot(4,1,3); stem(myConv_y2); 
xlabel('n'); ylabel('y2[n]'); grid on;

title('y2[n] Plot with myConv Function');

subplot(4,1,4); stem(conv_y2); 
xlabel('n'); ylabel('y2[n]'); grid on;

title('y2[n] Plot with conv Function');
end
% convolution function definition
function result1 = myConv(x, n, y, m)
    result1(n+m-1) = 0;
    for i = 1:n
        for j = 1:m
            result1(i+j-1) = result1(i+j-1) + x(i) * y(j);
        end
    end
end

% system function definition
function Y = system(M)
    Y = zeros(1, M * 400);
    Y(1) = 1;
    for i = 1:M
        Y(1 + 400*i) = 0.8 * i;
    end
end