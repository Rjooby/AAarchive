$.tweetCompose = function (el) {
  this.$el = $(el);
  this.tweetSubmit();
  this.$inputs = this.$el.find(":input");
  var charsLeft = 140;

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
}

$.tweetCompose.prototype.handleSuccess = function(response) {
  var id = this.$el.data("tweets-ul");
  var $ul = $(id);
  this.clearInput();
  this.$inputs.prop({disabled: false});
  var $li = $("<li>");
  var tweet = response.content + "--" + response.user.username + "--" + response.user.created_at;
  $li.append(tweet);

  $ul.prepend($li);
}

$.tweetCompose.prototype.clearInput = function() {
  this.$el[0].reset();
  this.$el.find("textarea").keyup();
}


$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.tweetCompose(this);
  });
};

$(function () {
  $("form.tweet-compose").tweetCompose();
});
