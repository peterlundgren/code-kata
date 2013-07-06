import Data.Char
import Test.HUnit

scoreGame :: String -> Int
scoreGame = go 10
  where
    go :: Int -> String -> Int
    go 0 _                  = 0
    go r ('X':xs@(_:'/':_)) = 20 +                             go (r - 1) xs
    go r ('X':xs@(a:b:_))   = 10 + scoreRoll a + scoreRoll b + go (r - 1) xs
    go r (_:'/':xs@(a:_))   = 10 + scoreRoll a +               go (r - 1) xs
    go r (a:b:xs)           =      scoreRoll a + scoreRoll b + go (r - 1) xs
    go _ _                  = error "Invalid Game"

scoreGame2 :: String -> Int
scoreGame2 = scoreGameInts . rollsToInts

scoreRoll :: Char -> Int
scoreRoll '-' = 0
scoreRoll 'X' = 10
scoreRoll x   = ord x - ord '0'

scoreGameInts :: [Int] -> Int
scoreGameInts [x,y]      = x + y
scoreGameInts [x,y,z]    = x + y + z
scoreGameInts (x:y:z:xs)
    | x == 10            = 10 +     y + z + scoreGameInts (y:z:xs)
    | x + y == 10        = 10 +         z + scoreGameInts (z:xs)
    | otherwise          =      x + y +     scoreGameInts (z:xs)
scoreGameInts _          = error "Invalid Game"

rollsToInts :: String -> [Int]
rollsToInts []         = []
rollsToInts (x:'/':xs) = scoreRoll x : 10 - scoreRoll x : rollsToInts xs
rollsToInts (x:xs)     = scoreRoll x :                    rollsToInts xs

tests :: Test
tests = test ["strikes" ~: 300 ~=? scoreGame "XXXXXXXXXXXX",
              "misses"  ~:  90 ~=? scoreGame "9-9-9-9-9-9-9-9-9-9-",
              "spares"  ~: 150 ~=? scoreGame "5/5/5/5/5/5/5/5/5/5/5",
              "variety" ~: 192 ~=? scoreGame "5/X8/817/XXX72X7/",
              "strikes2" ~: 300 ~=? scoreGame2 "XXXXXXXXXXXX",
              "misses2"  ~:  90 ~=? scoreGame2 "9-9-9-9-9-9-9-9-9-9-",
              "spares2"  ~: 150 ~=? scoreGame2 "5/5/5/5/5/5/5/5/5/5/5",
              "variety2" ~: 192 ~=? scoreGame2 "5/X8/817/XXX72X7/"]

main :: IO Counts
main = runTestTT tests
