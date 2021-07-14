module Options where

import qualified Data.ByteString.Char8 as C
import           Data.NanoID
import           Options.Applicative

data Options =
  Options
    { alphabet :: String
    , length   :: Int
    , quantity :: Int
    , newline  :: Bool
    }

opts :: ParserInfo Options
opts = info (options <**> helper)
  ( fullDesc
    <> progDesc "NanoID generator"
    <> header "nanoid v3.1.0, (c) Michel Boucey 2021" )

options :: Parser Options
options =
  Options
    <$>
      strOption
        ( short 'a'
          <> long "alphabet"
          <> help "Use an alternative alphabet (ascii chars only)"
          <> value (C.unpack $ unAlphabet defaultAlphabet) )
    <*>
      option auto
        ( short 'l'
          <> long "length"
          <> help "Default NanoID length is 21 chars"
          <> value 21 )
    <*>
      option auto
        ( short 'q'
          <> long "quantity"
          <> help "Quantity of NanoID to generate"
          <> value 1 )
    <*>
      flag True False
        ( short 'n'
          <> long "newline"
          <> help "Do not output the trailing newline" )

