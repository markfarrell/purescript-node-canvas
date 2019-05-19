module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Node.Canvas as Canvas

main :: Effect Unit
main = Canvas.createCanvas 48.0 144.0 >>= Canvas.toDataURL >>= log
