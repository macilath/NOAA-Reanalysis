% Stephen Anthony Ten Eyck
% finalproject.m
% Works with the reanalysis data of:
%   -the horizontal components of the wind (uwind and vwind)
%   -the air temperature (air)
%   -the geopotential height (hgt)
%   -the mean sea-level pressure (slp)
% Asks for input of a starting year, variable to display, what month or
% season to check (if the user selects it), as well as if it should display
% for a certain pressure level or if it is for a certain latitude, lat
clear, clc; % Clear out the memory in case of junk
error=1; 
while error % Set up a while loop in case an invalid input is given
    
yearIn=input('Enter the year for the start of the 30-year period: ');
% Verify it is within acceptable range - data sets are from January 1948 to
% November 2011
    if (yearIn < 1948 || yearIn > 2011)
        error=1;
        else error=0;
    end
    if error
        disp('Incorrect year entered.');
    end
end

error=1; % Reset error value
startYear=yearIn; % Variable to be used later

while error % Next, ask the user for what variable we should be analyzing:
disp('The available variables for display are: ');
disp('1: uwnd, the monthly mean u wind.');
disp('2: vwnd, the monthly mean v wind.');
disp('3: air, the monthly mean air temperature.');
disp('4: hgt, the monthly mean geopotential height.');
disp('5: slp, the monthly mean sea-level pressure.');
varIn=input('Enter the NUMBER of the variable you wish to display: ','s');
% Capture the number entered as a string for our switch statement.
% Switch statement to determine variable to use. If number is out of range,
% error=1
switch varIn
    case '1'
        varTest='uwn';
        error=0;
    case '2'
        varTest='vwn';
        error=0;
    case '3'
        varTest='air';
        error=0;
    case '4'
        varTest='hgt';
        error=0;
    case '5'
        varTest='slp';
        error=0;
    otherwise
        disp('Incorrect variable selected.');
        error=1;
end
end

error=1; % Reset error value
while error % Determines whether we are looking at months, seasons, or entire years
    disp('This is capable of computing means for a specific month, season, or for the whole year.');
typeIn=input('What do you want to compute? (Type month, season, or year) ','s');
% switch three inputs
switch typeIn
    case 'month'
        monthIn=input('What month do you wish to obtain data for? ','s');
        % Switch statment to check months and assign values
        switch monthIn
            case 'January'
              monthNum=1;
              error=0;
            case 'February'
              monthNum=2;
              error=0;
            case 'March'
              monthNum=3;
              error=0;
            case 'April'
              monthNum=4;
              error=0;
            case 'May'
              monthNum=5;
              error=0;
            case 'June'
              monthNum=6;
              error=0;
            case 'July'
              monthNum=7;
              error=0;
            case 'August'
              monthNum=8;
              error=0;
            case 'September'
              monthNum=9;
              error=0;
            case 'October'
              monthNum=10;
              error=0;
            case 'November'
              monthNum=11;
              error=0;
            case 'December'
              monthNum=12;
              error=0;
            otherwise
              error=1;
              disp('Incorrect month entered.');
        end
        % error=0;
    case 'season'
        monthNum=1;
        seasonIn=input('What season do you wish to obtain data for? ','s');
        % firstmonth=12 for summer, 6 for winter, 3 for fall, 9 for spring
        switch seasonIn % Switch statement to check seasons and assign values
            case 'Winter'
                firstmonth=6;
                error=0;
            case 'winter'
                firstmonth=6;
                error=0;
            case 'Summer'
                firstmonth=12;
                error=0;
            case 'summer'
                firstmonth=12;
                error=0;
            case 'Fall'
                firstmonth=3;
                error=0;
            case 'fall'
                firstmonth=3;
                error=0;
            case 'Spring'
                firstmonth=9;
                error=0;
            case 'spring'
                firstmonth=9;
                error=0;
            otherwise
            disp('Season entered incorrectly.');
            error=1;
        end
        % error=0;
    case 'year'
        error=0;
        firstmonth=0;
        monthNum=1;
    otherwise
        disp('Incorrect selection');
        error=1;
end
% YearIN should be the default execution, analyzing ALL the data.
end

% The data is stored on a
% three-dimensional grid: 2.5 degree latitude x 2.5 degree longitude global
% grid (144x73); the 17 pressure (hPa) levels are 1000, 925, 850, 700, 600,
% 500, 400, 300, 250, 200, 150, 100, 70, 50, 30, 20, 10

% This loop only needs to occur as long as varTest is not equal to 'slp'
if (varTest ~= 'slp')
error=1; % Reset error value
while error % This loop is meant to set up whether we are setting up a vertical profile or a contour plot
disp('If you want the mean for a set pressure level, type: pressure.');
disp('If you want a vertical profile for a latitude, longitude, type: location');
plevOrLoc=input('Choose now: ','s');
switch plevOrLoc
    case 'pressure'
        latInScale=0;
        lonInScale=0;
        PrLevel=input('Enter the pressure level in hPa (e.g., 500): ','s');
    switch PrLevel % Switch statement to assign a value to plev
        case '1000'
              plev=1;
              error=0;
        case '925'
              plev=2;
              error=0;
        case '850'
              plev=3;
              error=0;
        case '700'
              plev=4;
              error=0;
        case '600'
              plev=5;
              error=0;
        case '500'
              plev=6;
              error=0;
        case '400'
              plev=7;
              error=0;
        case '300'
              plev=8;
              error=0;
        case '250'
              plev=9;
              error=0;
        case '200'
              plev=10;
              error=0;
        case '150'
              plev=11;
              error=0;
        case '100'
              plev=12;
              error=0;
        case '70'
              plev=13;
              error=0;
        case '50'
              plev=14;
              error=0;
        case '30'
              plev=15;
              error=0;
        case '20'
              plev=16;
              error=0;
        case '10'
              plev=17;
              error=0;
        otherwise
              error=1;
    end
    case 'location'
        plev=0;
        latIn=input('Enter the latitude for the location: ');
        lonIn=input('Enter the longitude for the location: ');
        % Adjust latIn and lonIn to scale
        latInScale=(90-latIn)/(2.5);
        lonInScale=(lonIn)/(2.5);
        % Error check lat,lon (is it within range)
        if (latInScale > 90 || latInScale < -90)
            disp('Invalid Latitude entered');
            error=1;
        end
        if (lonInScale < 0 || lonInScale > 357.5)
            disp('Invalid Longitude entered');
            error=1;
        end
        error=0;
    otherwise
        disp('Incorrect entry.')
        error=1;
end

end 
end

% *********************************************************************** %
% At this point, we are ready to pull things together so we can graph.
disp('Processing...');

% We should also set defaults for varTest = 'slp' (to prevent errors)
if (varTest == 'slp')
    plev=0;
    latInScale=0; % Later tells Matlab we want data for all latitude, longitude
    lonInScale=0;
end

% FIRST we determine our "start" array:
startTime=((startYear-1948)*12)+(monthNum-1); % Find start index for the supplied year. Starts with January by default.

if (plev==0) % Find pressure level index
    startPlev=0;
else 
    startPlev=plev-1;
end

startLat=latInScale; % Find Latitude
startLon=lonInScale; % Find Longitude

% SECOND we will define the "count" array
countTime=360; % Default index is for 30 years, or 360 months

countCheck=startTime+countTime;
if (countCheck >= 767)
    % This small loop makes sure we do not go out of bounds with our 30
    % year index.
    countTime=countTime-(countCheck-767);
    % If we pick a year too close to 2011, we will graph all the data from
    % that point until the end of the data file, index # 767 as noted from
    % nc_dump.
end

% If the graph is for a certain pressure level, then we need to read data
% for all Lat,Lon --> count=[X X -1 -1]
if (startLat==0)
    countLat=-1; 
else 
    countLat=1; % We are either reading all Lat, Lon values or just one value
end
if (startLon==0)
    countLon=-1;
else
    countLon=1;
end
% Likewise, if plev=0, then we are making a vertical profile for all
% pressure levels
if (plev==0)
   countPlev=-1;
else 
   countPlev=1; % Reading either all pressure levels or just one
end

% We should also set defaults for varTest = 'slp' (to prevent errors)
if (varTest == 'slp') % For slp we don't need the pressure level component, set both to zero
    startPlev=0;
    countPlev=0;
end

start=[startTime startPlev startLat startLon];
count=[countTime countPlev countLat countLon]; %-1 means to acquire all data, otherwise it is # of indicies

if (varTest == 'slp') % If we are observing sea-level pressure, we can only look at three variables in slp:
    start2=[startTime startLat startLon];
    count2=[countTime countLat countLon];
end

% Now, we can open and load data
disp('Loading data....');
switch varTest
    case 'uwn'
        variable=nc_varget('uwnd.mon.mean.nc','uwnd',start,count);
        lat=nc_varget('uwnd.mon.mean.nc','lat');
        lon=nc_varget('uwnd.mon.mean.nc','lon');
        level=nc_varget('uwnd.mon.mean.nc','level');
        times=nc_varget('uwnd.mon.mean.nc','time');
    case 'vwn'
        variable=nc_varget('vwnd.mon.mean.nc','vwnd',start,count);
        lat=nc_varget('vwnd.mon.mean.nc','lat');
        lon=nc_varget('vwnd.mon.mean.nc','lon');
        level=nc_varget('vwnd.mon.mean.nc','level');
        times=nc_varget('vwnd.mon.mean.nc','time');
    case 'air'
        variable=nc_varget('air.mon.mean.nc','air',start,count);
        lat=nc_varget('air.mon.mean.nc','lat');
        lon=nc_varget('air.mon.mean.nc','lon');
        level=nc_varget('air.mon.mean.nc','level');
        times=nc_varget('air.mon.mean.nc','time');
    case 'hgt'
        variable=nc_varget('hgt.mon.mean.nc','hgt',start,count);
        lat=nc_varget('hgt.mon.mean.nc','lat');
        lon=nc_varget('hgt.mon.mean.nc','lon');
        level=nc_varget('hgt.mon.mean.nc','level');
        times=nc_varget('hgt.mon.mean.nc','time');
    case 'slp'
        variable=nc_varget('slp.mon.mean.nc','slp',start2,count2);
        lat=nc_varget('slp.mon.mean.nc','lat');
        lon=nc_varget('slp.mon.mean.nc','lon');
        times=nc_varget('slp.mon.mean.nc','time');
        % Sea-Level pressure has three dimensions, so no need for level
        % variable
end
disp('Data loaded successfully...'); % Lets user know that no errors exist so far.

disp('Drawing...'); % Let user know graph is being generated

if (countPlev==1) % If the pressure level is being held constant, we are making a contour map for a certain level.
    
    dimVariable=size(variable); % When holding at a level, we have a three dimensional array
    tdim=dimVariable(1);
    mdim=dimVariable(2);
    ndim=dimVariable(3);
    
    for m=1:mdim
        for n=1:ndim
            for time=1:tdim
                va(m,n,time)=variable(time,m,n); % These for loops rearrange the data so we can easily plot it
            end
        end
    end
    % Switch statement to graph the data dependent on whether we are
    % looking at a month, a season, or the year(s) as a whole.
    switch typeIn
        case 'month' % Code to execute if we are looking at a month's data over the period
            % Similar to season, but one month at a time for 30 months
            time=monthNum;
            mean=zeros(mdim,ndim);
            counter=0;
            while (time <= tdim) % Adds each month's data individually
                mean=mean+va(:,:,time);
                counter=counter+1;
                time=time+12;
            end
            mean=mean/counter;
            %
            mean(:,ndim+1)=mean(:,1);
            lon(ndim+1)=360;
            % We use meshgrid so we can correctly plot the data
            [X,Y]=meshgrid(lon,lat);
            contourf(X,Y,mean);
            xlabel('Longitude');
            ylabel('Latitude');
            colorbar;
            switch varTest % Switch statement to set the title to the right variable
                    case 'uwn'
                        str=sprintf('Mean U Wind Component (m/s) for %s',monthIn);
                        title(str);
                    case 'vwn'
                        str=sprintf('Mean V Wind Component (m/s) for %s',monthIn);
                        title(str);
                    case 'air'
                        str=sprintf('Mean Air Temperature (deg C) for %s',monthIn);
                        title(str);
                    case 'hgt'
                        str=sprintf('Mean Geopotential Height (m) for %s',monthIn);
                        title(str);
            end
            hold on;
            load('topo.mat','topo','topomat1'); % Adds continents to map so reference is easier.
            contour(0:359,-89:90,topo,[0 0],'k','LineWidth',1.1);
            % End case 'month'
        case 'season' % Code to execute if we are looking at seasonal data
            time=firstmonth-1;
            mean=zeros(mdim,ndim);
            counter=0;
            while (time <= tdim) % Adds the data for the three months in a season, then skips to the next year.
                mean=mean+va(:,:,time);
                mean=mean+va(:,:,time+1);
                mean=mean+va(:,:,time+2);
                counter=counter+3;
                time=time+12;
            end
            mean=mean/counter;
            %
            mean(:,ndim+1)=mean(:,1);
            lon(ndim+1)=360;
            % Define the horizontal grid using meshgrid
            [X,Y]=meshgrid(lon,lat);
            contourf(X,Y,mean); % Plot the mean of our seasonal data on the contour plot
            xlabel('Longitude');
            ylabel('Latitude');
            colorbar;
            switch varTest
                    case 'uwn'
                        str=sprintf('Seasonal Mean U Wind Component (m/s) for %s',seasonIn);
                        title(str);
                    case 'vwn'
                        str=sprintf('Seasonal Mean V Wind Component (m/s) for %s',seasonIn);
                        title(str);
                    case 'air'
                        str=sprintf('Seasonal Mean Air Temperature (deg C) for %s',seasonIn);
                        title(str);
                    case 'hgt'
                        str=sprintf('Seasonal Mean Geopotential Height (m) for %s',seasonIn);
                        title(str);
            end
            hold on;
            load('topo.mat','topo','topomat1'); % Adds continents to map so reference is easier.
            contour(0:359,-89:90,topo,[0 0],'k','LineWidth',1.1);
            % End case 'season'
    	case 'year'
            time=1;
            mean=zeros(mdim,ndim);
            counter=0;
            disp('Still working...');
            while (time <= tdim) % Adds each month's data individually.
                mean=mean+va(:,:,time);
                counter=counter+1;
                time=time+1;
            end
            mean=mean/counter;
            %
            mean(:,ndim+1)=mean(:,1);
            lon(ndim+1)=360;
            % Define the horizontal grid using meshgrid
            [X,Y]=meshgrid(lon,lat);
            contourf(X,Y,mean); % Plot the mean of our seasonal data on the contour plot
            xlabel('Longitude');
            ylabel('Latitude');
            colorbar;
            switch varTest
                    case 'uwn'
                        str=sprintf('Yearly Mean U Wind Component (m/s) for %s hPa',PrLevel);
                        title(str);
                    case 'vwn'
                        str=sprintf('Yearly Mean V Wind Component (m/s) for %s hPa',PrLevel);
                        title(str);
                    case 'air'
                        str=sprintf('Yearly Mean Air Temperature (deg C) for %s hPa',PrLevel);
                        title(str);
                    case 'hgt'
                        str=sprintf('Yearly Mean Geopotential Height (m) for %s hPa',PrLevel);
                        title(str);
            end
            hold on;
            load('topo.mat','topo','topomat1'); % Adds continents to map so reference is easier.
            contour(0:359,-89:90,topo,[0 0],'k','LineWidth',1.1);
            % End case 'year'
    end
    disp('Graph displayed, no errors detected'); % successful run
end
% *********************************************************************** %
if (varTest == 'slp')
    % Special case if we are observing the sea level pressure --> we are making a contour map.
    
    dimVariable=size(variable); % When holding at a level, we have a three dimensional array
    tdim=dimVariable(1);
    mdim=dimVariable(2);
    ndim=dimVariable(3);
    %
    for m=1:mdim
        for n=1:ndim
            for time=1:tdim
                va(m,n,time)=variable(time,m,n); % These for loops rearrange the data so we can easily plot it
            end
        end
    end
    % Switch statement to graph the data dependent on whether we are
    % looking at a month, a season, or the year(s) as a whole.
    switch typeIn
        case 'month' % Code to execute if we are looking at a month's data over the period
            % Similar to season, but one month at a time for 30 months
            time=monthNum;
            mean=zeros(mdim,ndim);
            counter=0;
            while (time <= tdim) % Adds each month's data individually
                mean=mean+va(:,:,time);
                counter=counter+1;
                time=time+12;
            end
            mean=mean/counter;
            %
            mean(:,ndim+1)=mean(:,1);
            lon(ndim+1)=360;
            % We use meshgrid so we can correctly plot the data
            [X,Y]=meshgrid(lon,lat);
            contourf(X,Y,mean);
            xlabel('Longitude');
            ylabel('Latitude');
            colorbar;
            str=sprintf('Mean Surface-Level Pressure (hPa) for %s',monthIn);
            title(str);
            %
            hold on;
            load('topo.mat','topo','topomat1'); % Adds continents to map so reference is easier.
            contour(0:359,-89:90,topo,[0 0],'k','LineWidth',1.1);
            % End case 'month'
        case 'season' % Code to execute if we are looking at seasonal data
            time=firstmonth-1;
            mean=zeros(mdim,ndim);
            counter=0;
            while (time <= tdim) % Adds the data for the three months in a season, then skips to the next year.
                mean=mean+va(:,:,time);
                mean=mean+va(:,:,time+1);
                mean=mean+va(:,:,time+2);
                counter=counter+3;
                time=time+12;
            end
            mean=mean/counter;
            %
            mean(:,ndim+1)=mean(:,1);
            lon(ndim+1)=360;
            % Define the horizontal grid using meshgrid
            [X,Y]=meshgrid(lon,lat);
            contourf(X,Y,mean); % Plot the mean of our seasonal data on the contour plot
            xlabel('Longitude');
            ylabel('Latitude');
            colorbar;
            str=sprintf('Seasonal Mean Surface-Level Pressure (hPa) for %s',seasonIn);
            title(str);
            %
            hold on;
            load('topo.mat','topo','topomat1'); % Adds continents to map so reference is easier.
            contour(0:359,-89:90,topo,[0 0],'k','LineWidth',1.1);
            % End case 'season'
    	case 'year'
            time=1;
            mean=zeros(mdim,ndim);
            counter=0;
            disp('Still working...');
            while (time <= tdim) % Adds each month's data individually.
                mean=mean+va(:,:,time);
                counter=counter+1;
                time=time+1;
            end
            mean=mean/counter;
            %
            mean(:,ndim+1)=mean(:,1);
            lon(ndim+1)=360;
            % Define the horizontal grid using meshgrid
            [X,Y]=meshgrid(lon,lat);
            contourf(X,Y,mean); % Plot the mean of our seasonal data on the contour plot
            xlabel('Longitude');
            ylabel('Latitude');
            colorbar;
            title('Yearly Mean Surface-Level Pressure (hPa)');
            %
            hold on;
            load('topo.mat','topo','topomat1'); % Adds continents to map so reference is easier.
            contour(0:359,-89:90,topo,[0 0],'k','LineWidth',1.1);
            % End case 'year'
    end
    disp('Graph displayed, no errors detected'); % successful run
end
% ********************************************************************** % 
% Case for calculating the vertical profile of a given longitude, latitude
if (varTest ~= 'slp') % We can't make a vertical profile of sea level pressure
  
if (countLon==1) % Holding Lon and Lat constant
    % If we are holding lon, lat constant, then our variable is only going to have 2 dimensions.
    
    dimVariable=size(variable);
    tdim=dimVariable(1); % level dim
    ldim=dimVariable(2); % time dim
    
    for l=1:ldim
        for time=1:tdim
            va(l,time)=variable(time,l);
        end
    end  
end

if (plev==0) % When plev = 0, we are making a vertical profile graph
    % when making a vertical profile, reset other loaded variables so we
    % can work with just the level.
    % However, we still have the time variable, so we have to average that
    % data
    
    % Switch statement to graph the data dependent on whether we are
    % looking at a month, a season, or the year(s) as a whole.
    switch typeIn
        case 'month' % Code to execute if we are looking at a month's data over the period
            % Similar to season, but one month at a time for 30 months
            time=monthNum;
            mean=zeros(ldim,tdim);
            counter=0;
            
            while (time <= tdim) % Adds each month's data individually
                mean=mean+va(:,time);
                counter=counter+1;
                time=time+12;
            end
            mean=mean/counter;
            %
            mean(:,ldim+1)=mean(:,1);  
            % End case 'month'
        case 'season' % Code to execute if we are looking at seasonal data
            time=firstmonth-1;
            mean=zeros(ldim,tdim);
            counter=0;
            while (time <= tdim) % Adds the data for the three months in a season, then skips to the next year.
                mean=mean+va(:,time);
                mean=mean+va(:,time+1);
                mean=mean+va(:,time+2);
                counter=counter+3;
                time=time+12;
            end
            mean=mean/counter;
            %
            mean(:,ldim+1)=mean(:,1);
            % End case 'season'
    	case 'year'
            time=1;
            mean=zeros(ldim,tdim);
            counter=0;
            while (time <= tdim) % Adds each month's data individually.
                mean=mean+va(:,time);
                counter=counter+1;
                time=time+1;
            end
            mean=mean/counter;
            %
            mean(:,ldim+1)=mean(:,1);
           % End case 'year'
    end
    
    % Plotting commands from quiz3
    plot(variable,mean)
    set(gca,'YDir','reverse');
    ylabel('Pressure Level [hPa]');
    switch varTest
        case 'uwn'
            xlabel('U component of wind [m/s]');
            title('Vertical Profile of Monthly Mean U component of wind');
        case 'vwn'
            xlabel('V component of wind [m/s]')
            title('Vertical Profile of Monthly Mean V component of wind');
        case 'air'
            xlabel('Air temperature [degrees F]');
            title('Vertical Profile of Monthly Mean Air Temperature');
        case 'hgt'
            xlabel('Geopotential Height [m]');
            title('Vertical Profile of Monthly Mean Geopotential Height');
     end
    
    disp('Graph displayed, no errors detected'); % successful run
end
end