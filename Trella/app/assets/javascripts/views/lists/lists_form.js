TrelloClone.Views.ListsForm = Backbone.View.extend({

  initialize: function (options) {
    this.board = options.board;
    console.log(this.board);
    this.list = new TrelloClone.Models.List({board: this.board});
  },

  template: JST['lists/form'],

  render: function () {
    var content = this.template({ board: this.board });
    this.$el.html(content);
    return this;
  },

  events: {
    "submit .new-list" : "newList"
  },

  newList: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget);
    var attr = $target.serializeJSON();
    attr.list.board_id = this.board.get('id');
    console.log(attr);
    // this.model.save(attr, {
    //   success: function () {
    //     this.collection.add(this.model);
    //     Backbone.history.navigate()
    // })
  }

});
