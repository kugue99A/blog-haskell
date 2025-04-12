{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Main (main) where

import Data.Aeson
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import System.IO

-- API型定義
type HealthCheckAPI = "health" :> Get '[JSON] HealthStatus

-- ヘルスステータスデータ型
data HealthStatus = HealthStatus
  { status :: String
  } deriving (Eq, Show, Generic)

instance ToJSON HealthStatus
instance FromJSON HealthStatus

-- サーバー実装
server :: Server HealthCheckAPI
server = return $ HealthStatus "ok"

-- API定義
healthCheckAPI :: Proxy HealthCheckAPI
healthCheckAPI = Proxy

-- アプリケーション
app :: Application
app = serve healthCheckAPI server

main :: IO ()
main = do
  let port = 8080
  hPutStrLn stderr $ "Starting server on port " ++ show port
  run port app
