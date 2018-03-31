module Telegram.Bot where

import           Bot

data TelegramBot

instance Bot TelegramBot where
  serveConsole b = fail "not implemented"
  serveWeb b = fail "not implemented"
