module Bot where

class Bot b where
  serveConsole :: b -> IO ()
  serveWeb :: b -> IO ()
