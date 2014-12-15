var Board = require("./board")

function CompPlayer(board,mark) {

  this.board = board;
  this.mark = mark;

  this.newBoard = function(){
    var nb = new Board();
    nb.grid = [[],[],[]]
    for(var i = 0; i < this.board.grid.length; i++) {
      for(var j = 0; j < this.board.grid[i].length; j++){
        nb.grid[i][j] = this.board.grid[i][j];
      }
    }
    return nb;
  };

  this.getPlayerMove = function (callback) {
    var move = [];
    var foundMove = false;
    for(var i = 0; i < this.board.grid.length; i++) {
      for(var j = 0; j < this.board.grid[i].length; j++){
        var nb = this.newBoard();
        if (nb.empty([i,j])) {
          move.push([i,j]);
          nb.grid[i][j] = this.mark;
          if (nb.winner() === this.mark){
            foundMove = true;
            callback([i,j]);
            break;
          }
        }
      }
    }
    if (foundMove === false) {
      callback(move[Math.floor(Math.random()*move.length)]);
    }
  };
};

module.exports = CompPlayer;
