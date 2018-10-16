#' makeScoreFile
#'
#' @description
#' The \code{makeScoreFile} function generates score files
#' containing columnwise sum of pairs score and total column
#' score. These files are utilized by LaTeX to generate
#' the graphs representing the scores in the alignments.
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
#' @param file The preferred name of the output file
#' 
#' @return A vector containing the paths to the score files
#' 
#' @examples 
#' score <- getScore("data/sampleref.fasta", "data/sampleMuscle.fasta")
#' makeScoreFile("data/sampleref.fasta", "data/sampleMuscle.fasta", 
#'                   fileName = "Test1")
#' 
#' @export
#' @keywords internal
#' 

makeScoreFile <- function(reference, compare, SP = TRUE, CS = TRUE, filename,
                          score) {
  
  #Get the column wise sum of pairs score and total column score
  spScore <- unlist(score$sum_of_pairs$columnwise.SPS)
  tcScore <- (unlist(score$column_score$columnwise.column.score))
  
  #Create a temporary files to store scores
  if (is.null(filename)) {
    filepathSP <- "data/outputSPS.txt"
    filepathTC <- "data/outputTC.txt"
  }
  
  else {
    filepathSP <- paste("data/", filename, "SPS.txt", sep="")
    filepathTC <- paste("data/", filename, "TC.txt", sep="")
  }
  
  #Write the scores in temporary files for each score
  if (!is.null(spScore)) {
    write(spScore, file = filepathSP, ncolumns = 1)
  }
  
  if (!is.null(tcScore)) {
    write(tcScore, file = filepathTC, ncolumns = 1)
  }
  
  scorePaths <- c(filepathSP, filepathTC)
  return (scorePaths)
  
}

# [END]