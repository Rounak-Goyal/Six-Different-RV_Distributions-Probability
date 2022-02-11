%% clear console,remove all variables from memory, close all figures
clc; clearvars; close all;

%% INPUT Configurations
% N : Number of samples
% x : row vector of equally spaced numbers
N = 1e6;
x = 0:0.01:10;
v = 5;%parameter v distance between the reference point and the center of the bivariate distribution
sigma = 1;%scale sigma
sigmasq = sigma * sigma;

% Plot Configurations
FONTSIZE_LABEL = 14;
FONTSIZE_LEGEND = 12;

%% Main Program

%Define theoritical PDF of Rice distribution
%function for diff. value of v
%arg = v * x / sigmasq;
%bessl = besseli(0, v * x / sigmasq);
f = @(v) (x/sigmasq) .* exp(-(x.*x + v*v)/(2*sigmasq)) .* besseli(0, v * x / sigmasq) ;

% Generate vector of normally distributed random numbers
% with mean 0 and variance 1
Z1 = randn(1,N);
Z2 = randn(1,N);

%Transform standard Gaussian to Rice distribution for atleast 3 value of v
t = randn(1,N); %t any real no. distributed
%y1 and y2 are two normal random variable having u = vcos(t) and SD = sigma
%making funtion in variable v
y1 = @(v) Z1*sigma + v*cos(t);
y2 = @(v) Z2*sigma + v*sin(t);
%relation in rice and N variable is R = sqrt(y1^2 + y2^2);
%for v = 0,1,2,3,4  
%X be rice random variable
X1 = sqrt(y1(0).^2 + y2(0).^2);
X2 = sqrt(y1(1).^2 + y2(1).^2);
X3 = sqrt(y1(2).^2 + y2(2).^2);
X4 = sqrt(y1(3).^2 + y2(3).^2);
X5 = sqrt(y1(4).^2 + y2(4).^2);

%% PDF Plots
figure;
subplot(1,1,1);

% Plot histogram of generated random numbers v =0,1,2,3,4
% 100 represent number of bins
histogram(X1,100,'Normalization','pdf');
hold on;
histogram(X2,100,'Normalization','pdf');
histogram(X3,100,'Normalization','pdf');
histogram(X4,100,'Normalization','pdf');
histogram(X5,100,'Normalization','pdf');

% Plot theoritical PDF for v =0,1,2,3,4 in f(k) function
plot(x,f(0),'r-','linewidth',3);
plot(x,f(1),'r-','linewidth',3);
plot(x,f(2),'r-','linewidth',3);
plot(x,f(3),'r-','linewidth',3);
plot(x,f(4),'r-','linewidth',3);

legend('Simulated (v=0)','Simulated (v=1)','Simulated (v=2)','Simulated (v=3)','Simulated (v=4)' ,'Theoritical Distribution','Fontsize',FONTSIZE_LEGEND,'Location','northeast');
%legend('Theoritical','Fontsize',FONTSIZE_LEGEND,'Location','northeast');

xlabel('x','Fontsize',FONTSIZE_LABEL);
ylabel('f(x)','Fontsize',FONTSIZE_LABEL);
title('PDF of Rice Distribution');

grid on;axis tight;grid minor;hold off;axis([0 8 0 0.7]);