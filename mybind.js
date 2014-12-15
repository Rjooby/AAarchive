Function.prototype.myBind = function(context) {
  var fn = this;
  return (function() {
    return fn.apply(context);
  });
};

// var Cat = function(name) { this.name = name; }
// undefined
// Cat.prototype.sayName = function () { return "my name is " + this.name; }
// function () { return "my name is " + this.name; }
// var c = new Cat();
// undefined
// c.sayName();
// "my name is undefined"
// var c = new Cat("myname");
// undefined
// c.sayName();
// "my name is myname"
// var sayName = c.sayName.myBind(c);
// undefined
// sayName();


function Clock () {

}

Clock.TICK =5000;

Clock.prototype.printTime = function () {
  var time = this.currentTime.getHours() + ":" + this.currentTime.getMinutes() + ":" + this.currentTime.getSeconds();
  console.log(time);

};

Clock.prototype.run = function () {
  var startTime = new Date();
  this.currentTime = startTime;
  this.printTime();

  // var clock = this;

  setInterval(this._tick.myBind(this), Clock.TICK);

  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  this.currentTime.setSeconds(this.currentTime.getSeconds() + 5);
  this.printTime();

  // }, Clock.TICK);
  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();
clock.run();
