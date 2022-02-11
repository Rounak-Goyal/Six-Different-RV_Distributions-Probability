%% clear console,remove all variables from memory, close all figures
clc; clearvars; close all;

%% INPUT Configurations
% N : Number of samples
% x : row vector of equally spaced numbers
N = 1e6;
x = 0:0.01:20;
k = 3;%degrees of freedom

% Plot Configurations
FONTSIZE_LABEL = 14;
FONTSIZE_LEGEND = 14;

%% Main Program

%Define theoritical PDF of chi square distribution
%function for value of k degree of freedom
f = @(k) (1 / (2^(k/2) * gamma(k/2))) * x.^(k/2-1) .* exp(-0.5*x) ;

% Generate vector of normally distributed random numbers
% with mean 0 and variance 1
Z1 = randn(1,N);
Z2 = randn(1,N);
Z3 = randn(1,N);
Z4 = randn(1,N);
Z5 = randn(1,N);
%Transform standard Gaussian to chi square distribution for atleast 3 value of k
%k = 1,2,3,4,5
%X be Chi-Squared random variable
X1 = (Z1.^2);
X2 = (Z1.^2 + Z2.^2);
X3 = (Z1.^2 + Z2.^2 + Z3.^2);
X4 = (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2);
X5 = (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2 + Z5.^2);

%% PDF Plots
figure;
subplot(1,1,1);

% Plot histogram of generated random numbers for k =1,2,3,4,5
% 400 represent number of bins
histogram(X1,400,'Normalization','pdf');
hold on;
histogram(X2,400,'Normalization','pdf');
histogram(X3,400,'Normalization','pdf');
histogram(X4,400,'Normalization','pdf');
histogram(X5,400,'Normalization','pdf');

% Plot theoritical PDF for k =1,2,3,4,5 in f(k) function
plot(x,f(1),'r-','linewidth',3);
plot(x,f(2),'r-','linewidth',3);
plot(x,f(3),'r-','linewidth',3);
plot(x,f(4),'r-','linewidth',3);
plot(x,f(5),'r-','linewidth',3);

legend('Simulated (k=1)','Simulated (k=2)','Simulated (k=3)','Simulated (k=4)','Simulated (k=5)' ,'Theoritical Distribution','Fontsize',FONTSIZE_LEGEND,'Location','northeast');
%legend('Theoritical','Fontsize',FONTSIZE_LEGEND,'Location','northeast');

xlabel('x','Fontsize',FONTSIZE_LABEL);
ylabel('f(x)','Fontsize',FONTSIZE_LABEL);
title('PDF of Chi-Square Distribution');

grid on;axis tight;grid minor;hold off;axis([0 10 0 0.6]);
