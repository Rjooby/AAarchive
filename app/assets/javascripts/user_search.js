$.usersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input.search");
  this.$ul = this.$el.find("ul.users");
  this.handleInput();

};

$.usersSearch.prototype.handleInput = function () {
  var that = this;

  this.$input.on("keyup", function(event){
    var value = $(this).val();
    $.ajax({
      url: "/users/search",
      type: "GET",
      dataType: "json",
      data: {
          query: value
      }, success: function (response) {
        that.renderResults(response);
      }
    });

  })

};

$.usersSearch.prototype.renderResults = function (response) {
  this.$ul.empty();
  var that = this;

  response.forEach(function (user) {
    var userUrl = '<li><a href="/users/'+user.id+'">'+user.username+'</a></li>';
    var $button = $('<button class="follow-toggle"></button>');
    var followState = user.followed? "followed" : "unfollowed";
    that.$ul.append(userUrl).append($button);
    $button.followToggle({userId: user.id, followState: followState});
  });

}

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.usersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});
