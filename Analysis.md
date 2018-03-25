# Quadratic Discriminant Analysis on Position

Using a 5-fold CV and various combination of independent variables:
Error Rate is how often the model is wrong.

| Variable        | Training Error Rate           | Test Error Rate  |
| ------------- |-------------| -----|
| FT%      |  0.440 | 0.441 |
|  FT% and PPG     | 0.439      |   0.439|
| FT% and RPG |0.316      |      0.317 |
| FT% and APG     |  0.366 |  0.367 |
|  FT% and BPG     | 0.318    |   0.317|
| FT% and APG | 0.412      |     0.415 |
| FT% and PPG and RPG | 0.276      |     0.278 |
| FT% and PPG and APG | 0.297      |     0.299 |
| FT% and RPG and APG | 0.225      |     0.225 |
| FT% and PPG and RPG and APG and SPG and BPG | 0.181      |     0.184 |
