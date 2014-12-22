Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $ul = $("<ul></ul>").addClass("detail");
  var $img = $("<img>").attr('src', pokemon.get("image_url"));
  $ul.append($img);
  _.each(pokemon.attributes, function(value, attr) {
    if (attr === "image_url"){
      return
    };
    var $li = $("<li></li>");
    $li.text(attr + ": " + value);
    $ul.append($li);
  });

  this.$pokeDetail.html($ul);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data("id");
  var pokemon = this.pokes.findWhere({id: id});
  this.renderPokemonDetail(pokemon);
};
