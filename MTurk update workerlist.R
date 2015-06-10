  ############################################################################
  #                                                                          #
  #  Excluding participants who participated in previous studies             #
  #  By Arnoud Plantinga, based on Gabriele Paolacci's Excel solution        #
  #                                                                          #
  #  Instructions (Note: edit only the non-indented lines):                  #
  #                                                                          #
  #  1. Create a qualification (e.g., "Study 1"; keep in mind that the name  #
  #  will be visible to Workers) in MTurk/Manage/Qualification Types         #
  #                                                                          #
  #  2. Download from Manage Workers your "WorkerList", i.e., the list of    #
  #  workers who participated in any of your study in the past. This may     #
  #  take some time.                                                         #
  #                                                                          #
  #  3. Download from MTurk the Results batch of your previous studies       #
  #  (i.e., of the study  whose participants you want to exclude).           #
  #                                                                          #
  #  4. Change the folder (e.g., "C:/Downloads"), name of your               #
  #  workerlist (e.g., "User_394740_workers.csv"), name of your new          #
  #  qualification (e.g., "Study 1") and names of your batches               #
  #  (e.g., "Batch_1921108_batch_results.csv", ...) below                    #
  #                                                                          #
  #  5. Run the script.                                                      #
  #                                                                          #
  #  6. Upload the newly created file "Workerlist.csv" in the Manage Workers #
  #  page, and confirm that you want to assign the "Study 1" Qualification   #
  #  to a bunch of workers (the amount should again be equal to the N of     #
  #  your Study 1).                                                          #
  #                                                                          #
  #  7. When you  design your Study 2 HIT, require that the Qualification    #
  #  "Study 1" "is not equal to" "1". People who were assigned that "1" in   #
  #  your WorkerList file will not be able to participate in your study.     #
  #                                                                          #
  ############################################################################


  # Load files --------------------------------------------------------------

  # Set the folder where your workerlist etc. are stored
setwd("C:/Downloads/")

  # Load your workerlist
workerlist <- read.csv("User_394740_workers.csv", check.names=F)

  # Name of your new qualification
qualification <- "Study 1"

  # Load your previous batches of the studies whose participants you want to 
  # exclude (add more batches if needed)
  batch <- list()
batch[[1]] <- read.csv("Batch_1921108_batch_results.csv")
batch[[2]] <- read.csv("Batch_1921214_batch_results.csv")


  # Create list of previous studies -----------------------------------------
  
  # Create a list of workerIDs
  workerids <- c()
  for (i in 1:length(batch)) {
    workerids <- c(workerids, as.character(batch[[i]]$WorkerId))
  }
  
  # Update variable ---------------------------------------------------------
  
  workerlist[, paste("UPDATE-", qualification, sep = "")] <- 
    ifelse(workerlist[, "Worker ID"] %in% workerids, 1, NA)
  
  # Give some feedback
  paste("A total of", 
        table(workerlist[, paste("UPDATE-", qualification, sep = "")]),
        'workers now has the qualification', qualification)
  
  # Save csv ----------------------------------------------------------------
  
  write.csv(workerlist, file="Workerlist.csv", na="", row.names=F)
