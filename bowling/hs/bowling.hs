import Data.Char
import Test.HUnit

score_roll :: Char -> Int
score_roll '-' = 0
score_roll 'X' = 10
score_roll x = ord x - ord '0'

score_game :: String -> Int
score_game = go 10
  where
    go :: Int -> String -> Int
    go 0 _ = 0
    go r ('X':xs@(_:'/':_)) = 20 + go (r - 1) xs
    go r ('X':xs@(a:b:_)) = 10 + score_roll a + score_roll b + go (r - 1) xs
    go r (_:'/':xs@(a:_)) = 10 + score_roll a + go (r - 1) xs
    go r (a:b:xs) = score_roll a + score_roll b + go (r - 1) xs
    go _ _ = error "Invalid Game"

score_game2 :: String -> Int
score_game2 = score_game_ints . rolls_to_ints

score_game_ints :: [Int] -> Int
score_game_ints [x,y] = x + y
score_game_ints [x,y,z] = x + y + z
score_game_ints (x:y:z:xs)
    | x == 10     = 10 + y + z + score_game_ints (y:z:xs)
    | x + y == 10 = 10 + z + score_game_ints (z:xs)
    | otherwise   = x + y + score_game_ints (z:xs)
score_game_ints _ = error "Invalid Game"

rolls_to_ints :: String -> [Int]
rolls_to_ints [] = []
rolls_to_ints (x:'/':xs) = (score_roll x):(10 - score_roll x):rolls_to_ints xs
rolls_to_ints (x:xs) = (score_roll x):rolls_to_ints xs

tests :: Test
tests = test ["strikes" ~: 300 ~=? score_game "XXXXXXXXXXXX",
              "misses"  ~:  90 ~=? score_game "9-9-9-9-9-9-9-9-9-9-",
              "spares"  ~: 150 ~=? score_game "5/5/5/5/5/5/5/5/5/5/5",
              "variety" ~: 192 ~=? score_game "5/X8/817/XXX72X7/",
              "strikes2" ~: 300 ~=? score_game2 "XXXXXXXXXXXX",
              "misses2"  ~:  90 ~=? score_game2 "9-9-9-9-9-9-9-9-9-9-",
              "spares2"  ~: 150 ~=? score_game2 "5/5/5/5/5/5/5/5/5/5/5",
              "variety2" ~: 192 ~=? score_game2 "5/X8/817/XXX72X7/"]

main :: IO Counts
main = runTestTT tests
