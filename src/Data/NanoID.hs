module Data.NanoID where

import           Control.Monad
import qualified Data.ByteString.Char8 as C
import           System.Random.MWC

newtype NanoID = NanoID { unNanoID :: C.ByteString } deriving (Eq, Show)

newtype Alphabet = Alphabet { unAlphabet :: C.ByteString } deriving (Eq, Show)

type Length = Int

defaultAlphabet :: Alphabet
defaultAlphabet = Alphabet (C.pack "ABCDEFGHIJKLMNOPKRSTUVWXYZ_-abcdefghijklmnopqrstuvwxyz")

nanoID :: IO (Either String NanoID)
nanoID = createSystemRandom >>= customNanoID defaultAlphabet 21

customNanoID :: Alphabet -> Length -> GenIO-> IO (Either String NanoID)
customNanoID a l g =
  if l > 21
    then return (Left "The length of NanoID is less or equal to 21")
    else do
      let acs = unAlphabet a
          al = C.length acs
      pure . NanoID . C.pack <$> replicateM l ((\r -> C.index acs (r-1)) <$> uniformR (1,al) g)

