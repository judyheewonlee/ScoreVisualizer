#test_makeTexFile.R
library(testthat)
context("makeTexFile")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- "/Users/judylee/Documents/BCB410/ScoreVisualizer/data/sampleref.fasta"
testAln <- "/Users/judylee/Documents/BCB410/ScoreVisualizer/data/sampleMuscle.fasta"
fakeFile <- "/Users/judylee/Documents/BCB410/ScoreVisualizer/data/sampleTest.fasta"

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(makeTexFile(), "argument \"filepaths\" is missing, with no default")
  expect_error(makeScoreFile(reference, testAln, filename = NULL), 
               "argument \"score\" is missing, with no default")
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]