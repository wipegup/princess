
# Note
**The contents of `lib/functions.rb` define the methods necessary to complete the challenges**

# Contents
- [Introduction](#introduction)
- [Design Choices](#design-choices)
  - [The Methods](#the-methods)
  - [The Testing](#the-testing)
    - [stdout](#stdout)
- [Git/hub Use](#git/hub-use)
- [Testing Classes](#testing-classes)
  - [`Grid`](#grid)
  - [`MoveProcessor`](#moveprocessor)
  - [`TextToGrid`](#texttogrid)

## Introduction
Take home code challenge - due 12/15/19 1700 MST

Based off of the `Save the Princess`[1](https://www.hackerrank.com/challenges/saveprincess) & [2](https://www.hackerrank.com/challenges/saveprincess) katas from `hackerrank`

Emphasis on:
- Ruby OOP
- Design
- Testing
- Readability
- Use of git and GitHub  

Uses:  
- Ruby 2.4.1  
- RSpec 3.8  

After cloning, tests may be run with `rspec` from the project root.

**The contents of `lib/functions.rb` define the methods necessary to complete the challenges**  

## Design Choices
### The Methods

Both challenges call for relatively simple methods. Thus, the methods in `lib/functions` are relatively simple.
Furthermore, `princess 2`/ `nextMove` may be completed by leveraging the work from  `princess 1`.  

The supplied `nextMove` method includes a fifth argument `stand_alone`(defaulted to `false`)
- when `stand_alone = false`, `nextMove` calls `dependent_next_move`, and uses `displayPathtoPrincess`
- when `stand_alone = true`, `nextMove` calls `stand_alone_next_move`, which does **not** use `displayPathtoPrincess`

Each solution has its merits: one uses re-usable code; the other allows logic to appropriately short-circuit.  

### The Testing

The testing process offered the best opportunity to use `Ruby` classes.  

- By evaluating a series of moves, `displayPathtoPrincess` could be tested.  
- By evaluating a move and returning the new state of the grid `nextMove` could be tested.  

The `Grid` class ingested information about the puzzle grids and ensured the grids met specifications. Additionally, `Grid`, contains the logic to determine how a grid would change after a move.  

To keep track of the moves, and to return objects in a method friendly manner, `MoveProcessor` was created. It can accept a single move or list of moves, keep track of those moves, and feed them to its `Grid` object as appropriate.  

Within `display_path_to_princess_spec` and `next_move_spec`, methods are built out that provide a grid to `Grid` via a `.txt` file, query `displayPath...` or `nextMove`, and use `MoveProcessor` to evaluate the results.  

Each class also has a dedicated `_spec` file.

#### stdout

The challenges describe that the methods simply need to *print* the appropriate directions. They do not need to *return* anything. Initially the methods both printed and returned their moves. In their current state, the methods only print the moves. This seemed like a good opportunity to learn more about how to test / manage ruby output.  

*See Also [Issue #16](https://github.com/wipegup/princess/issues/16)*  

[More complete documentation on the classes is available below](#testing-classes)

## Git/hub Use

A `PR` was completed for each major block of functionality.  

When appropriate commits were squashed. In particular, during the development of `Grid` and `MoveProcessor`, multiple commits squashed, resulting in a `PR` of one commit.  

A GitHub project was made, but progress was primarily represented by the closing / opening of issues.

## Testing Classes
### `Grid`
Utility class to keep track of grid state  
#### Initialization
`grid_info`: a hash which contains EITHER:\
- `path: <path to file>`
- `array: <array of strings>`

#### Instance Methods
##### `move(direction)`
Argument:  
`direction` a string direction ('LEFT', 'RIGHT', 'UP' or 'DOWN')  

Action:  
If move solves grid, sets `@solved` to `true`
Returns:  
- `false` if move is invalid
- `true` if move is valid

##### `solved?`
Returns:
Boolean -- whether or not grid is solved, e.g. "m" and "p" are in same cell  

##### `r`
Returns:
Integer row location of "m" in grid

##### `c`

Returns:  
Integer column location of "m" in grid

--------------------

### `MoveProcessor`
Utility class to interface with `nextMove` and `DisplayPathtoPrincess`.

#### Initialization
`grid`: a valid `Grid` object

#### Instance Methods
##### `move(direction)`
Argument:  
`direction`: a string direction  

Returns:  
- `true` if move solved grid
- `false` if move is not valid
- `[n, r, c, grid]` where:
  - `n` is grid size
  - `r` and `c` are row and column position of the 'm' character
  - `grid` is an array of strings representing the resultant state of the grid.

##### `move_list(direction_list)`
Argument:  
`direction_list`: new-line delineated list of directions  

Returns:  
- `true` if directions solve the grid
- `false` otherwise  

##### `best_score?`
Returns:
- `nil` if grid is not solved
- `true` if grid was solved in minimum moves
- `false` if grid was solved but not in minimum moves  

#### `moves`

Returns:  

String array of moves already taken

-----------------

### `TextToGrid`

Module with one method, used in `Grid`

#### `path_to_grid`
Arguments:  
`path` - string: path to file containing grid information  
Returns:  
Array of strings; All lines from the file, starting with first line that contains a '-', 'm' or 'p', denoting the start of the grid information
