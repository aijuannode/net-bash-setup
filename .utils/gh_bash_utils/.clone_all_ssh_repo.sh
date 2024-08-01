#!/bin/bash

# settings / change this to your config
remoteUser="SpectralAUT"
localCodeDir="/home/usertty/.[code]/024_clean"

# create the local code directory if it doesn't exist
if [ ! -d "$localCodeDir" ]; then
  mkdir -p "$localCodeDir"
fi

# get all repositories for the user
repos=$(gh api graphql --paginate \
  -F query='
  query($endCursor:String) {
    user(login:"'$remoteUser'") {
      repositories(first: 100, after: $endCursor) {
        pageInfo {
          hasNextPage
          endCursor
        }
        nodes {
          name
          sshUrl
        }
      }
    }
  }
' | jq -r '.data.user.repositories.nodes[] | .sshUrl')

# clone each repository
for repo in $repos; do
  repoName=$(basename "$repo" .git)
  git clone "$repo" "$localCodeDir/$repoName"
  echo -e "Cloning into $localCodeDir/$repoName...\n"
done
