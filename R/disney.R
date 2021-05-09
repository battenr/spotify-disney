# Setup ----

library(spotifyr)
library(tidyverse) # data manipulation, cleaning, etc.
library(ggridges) # use for making a joy plot

access_token <- get_spotify_access_token() # your personal access token (don't put in a script)

# Accessing data using Spotify API ----

# Step 1 : Play around with the data. More of an artform than a science

#... Pulling from the Disney Hits playlist on Spotify

get_my_top_artists_or_tracks(type = 'tracks', time_range = 'short_term', limit = 5) %>%
  mutate(artist.name = map_chr(artists, function(x) x$name[1])) %>%
  select(name, artist.name, album.name)

# Step 2: Generate a hypothesis. For this: Phil Collins' (a la Tarzan soundtrack) is less joyful than Tevin Campbell (a Goofy Movie)

# Based on Phil Collins data

joy_pc <- get_artist_audio_features('phil collins')

joy_pc %>% # understand what's going on here
  arrange(-valence) %>% # measure of musical positivity
  distinct(track_name) %>%
  head(5)

ggplot(joy_pc, aes(x = valence, y = album_name)) + # based on valence, a measure of musical positivity using Spotify's Web API
  geom_joy() +
  theme_joy() +
  ggtitle("How much joy do we get from Phil Collins' albums?",
  subtitle = "Brother Bear is Here") +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    axis.title.x = element_text(hjust = 0.5),
    axis.title.y = element_text(hjust = 0.5)
  )

# Based on Tevin Campbell's data

joy_tc <- get_artist_audio_features('tevin campbell')

ggplot(joy_tc, aes(x = valence, y = album_name)) +
    geom_joy() +
    theme_joy() +
    ggtitle("How much joy do we get from Tevin Campbell's albums?",
            subtitle = "Here we are looking for I2I") +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    axis.title.x = element_text(hjust = 0.5),
    axis.title.y = element_text(hjust = 0.5)
  )

# Final Four Disney Albums: ----

#... Tarzan ----

tarzan <- spotifyr::get_album(id = '6fBzYwBKjuO4hmhcGuklJM?si=8G4ZAzUVRcm0FRF8aXphuw')

str(tarzan)

#... The Little Mermaid ----

little_mermaid <- spotifyr::get_album(id = "4YTduhQWfS0pOzQC4o0HcG?si=LBpETiG2RSyZyIk8mloBQg" )

str(little_mermaid)

#... The Lion King ----

lion_king <- spotifyr::get_album(id = "3YA5DdB3wSz4pdfEXoMyRd?si=9UUAysDuTS6ixCsXYMykWg")

str(lion_king)

#... Hercules ---

hercules <- spotifyr::get_album(id = "1wbY6VUchNsZLaDi22eD3J?si=00ajCSlHReuJXSz8XpARZg")

str(hercules)

# By inspecting the lists, there is a field called "popularity". Based upon this:

# Popularity of the 1999 Tarzan soundtrack, released 1999-01-01: integer of 1
# Popularity of the 1997 The Little Mermaid soundtrack, released 1997-01-01: integer of 65
# Popularity of the 1994 The Lion King soundtrack, released 1994-01-01: integer of 76
# Popularity of the 1997 Hercules soundtrack, released 1997-01-01: integer of 67

# The Big Finale ----

# What does popularity mean? A score from 0 to 100 with 100 being to most popular

big_finale <- dplyr::tribble(
  ~album_name, ~popularity,
  "Tarzan (1999)", 1,
  "The Little Mermaid (1997)", 65,
  "Hercules (1997)", 67,
  "The Lion King (1994)", 76
)




