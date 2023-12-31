% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_emr_df.R
\name{get_emr_df}
\alias{get_emr_df}
\title{Get UK Biobank participant Date First (DF) diagnosis from Electronic Medical Records (EMR) data}
\usage{
get_emr_df(
  diagnosis_list,
  include_death_cause = TRUE,
  include_hesin = TRUE,
  include_gp_clinical = TRUE,
  verbose = FALSE
)
}
\arguments{
\item{diagnosis_list}{A list of data frames. The participant data for the requested diagnosis codes: `death_cause`, `hesin_diag`, and `gp_clinical`.}

\item{include_death_cause}{logical. Include the cause of death in the combined Date First output? If present in `diagnosis_list` will still provide a separate `_df` variable
\code{default=TRUE}}

\item{include_hesin}{logical. Include the HES data in the combined Date First output? If present in `diagnosis_list` will still provide a separate `_df` variable
\code{default=TRUE}}

\item{include_gp_clinical}{logical. Include the GP data in the combined Date First output? If present in `diagnosis_list` will still provide a separate `_df` variable
\code{default=TRUE}}

\item{verbose}{Logical. Be verbose,
\code{default=FALSE}}
}
\value{
Returns a single, "wide" data frame: the participant data for the requested diagnosis codes with "date first" `_df` variables. One for each source of data, and a combined variable.
}
\description{
For each participant identify the date of first diagnosis for the provided electronic medical records.
}
\examples{
# example diagnostic codes for CKD from GEMINI multimorbidity project
codes_df <- readr::read_tsv("https://raw.githubusercontent.com/GEMINI-multimorbidity/diagnostic_codes/main/codelists/CKD.txt")
codes_df

# get diagnosis data - returns list of data frames (one per source)
diagnosis_list <- get_emr_diagnoses(codes_df)
# 7 ICD10 codes, 40 Read2 codes, 37 CTV3 codes 
# 298.18 sec elapsed

# for each participant, get Date First diagnosed with the condition
diagnosis_df = get_emr_df(diagnosis_list)
# 0.9 sec elapsed

# save to files on the RAP worker node
readr::write_tsv(diagnosis_df, "ukbrap.CKD.date_first.20231114.txt.gz")

# upload data to RAP storage
upload_to_rap(file="ukbrap.CKD.date_first.20231114.txt.gz", dir="")

}
\author{
Luke Pilling
}
