% GENERIC INLET GEOMETRY 
clear all clc % Input Coordinates %———————————————
x = [0.501792114695 1.24521072797; -0.00358422939068 1.24521072797; -0.462365591398 1.22222222222; -0.802867383513 1.1877394636; -1.08243727599 1.12643678161; -1.18996415771 1.06896551724; -1.19713261649 1.01915708812; -1.15053763441 0.973180076628;-1.0394265233 0.938697318008; -0.910394265233 0.931034482759; -0.720430107527 0.942528735632; -0.390681003584 0.984674329502; 0 1; 0.3 1; % dummy node
0.3 0.298850574713; % dummy node
0 0.298850574713; -0.0931899641577 0.27969348659; -0.204301075269 0.275862068966; -0.321428571429 0.232824427481; -0.489285714286 0.145038167939; -0.731182795699 0];
% x and y coordinates
y = x(:,2); x = -x(:,1);
% Use spline function to generate nacelle geometry %———————————————

nacelle = [spline(0:13,x(1:14,1),0:0.1:13) ;
spline(0:13,y(1:14,1),0:0.1:13) ];
% find relevant data - exclude dummy nodes

for g = 1:length(nacelle) if nacelle(1,g) < 0 && nacelle(2,g) <= 1.1 junk(:,g) = nacelle(:,g); else n(:,g) = nacelle(:,g); end end
% remove zeros
x_info = find(n(1,:)); y_info = find(n(2,:)); if length(x_info) >= length(y_info) nacelle = n(:,x_info); else nacelle = n(:,y_info); end
% Use spline function to generate spinner geometry %———————————————
s2 = (x(15:21)+abs(min(x(15:21))))*100;
spinner = [spline(s2,x(15:21,1),0:0.1:max(s2));spline(s2,y(15:21,1),0:0.1:max(s2))];
% find relevant data - exclude dummy nodes
for g = 1:length(spinner)
if spinner(1,g) >= 0 s(:,g) = spinner(:,g); end end
% remove zeros
x_info = find(s(1,:)); y_info = find(s(2,:)); if length(x_info) >= length(y_info) spinner = s(:,x_info); else spinner = s(:,y_info); end
spinner(:,733) = [0.731182795699;0];
% Generate fan face %———————————————
fan_y = 0.298850574713:(1-0.298850574713)*1e-3:1; fan_x = zeros(1,length(fan_y));
% Redefining the geometry %———————————————% The fan radius is 1.2m
fan_x = fan_x'*1.2; fan_y = fan_y'*1.2;
liner = zeros(length(nacelle(1,end-34:end-2)),2);
nacelle = nacelle'*1.2; spinner = spinner'*1.2; nacelle(:,1) = nacelle(:,1)+0.123; spinner(:,1) = spinner(:,1)+0.123; liner(:,1) = nacelle(end-34:end-2,1); liner(:,2) = nacelle(end-34:end-2,2);
% plot generic inlet geometry %———————————————–
figure
% plot nacelle
plot(nacelle(:,1),nacelle(:,2),'Linewidth',1.5); hold on;
% plot liner position
plot(liner(:,1),liner(:,2),'-r','Linewidth',3);
% plot fan plan
plot([fan_x(1) fan_x(1)+0.123],[fan_y(1) fan_y(1)],'Linewidth',1.5);
plot([fan_x(end) fan_x(end)+0.123],[fan_y(end) fan_y(end)],'Linewidth',1.5);
plot(fan_x,fan_y);
% plot spinner
plot(spinner(:,1),spinner(:,2),'Linewidth',1.5);
% plot axis
grid on
set(gca,'Fontsize',16,'Ylim',[0 2],'YTick',[0:0.2:2])
set(gca,'Fontsize',16,'Xlim',[0 2],'XTick',[0:0.2:2])
xlabel('x (m)');
ylabel('r (m)');
print(gcf,'-depsc','Generic nacelle')
hold off
clear g junk n s s2 x_info y_info
% End of the Script
%———————————————–
