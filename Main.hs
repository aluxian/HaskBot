module Main where

blocks :: [(BlockID, Block)]
blocks = [
            (GET_STARTED, [
                            Act MarkSeen,
                            Act TypingOn,
                            Say $ Message "Hey {user.firstName}!" [] Nothing,
                            Say $ Message "Welcome to HaskellBot." [TextQR "hey" Nothing Nothing] Nothing,
                            Incl EXTRA_HW,
                            Hear [(AnyInput, [Say $ Message "ok i heard that" [] Nothing])]
                          ]),
            (EXTRA_HW, [Say $ Message "hello world!" [] Nothing])
          ]

main :: IO ()
main = serveBot ([], blocks)

serveBot :: Bot -> IO ()
serveBot _ = putStrLn "test"

data Request = SendApi MessagingType RecipientID Message

data MessagingType = MessagingTypeA | MessagingTypeB

type RecipientID = String

type Bot = ([ContextRule], [(BlockID, Block)])

type ContextRule = String

type Block = [Action]

data QuickReply = TextQR Title (Maybe ImageUrl) (Maybe Payload) | LocationQR | UserPhoneNumberQR | UserEmailQR

data Action = Say Message | Act SenderAction | Incl BlockID | Hear [(Input, Block)]

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

data SenderAction = TypingOn | TypingOff | MarkSeen

data BlockID = GET_STARTED | EXTRA_HW deriving Show
