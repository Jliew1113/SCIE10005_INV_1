% Import data from own sensor
% Device ID: dlab-ers-A81758FFFE06B444
CO2 = readtable('CO2 (ppm).csv');
Light = readtable('Light (LUX).csv');
Temp = readtable('Temperature (degC).csv');
RH = readtable('Relative Humidity (%).csv');

% Import data from other's sensor for comparison
% Device ID: dlab-ers-A81758FFFE06B439
CO2_ = readtable('CO2 (ppm) (1).csv');
Light_ = readtable('Light (LUX) (1).csv');
Temp_ = readtable('Temperature (degC) (1).csv');
RH_ = readtable('Relative Humidity (%) (1).csv');

% Convert table to timetable
CO2_T = table2timetable(CO2);
Light_T = table2timetable(Light);
Temp_T = table2timetable(Temp);
RH_T = table2timetable(RH);

CO2_T_ = table2timetable(CO2_);
Light_T_ = table2timetable(Light_);
Temp_T_ = table2timetable(Temp_);
RH_T_ = table2timetable(RH_);

% Resample data using timestep of 15mins
CO2_Tnew = retime(CO2_T, 'regular', 'linear', 'Timestep', minutes(15));
Light_Tnew = retime(Light_T, 'regular', 'linear', 'Timestep', minutes(15));
Temp_Tnew = retime(Temp_T, 'regular', 'linear', 'Timestep', minutes(15));
RH_Tnew = retime(RH_T, 'regular', 'linear', 'Timestep', minutes(15));

CO2_T_new = retime(CO2_T_, 'regular', 'linear', 'Timestep', minutes(15));
Light_T_new = retime(Light_T_, 'regular', 'linear', 'Timestep', minutes(15));
Temp_T_new = retime(Temp_T_, 'regular', 'linear', 'Timestep', minutes(15));
RH_T_new = retime(RH_T_, 'regular', 'linear', 'Timestep', minutes(15));

% Sync all atrributes of each sensor into one table
All = synchronize(CO2_Tnew, Light_Tnew, Temp_Tnew, RH_Tnew);
All_ = synchronize(CO2_T_new, Light_T_new, Temp_T_new, RH_T_new);

% Create array for time
t = [0: 15/60 : 15/60*672];
t = transpose(t);

% Extract data of each attributes from each sensor
CO2data = All{:,1};
Lightdata = All{:,2};
Tempdata = All{:,3};
RHdata = All{:,4};
RHdata_ = All_{:,4};
Tempdata_ = All_{:,3};
Lightdata_ = All_{:,2};
CO2data_ = All_{:,1};

% Combine array
tvslight = [t Lightdata];

% Remove outliers
outliers = (Lightdata > 250);
tvslight(outliers, :) = [];
light_tvslight=tvslight(:,2);
Lightdata_interp=interp1(t_tvslight,light_tvslight,t);
plot(t, Lightdata,'bo',t,Lightdata_interp,'rx');










