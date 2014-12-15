var Ttt = require("./ttt");


var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var b = new Ttt.Board();
var g = new Ttt.Game(reader);

g.run(function (status) {
  if (status === "draw") {
    console.log("It's a draw!");
  } else if (status === "X") {
    console.log("Player X Wins!");
  } else if (status === "O") {
    console.log("Player O Wins!");
  }
  reader.close();
});
