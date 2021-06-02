module Data.NanoID where

import           Control.Monad
import qualified Data.ByteString.Char8 as C
import           Data.Maybe
import           System.Random.MWC

newtype NanoID = NanoID { unNanoID :: C.ByteString } deriving (Eq, Show)

newtype Alphabet = Alphabet { unAlphabet :: C.ByteString } deriving (Eq, Show)

type Length = Int

nanoID :: IO (Either String NanoID)
nanoID = createSystemRandom >>= customNanoID defaultAlphabet Nothing

customNanoID :: Alphabet -> Maybe Length -> GenIO-> IO (Either String NanoID)
customNanoID a l g =
  let ua = unAlphabet a
      al = C.length ua in
  pure . NanoID . C.pack <$> replicateM (fromMaybe 21 l) ((\r -> C.index ua (r-1)) <$> uniformR (1,al) g)

-- | The default 'Alphabet', made of URL-friendly symbols.
defaultAlphabet :: Alphabet
defaultAlphabet = Alphabet (C.pack "ABCDEFGHIJKLMNOPKRSTUVWXYZ_1234567890-abcdefghijklmnopqrstuvwxyz")

-- | Predefined 'Alphabet's borrowed from <https://github.com/CyberAP/nanoid-dictionary>
numbers :: Alphabet
numbers = Alphabet (C.pack "1234567890")

hexadecimalLowercase :: Alphabet
hexadecimalLowercase = Alphabet (C.pack "0123456789abcdef")

hexadecimalUppercase :: Alphabet
hexadecimalUppercase = Alphabet (C.pack "0123456789ABCDEF")

lowercase :: Alphabet
lowercase = Alphabet (C.pack "abcdefghijklmnopqrstuvwxyz")

uppercase :: Alphabet
uppercase = Alphabet (C.pack "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

alphanumeric :: Alphabet
alphanumeric = Alphabet (C.pack "ABCDEFGHIJKLMNOPKRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz")

nolookalikes :: Alphabet
nolookalikes = Alphabet (C.pack "346789ABCDEFGHJKLMNPQRTUVWXYabcdefghijkmnpqrtwxyz")

nolookalikesSafe :: Alphabet
nolookalikesSafe = Alphabet (C.pack "6789ABCDEFGHJKLMNPQRTUWYabcdefghijkmnpqrtwyz")

