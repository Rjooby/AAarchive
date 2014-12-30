NewsReader.Views.FeedsIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  },

  template: JST['feeds/index'],

  render: function () {
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);
    return this;
  }


});
