#test_modifyAlns.R
library(testthat)
library(Biostrings)
context("modifyAlns")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- system.file("data/sampleref.fasta", package = "ScoreVisualizer")
testAln <- system.file("data/sampleMuscle.fasta",package = "ScoreVisualizer")

fileName <- "testing"
filepaths <- c("data/testingRef.fasta", "data/testingCom.fasta")

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(modifyAlns(reference, testAln), 
               "argument \"filename\" is missing, with no default")
  
})

test_that("a sample input prouces the expected output",  {
  expect_equal(modifyAlns(reference, testAln, filename = fileName), 
               filepaths)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]