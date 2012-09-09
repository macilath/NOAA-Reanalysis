Reanalysis of NOAA data 
=======================
The NCEP / NCAR Project
-----------------------


General Info
------------

>This MATLAB script works with the reanalysis data of:
   *the horizontal components of the wind (uwind and vwind)
   *the air temperature (air)
   *the geopotential height (hgt)
   *the mean sea-level pressure (slp)

>It asks for input of a starting year, variable to display, what month or
season to check (if the user selects it), as well as if it should display
for a certain pressure level or if it is for a certain latitude, longitude

Dependencies
------------
 + MATLAB
 + The following files from the [NCEP/NCAR Website:]: http://www.esrl.noaa.gov/psd/data/gridded/data.ncep.reanalysis.derived.pressure.html
	+ air.mon.mean.nc
	+ uwnd.mon.mean.nc
	+ vwnd.mon.mean.nc
	+ hgt.mon.mean.nc
	+ slp.mon.mean.nc
 + NetCDF installed and configured with MATLAB

This was last tested using the available .nc files during December, 2011. 
