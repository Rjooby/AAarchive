function Clock () {

}

Clock.TICK =5000;

Clock.prototype.printTime = function () {
  var time = this.currentTime.getHours() + ":" + this.currentTime.getMinutes() + ":" + this.currentTime.getSeconds();
  console.log(time);

};

Clock.prototype.run = function () {
  var startTime = new Date();
  this.currentTime = startTime;
  this.printTime();

  // var clock = this;

  setInterval(this._tick.bind(this), Clock.TICK);

  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  this.currentTime.setSeconds(this.currentTime.getSeconds() + 5);
  this.printTime();

  // }, Clock.TICK);
  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();


function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number", function(number) {
      var choice = parseInt(number);
      sum += choice;
      console.log(sum);

      addNumbers(sum, numsLeft -= 1, completionCallback)

    });
  } else {
    completionCallback(sum);

  }

};

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
//   reader.close();
// });

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfLessThan(el1, el2, callback) {
  reader.question(el1 + " < " + el2 + "? ", function (answer) {
    if (answer === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop){
  if (i === (arr.length - 1)) {
    outerBubbleSortLoop(madeAnySwaps);
  } else {
    askIfLessThan(arr[i], arr[i+1], function(isLessThan){
      if (isLessThan === false) {
        var tmp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = tmp;
        madeAnySwaps = true;
      } else {
        madeAnySwaps = false;
      }

      innerBubbleSortLoop(arr, i += 1, madeAnySwaps, outerBubbleSortLoop);
    });
  }
}

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
