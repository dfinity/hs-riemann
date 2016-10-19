module Main where

import           Control.Concurrent
import           Data.Function
import qualified Network.Monitoring.Riemann.Event as Event
import           Network.Monitoring.Riemann.TCP
import Network.Monitoring.Riemann.Client

main :: IO ()
main = do
    client <- tcpClient "localhost" 5555
    putStrLn "doing some IO work"
    event <- pure $
                 Event.ok "my service"
                     & Event.description "my description"
                     & Event.metric (length [ "some data" ])
                     & Event.ttl 20
                     & Event.tags [ "tag1", "tag2" ]
    sendEvent client event
    threadDelay 5000000
    putStrLn "do somethign else"
    event <- pure $ Event.ok "my other service"
    sendEvent client event
    threadDelay 7000000
    putStrLn "send again"
    sendEvent client event
    sendEvent client event
    sendEvent client event
    sendEvent client event
    sendEvent client event
    threadDelay 1000000
    putStrLn "finished"