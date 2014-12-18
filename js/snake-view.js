(function() {
  if (typeof SnakeG === "undefined") {
    window.SnakeG = {};
  }

  var View = SnakeG.View = function ($el) {

    this.element= $el;
    this.board = new SnakeG.Board();

    this.buildBoard();
    this.reDraw([this.board.snake.head()],this.board.apples);

    this.gameOver = false
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $("html").on("keydown", function(event) {
      that.board.snake.turn(that.chooseDir(event.which));
    });
  };

  View.prototype.buildBoard = function () {
    var html = "<ul class='group'>";
    for (var i = 0; i < 400; i++){ //MAYBE FIX IT
      html += "<li></li>";
    }
    html += "</ul>";
    this.element.append($(html));
  };

  View.prototype.chooseDir = function(num) {
    var dir = ""
    switch(num){
      case 37:
        dir = "W";
        break;
      case 38:
        dir = "N";
        break;
      case 39:
        dir = "E";
        break;
      case 40:
        dir = "S";
        break;
      default:
        console.log("Bad input??");
    }
    return dir;
  }

  View.prototype.step = function () {
    var that = this;
    window.setInterval( function () {
      if (that.gameOver) {
        return;
      }
      var appleChanges = that.board.apples.slice(0);

      var collision = that.board.collisionType();
      if (collision === "death") {
        that.gameOver = true;
        that.element.append($("<h1>GAMEOVER</h1>"))
        return;
      }
      var endChange = that.board.snake.move(collision);
      var firChange = that.board.snake.head();

      appleChanges = appleChanges.concat(that.board.apples);
      that.reDraw([firChange,endChange],appleChanges);
    },50)
  };

  View.prototype.reDraw = function (snakeChanges, appleChanges) {
    for (var i = 0; i < snakeChanges.length; i++) {
      var $ele = $("li:nth-of-type("+snakeChanges[i].htmlPos()+")");
      $ele.toggleClass("snake")
    }
    for (var i = 0; i < appleChanges.length; i++) {
      var $ele = $("li:nth-of-type("+appleChanges[i].htmlPos()+")");
      $ele.toggleClass("apple")
    }
  };

})();
