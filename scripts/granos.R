library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
# Barras contiguas
granos <- read_csv(file = "input/data/CSV_files/granos.csv",col_names = TRUE)
granos <- pivot_longer(data = granos, cols = c("Arroz","Maíz","Frijol"), 
                       names_to = c("Grano"), values_to = "Kilogramos")

granos.mex <- ggplot(data = granos, mapping = aes(x = Kilogramos, y = Grano)) + 
        geom_bar(aes(fill = País), stat = "identity", position = "dodge") +
        labs(title = "Disponibilidad anual por persona de kilogramos de granos básicos, 
             promedio 2000-2019",  
             subtitle = "México y algunos países de Centroamérica",
             x = "Kilogramos por persona", 
             y = "Grano",
             caption = "Fuente: Elaboración con ggplot a partir de la información 
             de FAOSTAT, 2019.")
ggsave(filename = "granos_mex.jpg", plot = granos.mex, device = "jpeg", 
       path = "output/img/", dpi = "print")

