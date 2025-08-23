# Equilateral AI Website

The official marketing website for Equilateral AI - MagicMiddleware for 1000x+ Development Acceleration.

## 🌐 Website Structure

- **index.html** - Main landing page
- **styles.css** - Enhanced styling with improved color palette and contrast
- **brand-assets.html** - Brand guidelines and visual identity
- **coding-with-constraints.html** - Technical philosophy and approach
- **enterprise-archaeology.html** - Enterprise transformation insights
- **war-stories.html** - Development success stories
- **mcp-workflow.html** - MCP (Model Context Protocol) workflow documentation
- **privacy.html** - Privacy policy
- **terms.html** - Terms of service
- **404.html** - Custom 404 error page

## 🎨 Recent Enhancements

- Improved color palette with better contrast ratios
- Enhanced typography and layout spacing
- Professional tech/AI theme with warm accents
- Mobile-responsive design optimization
- SEO metadata and structured data optimization

## 🚀 Deployment

### Automatic Deployment
```bash
./deploy.sh
```

### Manual Deployment
```bash
# Sync to S3
aws s3 sync . s3://equilateral --profile media-sso --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id E2ZVEWGDO83XS0 --paths "/*" --profile media-sso
```

## 🏗️ Infrastructure

- **Hosting**: AWS S3 bucket `equilateral` (Media Account: 855652006097)
- **CDN**: CloudFront Distribution `E2ZVEWGDO83XS0`
- **Domain**: equilateral.ai
- **SSL**: Managed by CloudFront

## 📝 Content Management

The website showcases:
- **AI Agent Orchestration** - 11+ specialist agents working in parallel
- **1000x+ Development Acceleration** - Proven development speed improvements
- **24-Hour Challenge** - Complete application and brand development
- **Enterprise Solutions** - MagicMiddleware for enterprise transformation
- **Technical Insights** - Coding with constraints and enterprise archaeology

## 🔧 Development

### Local Development
Simply open `index.html` in a browser or serve with any static file server:
```bash
python3 -m http.server 8000
# or
npx http-server
```

### Editing Guidelines
1. Maintain the enhanced color palette and contrast ratios
2. Follow the established typography hierarchy
3. Ensure mobile responsiveness
4. Update deployment after changes: `./deploy.sh`
5. Validate all links and assets work correctly

## 📊 Analytics & Performance

- SEO optimized with structured data
- Fast loading with CloudFront CDN
- Mobile-first responsive design
- Accessibility compliant (WCAG guidelines)

---

**Company**: Pareidolia LLC  
**Contact**: hello@equilateral.ai  
**Website**: https://equilateral.ai