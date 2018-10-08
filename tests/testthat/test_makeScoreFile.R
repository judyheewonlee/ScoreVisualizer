#test_makeScoreFile.R
library(testthat)
context("makeScoreFile")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- "data/sampleref.fasta"
testAln <- "data/sampleMuscle.fasta"

fileName <- "testing"
score <- AlignStat::compare_alignments(reference, testAln, SP=TRUE, CS=TRUE)
filepaths <- c("data/testingSPS.txt", "data/testingTC.txt")

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(makeScoreFile(reference, testAln, filename = NULL), 
               "argument \"score\" is missing, with no default")
  
})

test_that("a sample input prouces the expected output",  {
  expect_equal(makeScoreFile(reference, testAln, filename = fileName, score = score), 
               filepaths)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]