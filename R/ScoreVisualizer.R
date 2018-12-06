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
#' @examples 
#' reference <- "data/BB11017ClustalW.fasta"
#' test <- "data/BB11017Muscle.fasta"
#' ScoreVisualizer(reference, test)
#' 
#' @export
#'

ScoreVisualizer <- function(reference, compare, SP = TRUE, CS = TRUE, fileName=NULL) {
  
  # reference <- paste(getwd(), "/", reference, sep = "")
  # compare <- paste(getwd(), "/", compare, sep = "")
  
  # Ensure alignment file paths exists
  if (!file.exists(reference) || !file.exists(compare)) {
    stop("Please enter valid filepaths!\n")
  }
  
  # Get sps and cs scores from score object
  score <- getScore(reference, compare, SP, CS)
  
  # Call makeScoreFile to get the scores of the alignments
  scorePaths <- makeScoreFile(reference, compare, SP, CS, fileName, score)
  
  # Call modifyAlnFiles to modify the reference and test alignment
  # files so it can be run through texShade/LaTeX
  filePaths <- modifyAlns(reference, compare, fileName)
  
  # Call makeTexFile to create the LaTeX/texshade file to produce
  # the score visualizer
  texFile <- makeTexFile(reference, compare, SP, CS, fileName, filePaths,
                         score, scorePaths)
  
  # Call texi2dvi/pdf function to convert the tex file into 
  #a pdf of dvi file
  tools::texi2pdf(texFile, clean = TRUE)
  
  # Rename the generated PDF file and move it
  # to the data directory in the system.file package
  # Unfortunately the tex2pdf function does not
  # allow the user to choose the directory
  # which the pdf is made
  texFileName <- paste(tools::file_path_sans_ext(basename(texFile)), 
                       ".pdf",
                       sep = "")
  shinyPath <- system.file("ShinyApp/www", package = "ScoreVisualizer")
  
  noFileName <- "texOutput.pdf"
  if (!is.null(fileName)) {
    checkFileExist(paste("data/", fileName, ".pdf",
                                     sep = ""))
    checkFileExist(paste(shinyPath, "/", fileName, ".pdf",
                         sep = ""))
    file.rename(texFileName, paste(fileName, ".pdf",
                                  sep = ""))
    pdfFilePath <- paste(getwd(), "/",fileName, ".pdf",
                         sep = "")
  }
  
  else {
    checkFileExist(paste("data/", noFileName, sep = ""))
    checkFileExist(paste(shinyPath, "/", noFileName, sep = ""))
    file.rename(texFileName, noFileName)
    pdfFilePath <- paste(getwd(), "/", noFileName,
                         sep = "")
  }

  
  file.copy(from = pdfFilePath, to = "data/")
  file.copy(from = pdfFilePath, 
            to = system.file("ShinyApp/www", 
                            package = "ScoreVisualizer"))
  
  # Delete the file in the working directory.
  deleteFiles(pdfFilePath)
  
  #Print out completion statement
  message("The PDF was successfully generated!")
  
}

# [END]