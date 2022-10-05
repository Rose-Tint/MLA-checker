module Main (
    main,
    tests,
) where

import Test.HUnit (Test(TestList), runTestTTAndExit)


main :: IO ()
main = runTestTTAndExit tests

tests :: Test
tests = TestList []
