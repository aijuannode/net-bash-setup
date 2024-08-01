for repo in $(gh repo list --json name | jq -r '.[] | .name'); do
  gh api -X PATCH /repos/SpectralAUT/$repo -F "visibility=public"
done 
