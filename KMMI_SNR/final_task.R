#1 Mengimpor dataset covid19_tweet
library(tidyverse)
covid19_tweet <- read.csv("covid19_tweet.csv")
glimpse(covid19_tweet)

# memilih 2 kolom; kolon screen_ name dan text
covid19_tweet <- covid19_tweet %>%
  select(screen_name, text) %>%
  filter(str_detect(text, "vaksin"))

#2 Memfilter kolom text dengan word berikut (setiap kelompok pilih salah satu):  
##"vaksin", "jokowi", "pandemi", "antivaksin",
vaksin <- str_extract_all(string = covid19_tweet$text, 
                              pattern = "@[[:alnum:]_]*", simplify = TRUE)

#merubah kedalam tipe data dari martix ke data frame
vaksin <- data.frame(vaksin)

# menggabungkan seluruh kolom vaksin menjadi 1
vaksin <- vaksin %>%
  unite("kata", sep = " ")

# menggabungkan data frame vaksin ke covi19_tweet
covid19_tweet$vaksin <- paste0(vaksin$kata)

#menghitung jumlah kata vaksin dan menambahkan kolom total
covid19_tweet$total <- str_count(covid19_tweet$vaksin, "\\S+")

#membuang tweet yang tidak ada kata vaksin 
library(tidytext)
adj_objek <- covid19_tweet %>%
  filter(total >0) %>%
  select(- c(text, total)) %>%
  unnest_tokens(target, vaksin, token = "ngrams", n=1, to_lower = FALSE)

#menyiapkan data untuk Gephi
install.packages("igraph")
install.packages("rgexf")

library(igraph)
library(rgexf)

d_net <- simplify(graph_from_data_frame(d = adj_objek, directed = TRUE),
                  remove.loops = TRUE, remove.multiple = FALSE,
                  edge.attr.comb = igraph_opt("edge.attr.comb"))

#save objek igraph d_net kedalam file graphml
write_graph(graph = d_net, file = "vaksin.graphml", format = "graphml")

#membuat nodes/vertex
nodes_df <- data.frame(ID = c(1:vcount(d_net)), NAME = V(d_net)$name)

#membuat edges
edges_df <- as.data.frame(get.edges(d_net, c(1:ecount(d_net))))

#menyimpan nama edges dan nodes dalam bentuk gexf
write.gexf(nodes = nodes_df, edges = edges_df, defaultedgetype = "directed",
           output = "vaksin.gexf")



