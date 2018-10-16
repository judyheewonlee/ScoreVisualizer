#' makeTexFile.R
#'
#' @description
#' The \code{makeTexFile} function generates the LaTeX file
#' that generates the visual output of the scoring between
#' the given alignments.
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
#' @param filename The preferred name of the output file
#' 
#' @param filepaths The paths to the copied and modified alignment
#' files
#' 
#' @param score The pairwise alignment score object generated 
#' by AlignStat of the two alignments provided by the user
#' 
#' @param scorePaths The path to the data containing columnwise scores
#' for the sum of pairs score and total column score
#' 
#' @return The filepath to the generated Tex file is returned
#' 
#' @examples 
#' reference <- "data/BB11017ClustalW.fasta"
#' test <- "data/BB11017Muscle.fasta"
#' fileName <- "sampleTest2"
#' 
#' score <- getScore(reference, test)
#' filePaths <- modifyAlns(reference, test, fileName)
#' scorePaths <- makeScoreFile(reference, compare, SP, CS, fileName, score)
#' 
#' texpath <- makeTexFile(reference, test, fileName, filepaths, score,
#'                       scorePaths)
#' texpath
#'
#' @keywords internal
#' 

makeTexFile <- function(reference, compare, SP = TRUE, CS = TRUE, filename,
                        filepaths, score, scorePaths) {
  
  #get file paths
  filepathRef <- filepaths[1]
  filepathCom <- filepaths[2]
  spScorePath <- scorePaths[1]
  tcScorePath <- scorePaths[2]
  
  #Generate the Tex File for the visual output of the alignment comparison
  if (is.null(filename)) {
    texFile <- "texOutput.tex"
  }
  else{
    texFile <- paste(filename, ".tex", sep = "")
  }
  
  #Check if there is already a tex file with the same name
  checkFileExist(texFile)
  
  #Write to a .tex file
  texHead <- c("\\documentclass[12pt]{article}",
               "\\usepackage{texshade}",
               " ",
               "\\begin{document}",
               "\\textbf{Test Alignment}",
               " ")
  
  texCompare <- c(paste("\\begin{texshade}{", filepathCom, "}", sep = ""),
                  " ")
  texReference <- c(paste("\\begin{texshade}{", filepathRef, "}", sep = ""),
                    " ")
  
  if (isTRUE(SP)) {
    numColumns <- length(score$sum_of_pairs$columnwise.SPS)
    texCompare <- c(texCompare, paste("\\feature{ttop}{sample}{1..", 
                          as.character(numColumns),
                          "}{bar[0,1]:",
                          spScorePath, 
                          "[Red,Gray10]}{}", sep = ""),
                          "\\bargraphstretch{2}",
                          "\\showfeaturestylename{ttop}{SPS}",
                          "\\hideseq{sample}",
                          " ")
    
    texReference <- c(texReference, paste("\\feature{ttop}{sample}{1..", 
                                      as.character(numColumns),
                                      "}{bar[0,1]:",
                                      spScorePath, 
                                      "[Red,Gray10]}{}", sep = ""),
                                      "\\bargraphstretch{2}",
                                      "\\showfeaturestylename{ttop}{SPS}",
                                      "\\hideseq{sample}",
                                      " ")
    
  }
  
  if (isTRUE(CS)) {
    numColumns <- length(score$column_score$columnwise.column.score)
    texCompare <- c(texCompare, paste("\\feature{bottom}{sample}{1..", 
                                      as.character(numColumns),
                                      "}{bar[0,1]:",
                                      tcScorePath, 
                                      "[Blue,Gray10]}{}", sep = ""),
                    "\\bargraphstretch{2}",
                    "\\showfeaturestylename{bottom}{TC}",
                    "\\hideseq{sample}",
                    " ")
    
    texReference <- c(texReference, paste("\\feature{bottom}{sample}{1..", 
                                      as.character(numColumns),
                                      "}{bar[0,1]:",
                                      tcScorePath, 
                                      "[Blue,Gray10]}{}", sep = ""),
                    "\\bargraphstretch{2}",
                    "\\showfeaturestylename{bottom}{TC}",
                    "\\hideseq{sample}",
                    " ")
  }
  
  texCompare <- c(texCompare, "\\end{texshade}", " ")
  texReference <- c(texReference, "\\end{texshade}", " ")
  texEnd <- c("\\end{document}")
  
  texOutput <- c(texHead, texCompare, "\\newpage", 
                 "\\textbf{Reference Alignment}", texReference, texEnd)
  
  write(texOutput, file = texFile)
  return (texFile)
}

# [END]