#!/bin/bash

# Equilateral AI Agent System Upgrade Script
# Usage: ./upgrade-script.sh [project-path]

PROJECT_PATH=${1:-$(pwd)}
EQUILATERAL_SOURCE="/Users/jamesford/Source/EquilateralAgents"

echo "🚀 Equilateral AI Agent System Upgrade"
echo "Target: $PROJECT_PATH"
echo "Source: $EQUILATERAL_SOURCE"

# Check if source exists
if [ ! -d "$EQUILATERAL_SOURCE" ]; then
    echo "❌ Equilateral source not found at $EQUILATERAL_SOURCE"
    exit 1
fi

# Check if target is valid
if [ ! -f "$PROJECT_PATH/package.json" ]; then
    echo "❌ No package.json found at $PROJECT_PATH"
    exit 1
fi

echo "📁 Creating directory structure..."
mkdir -p "$PROJECT_PATH/src"

echo "📦 Copying agent system..."
cp -r "$EQUILATERAL_SOURCE/src/agents" "$PROJECT_PATH/src/"
cp -r "$EQUILATERAL_SOURCE/src/helpers" "$PROJECT_PATH/src/"

echo "📋 Copying standards..."
cp -r "$EQUILATERAL_SOURCE/.clinerules" "$PROJECT_PATH/"

echo "📝 Checking package.json for agents script..."
if ! grep -q '"agents":' "$PROJECT_PATH/package.json"; then
    echo "⚠️  Add this to your package.json scripts section:"
    echo '    "agents": "node src/agents/cli/orchestrator-cli.js"'
fi

echo "📦 Installing dependencies..."
cd "$PROJECT_PATH"
npm install commander@^12.0.0

echo "✅ Upgrade complete!"
echo ""
echo "Test with:"
echo "  npm run agents list-agents"
echo "  npm run agents list-workflows"