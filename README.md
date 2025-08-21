# Equilateral AI - Multi-Agent Orchestration System

**Developed by Equilateral AI (Pareidolia LLC)**

This system provides a comprehensive multi-agent orchestration platform with proven development methodology and enterprise-grade automation capabilities.

## Features Included

### ✅ Multi-Agent Orchestration System
- **11 Specialist Agents** ready for use
- **4 Pre-defined Workflows** for common development tasks
- **CLI Interface** for easy workflow execution
- **Event-driven Architecture** with real-time progress tracking

### ✅ Development Standards
- Complete `.clinerules/` directory with Equilateral AI standards
- API standards with APIResponse<T> patterns
- Backend handler standards with method-specific patterns
- Frontend standards with React + TypeScript + Flowbite
- Cost optimization and security standards

### ✅ Infrastructure Support
- Multi-environment configuration (dev/sandbox/production)
- Cost analysis gates with environment-appropriate thresholds
- Progressive security philosophy implementation
- ARM64 optimization patterns

## Quick Start

### 1. Copy Template
```bash
cp -r project-template/ your-new-project/
cd your-new-project/
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Test Orchestration System
```bash
# List available workflows and agents
npm run agents list-workflows
npm run agents list-agents

# Test a workflow
npm run agents security-review --scope full
```

### 4. Customize for Your Project
- Update `package.json` with your project details
- Modify `.clinerules/` standards as needed
- Configure environment-specific settings
- Add project-specific agents if needed

## Available Workflows

### deploy-feature
Full feature deployment with validation pipeline
```bash
npm run agents deploy-feature --environment dev --branch feature/name
```

### security-review
Comprehensive security assessment
```bash
npm run agents security-review --include-cost-analysis --severity high
```

### quality-check
Code quality analysis with standards validation
```bash
npm run agents quality-check --standards-check --include-patterns
```

### full-stack-deploy
Complete deployment with all validations
```bash
npm run agents full-stack-deploy --environment production --validate-costs
```

## Project Structure

```
your-new-project/
├── src/
│   └── agents/
│       ├── core/AgentOrchestrator.js
│       ├── cli/orchestrator-cli.js
│       ├── specialists/[11 agents]
│       └── config.json
├── .clinerules/
│   ├── api_standards.md
│   ├── backend_handler_standards.md
│   ├── frontend_standards.md
│   ├── development_principles.md
│   ├── cost_optimization_standards.md
│   └── agent_orchestration_standards.md
├── package.json
├── CLAUDE.md
└── README.md
```

## Customization Guide

### Adding New Agents
1. Create agent in `src/agents/specialists/`
2. Add configuration to `src/agents/config.json`
3. Update orchestrator workflows as needed
4. Test with existing workflows

### Creating Custom Workflows
1. Add workflow definition in AgentOrchestrator.js
2. Update CLI commands as needed
3. Document usage patterns
4. Test with representative scenarios

### Environment Configuration
Update environment-specific settings in:
- `.env` files for different environments
- `CLAUDE.md` for AI assistant configuration
- `src/agents/config.json` for deployment environments

## Cost Control

### Environment Thresholds
- **Development**: <$20/month fixed costs
- **Sandbox**: <$50/month fixed costs
- **Production**: Cost justified by SLAs

### Automatic Cost Analysis
All deployment workflows include cost analysis gates that prevent expensive infrastructure mistakes before deployment.

## Security Standards

### Progressive Security Philosophy
Security enhancements are applied progressively based on environment and business requirements:
- **Foundation**: Basic security patterns for all environments
- **Enhanced**: Additional security with cost awareness for staging
- **Advanced**: Comprehensive security for production environments
- **Enterprise**: Full compliance when business requirements justify costs

## Support

### Documentation
- `CLAUDE.md` - Configuration for AI assistants
- `.clinerules/` - Complete development standards
- `src/agents/README.md` - Detailed agent documentation

### Troubleshooting
```bash
# Check system status
npm run agents status

# Verify available resources
npm run agents list-workflows
npm run agents list-agents

# Test with dry-run
npm run agents deploy-feature --dry-run
```

---

**Equilateral AI provides everything needed to start a new project with proven development methodology and enterprise-grade multi-agent orchestration capabilities.**

## About Equilateral AI

Equilateral AI represents a breakthrough in autonomous development systems, featuring self-bootstrapping agents that generate, validate, and deploy code following rigorous enterprise standards. Developed by Pareidolia LLC, this system has been validated in production environments across multiple domains.