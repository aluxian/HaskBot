module MainConsole where

import           Bot
import           FacebookMessenger.Bot

data GlobalState = GlobalState {
  currentTags      :: [String],
  currentSender    :: [String],
  playerTakingSnap :: [String],
  wrongGuesses     :: Integer,
  snaps            :: [String],
  players          :: [(String, String)],
  profiles         :: [(String, String)]
}

main :: IO ()
main = serveConsole $ FacebookMessengerBot ([], allBlocks)

allBlocks :: [(BID, [Action BID])]
allBlocks =
  [
    (GET_STARTED, getStartedBlock),
    (TEST, testBlock)
  ]

getStartedBlock :: [Action BID]
getStartedBlock =
  [
    Act MarkSeen,
    Act $ TypingOn 1000,
    Say $ Message "Hey {user.firstName}!" [] Nothing,
    Act $ TypingOn 1000,
    Say $ Message "Welcome to HaskellBot." [TextQR "hey" Nothing Nothing] Nothing,
    Incl TEST,
    Hear [(AnyInput, [Say $ Message "ok i heard that" [] Nothing])]
  ]

testBlock :: [Action BID]
testBlock =
  [
    Say $ Message "hello world!" [] Nothing
  ]

data BID = GET_STARTED | TEST deriving Show
