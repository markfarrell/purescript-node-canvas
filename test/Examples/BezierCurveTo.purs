module Test.Examples.BezierCurveTo where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Math (pi) as Math

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/bezierCurveTo --}
main :: Effect Unit
main = 
  let
    width = 300.0
    height = 300.0
    start = { x : 50.0, y : 20.0 }
    cp1 = { x : 230.0, y : 30.0 }
    cp2 = { x : 150.0, y : 80.0 }
    end = { x : 250.0, y : 100.0 }
    log' = liftEffect <<< log
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.beginPath context
      _ <- Canvas.moveTo context start.x start.y
      _ <- Canvas.bezierCurveTo context $
        { cp1x : cp1.x
        , cp1y : cp1.y
        , cp2x : cp2.x
        , cp2y : cp2.y
        , x : end.x
        , y : end.y
        }
      _ <- Canvas.stroke context
      _ <- Canvas.setFillStyle context "blue"
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context $
        { x : start.x
        , y : start.y
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.arc context $
        { x : end.x
        , y : end.y
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.fill context
      _ <- Canvas.setFillStyle context "red"
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context $
        { x : cp1.x
        , y : cp1.y
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.arc context $
        { x : cp2.x
        , y : cp2.y
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.fill context
      log' =<< Canvas.toDataURL canvas
