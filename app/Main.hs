{-# LANGUAGE RecordWildCards #-}

import           Control.Monad
import qualified Data.ByteString.Char8 as C
import           Options.Applicative
import           System.Exit
import           System.Random.MWC

import           Data.NanoID
import           Options

main :: IO ()
main = do
  Options{..} <- execParser opts
  if length > 21
    then putStrLn "The length of NanoID is less or equal to 21" >> exitFailure
    else do
      let alphabet' = Alphabet { unAlphabet = C.pack alphabet }
      replicateM_ quantity $
        unNanoID <$> (createSystemRandom >>= customNanoID alphabet' length) >>= putNanoID newline
      exitSuccess
      where
        putNanoID n = if n then C.putStrLn else C.putStr

