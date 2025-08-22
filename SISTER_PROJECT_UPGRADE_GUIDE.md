# Sister Project Upgrade Guide - Equilateral AI Agent System

**For: Waves, HoneyDo, Seawater Projects**

## Quick Upgrade Instructions

### 1. Copy Agent System
```bash
# From your project root
cp -r /Users/jamesford/Source/EquilateralAgents/src/agents ./src/
cp -r /Users/jamesford/Source/EquilateralAgents/src/helpers ./src/
cp -r /Users/jamesford/Source/EquilateralAgents/.clinerules ./
```

### 2. Install Dependencies
```bash
npm install commander@^12.0.0
```

### 3. Add NPM Scripts
Add to your `package.json`:
```json
{
  "scripts": {
    "agents": "node src/agents/cli/orchestrator-cli.js"
  }
}
```

### 4. Test Installation
```bash
npm run agents list-agents
npm run agents list-workflows
```

## What You Get

- **11 Specialist Agents** including new TestAgent with UI element remapping
- **4 Pre-built Workflows** (deploy-feature, security-review, quality-check, full-stack-deploy)
- **Complete .equilateral Integration** (replaces old .adrian references)
- **Standards Framework** for consistent development

## Usage Examples

```bash
# List all available agents and their capabilities
npm run agents list-agents

# Run security review
npm run agents security-review --scope full

# Run quality check
npm run agents quality-check --standards-check

# Deploy feature
npm run agents deploy-feature --environment dev
```

## Domain-Specific Customization

Each project should customize the agents for their domain:

### Waves (Marine Navigation)
- Focus on navigation algorithms and safety protocols
- Maritime data validation patterns
- Real-time positioning system integration

### HoneyDo (Task Management) 
- Task workflow optimization
- User productivity analytics
- Integration testing for task dependencies

### Seawater (Climate Risk)
- Climate data source validation
- Risk assessment algorithms
- Environmental compliance checking

## Support

If you encounter issues:
1. Check that all files copied correctly
2. Verify npm dependencies installed
3. Test with `npm run agents list-agents`
4. Check `.equilateral` directory exists and contains agent data

The system is designed to work immediately after installation with your existing project structure.