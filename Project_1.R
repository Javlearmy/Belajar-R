#Project : menghilangkan tanda baca dan mengubah huruf menjadi non kapital -
#          pada kolom tertentu terhadap suatu data frame

#import data
library(tidyverse)
library(readr)
df_master <- read_csv("C:/Users/JavaneseLA/Desktop/kmmi/social-network-kmmi/covid19_tweet.csv")

#memotong dataset menjadi 20 baris agar lebih ringan saat di proses
df_sample <- df_master[1:20,]


#melakukan select() terhadap kolom 'teks'
df_text <- df_sample %>% select(text)

#remove tanda baca
df_filter <- gsub("[[:punct:]]", "", as.matrix(df_text)) 

#change to lowercase
df_filter <- tolower(df_filter)

#replace the content of collumn 'text'
df_sample$text <- df_filter

view(df_filter)
view(df_sample)
