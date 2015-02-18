$.tweetCompose = function (el) {
  this.$el = $(el);
  this.tweetSubmit();
  this.$inputs = this.$el.find(":input");
  var charsLeft = 140;
  this.addUser();
  this.removeUser();

  this.$el.find("textarea").on("keyup", function(event){
    charsLeft = 140;
    var chars = $(this).val().length;
    charsLeft -= chars;
    $('strong.chars-left').html(charsLeft);
  });
};

$.tweetCompose.prototype.tweetSubmit = function() {
  var that = this;

  this.$el.on("submit", function() {
    event.preventDefault();
    var form = that.$inputs.serialize();
    that.$inputs.prop({disabled: true});
    $.ajax({
      url: "/tweets",
      type: "POST",
      data: form,
      dataType: 'json',
      success: function(response) {
        that.handleSuccess(response);
      }
    })
  })
};

$.tweetCompose.prototype.addUser = function() {
  var that = this;
  $('a.add-mentioned-user').on("click", function(event){
    var $script = that.$el.find(('script'));
    var $html = $script.html();
    that.$el.find('ul.mentioned-users').append($html);
  });
};

$.tweetCompose.prototype.removeUser = function () {
  var $ul = this.$el.find('ul.mentioned-users');

  $ul.on("click", "a.remove-mentioned-user", function(event){
    var div = $(event.currentTarget).parent();
    div.remove();
  });
};


$.tweetCompose.prototype.handleSuccess = function(response) {
  var id = this.$el.data("tweets-ul");
  var $ul = $(id);
  this.clearInput();
  this.$inputs.prop({disabled: false});
  var $li = $("<li>");
  var tweet = response.content + "--" + response.user.username + "--" + response.user.created_at;
  $li.append(tweet);

  $ul.prepend($li);
};

$.tweetCompose.prototype.clearInput = function() {
  this.$el[0].reset();
  this.$el.find("textarea").keyup();
  this.$el.find('ul.mentioned-users').empty();
};


$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.tweetCompose(this);
  });
};

$(function () {
  $("form.tweet-compose").tweetCompose();
});
