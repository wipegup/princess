Take home code challenge - due 12/15/19 1700 MST


Based off of the `Save the Princess` katas from `hackerrank`

`https://www.hackerrank.com/challenges/saveprincess2`  
and  
`https://www.hackerrank.com/challenges/saveprincess`

Emphasis on:
- Ruby OOP
- Design
- Testing
- Readability
- Use of git and GitHub

# Contents

- [Testing Classes](#testing-classes)
  - [`Grid`](#grid)
  - [`MoveProcessor`](#moveprocessor)
  - [`TextToGrid`](#texttogrid)


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
