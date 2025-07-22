#!/bin/bash

# Test script for Fabric YouTube API
set -e

# Default to localhost if no URL provided
API_URL=${1:-"http://localhost:8080"}

echo "🧪 Testing Fabric YouTube API at: $API_URL"

# Test 1: Health check
echo "1️⃣  Testing health endpoint..."
if curl -s "$API_URL/models/names" > /dev/null; then
    echo "✅ Health check passed"
else
    echo "❌ Health check failed - is the server running?"
    exit 1
fi

# Test 2: YouTube transcript endpoint
echo "2️⃣  Testing YouTube transcript endpoint..."
RESPONSE=$(curl -s -X POST "$API_URL/youtube/transcript" \
    -H "Content-Type: application/json" \
    -d '{"url":"https://www.youtube.com/watch?v=dQw4w9WgXcQ","language":"en","timestamps":false}' \
    -w "%{http_code}")

HTTP_CODE="${RESPONSE: -3}"
BODY="${RESPONSE%???}"

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ YouTube transcript API working!"
    echo "📝 Response preview:"
    echo "$BODY" | jq -r '.transcript' | head -c 200
    echo "..."
else
    echo "❌ YouTube transcript API failed (HTTP $HTTP_CODE)"
    echo "Response: $BODY"
fi

# Test 3: YouTube transcript with timestamps
echo "3️⃣  Testing YouTube transcript with timestamps..."
RESPONSE=$(curl -s -X POST "$API_URL/youtube/transcript" \
    -H "Content-Type: application/json" \
    -d '{"url":"https://www.youtube.com/watch?v=dQw4w9WgXcQ","language":"en","timestamps":true}' \
    -w "%{http_code}")

HTTP_CODE="${RESPONSE: -3}"
BODY="${RESPONSE%???}"

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ YouTube transcript with timestamps working!"
    echo "📝 Response preview:"
    echo "$BODY" | jq -r '.transcript' | head -c 200
    echo "..."
else
    echo "❌ YouTube transcript with timestamps failed (HTTP $HTTP_CODE)"
    echo "Response: $BODY"
fi

echo ""
echo "🎉 Testing complete!"
echo "📚 API Documentation:"
echo "  POST $API_URL/youtube/transcript"
echo "  Body: {\"url\": \"youtube_url\", \"language\": \"en\", \"timestamps\": false}"