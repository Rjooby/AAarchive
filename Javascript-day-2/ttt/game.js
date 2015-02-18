var Board = require("./board")
var HumanPlayer = require("./hplayer")
var CompPlayer = require("./cplayer")

function Game (reader) {
  this.reader = reader;
  var board  = new Board;
  var playerOne = new HumanPlayer(reader, "O");
  var playerTwo = new CompPlayer(board, "X");
  var currentPlayer = playerOne;


  this.switchPlayer = function(currentPlayer) {
    return currentPlayer === playerOne ? playerTwo : playerOne;
  };

  this.run = function(completionCallback) {

    var that = this;
    board.render();

    currentPlayer.getPlayerMove(function (pos) {
      if (board.placeMark(pos, currentPlayer.mark) === true) {
        if(board.winner() === currentPlayer.mark) {
          completionCallback(currentPlayer.mark);
        } else if (board.full()) {
          completionCallback("draw");
        } else {
          currentPlayer = that.switchPlayer(currentPlayer);
          that.run(completionCallback);
        }
      } else {
        that.run(completionCallback);
      }
    });

  };
};

module.exports = Game;
