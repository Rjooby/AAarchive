(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.grid = $el;

    this.setupBoard();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $("li").on("click", function () {
      if (that.game.isOver()) {
        return;
      }
      var $li = $(event.currentTarget);
      that.makeMove($li);
    });
  };

  View.prototype.makeMove = function ($square) {
    var $lis = $("li");
    var index = $lis.index($square);
    $square.addClass(this.game.currentPlayer);
    this.game.playMove([Math.floor(index / 3), index % 3]);

    if (this.game.isOver()) {
      if (this.game.winner()){
        var $winner = $("<h1>Winner!</h1>");
        this.grid.append($winner);

      } else {
        var $draw = $("<h1>Draw!</h2>");
        this.grid.append($draw);
      }
    }


  };




  View.prototype.setupBoard = function () {
    var $html = $("<ul class='group'><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li></ul>");
    this.grid.append($html);

  };
})();
