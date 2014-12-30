NewsReader.Views.FeedsShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['feeds/show'],

  render: function () {
    var content = this.template({feed: this.model});
    this.$el.html(content);
    return this;
  }

})
