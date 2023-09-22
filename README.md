# Transmission-line-distributed-parameters

A Matlab script that determines the best possible combination of voltage, type/number of conductors per phase for a given transmission line using the distributed parameters model.

For now, it's written in portuguese and doesn't follow standard code formatting.

## How does it work?

1) Conductor data is imported from an Excel file
2) Calculation is performed for each conductor of that list, using every combination of voltage levels and number of conductors per phase
3) Total cost and viability are determined for each scenario
4) Results are organized and stored in the next worksheets

The analysis covered the following possibilities:
▪ 4 line power levels: 50, 200, 350 and 500 MVA
▪ 5 voltage levels: 230, 345, 440, 500, 765 kV
▪ 1 to 4 conductors per phase
▪ 31 conductors to choose from

Thus, there are 2480 possible scenarios, of which only 606 are considered viable, using the following viability criteria: 
  - Load angle
  - Voltage regulation index
  - Conductor current capacity


## Data analysis

By analyzing the results we can find the most viable scenarios for a given transmission line, as well as some interesting insights, such as:

Cost tendency 500MW scenarios, according to voltage and number of conductors per phase
![Tendência de custo de acordo com nível de tensão e número de condutores por fase](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/88c04d97-80f6-4ae3-95f5-20fe8db018d3)


Tendência aproximada do custo total conforme nível de tensão e potência

![Tendência aproximada do custo total conforme nível de tensão e potência](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/0978e400-a823-4da6-8b6d-27bdee4fecea)

Perfil de custos composto (500MW)

![Perfil de custos composto (500MW)](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/af16a068-315f-4c69-9b52-36d09d646817)

amperagem
![amperagem](https://github.com/lorefc/Transmission-line-distributed-parameters/assets/108432416/6469623a-52d5-42c0-a25b-c338d2d8d4a3)


> [!NOTE]
> Prices are arbitrary and given in an imaginary monetary unit. A value is assigned to energy losses and construction costs, which vary according to voltage levels and type/number of conductors.




--
