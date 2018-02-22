library("tibble")
#10.5 exercise
#1.How can you tell if an object is a tibble? 
mtcars
is.tibble(mtcars)
class(mtcars)

#2.Compare and contrast the following operations on a data.frame and equivalent tibble. 
df <- data.frame(abc = 1, xyz = "a")
df
df$x #the name of the column in data frame can be automatically completed and recognized by R
class(df[, "xyz"]) #it returns a factor if one single value is seleted in a data frame
class(df[, c("abc", "xyz")])

tb <- as_tibble(df)
tb
tb$x #opposed to what happened to data frame, the incomplete name of the column of a tibble cannot be recognized
class(tb[, "xyz"]) # it returns a datafrane even if only a single value is selected.
class(tb[, c("abc", "xyz")])

#3. how can you extract the reference variable from a tibble?
df3 <- tibble(a="mpg",b=23)
df3[["a"]]

#4. 
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
  #1) 
annoying[["1"]]
  #2)
ggplot(annoying, aes(x = `1`, y = `2`)) +
  geom_point()
  #3)
annoying_new <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`)),
  `3` = `2`/`1`
)
  #4)
names(annoying_new) <- c("one","two","three")
annoying_new

#5.
enframe(c(a = 14, b = 12, c = 45))
# it makes named vectors a data frame with name and value

#6.
#n_extra in print.tbl_df 

#12.6.1
#1.
who1 <- who %>%
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
glimpse(who1)
who2 <- who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

who3 <- who2 %>%
  separate(key, c("new", "type", "sexage"), sep = "_")
who3
who3 %>%
  count(new)
who4 <- who3 %>%
  select(-new, -iso2, -iso3)
who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep = 1)
who5
who1 %>%
  filter(cases == 0) %>%
  nrow()
gather(who, new_sp_m014:newrel_f65, key = "key", value = "cases") %>%
  group_by(country, year)  %>%
  mutate(missing = is.na(cases)) %>%
  select(country, year, missing) %>%
  distinct() %>%
  group_by(country, year) %>%
  filter(n() > 1)
#2.
who3a <- who1 %>%
  separate(key, c("new", "type", "sexage"), sep = "_")

filter(who3a, new == "newrel") %>% head()

#3.
select(who3, country, iso2, iso3) %>%
  distinct() %>%
  group_by(country) %>%
  filter(n() > 1)
#4.
who5 %>%
  group_by(country, year, sex) %>%
  filter(year > 1995) %>%
  summarise(cases = sum(cases)) %>%
  unite(country_sex, country, sex, remove = FALSE) %>%
  ggplot(aes(x = year, y = cases, group = country_sex, colour = sex)) +
  geom_line()
who5
