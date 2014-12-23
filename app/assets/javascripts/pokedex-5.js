Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var template = JST['pokemonListItem']({pokemon: pokemon});
    this.$el.append(template);
    return this;

  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: this.render.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    var that = this;
    this.collection.each(function (poke){
      that.addPokemonToList(poke);
    })
  },

  selectPokemonFromList: function (event) {
    var $pokeLi = $(event.target);
    var poke = this.collection.findWhere({id: $pokeLi.data("id")});
    var detail = new Pokedex.Views.PokemonDetail({model: poke});
    $("#pokedex .pokemon-detail").html(detail.$el);
    detail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li" : "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: (function() {
        that.render();
      }).bind(this)
    });
  },

  render: function () {
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);

    this.model.toys().each((function(toy) {
      var toyListItem = JST["toyListItem"]({toy: toy});
      this.$el.find(".toys").append(toyListItem);
    }).bind(this));

    return this;
  },

  selectToyFromList: function (event) {
    var $toyLi = $(event.target);
    var toy = this.model.toys().findWhere({id: $toyLi.data("id")});
    var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
    $("#pokedex .toy-detail").html(toyDetail.$el);
    toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var content = JST["toyDetail"]({pokemon: [], toy: this.model});
    this.$el.html(content);
    return this;
  }
});

$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
