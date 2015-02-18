(function() {
  if (typeof SnakeG === "undefined") {
    window.SnakeG = {};
  }

  var Snake = SnakeG.Snake = function () {
    this.dir = null;
    this.segments = [new Coord(10,10)]; //array of coords
  };

  Snake.DIRS = ["N", "E", "S", "W"]

  Snake.prototype.move = function (collision) {
    this.segments.unshift(this.segments[0].plus(this.dir));
    if (collision === "grow") {
      return new Coord(10000,10000);
    } else {
      return this.segments.pop();
    }
  };

  Snake.prototype.grow = function () {
    this.segments.push(this.segments[this.segments.length-1]);
  }

  Snake.prototype.turn = function (align) {
    if (Math.abs(Snake.DIRS.indexOf(align) - Snake.DIRS.indexOf(this.dir)) !== 2 || this.dir === null){
      this.dir = align;
    }
  };

  Snake.prototype.head = function () {
    return this.segments[0];
  };

  var Coord = SnakeG.Coord = function (x,y) {
    this.x = x;
    this.y = y;
  };

  Coord.prototype.plus = function (dir) {
    var newX = this.x;
    var newY = this.y;
    switch (dir) {
      case "N":
        newY -= 1;
        break;
      case "S":
        newY += 1;
        break;
      case "E":
        newX += 1;
        break;
      case "W":
        newX -= 1;
        break;
      default:
        console.log("wrong dir")
    }
    return new Coord(newX,newY);
  };

  Coord.prototype.htmlPos = function () {
    return this.y * Board.SIZE + this.x + 1;
  };

  Coord.prototype.compare = function (ocoord) {
    return ocoord.x === this.x && ocoord.y === this.y && this !== ocoord;
  }

  var Board = SnakeG.Board = function () {
    this.snake = new Snake();
    this.apples = [];
    this.addApple();
  };

  Board.SIZE = 20;

  Board.prototype.addApple = function () {
    this.apples.push(this.makeApple());
  };

  Board.prototype.makeApple = function () {
    var newX = Math.floor(Math.random() * Board.SIZE);
    var newY = Math.floor(Math.random() * Board.SIZE);
    return new Coord(newX, newY);
  };

  Board.prototype.collisionType = function () {
    var currX = this.snake.head().x
    var currY = this.snake.head().y
    if (currX >= Board.SIZE || currX <= 0 || currY >= Board.SIZE || currY <= 0) {
      return 'death';
    }
    for (var i = 0; i < this.snake.segments.length; i++) {
      if (this.snake.head().compare(this.snake.segments[i])) {
        return 'death';
      }
    }
    for (var i = 0; i < this.apples.length; i++) {
      if (this.snake.head().compare(this.apples[i])) {
        this.apples[i] = this.makeApple();
        return 'grow';
      }
    }
    return null;
  };



}());
