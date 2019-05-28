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

exports.getImageWidth = function(image) {
  return function() {
    return image.width;
  };
};

exports.getImageHeight = function(image) {
  return function() {
    return image.height;
  };
};

exports.getImageData = function(ctx) { 
  return function(sx) {
    return function(sy) {
      return function(width) {
        return function(height) {
          return function() {
            return ctx.getImageData(sx, sy, width, height);
          }
        }
      }
    }
  }
};

exports.getImageDataBuffer = function(imageData) {
  return function() {
    return imageData.data;
  };
};

exports.getImageDataWidth = function(imageData) {
  return function() {
    return imageData.width;
  };
};

exports.getImageDataHeight = function(imageData) {
  return function() {
    return imageData.height;
  };
};

exports.getImageDataIndexImpl = function(imageData) {
  return function(index) {
    return function() {
      return imageData.data[index];
    };
  };
};

exports.setFillStyle = function(ctx) {
  return function(style) {
    return function() {
      ctx.fillStyle = style;
    };
  };
};

exports.fillRect = function(ctx) {
  return function(sx) {
    return function(sy) {
      return function(width) {
        return function(height) {
          return function() {
            ctx.fillRect(sx, sy, width, height);
          };
        };
      };
    };
  };
};

exports.setStrokeStyle = function(ctx) {
  return function(style) {
    return function() {
      ctx.strokeStyle = style;
    };
  };
};

exports.strokeRect = function(ctx) {
  return function(sx) {
    return function(sy) {
      return function(width) {
        return function(height) {
          return function() {
            ctx.strokeRect(sx, sy, width, height);
          };
        };
      };
    };
  };
};

exports.clearRect = function(ctx) {
  return function(sx) {
    return function(sy) {
      return function(width) {
        return function(height) {
          return function() {
            ctx.clearRect(sx, sy, width, height);
          };
        };
      };
    };
  };
};

exports.setFont = function(ctx) {
  return function(font) {
    return function() {
      ctx.font = font;
    };
  };
};

exports.fillText = function(ctx) {
  return function(text) {
    return function(x) {
      return function(y) {
          return function() {
            return ctx.fillText(text, x, y);
          };
      };
    };
  };
};

exports.strokeText = function(ctx) {
  return function(text) {
    return function(x) {
      return function(y) {
          return function() {
            return ctx.strokeText(text, x, y);
          };
      };
    };
  };
};

exports.measureText = function(ctx) {
  return function(text) {
    return function() {
      return ctx.measureText(text);
    };
  };
};

exports.getTextMetricsWidth = function(textMetrics) {
  return function() {
    return textMetrics.width;
  };
};

exports.save = function(ctx) {
  return function() {
    ctx.save();
  };
};

exports.restore = function(ctx) {
  return function() {
    ctx.restore();
  };
};

exports.setTextAlignImpl = function(ctx) {
  return function(textAlign) {
    return function() {
      ctx.textAlign = textAlign;
    };
  };
};

exports.fill = function(ctx) {
  return function() {
    ctx.fill();
  };
};

exports.stroke = function(ctx) {
  return function() {
    ctx.stroke();
  };
};

exports.clip = function(ctx) {
  return function() {
    ctx.clip();
  };
};

exports.rect = function(ctx) {
  return function(x) {
    return function(y) {
      return function(width) {
        return function(height) {
          return function() {
            ctx.rect(x, y, width, height);
          };
        };
      };
    };
  };
};

exports.arc = function(ctx) {
  return function(x) {
    return function(y) {
      return function(radius) {
        return function(startAngle) {
          return function(endAngle) {
            return function() {
              ctx.arc(x, y, radius, startAngle, endAngle);
            };
          };
        };
      };
    };
  };
};

exports.beginPath = function(ctx) {
  return function() {
    ctx.beginPath();
  };
};

exports.moveTo = function(ctx) {
  return function(x) {
    return function(y) {
      return function() {
        ctx.moveTo(x, y);
      };
    };
  };
};

exports.lineTo = function(ctx) {
  return function(x) {
    return function(y) {
      return function() {
        ctx.lineTo(x, y);
      };
    };
  };
};

exports.closePath = function(ctx) {
  return function() {
    ctx.closePath();
  };
};

exports.rotate = function(ctx) {
  return function(radians) {
    return function() {
      ctx.rotate(radians);
    };
  };
};

exports.scale = function(ctx) {
  return function(x) {
    return function(y) {
      return function() {
        ctx.scale(x,y);
      };
    };
  };
};

exports.translate = function(ctx) {
  return function(x) {
    return function(y) {
      return function() {
        ctx.translate(x,y);
      };
    };
  };
};

exports.transform = function(ctx) {
  return function(a) {
    return function(b) {
      return function(c) {
        return function(d) {
          return function(e) {
            return function(f) {
              return function() {
                ctx.transform(a, b, c, d, e, f);
              };
            };
          };
        };
      };
    };
  };
};
