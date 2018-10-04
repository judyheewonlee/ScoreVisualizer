#' deleteFiles.R
#'
#' @description
#' The \code{deleteFiles} function removes any existing
#' files given the filepath
#'
#' Details.
#'
#' @param filePaths A vector of filePaths directing to files that
#' are needed to be removed
#'
#' @export
#'

deleteFiles <- function(filePaths) {
  
  #delete files in the filePath
  for (path in filePaths) {
    if (file.exists(path)) {
      file.remove(path)
    }
  }
}