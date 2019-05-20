module Process (argv) where

import Effect (Effect)

foreign import argv :: Effect (Array String)
