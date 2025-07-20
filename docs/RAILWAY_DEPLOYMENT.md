# Railway Deployment Guide

This guide explains how to deploy Fabric's enhanced YouTube API to Railway.

## Prerequisites

1. [Railway account](https://railway.app)
2. Railway CLI installed: `npm install -g @railway/cli`
3. YouTube API key (optional, for comments and metadata features)

## Quick Deploy

### Option 1: Deploy Button (Recommended)

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/fabric-youtube-api)

### Option 2: Manual Deployment

1. **Clone and prepare the repository:**
   ```bash
   git clone https://github.com/danielmiessler/fabric.git
   cd fabric
   ```

2. **Login to Railway:**
   ```bash
   railway login
   ```

3. **Create a new Railway project:**
   ```bash
   railway init
   ```

4. **Set environment variables:**
   ```bash
   # Required for YouTube comments and metadata (optional for transcripts)
   railway variables set YOUTUBE_API_KEY=your_youtube_api_key_here
   
   # Optional: Set custom port (Railway sets this automatically)
   railway variables set PORT=8080
   
   # Optional: Configure other Fabric settings
   railway variables set DEFAULT_MODEL=gpt-4
   railway variables set OPENAI_API_KEY=your_openai_key
   ```

5. **Deploy:**
   ```bash
   railway up
   ```

## Configuration

### Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `PORT` | No | Railway sets this automatically |
| `YOUTUBE_API_KEY` | No* | Required for comments and metadata endpoints |
| `OPENAI_API_KEY` | No | Required for AI chat features |
| `DEFAULT_MODEL` | No | Default AI model to use |

*YouTube API key is only required for `/youtube/comments`, `/youtube/metadata`, and `/youtube/playlist` endpoints. The `/youtube/transcript` endpoint works without it using yt-dlp.

### Getting a YouTube API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the YouTube Data API v3
4. Create credentials (API Key)
5. Copy the API key to Railway environment variables

## API Endpoints

Once deployed, your Railway app will expose these endpoints:

### Existing Endpoint
- `POST /youtube/transcript` - Extract video transcript

### New Enhanced Endpoints
- `POST /youtube/metadata` - Extract video metadata
- `POST /youtube/comments` - Extract video comments  
- `POST /youtube/extract` - Extract multiple content types
- `POST /youtube/playlist` - Process playlist videos

### Example Usage

```javascript
// Your Railway app URL
const API_BASE = 'https://your-app-name.railway.app';

// Extract comprehensive video data
const response = await fetch(`${API_BASE}/youtube/extract`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    includeTranscript: true,
    includeComments: true,
    includeMetadata: true,
    timestamps: true
  })
});

const data = await response.json();
console.log(data);
```

## Monitoring and Logs

### View Logs
```bash
railway logs
```

### Monitor Deployment
```bash
railway status
```

### Access Railway Dashboard
```bash
railway open
```

## Troubleshooting

### Common Issues

1. **"yt-dlp not found" error:**
   - This shouldn't happen with the Railway Dockerfile, but if it does, the container includes yt-dlp
   - Check logs: `railway logs`

2. **YouTube API quota exceeded:**
   - YouTube API has daily quotas
   - Monitor usage in Google Cloud Console
   - Consider implementing caching for metadata

3. **Port binding issues:**
   - Railway automatically sets the PORT environment variable
   - Don't hardcode port numbers

4. **Memory issues:**
   - Railway provides 512MB RAM by default
   - Upgrade plan if processing large playlists
   - Consider implementing pagination

### Health Check

Railway will automatically health check your app at `/models/names`. If this endpoint returns 200, your app is considered healthy.

## Scaling

### Horizontal Scaling
Railway supports horizontal scaling:
```bash
railway scale --replicas 3
```

### Vertical Scaling
Upgrade your Railway plan for more CPU/RAM resources.

## Security

### API Key Protection
- Never commit API keys to version control
- Use Railway's environment variables
- Rotate keys regularly

### Rate Limiting
Consider implementing rate limiting for production use:
- Per-IP limits
- API key-based limits
- Endpoint-specific limits

## Cost Optimization

### Railway Pricing
- Hobby plan: $5/month
- Pro plan: $20/month
- Usage-based pricing for resources

### Optimization Tips
1. Implement response caching
2. Use efficient Docker image (alpine-based)
3. Monitor resource usage
4. Set up proper health checks

## Support

- [Railway Documentation](https://docs.railway.app/)
- [Fabric GitHub Issues](https://github.com/danielmiessler/fabric/issues)
- [Railway Discord](https://discord.gg/railway)