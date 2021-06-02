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
    then putStrLn "Strange (nano)idea... less than char" >> exitFailure
    else do
      let alphabet' = Alphabet { unAlphabet = C.pack alphabet }
      replicateM_ quantity $
        createSystemRandom >>= customNanoID alphabet' (Just length) >>= putNanoID newline
      exitSuccess
        where
          putNanoID nl = either (put nl . C.pack) (put nl . unNanoID)
            where put nl = if nl then C.putStrLn else C.putStr

