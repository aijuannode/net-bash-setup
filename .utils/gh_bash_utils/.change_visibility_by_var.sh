#!/bin/bash

# Define the visibility
VISIBILITY="private"

# Loop through the repositories and update their visibility
for repo in $(gh repo list --json name | jq -r '.[] | .name'); do
  echo "Updating $repo to $VISIBILITY visibility..."
  gh api -X PATCH /repos/SpectralAUT/$repo -F "visibility=$VISIBILITY"
done