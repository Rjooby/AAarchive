(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.board = $el;
    this.startIndex = null;

    this.render();
  };

  View.prototype.render = function () {
    var towerHeight = this.game.towers[0].length;
    var towerString = "<ul class='group'>";
    for (var i = 1; i <= towerHeight; i++) {
      towerString += "<li><h2>"+ i +"</h2></li>";
    }
    towerString += "</ul>";

    var $tower = $(towerString);

    var towerString = "<ul class='group'>";
    for (var i = 1; i <= towerHeight; i++) {
      towerString += "<li><h2></h2></li>";
    }
    towerString += "</ul>";

    var $tower2 = $(towerString);
    var $tower3 = $(towerString);

    this.board.append($tower);
    var $lis = $("li");
    $lis.addClass("filled");


    this.board.append($tower2);
    this.board.append($tower3);


  };

  View.prototype.bindEvents = function () {
    var that = this;
    $("ul").on("click", function () {
      var $ul = $(event.currentTarget);
      if ( (that.startIndex === null) || ( $("ul").index($ul) === that.startIndex) ) {
        that.selectTower($ul);
      } else {
        that.makeMove($ul);
      }
    });
  };

  View.prototype.selectTower = function ($tower) {
    if (this.startIndex === null){
      this.startIndex = $("ul").index($tower);
    } else {
      this.startIndex = null;
    }

    $tower.toggleClass("highlight")
  };

  View.prototype.makeMove = function ($tower) {
    var endIndex = $("ul").index($tower);
    var tower = this.game.towers[this.startIndex];
    var block = tower[tower.length-1];

    if (this.game.move(this.startIndex, endIndex)) {

      var startDisk = $("ul:nth-child("+(this.startIndex+1)+") li.filled").first();

      // ul is wrong
      startDisk.children().remove();
      startDisk.toggleClass("filled");
      var endDisk = $("ul:nth-child("+(endIndex+1)+")  li:not(.filled)").last();
      endDisk.toggleClass("filled");
      endDisk.append($("<h2>"+ block +"</h2>"));
      $("ul:nth-child("+(this.startIndex+1)+")").toggleClass("highlight")
      this.startIndex = null;

      if (this.game.isWon()) {
        $("body").append("<h1>You win.</h1>");
        $("ul").off("click");
      }

    };
  };

})();
