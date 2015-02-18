

function HumanPlayer(reader, mark) {

  this.reader = reader;
  this.mark = mark;

  this.getPlayerMove = function (callback) {
    reader.question(this.mark + " make your move ", function(pos){
      callback(pos.split(","));
    });
  };
};

module.exports = HumanPlayer;
