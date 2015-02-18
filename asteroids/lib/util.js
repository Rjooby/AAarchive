(function (){

if (typeof Asteroids === "undefined") {
  window.Asteroids = {};
}

var Util = Asteroids.Util = {}

Util.inherits = function (subclass, superclass){

  function Surrogate() {};
  Surrogate.prototype = superclass.prototype;
  subclass.prototype = new Surrogate();

};

Util.randomVec = function(length) {
  var random = [-1,1][Math.floor(Math.random() * 2)]
  var random2 = [-1,1][Math.floor(Math.random() * 2)]
  var x = Math.random() * length * random;
  var y = Math.sqrt(Math.pow(length, 2) - Math.pow(x, 2)) * random2;
  return [x, y];
}

Util.distance = function (obj1, obj2) {
  var xdist = obj2.pos[0] - obj1.pos[0];
  var ydist = obj2.pos[1] - obj1.pos[1];
  return Math.sqrt(Math.pow(xdist, 2) + Math.pow(ydist, 2));
}

Number.prototype.mod = function(n) { return ((this%n)+n)%n; }

}) ();
