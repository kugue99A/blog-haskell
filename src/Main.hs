{-# LANGUAGE OverloadedStrings #-}

import Network.Wai
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Types (status200)
import qualified Data.ByteString.Char8 as BS
import qualified Data.CaseInsensitive as CI
import qualified Data.Aeson as A
import Data.Aeson (object, (.=))

-- | メインアプリケーション
main :: IO ()
main = do
  putStrLn "サーバーを起動します。 http://localhost:8000/"
  run 8000 app

-- | シンプルなHTTPアプリケーション
app :: Application
app _req respond = respond $ jsonResponse helloWorldData

-- | JSONレスポンスを生成する関数
jsonResponse :: A.Value -> Response
jsonResponse value = responseLBS 
  status200
  [(CI.mk (BS.pack "Content-Type"), BS.pack "application/json")]
  (A.encode value)

-- | レスポンスのJSONデータ
helloWorldData :: A.Value
helloWorldData = object [ "message" .= ("hello world" :: String) ]