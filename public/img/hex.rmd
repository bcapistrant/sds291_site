```{r}
library(ggplot2)
library(hexSticker)
data("iris")

sds291hex<-ggplot(iris,aes(y=Sepal.Length,x=Sepal.Width, group=Species, color=Species)) + 
  geom_point(size = .6) + 
  geom_smooth(method='lm', se=FALSE, lwd=1.2) + 
  scale_color_manual(values=c("#ED8B00","#70A241","#953192")) +
   theme(axis.title.x=element_blank(),
         axis.text.x=element_blank(),
         axis.ticks.x=element_blank(),
         axis.title.y=element_blank(),
         axis.text.y=element_blank(),
         axis.ticks.y=element_blank(),
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         panel.border = element_blank(),
         axis.line.x = element_line(color="white", size = 0.1),
         axis.line.y = element_line(color="white", size = 0.1),
         panel.background = element_blank(),
         legend.position = "none"
   ) + theme_transparent()
  sds291hex
#ggsave("~/Dropbox/3_Smith/SDS291/MR_2020/static/images/291scatter_v03_a.png", width=1, height=1, units="in")

sticker(sds291hex, package="", p_size=10, s_x=1, s_y=1, s_width=2, s_height=1.5,
        h_fill="#004f71", h_color="#206681",
        filename="static/img/ggplot2.png")

sticker(sds291hex, package="SDS 291", p_size=10, s_x=1, s_y=.75, s_width=1.65, s_height=1.05,
        h_fill="#004f71", h_color="#206681",
        filename="static/img/ggplot2_v1.png")


library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Fredoka One", "fredoka")

sticker(sds291hex, package="SDS 291", p_size=10, s_x=1, s_y=.75, s_width=1.4, s_height=.9,
        h_fill="#004f71", h_color="#A4B5CB",p_family = "fredoka",p_color="#ED8B00",
        filename="static/img/291hex.png")
```