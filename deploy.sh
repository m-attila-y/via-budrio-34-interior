#!/usr/bin/env bash
# One-command GitHub Pages deploy for the Interactive Property Studio.
# Requires: gh CLI authenticated, git configured with your name/email.
set -euo pipefail

REPO_NAME="${REPO_NAME:-interior-material-studio}"
BRANCH="gh-pages"
MESSAGE="Deploy interactive property studio"

cd "$(dirname "$0")"

echo "→ Initialising repo"
git init -q -b main
git add -A
git -c user.name="$(git config --get user.name || echo 'Studio')" \
    -c user.email="$(git config --get user.email || echo 'studio@local')" \
    commit -q -m "Initial commit: interactive property studio"

echo "→ Creating $REPO_NAME on your GitHub account"
gh repo create "$REPO_NAME" --public --source=. --remote=origin --description "Interactive property studio — click surfaces in interior renderings to preview finishes." 2>/dev/null || gh repo create "$REPO_NAME" --public --source=. --remote=origin --description "Interactive property studio."

echo "→ Pushing main branch"
git push -u origin main 2>/dev/null || git push -u origin main --force

echo "→ Creating orphan gh-pages branch with site contents"
git checkout --orphan "$BRANCH" -q
git -c advice.detachedHead=false rm -rf . 2>/dev/null || true
# Copy everything except .git itself
shopt -s dotglob
cp -r ../$(basename "$(pwd)")/* . 2>/dev/null || cp -r ../"$(basename "$(pwd)")"/.[!.]* . 2>/dev/null || true
# Above fallback may not work in subshell — re-do cleanly:
cd ..
TMP=$(mktemp -d)
shopt -s dotglob
cp -r "$REPO_NAME"/. "$TMP"/
cd "$TMP"
git init -q -b "$BRANCH"
git -c user.name="$(git config --get user.name || echo 'Studio')" \
    -c user.email="$(git config --get user.email || echo 'studio@local')" \
    commit -q --allow-empty -m "$MESSAGE"
git remote add origin "https://github.com/$(gh api user -q .login)/$REPO_NAME.git"
git push -u origin "$BRANCH" --force
cd - >/dev/null

echo "→ Enabling GitHub Pages"
gh repo edit "$REPO_NAME" --enable-pages --pages-branch "$BRANCH" 2>/dev/null || true

USER=$(gh api user -q .login)
echo ""
echo "✓ Done.  Once Pages finishes building (≈30 s):"
echo "  https://$USER.github.io/$REPO_NAME/"
