"use strict";

var Canvas = require("canvas");

exports.createCanvas = function(width) {
  return function(height) {
    return function() {
      return Canvas.createCanvas(width, height);
    };
  };
};

exports.getContext2D = function(canvasElement) {
  return function() {
    return canvasElement.getContext("2d");
  };
};

exports._loadImage = function(src) {
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

exports.getCanvasWidth = function(canvasElement) {
  return function() {
    return canvasElement.width;
  };
};

exports.getCanvasHeight = function(canvasElement) {
  return function() {
    return canvasElement.height;
  };
};

exports.toDataURL = function(canvasElement) {
  return function() {
    return canvasElement.toDataURL();
  };
};

exports.drawImage = function(ctx) {
  return function(image) {
    return function(sx) {
      return function(sy) {
        return function(sWidth) {
          return function(sHeight) {
            return function(dx) {
              return function(dy) {
                return function (dWidth) {
                  return function (dHeight) {
                    return function() {
                      ctx.drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight);
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
};
