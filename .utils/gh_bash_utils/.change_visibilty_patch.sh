#!/bin/bash

# Define the visibility as a variable
VISIBILITY="public"

# Define an array of repositories to update
REPOSITORIES=($(gh repo list --json name | jq -r '.[] | .name'))

# Define an array of visibilities to update (optional)
VISIBILITIES=("public" "private" "internal")

# Loop through the repositories and update their visibility
for repo in "${REPOSITORIES[@]}"; do
  for visibility in "${VISIBILITIES[@]}"; do
    echo "Updating $repo to $visibility visibility..."
    gh api -X PATCH /repos/SpectralAUT/$repo -F "visibility=$visibility"
    sleep 5 # add a 5-second delay
  done
done