"use strict";

var Canvas = require("canvas");

exports.createCanvasImpl = function(width) {
  return function(height) {
    return function() {
      return Canvas.createCanvas(width, height);
    };
  };
};

exports.loadImageImpl = function(src) {
  return function(onError, onSuccess) {
    var image = new Canvas.Image();
    image.onload = function() {
      onSuccess(image);
    };
    image.onerror = function(err) {
      onError(err);
    };
    image.src = src;
    return function(cancelError, cancelerError, cancelerSuccess) {
      image.onload = null;
      image.onerror = null;
      image.src = "";
      cancelerSuccess();
    };
  };
};
