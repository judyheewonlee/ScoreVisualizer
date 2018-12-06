#test_getScore.R
library(testthat)
context("getScore")

# ==== BEGIN SETUP AND PREPARE =================================================
#
reference <- system.file("data/sampleref.fasta", package = "ScoreVisualizer")
testAln <- system.file("data/sampleMuscle.fasta", package = "ScoreVisualizer")
fakeFile <- system.file("data/sampleTest.fasta", package = "ScoreVisualizer")

score <- AlignStat::compare_alignments(reference, testAln, SP=TRUE, CS=TRUE)

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(getScore(), "argument \"reference\" is missing, with no default")
  expect_error(getScore(reference, fakeFile), "File  is not readable")
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]