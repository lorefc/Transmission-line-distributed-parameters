# Transmission-line-distributed-parameters

A Matlab script that determines the best possible combination of voltage, type/number of conductors per phase for a given transmission line using the distributed parameters model.

For now, it's written in portuguese and doesn't follow standard code formatting.

## How does it work?


1) Conductor data is imported from an Excel file
2) Calculation is performed for each conductor of that list, using every combination of voltage levels and number of conductors per phase
3) Total cost and viability are determined for each scenario
4) Results are organized and stored in the next worksheets

The analysis covered the following possibilities:
- 4 line power levels: 50, 200, 350 and 500 MVA
- 5 voltage levels: 230, 345, 440, 500, 765 kV
- 1 to 4 conductors per phase
- 31 conductors to choose from

Thus, there are 2480 possible scenarios, of which only 606 are considered viable, using the following viability criteria: 
  - Load angle
  - Voltage regulation index
  - Conductor current capacity

By analyzing the results we can find the most viable scenarios for a given transmission line. The data is extensive and can provide us with some interesting insights, such as:

## Data analysis

###### Cost tendency of 500MW scenarios, according to voltage and number of conductors per phase:

> [!NOTE]
> The most viable scenario is in the blue zone.

![Tendência de custo de acordo com nível de tensão e número de condutores por fase](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/bb2c281d-3d71-4fe8-8d50-bb2522a10ccf)

###### Cost tendency of all possible scenarios:
> [!NOTE]
> This is the relationship between power, voltage and cost of a scenario.

![Tendência aproximada do custo total conforme nível de tensão e potência](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/79231fe0-0e98-4646-b92b-b560868cd160)

###### Cost profile of 500MW scenarios, composed by cable, tower and losses costs:
> [!NOTE]
> How much each cost component contributes to total cost in relation to the price of that scenario. Expensive scenarios have an ilogical combination of voltage and cable diameter, as per electrical theory.

![Perfil de custos composto (500MW)](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/1fd8921c-d937-4ec0-bb54-d56def8e713f)

###### Cable ampacity versus current levels of a given scenario:
> [!NOTE]
> All viable scenarios obviously have cables that can handle the current levels of the transmission line. This graph proves it.
 
![amperagem](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/ff98f07c-0aff-474f-b9a1-c6e1090675b6)

> [!NOTE]
> Prices are arbitrary and given in an imaginary monetary unit. A value is assigned to energy losses and construction costs, which vary according to voltage levels and type/number of conductors.
