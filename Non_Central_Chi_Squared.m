%% clear console,remove all variables from memory, close all figures
clc; clearvars; close all;

%% INPUT Configurations
% N : Number of samples
% x : row vector of equally spaced numbers
N = 1e6;
x = 0:0.01:50;
k = 2;%k = degrees of freedom
s = 5;%lamda = non-centrality parameter

% Plot Configurations
FONTSIZE_LABEL = 14;
FONTSIZE_LEGEND = 14;

%% Main Program

% Define theoritical PDF of Non-Central Chi-Squared distribution
%function for value of k degree of freedom
%nu = k/2 - 1;
%z = sqrt(s*x);
%bessl = besseli(nu, z);
f = @(k) 0.5 * (x / s).^((k-2)/4) .* exp(-0.5*(x + s)) .* besseli(k/2 - 1, sqrt(s*x));

% Generate vector of normally distributed random numbers
% having 1 random variable 'mean sqrt(s) and variance 1'
% and others having mean 0 and variance 1
Z1 = randn(1,N) + sqrt(s) ;
Z2 = randn(1,N);
Z3 = randn(1,N);
Z4 = randn(1,N);
Z5 = randn(1,N);
Z6 = randn(1,N);
%Transform standard Gaussian to Non-Central Chi-Squared distribution for atleast 3 value of k
% k = 2,4,6
%X be Non-Central Chi-Squared random variable
X1 = (Z1.^2 + Z2.^2);
X2 = (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2);
X3 = (Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2 + Z5.^2 + Z6.^2);

%% PDF Plots
figure;
subplot(1,1,1);

% Plot histogram of generated random numbers for k =2,4,6
% 200 represent number of bins
histogram(X1,200,'Normalization','pdf');
hold on;
histogram(X2,200,'Normalization','pdf');
histogram(X3,200,'Normalization','pdf');


% Plot theoritical PDF  for k =2,4,6 in f(k) function
plot(x,f(2),'r-','linewidth',3);
plot(x,f(4),'r-','linewidth',3);
plot(x,f(6),'r-','linewidth',3);

legend('Simulated (k=2)','Simulated (k=4)','Simulated (k=6)','Theoritical Distribution','Fontsize',FONTSIZE_LEGEND,'Location','northeast');
%legend('Theoritical','Fontsize',FONTSIZE_LEGEND,'Location','northeast');

xlabel('x','Fontsize',FONTSIZE_LABEL);
ylabel('f(x)','Fontsize',FONTSIZE_LABEL);
title('PDF of Non-Central Chi-Squared Distribution');

grid on;axis tight;grid minor;hold off;axis([0 30 0 0.13]);