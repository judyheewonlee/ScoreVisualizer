# # Purpose:  A Sample Script for ScoreVisualizer, a BCB410 Project
# #
# #
# # Version:  1.0
# #
# # Date:     2018 11
# # Author:   Judy Heewon Lee (heewon.lee@mail.utoronto.ca)
# #
# # Versions:
# #
# #           1.0 First Implementation of ScoreVisualizer
# #
# #
# # ===================== ScoreVisualizer Sample Script ========================= #
#
# #TOC> ==========================================================================
# #TOC>
# #TOC>   Section  Title                                                    Line
# #TOC> --------------------------------------------------------------------------
# #TOC>   1        Initalizing ScoreVisualizer                               26
# #TOC>   2        Running ScoreVisualizer                                   38
# #TOC>   3        Using getScore                                            65
# #TOC>   4        Using the ShinyApp For ScoreVisualizer                    79
# #TOC>
# #TOC> ==========================================================================
#
# # ================== 1. Initializing ScoreVisualizer ========================= #
#
# # Score Visualizer utilizes the AlignStat, Biostrings and TexShade/LaTex in order
# # generate a multiple sequence alignment and the corresponding 
# # total column and sum-of-pairs score as a visual output. The format the output
# # is a PDF file that is generated in the user's working directory.A sample
# # output is also provided in the inst directory. Additionally, sample .fasta
# # files can be found in the data directory. In order to 
# # run ScoreVisualizer, you can first load the package using:
#
#
# devtools::install_github("judyheewonlee/ScoreVisualizer")
#
#
# # ================== 2. Running ScoreVisualizer ========================= #
#
# # You can run ScoreVisualizer by calling the ScoreVisualizer function. 
# # ScoreVisualizer takes paths to a reference and comparing alignment 
# # to generate a visualization of the TC and SPS scores between the two
# # fasta alignments. A sample is shown below:
#
# reference <- "data/sampleref.fasta"
# compare <- "data/sampleMuscle.fasta"
# ScoreVisualizer(reference, compare)
# 
# Note: The sample files are located in the ScoreVisualizer package in the data
# folder. As well, ScoreVisualizer will also be able to retrieve files
# from the user's working directory. Simply add the path to the .fasta file of
# interest relative to the working directory.
#
# # You can also add a fileName if wanted. The default name for files is "texOutput"
#
# ScoreVisualizer(reference, compare, fileName = "myAlignment")
#
# # If you would only like to retrieve the sum-of-pairs score or column score or both,
# # You can set the SP and CS parameters to TRUE or FALSE. 
#
# ScoreVisualizer(reference, compare, fileName = "myAlignment", SP = TRUE, CS = FALSE)
#
# # More details about the ScoreVisualizer function can be retrieved by running ?ScoreVisualizer
#
# # ================== 3. Using getScore ========================= #
#
# # If the user would like to look at the scoring of the two alignments, 
# # the function getScore is exported for this case. getScore uses the AlignStat
# # package in order to retrieve scores from comparing the two alignments.
# # A sample script is given below:
#
# score <- getScore(reference, compare)
#
# # getScore also provides the option for the user to retrieve either or both column
# # score or sum-of-pairs score in their result.
#
#
# # ================== 4. Using the ShinyApp For ScoreVisualizer ========================= #
#
# # There is a shiny implementation for ScoreVisualizer, it is found in the inst/ShinyApp folder
# # To run the shiny app, simply type the followin command:
#
# shinyApp(ui = ui, server = server)
#
#
# # A seperate window will appear and the user may provide two input fasta files that the user
# # wants to compare. There is also the choice of creating a filename to the produced PDF file and
# # a choice in selecting whether the user would like to include both or either the sum-of-pairs 
# # Total column scores. Sample .fasta alignment files can be found in the package /data folder.
#
# [END]
