# R MAKE FILES
# makefiles are the controller for the statistical analysis dataset
# provide framework control for data cleanup and prep

swtwd('~/desktop') # set to project directory

# run all gather / clean scripts
source("Gather1.R")
source("Gather2.R")
source("Gather3.R")

# merge and output flat file for statistical analysis
source("MergeData.R")

# GNU Makefile Example

RDIR = .
MERGE_OUT = MergeData.Rout

# Create list of R source files
RSOURCE = $(wildcard $(RDIR)/*.R)

# Files to indicate when RSOURCE file was run
OUT_FILES = $(RSOURCE:.R=.Rout)

# Default target
all: $(OUT_FILES)

# RUN RSOURCE Files
$(RDIR)/%.Rout: $(RDIR)/%.R
  R CMD BATCH $<
    
# Remove Out Files
clean:
    rm -fv $(OUT_FILES)

# Remove MergeData.Rout
cleanMerge:
  rm -fv $(MERGE_OUT)


