$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  this.handleClick();
};

$.FollowToggle.prototype.render = function () {

  if (this.followState === "following" || this.followState === "unfollowing"){
    this.$el.prop({disabled: true});
  }

  if (this.followState === "followed"){
    this.$el.prop({disabled: false});
    this.$el.html("Unfollow!");
    console.log(this.$el);
  } else if (this.followState === "unfollowed") {
    this.$el.prop({disabled: false});
    this.$el.html("Follow!");
  }
};

$.FollowToggle.prototype.handleClick = function() {
  var that = this;
  this.$el.on("click", function() {
    event.preventDefault();
    if (that.followState === "unfollowed"){
      that.followState = "following";
      that.render();
      $.ajax({
        url: "/users/" + that.userId + "/follow",
        type: "POST",
        dataType: "json",
        success: function(data){
          that.followState = "followed";
          that.render();
        }
      });
    } else if (that.followState === "followed"){
      that.followState = "unfollowing";
      that.render();
      $.ajax({
        url: "/users/" + that.userId + "/follow",
        type: "DELETE",
        dataType: "json",
        success: function(){
          that.followState = "unfollowed";
          that.render();
        }
      });
    }

  })


}

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
