# Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

instructorRepo <- "https://api.github.com/users/jtleek/repos"

# githubClientId <- "bc83f6edf61fa9cfbac5"
# githubClientSecret <- "4be1e679a09c448a3b4f0ee65c87783368bc8715"

github_personal_access_token <- "a888636b126cdc993aba88d9caa0030c576648c4"

library(jsonlite)
jsonResponse <- GET(instructorRepo,authenticate(user="a888636b126cdc993aba88d9caa0030c576648c4",password="x-oauth-basic"))
j<- fromJSON(content(jsonResponse,as="text"))
created_at <- j[j$name == "datasharing","created_at"]
#  "2013-11-07T13:25:07Z"