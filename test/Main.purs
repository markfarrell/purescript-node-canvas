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

createCanvas' :: Number -> Number -> Aff CanvasElement
createCanvas' width height = liftEffect $ Canvas.createCanvas width height

getCanvasWidth' :: Number -> Number -> Aff Unit
getCanvasWidth' width height =
  do
    canvas <- createCanvas' width height
    width' <- liftEffect $ Canvas.getCanvasWidth canvas
    Assert.equal width width'

getCanvasHeight' :: Number -> Number -> Aff Unit
getCanvasHeight' width height =
  do
    canvas <- createCanvas' width height
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

toDataURL' :: String -> CanvasElement -> Aff Unit
toDataURL' url canvas =
  do
    url' <- liftEffect $ Canvas.toDataURL canvas
    Assert.equal url url'

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
    test "toDataURL" do
      toDataURL' "data:," =<< createCanvas' 0.0 0.0
      toDataURL' "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAACQCAYAAABOHuhpAAAABmJLR0QA/wD/AP+gvaeTAAAAMklEQVR4nO3BAQ0AAADCoPdPbQ43oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgFcDbJAAAZK9ohEAAAAASUVORK5CYII=" =<< createCanvas' 48.0 144.0
      
