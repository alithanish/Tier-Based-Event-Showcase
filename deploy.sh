#!/bin/bash

echo "🚀 Starting Netlify Deployment Process..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Git repository not found. Please initialize git first:"
    echo "   git init"
    echo "   git add ."
    echo "   git commit -m 'Initial commit'"
    exit 1
fi

# Check if netlify.toml exists
if [ ! -f "netlify.toml" ]; then
    echo "❌ netlify.toml not found. Please ensure it exists in the root directory."
    exit 1
fi

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo "❌ package.json not found. Please ensure it exists in the root directory."
    exit 1
fi

echo "✅ Prerequisites check passed!"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build the project
echo "🔨 Building the project..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo "⚠️  Warning: .env.local not found."
    echo "   Please create .env.local with the following variables:"
    echo ""
    echo "   NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key"
    echo "   CLERK_SECRET_KEY=your_clerk_secret_key"
    echo "   NEXT_PUBLIC_SUPABASE_URL=your_supabase_url"
    echo "   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key"
    echo "   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key"
    echo ""
    echo "   Then set these same variables in your Netlify dashboard."
fi

echo ""
echo "🎉 Ready for deployment!"
echo ""
echo "Next steps:"
echo "1. Push your code to Git:"
echo "   git add ."
echo "   git commit -m 'Prepare for deployment'"
echo "   git push origin main"
echo ""
echo "2. Deploy to Netlify:"
echo "   - Go to https://app.netlify.com"
echo "   - Click 'New site from Git'"
echo "   - Connect your repository"
echo "   - Set build command: npm run build"
echo "   - Set publish directory: .next"
echo "   - Add environment variables in Site settings"
echo ""
echo "3. Or use Netlify CLI:"
echo "   npm install -g netlify-cli"
echo "   netlify login"
echo "   netlify init"
echo "   netlify deploy --prod"
echo ""
echo "📖 See DEPLOYMENT.md for detailed instructions." 