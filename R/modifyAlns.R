#' modifyAlns.R
#'
#' @description
#' The \code{modifyAlns} function copies and modifies the 
#' alignments provided by the user in order to generate a valid
#' texShade output. It adds a 'sample' alignment since 
#' texShade does not include gaps in the sequence 
#' length of the alignment. TexShare only counts the 
#' residues in the individual sequences. Lastly, the
#' function returns the filepaths of the copied and modified 
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
#' @param filename The preferred name of the output file provided by
#' the user in ScoreVisualizer
#' 
#' @return The filepaths of the copied and modified alignments that
#' will be used to generate the tex file
#' 
#' @examples 
#' reference <- "data/BB11017ClustalW.fasta"
#' test <- "data/BB11017Muscle.fasta"
#' 
#' filepaths <- modifyAlns(reference, compare, "Test3")
#' filepaths
#'
#' @keywords internal
#' 

modifyAlns <- function(reference, compare, filename) {
  #modify the reference and text alignment so that it can be processed
  #by texShade 
  
  #Read the fasta files provided by the users using Biostrings
  #package.
  #Add a 'sample' alignment since texShare does not include gaps
  #in the sequence length of the alignment. TexShare only
  #counts the residues in the individual sequences.
  
  referenceAln <- Biostrings::readBStringSet(reference)
  compareAln <- Biostrings::readBStringSet(compare)
  
  sampleRefSeq <- Biostrings::BStringSet(strrep("X", 
                                        Biostrings::width(referenceAln)[1]))
  sampleCompareSeq <- Biostrings::BStringSet(strrep("X", 
                                        Biostrings::width(compareAln)[1]))
  
  #Add a title to the sample sequence
  names(sampleRefSeq) <- "sample"
  names(sampleCompareSeq) <- "sample"
  
  #Concatenate the two BStringSets
  referenceAln <- Biostrings::BStringSet(c(referenceAln, sampleRefSeq))
  compareAln <- Biostrings::BStringSet(c(compareAln, sampleCompareSeq))
  
  #Write the alignments to temporary files in the package data 
  #directory
  
  filepathRef <- tempfile(pattern = "file", fileext = ".fasta", 
                          tmpdir = "inst/tmp")
  filepathCom <- tempfile(pattern = "file", fileext = ".fasta", 
                          tmpdir = "inst/tmp")
  
  Biostrings::writeXStringSet(referenceAln, filepath = filepathRef)
  Biostrings::writeXStringSet(compareAln, filepath = filepathCom)
  
  #Return the paths of the reference alignment and compared alignment
  result <- c(filepathRef, filepathCom)
  return(result)
  
}

# [END]