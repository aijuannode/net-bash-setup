#!/bin/bash

# Set your GitHub username and password
GITHUB_USERNAME="juannodecoorp@gmail.com"
GITHUB_PASSWORD="$$$$#FOV78sbxss6567&&sxns"

# Open a new browser window
xdg-open https://github.com/login

# Login to GitHub using gh auth login
echo $GITHUB_PASSWORD | gh auth login -h github.com -p https --web

# Generate a new personal access token with all scopes selected using gh auth token
NEW_TOKEN=$(timeout 30s gh auth token --scopes "repo,repo:status,repo_deployment,public_repo,repo:invite,security_events,workflow,write:packages,read:packages,delete:packages,admin:org,write:org,read:org,manage_runners:org,admin:public_key,write:public_key,read:public_key,admin:repo_hook,write:repo_hook,read:repo_hook,admin:org_hook,gist,notifications,user,read:user,user:email,user:follow,delete_repo,write:discussion,read:discussion,admin:enterprise,manage_runners:enterprise,manage_billing:enterprise,read:enterprise,audit_log,read:audit_log,codespace,codespace:secrets,copilot,manage_billing:copilot,project,read:project,admin:gpg_key,write:gpg_key,read:gpg_key,admin:ssh_signing_key,write:ssh_signing_key,read:ssh_signing_key" &)

# Print the new token
echo "New personal access token: $NEW_TOKEN"

# Call the other script to open the browser and paste the token
bash "$(pwd)/open_browser_and_paste_token.sh" "$NEW_TOKEN"