# Líneas
library(readr)
library(dplyr)
library(ggplot2)
granos.mexico <- read_csv(file = "input/data/CSV_files/granos_mexico.csv",
                   col_names = TRUE)
legend <- "Fuente: Elaboración con ggplot a partir de la información de FAOSTAT, 2019."
granos.mex <- granos.mexico %>% filter(Grano == "Maíz") %>% 
ggplot(data = . , mapping = aes(x = Año, y = Kilogramos)) + 
        geom_line(mapping = aes(group = Grano, colour = Grano)) +
        ylim(0, 180) + xlim(2000,2020) +
        labs(title = "Disponibilidad promedio anual de kilogramos de maíz por persona",  
             subtitle = "México, 2000-2019",
             x = "Kilogramos por persona", 
             y = "Grano",
             caption = legend)
ggsave(filename = "granos_maiz_mex.jpg", plot = granos.mex, device = "jpeg", 
       path = "output/img/", dpi = "print")
