Array.prototype.uniq = function() {
  var result = [] ;
  for (var i = 0; i < this.length; i++) {
    if (result.indexOf(this[i]) === -1) {
      result.push(this[i]);
    }
  }
  return result;
};

Array.prototype.twoSum = function() {
  var result = [] ;
  for (var i = 0; i < this.length; i++) {
    for (var j = i+1; j < this.length; j++) {
      if ((this[i] + this[j]) === 0) {
        result.push([i,j]);
      }
    }
  }
  return result;
}

  Array.prototype.transpose = function() {
    var result = [] ;
    for (var k = 0; k < this[0].length; k++){
      result.push([]);
    }
    for (var i = 0; i < this.length; i++){
      for (var j = 0; j < this[0].length; j++){
        result[j][i] = this[i][j];
      }
    }


    return result;
  }

Array.prototype.myEach = function (f) {

  for (i = 0; i < this.length; i++) {
    f(this[i]);

  }


};

Array.prototype.myMap = function (f) {
  var result = [];
  this.myEach( function(el) {
    result.push(f(el));
  });


  return result;
};

Array.prototype.myInject = function (start,f) {
  var result = start;
  this.myEach( function(el) {
    result = f(result, el);
  });


  return result;

};


Array.prototype.bubbleSort = function () {
  var sorted = false;
  while (sorted === false){
    sorted = true;
    for (var i = 0; i < this.length; i++) {
      for (var j = i+1; j < this.length; j++) {
        if (this[i] > this[j]){
          var temp = this[i];
          this[i] = this[j];
          this[j] = temp;
          sorted = false;
        }
      }
    }
  }
  return this
}

String.prototype.substrings = function() {
  var result = [] ;
  for (var i = 0; i < this.length; i++) {
    for (var j = i+1; j < this.length; j++) {
      result.push(this.substring(i,j))
    }
  }
  return result;
}

var range = function(start,end) {
  if (end < start) {
    return [];
  }
  return range(start, end - 1).concat(end);
}


console.log(range(2,5));
