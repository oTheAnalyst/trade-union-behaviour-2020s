source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")
# Assuming your data frame is named joined_full_data_set
ILO_Summary_data <- joined_full_data_set %>%
  summarise(
    mean_Labour_Rights = mean(National_Compliance_wth_Labour_Rights,
      na.rm = TRUE
    ),
    mean_Bargaining_Coverage = mean(`Collective Bargaining Coverage`,
      na.rm = TRUE
    ),
    mean_Union_Density = mean(`Union Density`,
      na.rm = TRUE
    )
  )
print(ILO_Summary_data)


ILO_Summary_data <- joined_full_data_set %>%
  select(ref_area = "United States")
summarise(
  mean_Labour_Rights = mean(National_Compliance_wth_Labour_Rights,
    na.rm = TRUE
  ),
  mean_Bargaining_Coverage = mean(`Collective Bargaining Coverage`,
    na.rm = TRUE
  ),
  mean_Union_Density = mean(`Union Density`,
    na.rm = TRUE
  )
)
print(ILO_Summary_data)

# joined_full_data_set

OldData <- OldData %>%
  rename(
    CollectiveBargainingCoverage = Value.y,
    UnionDensity = Value.x
  )

Old_Summary <- OldData %>%
  select(Country, Year, UnionDensity, CollectiveBargainingCoverage) %>%
  group_by(Country) %>%
  summarise(
    MeanCollectiveBargainingCoverage = mean(CollectiveBargainingCoverage),
    MeanUnionDensity = mean(UnionDensity)
  )

print(Old_Summary)
