# for QC merge function
rm(list=ls())
library(dplyr)

inDir <- "F:\\Jie\\MS\\02_Code\\MS_Repo_Gitlab\\03_CohortData\\2016-07-07 08.00.52\\2016-07-07 08.21.57\\"

cohDtFileLst <- list.files(inDir, full.names = T)

for(iCoh in 1:4){
    for(jCoh in (iCoh+1):5){
        cat(iCoh, ' Vs ', jCoh, '\n\n')
        iDt <- read.table(cohDtFileLst[iCoh]
                          , sep=','
                          , header = T
                          , stringsAsFactors = F)
        jDt <- read.table(cohDtFileLst[jCoh]
                          , sep=','
                          , header = T
                          , stringsAsFactors = F)
        iDt <- arrange(iDt, record_num)
        jDt <- arrange(jDt, record_num)
        iRcdId <- iDt$record_num
        jRcdId <- jDt$record_num
        
        if(all(iRcdId==jRcdId)){
            cat("record_num the same!\n\n")
            
        }else{
            cat("record_num have difference!\n\n")
        }
        
        iDt4Cmp <- select(iDt, -one_of(c("record_num")))
        jDt4Cmp <- select(jDt, -one_of(c("record_num")))
        bEql <- all.equal(iDt4Cmp, jDt4Cmp
                  , ignore_col_order=T
                  , ignore_row_order=T
                  , convert=T)
        if(all(bEql==TRUE)){
            cat("cohort data the same!\n\n")
        }else{
            cat("cohort data have difference!\n\n")
        }
        # cat(bEql, '\n\n')
    }
}
