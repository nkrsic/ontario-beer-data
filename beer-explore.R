df <- read.table("./beer_w_quotes.csv", 
                 sep=",", 
                 header=TRUE,
                 encoding="latin1",
                 colClasses=c("character","character","character")
                 ) # File is encoded ISO 8859-1

# See unique levels of type factor

u <- unique(df$Manufacturer.Type..Type.de.fabricant.)
u

# Change mis-spellings of "Microbrewer" to proper-spelling 

mis_spell1 <- df$Manufacturer.Type..Type.de.fabricant. == u[3]
mis_spell2 <- df$Manufacturer.Type..Type.de.fabricant. == u[4]

df$Manufacturer.Type..Type.de.fabricant.[mis_spell1] = "Microbrewer"
df$Manufacturer.Type..Type.de.fabricant.[mis_spell2] = "Microbrewer"

# Sanity check

u <- unique(df$Manufacturer.Type..Type.de.fabricant.)
u

# Third column (the manufacturers' brands) has some empty strings. 
# Set these to clear "#NULL#" value

sum(df$Manufacturer.Type..Type.de.fabricant. == "")
sum(df$Manufacturer.Name..Nom.du.fabricant. == "")
sum(df$Manufacturer.s.Brand..Marque.du.fabricant. == "")

idx <- df$Manufacturer.s.Brand..Marque.du.fabricant. == ""
sum(idx)

df$Manufacturer.s.Brand..Marque.du.fabricant.[idx] = "#NA#"

# Sanity check -- No more empty strings

idx <- df$Manufacturer.s.Brand..Marque.du.fabricant. == ""
sum(idx)

# Conversion to UTF-8

Encoding(df$Manufacturer.Type..Type.de.fabricant.) <- "latin1"
brewer_type <- iconv( df$Manufacturer.Type..Type.de.fabricant., 
                      from="latin1", 
                      to="UTF-8")

Encoding(df$Manufacturer.Name..Nom.du.fabricant.) <- "latin1"
brewer_name <- iconv( df$Manufacturer.Name..Nom.du.fabricant., 
                      from="latin1", 
                      to="UTF-8")

Encoding(df$Manufacturer.s.Brand..Marque.du.fabricant.) <- "latin1"
brand <- iconv( df$Manufacturer.s.Brand..Marque.du.fabricant., 
                from="latin1", 
                to="UTF-8")

names(df) <- c("brewer_type", "brewer_name", "brand")

df2 <- as.data.frame( cbind(brewer_type, brewer_name, brand) )

write.csv(x=df2, 
          file="beer_clean_utf8.csv", 
          quote=TRUE,
          row.names=FALSE,
          fileEncoding = "UTF-8")

write.csv(x=df,
          file="beer_clean_iso8859_1.csv", 
          quote=TRUE,
          row.names=FALSE,
          fileEncoding = "latin1")



# ----------------------------

# is_empty <- df$Manufacturer.s.Brand..Marque.du.fabricant. == ""
# df2 <- df[!is_empty, ]
# 
# tt <- table(df2$Manufacturer.Type..Type.de.fabricant.)
# tt2 <- c(157, 813+3+1)
# p <- (1.0 / sum(tt2) )*100* tt2
# 
# ttn <- c(sprintf("Manufacturer %3.1f%%",p[1]), 
#          sprintf("Microbrewer %3.1f%%",p[2]) )
# 
# 
# library(plotrix)
# pie3D(tt2, 
#       labels = ttn, 
#       main = "Unique beer representation", 
#       explode=0.12, radius=1.5, labelcex = 1.1,  start=0.7, labelrad=2.30)

