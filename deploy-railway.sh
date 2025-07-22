#!/bin/bash

# Fabric Railway Deployment Script
set -e

echo "🚀 Deploying Fabric to Railway..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Installing..."
    npm install -g @railway/cli
fi

# Check if user is logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 Please login to Railway:"
    railway login
fi

# Initialize project if not already done
if [ ! -f "railway.json" ]; then
    echo "📝 Initializing Railway project..."
    railway init
fi

# Set environment variables
echo "⚙️  Setting up environment variables..."

# Optional: Set YouTube API key if provided
if [ ! -z "$YOUTUBE_API_KEY" ]; then
    echo "Setting YouTube API key..."
    railway variables set YOUTUBE_API_KEY="$YOUTUBE_API_KEY"
fi

# Optional: Set OpenAI API key if provided
if [ ! -z "$OPENAI_API_KEY" ]; then
    echo "Setting OpenAI API key..."
    railway variables set OPENAI_API_KEY="$OPENAI_API_KEY"
fi

# Deploy
echo "🚢 Deploying to Railway..."
railway up

echo "✅ Deployment complete!"
echo "🌐 Your Fabric API will be available at your Railway app URL"
echo "📊 Check status: railway status"
echo "📝 View logs: railway logs"
echo "🔗 Open dashboard: railway open"

# Test the deployment
echo "🧪 Testing deployment..."
sleep 10  # Wait for deployment to be ready

APP_URL=$(railway status --json | jq -r '.deployments[0].url' 2>/dev/null || echo "")
if [ ! -z "$APP_URL" ]; then
    echo "Testing health endpoint..."
    if curl -s "$APP_URL/models/names" > /dev/null; then
        echo "✅ Health check passed!"
        echo "🎉 Your Fabric API is live at: $APP_URL"
        echo ""
        echo "Try the YouTube transcript API:"
        echo "curl -X POST $APP_URL/youtube/transcript \\"
        echo "  -H 'Content-Type: application/json' \\"
        echo "  -d '{\"url\":\"https://www.youtube.com/watch?v=dQw4w9WgXcQ\"}'"
    else
        echo "⚠️  Health check failed. Check logs: railway logs"
    fi
else
    echo "⚠️  Could not determine app URL. Check: railway status"
fi