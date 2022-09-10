# transmission-line-parameters

A Matlab script that performs the distributed parameters model of a 3-phase transmission line for a whole set of conductors.


## How does it work?

The calculation is done for each conductor listed in the first Excel worksheet, for each possible combination of voltage levels and number of conductors per phase. Then, the viable results are stored in the next worksheet. By sorting these results by price we can find the most viable scenarios for a given transmission line.

Prices are arbitrary and given in an imaginary monetary unit. A value is assigned to energy losses and construction costs, which vary according to voltage levels and number of conductors.


--

For now, it's written in portuguese and doesn't follow standard code formatting.
