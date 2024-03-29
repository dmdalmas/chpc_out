library(ggplot2)
library(stringr)
df <- read.table("data_quechua_rma.opf", header=T)
names(df) <- c("SitePat", "I")
df$SitePat <- sapply(df$SitePat, str_replace_all, ":", "")

# We want the site patterns printed in the order they appear in the file,
# from top to bottom. To fix the order, we want an ordered factor. But R
# prints things from bottom to top, so we need to reverse the order.
df$SitePat <- ordered(df$SitePat, levels=rev(df$SitePat))

# Normalize
s <- sum(df$I)
df$I <- df$I / s

# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 20
theme_set(mytheme)

ggplot(df, aes(SitePat, I, ymin=0, ymax=max(I))) +
    geom_point(pch=16, size=3) +
    theme(aspect.ratio=14/10,
          axis.title.y = element_blank()) +
    ylab("Site Pattern Frequency") +
    coord_flip()

ggsave("quechua_patfrq_rma.pdf")

