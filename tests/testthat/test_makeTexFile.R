#test_makeTexFile.R
library(testthat)
context("makeTexFile")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- "data/sampleref.fasta"
testAln <- "data/sampleMuscle.fasta"
fakeFile <- "data/sampleTest.fasta"
filepaths <- c(reference, testAln)
fileName <- "testing"

score <- AlignStat::compare_alignments(reference, testAln, SP=TRUE, CS=TRUE)
scorepaths <- makeScoreFile(reference, testAln, filename = fileName, score = score)
texPath <- "testing.tex"
#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(makeTexFile(), "argument \"filepaths\" is missing, with no default")
  expect_error(makeScoreFile(reference, testAln, filename = NULL), 
               "argument \"score\" is missing, with no default")
})

test_that("a sample input prouces the expected output",  {
  expect_equal(makeTexFile(reference, testAln, filepaths = filepaths, 
                           filename = fileName, score = score, 
                           scorePaths = scorepaths), 
               texPath)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]