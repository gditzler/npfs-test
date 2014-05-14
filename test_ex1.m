%% simple example code
clc
clear
close all

% you will need to change this to add in your feast paths...
addpath(genpath('~/Git/thesis-code/feat_sel/FEAST/'));
%addpath('~/Git/thesis-code/utils/');

n_samples = 1000;
n_features = 25;
n_relevent = 5;
n_bootstraps = 100;
alpha =0.01;
n_select = 10; % change to 10, 15, 24 (or whatever)
method = 'mim';

% deal with parallel computing 
delete(gcp); % close a pool if its open
parpool('local', 4);

% generate some data
[data, labels] = uni_data(n_samples, n_features, n_relevent, 'hard');
[idx, X] = npfs(data, labels, method, n_select, n_bootstraps, alpha, 0);
delete(gcp); % close a pool if its open

h = figure;
hold on;
X(idx,:) = .5; % change the color of the index NPFS selects
[x,y] = meshgrid(1:25, 1:100);
pcolor(y,x,X');
colormap(hot)
xlabel('bootstraps', 'FontSize', 22)
ylabel('feature', 'FontSize', 22)
set(gca, 'fontsize', 22);
save('results.mat')
saveas(h, 'result.fig')
saveas(h, 'result.png')