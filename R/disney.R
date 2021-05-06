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

