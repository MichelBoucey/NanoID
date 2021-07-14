{-# LANGUAGE RecordWildCards #-}

import           Control.Monad
import qualified Data.ByteString.Char8 as C
import           Data.Either
import           Options.Applicative
import           System.Exit
import           System.Random.MWC

import           Data.NanoID
import           Options

main :: IO ()
main = do
  Options{..} <- execParser opts
  if length < 1
    then strFail "nanoid length"
    else if quantity < 1
      then strFail "quantity"
      else do
        let alphabet' = Alphabet { unAlphabet = C.pack alphabet }
        replicateM_ quantity $
          createSystemRandom >>= customNanoID alphabet' (toEnum length) >>= putNanoID newline
        exitSuccess
  where
    strFail m = putStrLn ("Bad " <> m <> ". See help (-h).") >> exitFailure
    putNanoID nl = put nl . unNanoID
      where put nl = if nl then C.putStrLn else C.putStr

