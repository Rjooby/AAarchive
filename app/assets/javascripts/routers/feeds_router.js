NewsReader.Routers.Feeds = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = $(options.rootEl);
    this.collection = options.collection
  },

  routes:  {
    "" : "index",
    "feeds/:id" : "feedShow"
  },

  index: function() {
    var view = new NewsReader.Views.FeedsIndex({collection: this.collection});
    this.$rootEl.html(view.render().$el);
    //swap view----------
  },

  feedShow: function(id) {
    var model = this.collection.getOrFetch(id);
    var view = new NewsReader.Views.FeedsShow({model: model});
    this.$rootEl.html(view.render().$el);
  }

});
