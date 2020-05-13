library(readr)
library(dplyr)
library(ggplot2)
teachers <- read_csv("../../Desktop/teachers.csv")
population.age <- read_csv("../../Desktop/population_age.csv")
countries <- teachers %>% 
        filter(Entity %in% 
        c("Argentina", "Mexico", "Brazil", "Chile", "Uruguay",
        "Paraguay", "Peru", "Bolivia", "Ecuador", "Venezuela", "Guatemala", "El Salvador", 
        "Nicaragua", "Panama", "Costa Rica"))
countries <- countries %>% rename("pre_primary" = `Pre-primary education (number)`)
countries <- countries %>% rename("primary" = `Primary education (number)`)
countries <- countries %>% rename("junior_high" = `Lower secondary education (number)`)
countries <- countries %>% rename("high_school" = `Upper secondary education (number)`)
countries <- countries %>% rename("upper" = `Tertiary education (number)`)
countries <- countries %>% mutate(total_teachers =
               select(.,pre_primary, primary, 
                      junior_high, high_school, upper) %>% 
               rowSums(na.rm = TRUE))
countries <- countries %>% group_by(Entity) %>% top_n(1, Year)
teach_pop <- left_join(x = countries, y = population.age, by = c("Entity", "Year"))
teach_pop <- teach_pop %>% mutate(teachers_rate = ((primary+junior_high)*30)/`5-14 years`)
teach_pop <- ungroup(teach_pop)
teach_pop <- teach_pop[order(teach_pop$teachers_rate, decreasing = TRUE), ]
teach_pop

teach_pop %>% filter(!is.na(teachers_rate)) %>% 
        ggplot(data = .) + 
        geom_col(aes(y = teachers_rate, x = reorder(paste0(Code.x,",\n", Year), teachers_rate))) + 
        labs(title = "Número de profesores de educación básica (primaria y secundaria) \n por cada 30 personas en edad escolar (5-14 años) de la población total",  # Título de la gráfica
             subtitle = "Varios países de América Latina",# Subítulo de la gráfica
             x = "Países", # Título eje x
             y = "Profesores", # Título eje y
             caption = "Fuente: https://ourworldindata.org/")







