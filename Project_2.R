#Berdasarkan dataset, cari 10 kata yang paling banyak digunakan pada masing masing harinya

library('tidyverse')
library('tidytext')
library('dplyr')

##import dataset
df_master <- read.csv2('covid19_tweet.csv', sep = ',')

###karena dalam dataset ada empat hari (22,23,24,25) maka
##memfilter 2021-08-22 dan memilih kolom created_at dan text
date22 <- df_master %>%
  filter(created_at == as.Date("2021-08-22")) %>%
  select(created_at,text)

#select kolom text, unnest_tokens, mengurutkan, slice 10 kata terbanyak
text22 <- date22 %>% select(text)
text22 <- text22 %>% unnest_tokens(word, text, token = 'ngrams', n = 1, to_lower = TRUE)
text22 <- text22 %>% count(word) %>% arrange(desc(n))
text22 <- text22[1:10,]
fix22 <- data.frame(tanggal="2021-08-22",text22$word,text22$n)

#rename kolom
fix22 <- rename(fix22, word = text22.word, count = text22.n)

#################################################

##memfilter 2021-08-23 dan memilih kolom created_at dan text
date23 <- df_master %>%
  filter(created_at == as.Date("2021-08-23")) %>%
  select(created_at,text)

#select kolom text, unnest_tokens, mengurutkan, slice 10 kata terbanyak
text23 <- date23 %>% select(text)
text23 <- text23 %>% unnest_tokens(word, text, token = 'ngrams', n = 1, to_lower = TRUE)
text23 <- text23 %>% count(word) %>% arrange(desc(n))
text23 <- text23[1:10,]
fix23 <- data.frame(tanggal="2021-08-23",text23$word,text23$n)

#################################################

##memfilter 2021-08-24 dan memilih kolom created_at dan text
date24 <- df_master %>%
  filter(created_at == as.Date("2021-08-24")) %>%
  select(created_at,text)

#select kolom text, unnest_tokens, mengurutkan, slice 10 kata terbanyak
text24 <- date24 %>% select(text)
text24 <- text24 %>% unnest_tokens(word, text, token = 'ngrams', n = 1, to_lower = TRUE)
text24 <- text24 %>% count(word) %>% arrange(desc(n))
text24 <- text24[1:10,]
fix24 <- data.frame(tanggal="2021-08-24",text24$word,text24$n)

#rename kolom
fix24 <- rename(fix24, word = text24.word, count = text24.n)

plus_ultra_fix <- rbind(fix22,fix23,fix24)

  
