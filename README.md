# DeepSeek Text Summarizer

A full-stack application that uses the DeepSeek API to generate AI-powered text summaries. Built with React (frontend) and Node.js/Express (backend).

## Features

- ✅ Secure API key handling (never exposed to frontend)
- ✅ Two summary modes: Concise and Detailed
- ✅ Real-time character count
- ✅ Error handling and loading states
- ✅ CORS enabled for local development
- ✅ Production-ready configuration
- ✅ TypeScript support

## Project Structure

```
deepseek-summarizer/
├── backend/
│   ├── server.js          # Express server
│   ├── package.json       # Backend dependencies
│   └── .env              # Environment variables (create this)
├── frontend/
│   ├── SummarizerApp.tsx  # React component
│   └── package.json       # Frontend dependencies
└── README.md
```

## Quick Start

### 1. Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Create environment file
cp env.example .env

# Edit .env file with your DeepSeek API key
# DEEPSEEK_API_KEY=sk-or-v1-your-actual-api-key-here

# Start the server
npm run server
```

The backend will start on `http://localhost:5000`

### 2. Frontend Setup

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start the React app
npm start
```

The frontend will start on `http://localhost:3000`

## API Endpoints

### POST `/api/summarize`

**Request Body:**
```json
{
  "text": "Your text to summarize here...",
  "mode": "concise" // or "detailed"
}
```

**Response:**
```json
{
  "success": true,
  "summary": "Generated summary text...",
  "mode": "concise",
  "characterCount": 150,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

**Error Response:**
```json
{
  "error": "Error message here"
}
```

## Environment Variables

### Backend (.env)

```env
# DeepSeek API Configuration
DEEPSEEK_API_KEY=sk-or-v1-your-api-key-here

# Server Configuration
PORT=5000
NODE_ENV=development

# Frontend URL (for CORS in production)
FRONTEND_URL=http://localhost:3000
```

### Frontend (.env)

```env
# Backend API URL (optional, defaults to localhost:5000)
REACT_APP_API_URL=http://localhost:5000
```

## DeepSeek API Configuration

1. Get your API key from [DeepSeek Platform](https://platform.deepseek.com/)
2. Add it to your backend `.env` file
3. The API key is never exposed to the frontend

## Example DeepSeek API Request

```javascript
// Backend makes this request to DeepSeek
const response = await axios.post(
  'https://api.deepseek.com/v1/chat/completions',
  {
    model: 'deepseek-chat-v3-0324',
    messages: [
      { 
        role: 'system', 
        content: 'You are a document summarizer...' 
      },
      { 
        role: 'user', 
        content: 'Please summarize this text:\n\n' + userText 
      }
    ],
    max_tokens: 200, // or 800 for detailed mode
    temperature: 0.3,
  },
  {
    headers: {
      'Authorization': `Bearer ${process.env.DEEPSEEK_API_KEY}`,
      'Content-Type': 'application/json',
    },
  }
);
```

## Development Commands

### Backend
```bash
npm run server    # Start with nodemon (development)
npm start         # Start with node (production)
```

### Frontend
```bash
npm start         # Start development server
npm run build     # Build for production
npm test          # Run tests
```

## Security Features

- ✅ API key stored securely in backend environment variables
- ✅ CORS configured for production and development
- ✅ Input validation on both frontend and backend
- ✅ Error handling without exposing sensitive information
- ✅ Request timeouts to prevent hanging requests

## Troubleshooting

### Common Issues

1. **401 Unauthorized Error**
   - Check that your DeepSeek API key is correct
   - Ensure the API key is properly set in `.env` file
   - Verify the API key has sufficient credits

2. **CORS Errors**
   - Backend must be running on port 5000
   - Frontend must be running on port 3000
   - Check that CORS is properly configured

3. **Network Errors**
   - Ensure backend server is running (`npm run server`)
   - Check that ports are not blocked by firewall
   - Verify the API_BASE_URL in frontend

4. **Rate Limiting**
   - DeepSeek API has rate limits
   - Wait a few seconds between requests
   - Consider implementing request queuing for production

### Debug Mode

To enable debug logging, set `NODE_ENV=development` in your backend `.env` file.

## Production Deployment

### Backend Deployment
1. Set `NODE_ENV=production`
2. Set `FRONTEND_URL` to your production frontend URL
3. Ensure `DEEPSEEK_API_KEY` is set
4. Use a process manager like PM2

### Frontend Deployment
1. Set `REACT_APP_API_URL` to your production backend URL
2. Build with `npm run build`
3. Deploy the `build` folder to your hosting service

## License

MIT License - feel free to use this code for your projects!
