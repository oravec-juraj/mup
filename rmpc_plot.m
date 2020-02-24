% RMPC_PLOT
%

% Copyright is with the following author(s):
%
% (c) 2016 Juraj Oravec, Slovak University of Technology in Bratislava,
% juraj.oravec@stuba.sk
% (c) 2016 Monika Bakosova, Slovak University of Technology in Bratislava,
% monika.bakosova@stuba.sk
% ------------------------------------------------------------------------------
% Legal note:
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public
% License along with this library; if not, write to the
% Free Software Foundation, Inc.,
% 59 Temple Place, Suite 330,
% Boston, MA 02111-1307 USA
%
% ------------------------------------------------------------------------------

function data_xu = rmpc_plot(varargin)

% Ensure backward compatibility with MATLAB r2013b or sooner
v = ver('MATLAB');
if(str2num(v.Version) <= 8.2)
    data_xu = rmpc_plot_r13b(varargin);
else
    
% Open new figure
%
fh = fig_opened;
if(isempty(fh))
    fh = 1;
else
    fh = fh(end) + 1;
end

style{1,1} = '-';
style{2,1} = '-';
style{3,1} = '-';
style{4,1} = '-';

col{1,1} = [0 0 1];
col{2,1} = [1 0 0];
col{3,1} = [0 0.7 0];
col{4,1} = [0.6 0 0.4];
col{5,1} = [1 0.6 0];
col{6,1} = 'm';

for n = 1 : nargin

style_n = n;
if(style_n > length(style))
    style_n = 1;
end % if

col_n = n;
if(col_n > length(col))
    col_n = 1;
end % if

data = varargin{n};

data_xu{1,1} = data.x;
data_xu{2,1} = data.u;
if(exist('data.ts') ~= 1)
    data.ts = 1; % Default value of sampling time "ts"
end % 
ts = data.ts;

% Problem Sizes
%
nx = size(data.x{1},1);
nu = size(data.u{1},1);
nv = size(data.x,1);

ylab_str{1} = 'x';
ylab_str{2} = 'u';

% Init Figure
%
figure(fh)
nb = [nx,nu]; % number of variabl-types (states&inputs)
for b = 1 : length(nb)
    subplot(2,1,b)
    hold on
    xlabel('t')
    ylabel(ylab_str{b})
    box on
end % for b

for b = 1 : length(nb)
str_leg = {};
cnt_leg = 0; % counter of legend items
d = data_xu{b};
t = [0:size(d{1},2)-1]'*ts;
for v = 1 : nv
for k = 1 : nb(b)
    subplot(2,1,b)
    if(b == 1)
        plot(t(1:length(d{v}(k,:))),d{v}(k,:),style{style_n})
    else
        stairs(t(1:length(d{v}(k,:))),d{v}(k,:),style{style_n})
    end
    % plot(t,d{v}(:,k),style{style_n},'Color',col{col_n})
    cnt_leg = cnt_leg + 1;
end % for k
end % for v
end % b

end % for n

for b = 1 : length(nb)
    subplot(2,1,b)
    leg = [];
    for n = 1 : nargin
        data = varargin{n};
        data_xu{1,1} = data.x;
        data_xu{2,1} = data.u;
        leg_item = dataleg(data_xu{b});
        leg = [leg;leg_item];
        legend(leg)
        legend('off')
        legend('location','best')
        % legend('location','bestoutside')
    end % for n
end % for b

end % if v.Vesrions

end % function