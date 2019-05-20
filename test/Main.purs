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

getCanvasWidth' :: Number -> CanvasElement -> Aff Unit
getCanvasWidth' width canvas =
  do
    width' <- liftEffect $ Canvas.getCanvasWidth canvas
    Assert.equal width width'

getCanvasHeight' :: Number -> CanvasElement -> Aff Unit
getCanvasHeight' height canvas =
  do
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

drawImage' :: String -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Aff CanvasElement
drawImage' src sx sy sWidth sHeight dx dy dWidth dHeight =
  do
    canvas <- createCanvas' dWidth dHeight
    image <- Canvas.loadImage src
    ctx <- liftEffect $ Canvas.getContext2D canvas
    _ <- liftEffect $ Canvas.drawImage ctx image sx sy sWidth sHeight dx dy dWidth dHeight
    pure canvas

main :: Effect Unit
main = runTest do
  suite "Node.Canvas" do
    test "getCanvasWidth" do
      getCanvasWidth' 0.0 =<< createCanvas' 0.0 0.0
      getCanvasWidth' 48.0 =<< createCanvas' 48.0 144.0
    test "getCanvasHeight" do
      getCanvasHeight' 0.0 =<< createCanvas' 0.0 0.0
      getCanvasHeight' 144.0 =<< createCanvas' 48.0 144.0
    test "loadImage" do
      loadImage' "public/images/characters/skin/1.png"
    test "toDataURL" do
      let
        url = "data:,"
        url' = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAACQCAYAAABOHuhpAAAABmJLR0QA/wD/AP+gvaeTAAAAMklEQVR4nO3BAQ0AAADCoPdPbQ43oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgFcDbJAAAZK9ohEAAAAASUVORK5CYII="
        url'' = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAA80lEQVQ4jcVToRHDMAx898IKUpii4sKg7pABcuadoJN0DU8Q0A2CDI2NbFoQnIJUOceSe2F9pNj6t/RSgH9DlS66azOn34OLYm5VIuvLGcdbCwCYRgsAsyTCBHIyABxvLfQSMpFDqYW9KAp8y2ZxDtGDPUSC6Cz5kML4IE6CHaTkbAqiyCEn3/tuQ07je9+x/WAmTqOF8YG1ZXwQPVkFqHQiS1MwPkBfzpsqqrR0ShxcVOHUzXhRWgvrrMrLXwXSV74Gzrq2eL6X3h+1hbk2tIWbbazoRQBM/VHznotTGFxU+aXxYTMNCWwTSWRwcTXr18/0AQMAgvXiBxQLAAAAAElFTkSuQmCC" 
      toDataURL' url =<< createCanvas' 0.0 0.0
      toDataURL' url' =<< createCanvas' 48.0 144.0
      toDataURL' url'' =<< drawImage' "public/images/characters/skin/1.png" 0.0 0.0 16.0 18.0 0.0 0.0 16.0 18.0  
