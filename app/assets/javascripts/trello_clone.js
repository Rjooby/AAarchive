window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.boards = new TrelloClone.Collections.Boards();
    this.boards.fetch();
    console.log("hey2");
    this.router = new TrelloClone.Routers.Boards({collection: this.boards});
    Backbone.history.start();
  }
};
