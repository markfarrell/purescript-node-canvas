module Test.Main where

import Prelude

import Control.Monad.Error.Class (try)
import Data.Either (isRight) 

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Test.Unit.Assert as Assert

import Node.Canvas (CanvasElement)
import Node.Canvas as Canvas

getCanvasWidth' :: Number -> Number -> Aff Unit
getCanvasWidth' width height =
  do
    canvas <- liftEffect $ Canvas.createCanvas width height
    width' <- liftEffect $ Canvas.getCanvasWidth canvas
    Assert.equal width width'

getCanvasHeight' :: Number -> Number -> Aff Unit
getCanvasHeight' width height =
  do
    canvas <- liftEffect $ Canvas.createCanvas width height
    height' <- liftEffect $ Canvas.getCanvasHeight canvas
    Assert.equal height height'

loadImage' :: String -> Aff Unit
loadImage' src =
  let
    assertTrue = Assert.equal true
  in 
    do
      result <- try $ Canvas.loadImage src
      assertTrue $ isRight result

main :: Effect Unit
main = runTest do
  suite "Node.Canvas" do
    test "getCanvasWidth" do
      getCanvasWidth' 0.0 0.0
      getCanvasWidth' 48.0 144.0
    test "getCanvasHeight" do
      getCanvasHeight' 0.0 0.0
      getCanvasHeight' 48.0 144.0
    test "loadImage" do
      loadImage' "public/images/characters/skin/1.png"
