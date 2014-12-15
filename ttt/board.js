function Board () {
  this.grid = [[],[],[]];
  for(var i = 0; i < this.grid.length; i++) {
    this.grid[i].push('*');
    this.grid[i].push('*');
    this.grid[i].push('*');
  }

  this.won = function() {
    var board = this;
    var grid = board.grid

    //Check rows & columns
    for(var i = 0; i < grid.length; i++) {
      if (grid[i][0] === grid[i][1] &&
          grid[i][0] === grid[i][2] && grid[i][0] !== '*') {
        return grid[i][0];
      } else if (grid[0][i] === grid[1][i] &&
                 grid[0][i] === grid[2][i] && grid[0][i] !== '*') {
        return grid[0][i];
      }
    }

    //Check diagonals
    if (grid[0][0] === grid[1][1] &&
        grid[0][0] === grid[2][2] && grid[0][0] !== '*') {
      return grid[0][0];
    } else if (grid[0][2] === grid[1][1] &&
               grid[0][2] === grid[2][0] && grid[0][0] !== '*') {
      return grid[0][2];
    }
    return -1;
  };

  this.winner = function() {
    return this.won() === -1 ? -1 : this.won();
  };

  this.full = function() {
    for(var i = 0; i < this.grid.length; i++) {
      for(var j = 0; j < this.grid[i].length; j++) {
        if (this.grid[i][j] === '*') {
          return false;
        }
      }
    }
    return true;
  }

  this.empty = function(pos) {
    return this.grid[pos[0]][pos[1]] === '*';
  };

  this.placeMark = function(pos, mark) {
    if (this.empty(pos)) {
      this.grid[pos[0]][pos[1]] = mark;
      return true;
    } else {
      console.log("Invalid move");
      return false;
    }
  };

  this.render = function() {
    console.log("");
    for(var i = 0; i < this.grid.length; i++){
      console.log(JSON.stringify(this.grid[i]));
    }
  };
};

module.exports = Board;
