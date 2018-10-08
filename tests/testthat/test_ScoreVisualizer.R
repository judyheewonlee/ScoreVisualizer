#test_ScoreVisualizer.R
library(testthat)
library(Biostrings)
context("ScoreVisualizer")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- "data/sampleref.fasta"
testAln <- "data/sampleMuscle.fasta"

fileName <- "testing"
filepaths <- c("data/testingRef.fasta", "data/testingCom.fasta")

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(ScoreVisualizer(), 
               "argument \"reference\" is missing, with no default")
  
})

test_that("a sample input prouces the expected output",  {
  expect_equal(ScoreVisualizer(reference, testAln, fileName),
               cat("The PDF was successfully generated!"))
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]