# Testing Plan

## Unit Test Mechanics

### Pirate chest

- Click on chest: Minus lives
- Click on chest (no pirate); Minus lives
- Click on chest (pirate): Add booty
- Click anywhere else: Nothing happens

## Boundary Cases

### Amount of points

- 0 booty: Nothing happens
- 1000000 booty: Nothing happens
- Below amount of booty for item: Nothing happens
- Amount of booty for item: Item purchased, booty = booty - price
- Above amount of booty for item: Item purchased, booty = booty - price

## Integration Testing

### Score Calculation

- The player pounds no pirates: No score added
- The player pounds one pirate: Adequate score added
- The player pounds many pirates: Adequate score added
