# to measure topological parameters
library(igraph)
morcvd = read.csv(file.choose(), sep = ",", header = TRUE)
g = graph_from_data_frame(morcvd,directed=FALSE)
layer = rep(2, length(V(g)$name))
layer[grep("tax:",V(g)$name)]=1
layer[grep("hp:",V(g)$name)]=3
names = V(g)$name
names = sub("tax:","", names)
names = sub("hp:","", names)
V(g)$name = names
layout = layout_with_sugiyama(g, layers=layer)

#network validation by generation of 1000 random networks
set.seed(1)
for (x in seq_len(1000L)) {
  g[[x]] <- erdos.renyi.game(sample(1:1000, 1), p.or.m = runif(1))
  E(g[[x]])$weight <- sample(1:5, ecount(g[[x]]), T)
}
plot(gs[[1]], edge.width = E(g[[1]])$weight) # plot first graph

#to measure degree of nodes
degreeG <- degree(g)
View(degreeG)
write.csv(degreeG, "degree_network.csv", quote = F)

#to measure betweenness of nodes
betweennessG <- betweenness(g)
View(betweennessG)
write.csv(betweennessG, "betweenness_network.csv", quote = F)

#to get a combined table of degree, closeness & betweenness
forumG <- data.frame(V(g)$name, degreeG, closenessG, betweennessG)
write.table(forumG, file = "forumG.csv", sep = ";")

#to measure eigen_centrality of nodes
eigenG <- eigen_centrality(g)
View(eigenG)
write.csv(eigenG, "eigen_network.csv", quote = F)

#to sort degree in decreasing order
sort(degreeG, decreasing = TRUE)
View(sort(degreeG, decreasing = TRUE))
xd <- sort(degreeG, decreasing = TRUE)
write.csv(xd, "deg.csv", quote = F)

#to sort betweenness centrality in decreasing order
sort(betweennessG, decreasing = TRUE)
xb <- sor(betweennessG, decreasing = TRUE)
write.csv(xb, "betcen.csv", quote = F)

#to sort eigenvector centrality in decreasing order
sort(eigenG, decreasing = TRUE)
xc <- sort(eigenG, decreasing = TRUE)
write.csv(xc, "eigencen.csv", quote = F)