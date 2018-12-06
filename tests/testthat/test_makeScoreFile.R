#test_makeScoreFile.R
library(testthat)
context("makeScoreFile")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- system.file("data/sampleref.fasta", package = "ScoreVisualizer")
testAln <- system.file("data/sampleMuscle.fasta", package = "ScoreVisualizer")

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(makeScoreFile(reference, testAln, filename = NULL), 
               "argument \"score\" is missing, with no default")
  
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]