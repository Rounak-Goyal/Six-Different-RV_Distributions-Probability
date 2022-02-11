%% clear console,remove all variables from memory, close all figures
clc; clearvars; close all;

%% INPUT Configurations
% N : Number of samples
% x : row vector of equally spaced numbers
N = 1e6;
x = 0:0.01:5;
k = 3;
m = k/2;%m or u %shape m>=0.5
w = 1;%w  %spread w>0

% Plot Configurations
FONTSIZE_LABEL = 14;
FONTSIZE_LEGEND = 12;

%% Main Program

%Define theoritical PDF of nakagami distribution for m values
f = @(m) (2 / (w*gamma(m))) .* m^m .* ((x)/w).^(2*m-1) .* exp(-m*((x)/w).^2);

% Generate vector of normally distributed random numbers
% with mean 0 and variance 1
Z1 = randn(1,N);
Z2 = randn(1,N);
Z3 = randn(1,N);
Z4 = randn(1,N);

%Transform standard Gaussian to nakagami distribution 
% using first scaling into chi function then taking m = 0.5, 1, 1.5, 2
% k = 2*m % chi parameter making funtion in m
% X be nakagami random variable
X1 = @(m) sqrt(w/(2*m))*sqrt(Z1.^2);
X2 = @(m) sqrt(w/(2*m))*sqrt(Z1.^2 + Z2.^2);
X3 = @(m) sqrt(w/(2*m))*sqrt(Z1.^2 + Z2.^2 + Z3.^2);
X4 = @(m) sqrt(w/(2*m))*sqrt(Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2);


%% PDF Plots
figure;
subplot(1,1,1);

% Plot histogram of generated random numbers for m =0.5, 1, 1.5, 2
% 200 represent number of bins
histogram(X1(0.5),200,'Normalization','pdf');
hold on;
histogram(X2(1),200,'facecolor','m','Normalization','pdf');
histogram(X3(1.5),200,'facecolor','b','Normalization','pdf');
histogram(X4(2),200,'facecolor','y','Normalization','pdf');


% Plot theoritical PDF for m =0.5, 1, 1.5, 2 in f(k) function
plot(x,f(0.5),'r-','linewidth',3);
plot(x,f(1),'r-','linewidth',3);
plot(x,f(1.5),'r-','linewidth',3);
plot(x,f(2),'r-','linewidth',3);

legend('Simulated (m=0.5,w=1)','Simulated (m=1 ,w=1)','Simulated (m=1.5,w=1)','Simulated (m=2 ,w=1)','Theoritical Distribution','Fontsize',FONTSIZE_LEGEND,'Location','northeast');
%legend('Theoritical','Fontsize',FONTSIZE_LEGEND,'Location','northeast');

xlabel('x','Fontsize',FONTSIZE_LABEL);
ylabel('f(x)','Fontsize',FONTSIZE_LABEL);
title('PDF of Nakagami m Distribution');

grid on;axis tight;grid minor;hold off;axis([0 2.5 0 1.5]);