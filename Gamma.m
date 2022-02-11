%% clear console,remove all variables from memory, close all figures
clc; clearvars; close all;

%% INPUT Configurations
% N : Number of samples
% x : row vector of equally spaced numbers
N = 1e6;
x = 0:0.01:20;
a = 1;%alpha %shape a>0 change
%for N(0,1) sigma = 1 so b = 1
b = 1; %beta  %rate

% Plot Configurations
FONTSIZE_LABEL = 14;
FONTSIZE_LEGEND = 12;

%% Main Program

%Define theoritical PDF of gamma distribution for a values
f = @(a,b) ( (b^a)/gamma(a) ) * (x.^(a-1)) .*  exp(-(b*x)) ;

% Generate vector of normally distributed random numbers
% with mean 0 and variance 1
Z1 = randn(1,N);
Z2 = randn(1,N);
Z3 = randn(1,N);
Z4 = randn(1,N);
Z5 = randn(1,N);
Z6 = randn(1,N);

%Transform standard Gaussian to gamma distribution for a = 0.5, 1, 1.5, 2, 2.5, 3
%using first scaling into chi square function k = 2*a
%k = 2*a % k = chi-square parameter is special case of gamma function
%X be Gamma random variable
X1 = @(b) (Z1.^2)/(2*b) ;
X2 = @(b) (Z1.^2 + Z2.^2)/(2*b) ;
X3 = @(b) (Z1.^2 + Z2.^2 + Z3.^2)/(2*b); 
X4 = @(b) (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2)/(2*b);
X5 = @(b) (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2 + Z5.^2)/(2*b);
X6 = @(b) (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2 + Z5.^2 + Z6.^2)/(2*b);

%% PDF Plots
figure;
subplot(1,1,1);

% Plot histogram of generated random numbers for a = 0.5, 1, 1.5, 2, 2.5, 3
% 300 represent number of bins
histogram(X1(2),300,'Normalization','pdf');
hold on;
histogram(X2(1),300,'Normalization','pdf');
histogram(X3(1),300,'Normalization','pdf');
histogram(X4(2),300,'Normalization','pdf');
histogram(X5(2),300,'Normalization','pdf');
histogram(X6(1),500,'Normalization','pdf');

% Plot theoritical PDF for a = 0.5, 1, 1.5, 2, 2.5, 3
plot(x,f(0.5,2),'r-','linewidth',3);
plot(x,f(1,1),'r-','linewidth',3);
plot(x,f(1.5,1),'r-','linewidth',3);
plot(x,f(2,2),'r-','linewidth',3);
plot(x,f(2.5,2),'r-','linewidth',3);
plot(x,f(3,1),'r-','linewidth',3);

legend('Simulated (a=0.5,b = 2)','Simulated (a=1, b = 1)','Simulated (a=1.5,b = 1)','Simulated (a=2, b = 2)','Simulated (a=2.5,b = 2)','Simulated (a=3, b = 1)','Theoritical Distribution','Fontsize',FONTSIZE_LEGEND,'Location','northeast');
%legend('Theoritical','Fontsize',FONTSIZE_LEGEND,'Location','northeast');

xlabel('x','Fontsize',FONTSIZE_LABEL);
ylabel('f(x)','Fontsize',FONTSIZE_LABEL);
title('PDF of Gamma Distribution');

grid on;axis tight;grid minor;hold off;axis([0 5 0 1.2]);