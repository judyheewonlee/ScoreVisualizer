#test_modifyAlns.R
library(testthat)
library(Biostrings)
context("modifyAlns")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- system.file("data/sampleref.fasta", package = "ScoreVisualizer")
testAln <- system.file("data/sampleMuscle.fasta",package = "ScoreVisualizer")

fileName <- "testing"

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(modifyAlns(reference), 
               "argument \"compare\" is missing, with no default")
  expect_error(modifyAlns(compare = testAln), 
               "argument \"reference\" is missing, with no default")
  
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]