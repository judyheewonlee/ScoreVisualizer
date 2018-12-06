#' getScore
#'
#' @description
#' The \code{getScore} function generates a "Pairwise alignment
#' comparison" (PAC) object which contains the sum of pairs
#' score and the total column score of two multiple sequence
#' alignments.
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
#' @return The Pairwise alignment comparison object from the two
#' alignments provided
#' 
#' @examples 
#' score <- getScore("data/sampleref.fasta", "data/sampleMuscle.fasta")
#' score
#' 
#' @export
#' 

getScore <- function(reference, compare, SP = TRUE, CS = TRUE) {
  
  #Use AlignStat package to retrieve sum of pairs score or column score
  #from the provided alignments
  score <- AlignStat::compare_alignments(reference, compare, SP, CS)
  
  return(score)
}

# [END]