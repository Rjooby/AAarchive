(function() {

  if (typeof Thumbnail === "undefined"){
    window.Thumbnail = {};
  }

  $.Thumbnail = function(el) {
    this.$el = $(el);
    this.gutterIdx = 0;
    this.$images = $(el).find(".gutter-images img");

    this.$el.on('mouseover', '.gutter-images img', function (event){
      var $current = $(event.currentTarget);
      this.activate($current);
    }.bind(this));

    this.$el.on('mouseleave', '.gutter-images img', function(event){
      this.activate(this.$activeImg);
    }.bind(this));

    this.$el.on('click', 'img', function(event){
      var $clicked = $(event.target);
      this.$activeImg = $clicked;
    }.bind(this))


    this.$el.on('click', 'a.nav', function(event){
      var $clicked = $(event.target);
      if ($clicked.hasClass("left")){
        this.gutterIdx--;
        this.gutterIdx = this.gutterIdx % this.$images.length;
      }
      else{
        this.gutterIdx++;
        this.gutterIdx = this.gutterIdx % this.$images.length;
      }
      this.fillGutterImages();

    }.bind(this))

    this.fillGutterImages();
    this.$activeImg = $(el).find(".gutter-images img:first-child");
    this.activate(this.$activeImg);


  }

  $.Thumbnail.prototype.activate = function($img){
    var $clone = $img.clone();
    var $active = $("ul.active");
    $active.html($clone);
  }

  $.Thumbnail.prototype.fillGutterImages = function(){
    var $gutter = this.$el.find(".gutter-images");
    $gutter.empty();
    for (var i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
      // $(this.$images[i % this.$images.length]).appendTo($gutter);
      this.$images.eq(i % this.$images.length).appendTo($gutter);
    }
  }


  $.fn.thumbnail = function () {
    return this.each(function () {
      new $.Thumbnail(this);
    });
  };




}());
