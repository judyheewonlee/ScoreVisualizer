#test_ScoreVisualizer.R
library(testthat)
library(Biostrings)
context("ScoreVisualizer")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- system.file("data/sampleref.fasta", package = "ScoreVisualizer")
testAln <- system.file("data/sampleMuscle.fasta", package = "ScoreVisualizer")

fileName <- "testing"

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(ScoreVisualizer(), 
               "argument \"reference\" is missing, with no default")
  
})

test_that("corrupt input generates errors", {
  expect_error(ScoreVisualizer(reference),
               "argument \"compare\" is missing, with no default")
})

# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]