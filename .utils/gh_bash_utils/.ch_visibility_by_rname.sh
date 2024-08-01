#!/bin/bash

# Define the visibility as a variable
VISIBILITY="public"

# Define an array of repository names to update
REPOSITORIES_TO_UPDATE=("sdet_cert" "nasa_demo_test_plan" "octokit-js-crud")

# Define an array of visibilities to update (optional)
VISIBILITIES=("public" "private" "internal")

# Loop through the repositories to update and update their visibility
for repo in "${REPOSITORIES_TO_UPDATE[@]}"; do
  for visibility in "${VISIBILITIES[@]}"; do
    echo "Updating $repo to $visibility visibility..."
    gh api -X PATCH /repos/SpectralAUT/$repo -F "visibility=$visibility"
  done
done
