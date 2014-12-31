TrelloClone.Routers.Boards = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = $('#main');
    this.collection = options.collection;
    console.log("hey");
  },

  routes: {
    "": "index",
    "boards" : "index",
    "boards/new" : "new",
    "boards/:id" : "show",
    "boards/:id/lists/new" : "newList"
  },

  index: function () {
    var view = new TrelloClone.Views.BoardsIndex( {collection: this.collection} );
    this._swap(view);
  },

  new: function () {
    var view = new TrelloClone.Views.BoardsNew( {collection : this.collection});
    this._swap(view);
  },

  show: function (id) {
    this.collection.fetch();
    var mod = this.collection.getOrFetch(id);
    var view = new TrelloClone.Views.BoardsShow( {model : mod });
    this._swap(view);
  },

  newList: function (id) {
    var mod = this.collection.getOrFetch(id);
    console.log(mod);
    var view = new TrelloClone.Views.ListsForm( {board : mod});
    this._swap(view);
  },

  _swap: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    this.$rootEl.html(view.render().$el)
  }

});
