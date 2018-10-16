#test_makeScoreFile.R
library(testthat)
context("makeScoreFile")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- system.file("data/sampleref.fasta", package = "ScoreVisualizer")
testAln <- system.file("data/sampleMuscle.fasta", package = "ScoreVisualizer")

fileName <- "testing"
score <- AlignStat::compare_alignments(reference, testAln, SP=TRUE, CS=TRUE)
scorePath <- makeScoreFile(reference, testAln, filename = fileName, score = score)
filepaths <-  c("data/testingSPS.txt", "data/testingTC.txt")
#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(makeScoreFile(reference, testAln, filename = NULL), 
               "argument \"score\" is missing, with no default")
  
})

test_that("a sample input prouces the expected output",  {
  expect_identical(scorePath, filepaths)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]