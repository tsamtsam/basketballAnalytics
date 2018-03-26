# Quadratic Discriminant Analysis on Position

Using a 5-fold CV and various combination of independent variables:
Error Rate is how often the model is wrong.

| Variable        | Training Error Rate           | Test Error Rate  |
| ------------- |-------------| -----|
| FT%      |  0.440 | 0.441 |
|  FT%, PPG     | 0.439      |   0.439|
| FT%, RPG |0.316      |      0.317 |
| FT%, APG     |  0.366 |  0.367 |
|  FT%, BPG     | 0.318    |   0.317|
| FT%, APG | 0.412      |     0.415 |
| FT%, PPG, RPG | 0.276      |     0.278 |
| FT%, PPG, APG | 0.297      |     0.299 |
| FT%, RPG, APG | 0.225      |     0.225 |
| PPG, RPG, APG, SPG, BPG | 0.181      |     0.183 |
| FT%, PPG, RPG, APG, SPG, BPG | 0.181      |     0.184 |
