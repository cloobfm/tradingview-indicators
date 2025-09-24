#!/bin/bash

# Pine Scripts Git Sync Helper
# Usage: ./scripts/sync.sh [commit_message]

set -e

echo "🌲 Pine Scripts Sync Helper"
echo "=========================="

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d ".git" ]; then
    echo "❌ Error: Run this script from the root of the tradingview-indicators repository"
    exit 1
fi

# Default commit message if none provided
COMMIT_MSG="${1:-Update Pine scripts $(date +%Y-%m-%d)}"

echo "📊 Checking repository status..."
git status

echo ""
echo "📝 Adding all changes..."
git add .

# Check if there are any changes to commit
if git diff --cached --quiet; then
    echo "✅ No changes to commit"
    echo "🔄 Checking for remote updates..."
    git pull origin main
    echo "✅ Repository is up to date"
else
    echo "💾 Committing changes: $COMMIT_MSG"
    git commit -m "$COMMIT_MSG"
    
    echo "📤 Pushing to GitHub..."
    git push origin main
    
    echo "✅ Successfully synced to GitHub!"
    echo "🔗 Repository: https://github.com/cloobfm/tradingview-indicators"
fi

echo ""
echo "📋 Repository Summary:"
echo "   Files: $(find . -name "*.pine" | wc -l | tr -d ' ') Pine scripts"
echo "   Branch: $(git branch --show-current)"
echo "   Remote: $(git remote get-url origin)"
echo ""