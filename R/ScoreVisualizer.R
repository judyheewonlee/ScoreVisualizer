#' ScoreVisualizer.R
#'
#' @description
#' The \code{ScoreVisualizer} function is the main function
#' for the ScoreVisualizer package. It calls the helper functions
#' and generates a visual output to show the degree of scoring
#' within two alignments. 
#'
#' Details.
#'
#' @param reference A directory path to the reference alignment
#' the user would like to use
#' 
#' @param compare A directory path to the alignment being compared
#' to the reference alignment
#' 
#' @param SP A boolean value left TRUE if the user would like to
#' generate the sum of pairs in their output
#' 
#' @param CS A boolean value left TRUE if the user would like
#' to generate the total column score in their output
#' 
#' @param fileName The preferred name of the output file
#' 
#' @export
#'

ScoreVisualizer <- function(reference, compare, SP = TRUE, CS = TRUE, fileName=NULL) {
  
  #Ensure alignment file paths exists
  if (!file.exists(reference) || !file.exists(compare)) {
    stop("Please enter valid filepaths!\n")
  }
  
  #get sps and cs scores from score object
  score <- getScore(reference, compare, SP, CS)
  
  #Call makeScoreFile to get the scores of the alignments
  scorePaths <- makeScoreFile(reference, compare, SP, CS, fileName, score)
  
  #Call modifyAlnFiles to modify the reference and test alignment
  #files so it can be run through texShade/LaTeX
  filePaths <- modifyAlns(reference, compare, fileName)
  
  #Call makeTexFile to create the LaTeX/texshade file to produce
  #the score visualizer
  texFile <- makeTexFile(reference, compare, SP, CS, fileName, filePaths,
                         score, scorePaths)
  
  #Call texi2dvi/pdf function to convert the tex file into 
  #a pdf of dvi file
  tools::texi2pdf(texFile)
  
  #Delete temporary files
  filePaths <- c(scorePaths, filePaths)
  deleteFiles(filePaths)
  
}