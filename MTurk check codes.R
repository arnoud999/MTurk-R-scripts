############################################################################
#                                                                          #
#   Check MTurk validation codes                                           #
#   By Arnoud Plantinga                                                    #
#                                                                          #
############################################################################

setwd("D:/Downloads/")


# Check Qualtrics codes ---------------------------------------------------

# Load your results
results <- read.csv("Batch_1975182_batch_results.csv", check.names=F)

# Load Qualtrics file
qualtrics <- read.Qualtrics("DuP_Exp05_Scarcity__Opportunity_Costs_3(1).csv")

# Check
data.frame(WorkerId=results$WorkerId, code_entered=results$Answer.Q2age, 
           code_in_Qualtrics=results$Answer.Q2age %in% qualtrics$mturkcode, 
           workerid_in_Qualtrics=results$WorkerId %in% qualtrics$worker_id)


# Do some checks ----------------------------------------------------------

# Check comments
unique(qualtrics$End)

# Check duration
summary(as.numeric(qualtrics$duration))
