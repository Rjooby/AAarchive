var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame (stacks) {
  this.stacks = stacks;

  this.isWon = function () {
    for(var i = 0; i < this.stacks.length - 1; i++) {
      if ( this.stacks[i].length > 0 ) {
        return false;
      }
    }
    return true;
  };

  this.isValidMove = function(startTowerIdx, endTowerIdx) {
    var start = stacks[startTowerIdx];
    var end = stacks[endTowerIdx];
    if (stacks[startTowerIdx].length === 0) {
      return false;
    } else if (start[start.length - 1] > end[end.length - 1]) {
      return false;
    } else {
      return true;
    }
  };

  this.move = function (startTowerIdx, endTowerIdx) {
    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
      stacks[endTowerIdx].push(stacks[startTowerIdx].pop());
      return true;
    } else {
      return false;
    }
  }

  this.print = function () {
    console.log(JSON.stringify(this.stacks));
  };

  this.promptMove = function (callback) {
    this.print();
    reader.question("Make your move", function(answer){
      var arr = answer.split(',');
      var start = parseInt(arr[0]);
      var end = parseInt(arr[1]);

      callback(start, end);
    })
  };

  this.run = function (completionCallback) {
    var hanoi = this;
    this.promptMove(function(start, end) {
      if (hanoi.move(start, end) === true) {
        if (hanoi.isWon()) {
          completionCallback();
        } else {
          hanoi.run(completionCallback);
        }
      } else {
        console.log("Move failed, try again");
        hanoi.run(completionCallback);
      }
    })
  };
}

var hg = new HanoiGame([[3,2,1],[],[]]);

hg.run(function () {
  console.log("You won!");
  reader.close();
});
