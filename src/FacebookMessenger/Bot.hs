module FacebookMessenger.Bot where

import           Bot
import           System.Console.Haskeline

newtype FacebookMessengerBot a = FacebookMessengerBot ([ContextRule], [(a, [Action a])])

data Request = SendApi MessagingType RecipientID Message

data MessagingType = MessagingTypeA | MessagingTypeB

type RecipientID = String

type ContextRule = String

data QuickReply = TextQR Title (Maybe ImageUrl) (Maybe Payload) | LocationQR | UserPhoneNumberQR | UserEmailQR

data Action a = Say Message | Act SenderAction | Incl a | Hear [(Input, [Action a])]

data Input = AnyInput | NumberInput | EmailInput

data Attachment
  = TemplateAttachment TemplateAttachmentPayload
  | ImageAttachment
  | AudioAttachment
  | VideoAttachment
  | FileAttachment

data TemplateAttachmentPayload = ButtonTemplate String [Button]

type Title = String
type Text = String
type Payload = String
type Url = String
type ImageUrl = String

data Button = TextBtn Title | WebUrlBtn Title Url | PostbackBtn Title Payload

data Message = Message {
  text         :: String,
  quickReplies :: [QuickReply],
  attachment   :: Maybe Attachment
}

data SenderAction = TypingOn Integer | TypingOff | MarkSeen

instance (Show a) => Bot (FacebookMessengerBot a) where
  serveConsole b = readEvalPrintLoop
  serveWeb b = fail "not implemented"

readEvalPrintLoop :: IO ()
readEvalPrintLoop = runInputT defaultSettings loop
  where
    loop :: InputT IO ()
    loop = do
      minput <- getInputLine "> "
      case minput of
        Nothing -> return ()
        Just input -> do
          outputStrLn $ "Input was: " ++ input
          loop
