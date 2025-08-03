# Netlify Deployment Guide

This guide will help you deploy your Next.js application to Netlify.

## Prerequisites

1. **GitHub/GitLab/Bitbucket Account**: Your code should be in a Git repository
2. **Netlify Account**: Sign up at [netlify.com](https://netlify.com)
3. **Supabase Project**: Set up your database
4. **Clerk Application**: Set up authentication

## Step 1: Prepare Your Repository

1. **Push your code to Git**:
   ```bash
   git add .
   git commit -m "Prepare for Netlify deployment"
   git push origin main
   ```

2. **Verify your `netlify.toml`** is in the root directory (already configured)

## Step 2: Set Up Supabase

1. Go to your [Supabase Dashboard](https://supabase.com/dashboard)
2. Create a new project or use existing one
3. Go to **Settings > API** and copy:
   - Project URL
   - Anon (public) key
   - Service role key (for admin operations)

4. **Set up your database**:
   - Go to **SQL Editor**
   - Run the SQL from `database-setup.sql` to create tables and sample data

## Step 3: Set Up Clerk Authentication

1. Go to [Clerk Dashboard](https://clerk.dev)
2. Create a new application
3. Choose **Next.js** as your framework
4. Go to **API Keys** and copy:
   - Publishable Key
   - Secret Key

5. **Configure User Metadata**:
   - Go to **User & Authentication > Metadata**
   - Add a public metadata field:
     - **Field name**: `tier`
     - **Type**: String
     - **Possible values**: `free`, `silver`, `gold`, `platinum`
     - **Default value**: `free`

## Step 4: Deploy to Netlify

### Option A: Deploy via Netlify UI (Recommended)

1. **Connect Repository**:
   - Go to [Netlify Dashboard](https://app.netlify.com)
   - Click **"New site from Git"**
   - Choose your Git provider (GitHub, GitLab, etc.)
   - Select your repository
   - Choose the branch (usually `main`)

2. **Configure Build Settings**:
   - **Build command**: `npm run build`
   - **Publish directory**: `.next`
   - Click **"Deploy site"**

3. **Set Environment Variables**:
   - Go to **Site settings > Environment variables**
   - Add the following variables:

   ```
   NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_your_clerk_publishable_key_here
   CLERK_SECRET_KEY=sk_test_your_clerk_secret_key_here
   NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here
   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key_here
   ```

4. **Trigger a new deployment**:
   - Go to **Deploys** tab
   - Click **"Trigger deploy" > "Deploy site"**

### Option B: Deploy via Netlify CLI

1. **Install Netlify CLI**:
   ```bash
   npm install -g netlify-cli
   ```

2. **Login to Netlify**:
   ```bash
   netlify login
   ```

3. **Initialize and Deploy**:
   ```bash
   netlify init
   netlify deploy --prod
   ```

## Step 5: Configure Domain (Optional)

1. Go to **Domain settings** in your Netlify dashboard
2. Click **"Add custom domain"**
3. Follow the instructions to configure your domain

## Step 6: Test Your Deployment

1. **Test Authentication**:
   - Try signing up with a new account
   - Verify you can sign in/out

2. **Test Tier System**:
   - Create a test user in Clerk dashboard
   - Update their tier metadata
   - Verify they can access appropriate events

3. **Test Database**:
   - Verify events are loading
   - Test tier-based access control

## Troubleshooting

### Common Issues

1. **Build Fails**:
   - Check build logs in Netlify dashboard
   - Verify all environment variables are set
   - Ensure all dependencies are in `package.json`

2. **Authentication Not Working**:
   - Verify Clerk keys are correct
   - Check that Clerk application is configured for production
   - Update Clerk application URLs to include your Netlify domain

3. **Database Connection Issues**:
   - Verify Supabase URL and keys
   - Check Row Level Security settings
   - Ensure database tables exist

4. **Environment Variables Not Working**:
   - Redeploy after adding environment variables
   - Check variable names match exactly
   - Verify no extra spaces or quotes

### Environment Variables Reference

```env
# Clerk Authentication
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_...
CLERK_SECRET_KEY=sk_test_...

# Supabase Database
NEXT_PUBLIC_SUPABASE_URL=https://...
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
SUPABASE_SERVICE_ROLE_KEY=eyJ...
```

## Post-Deployment

1. **Update Clerk Application URLs**:
   - Go to Clerk dashboard > Applications
   - Add your Netlify domain to allowed URLs
   - Update redirect URLs if needed

2. **Monitor Performance**:
   - Use Netlify Analytics
   - Monitor build times and success rates

3. **Set Up Continuous Deployment**:
   - Every push to main branch will trigger a new deployment
   - Configure branch deployments for testing

## Support

If you encounter issues:
1. Check Netlify build logs
2. Verify all environment variables
3. Test locally with production environment variables
4. Check Netlify and Next.js documentation 