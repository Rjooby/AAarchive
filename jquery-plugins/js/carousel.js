(function() {
if (typeof Carousel === "undefined"){
  window.Carousel = {};
};


$.Carousel = function (el) {
  this.transitioning = false;
  this.$el = $(el);
  this.activeIdx = 0;
  this.$el.find("ul.items img:first-child").addClass("active");
  this.$el.find(".slide-right").on('click', function(){
    this.slideRight();
  }.bind(this));
  this.$el.find(".slide-left").on('click', function(){
    this.slideLeft();
  }.bind(this));

};

$.Carousel.prototype.slide = function (dir) {

  if (this.transitioning === true){
    return;
  }

  this.transitioning = true;

  var count = $("ul.items img").length;

  var $activePic = this.$el.find("ul.items img").eq(this.activeIdx);

  this.activeIdx += dir;
  this.activeIdx = this.activeIdx % count;

  var $newPic = this.$el.find("ul.items img").eq(this.activeIdx);
  $newPic.addClass("active");

  if (dir === -1){
    $newPic.addClass("left");
    $activePic.addClass("right");
  } else{
    $newPic.addClass("right");
    $activePic.addClass("left");
  }

  $activePic.one("transitionend", function(){
    $activePic.removeClass();
    this.transitioning = false;
  }.bind(this))

  setTimeout(function(){
    $newPic.removeClass("left right");
  }, 0);
}

$.Carousel.prototype.slideRight = function () {
  this.slide(1);

}

$.Carousel.prototype.slideLeft = function () {
  this.slide(-1);
}








$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
}());
