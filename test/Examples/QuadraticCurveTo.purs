module Test.Examples.QuadraticCurveTo where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Math (pi) as Math

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/quadraticCurveTo --}
main :: Effect Unit
main = 
  let
    width = 300.0
    height = 300.0
    log' = liftEffect <<< log
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.beginPath context
      _ <- Canvas.moveTo context 50.0 20.0
      _ <- Canvas.quadraticCurveTo context $
        { cpx : 230.0
        , cpy : 30.0
        , x : 50.0
        , y : 100.0
        }
      _ <- Canvas.stroke context
      _ <- Canvas.setFillStyle context "blue"
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context $
        { x : 50.0
        , y : 20.0
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.arc context $
        { x : 50.0
        , y : 100.0
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.fill context
      _ <- Canvas.setFillStyle context "red"
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context $
        { x : 230.0
        , y : 30.0
        , radius : 5.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.fill context
      log' =<< Canvas.toDataURL canvas
