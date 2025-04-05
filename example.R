shelter <- eval(parse("https://gist.githubusercontent.com/driedkelp1/53d6aa9da8ca8fbb20d4795995874812/raw/2033ce93c254892cfc99dae13bb80bc55e08f1ec/gistfile1.txt")) #read in the dataset

str(shelter)
head(shelter)
colnames(shelter)

shelter |> 
   View()
  
scount <- shelter |> 
  dplyr::filter(Outcome_Type == "Adopted") |> 
  dplyr::select(AnimalID) |> 
  dplyr::distinct()

View(scount)# which animals are adopted?
str(scount)# how many times do these animals show up in the dataset?


### proper solution
adopted <- unique(shelter$AnimalID[shelter$Outcome_Type == "Adopted"]) # which animals are adopted?

str(adopted)
View((adopted))

table(shelter$AnimalID)[adopted] # how many times do these animals show up in the dataset?
