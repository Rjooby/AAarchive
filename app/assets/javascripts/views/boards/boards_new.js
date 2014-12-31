TrelloClone.Views.BoardsNew = Backbone.View.extend({

  initialize: function () {
    this.model = new TrelloClone.Models.Board();
  },

  template: JST['boards/new'],

  events: {
    "submit .new-board" : "newBoard"
  },

  render: function () {
    var content = this.template({ board:this.model});
    this.$el.html(content);
    return this;
  },

  newBoard: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget);
    var attr = $target.serializeJSON();
    // console.log(attr);
    this.model.save(attr, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate('boards/' + this.model.id, {trigger: true} )
      }.bind(this)
    });
    
  }


});
