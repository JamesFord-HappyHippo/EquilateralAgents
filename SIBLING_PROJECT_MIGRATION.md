# Sibling Project Migration Guide

## Database Updates & Real Agent Implementation

### Overview

The EquilateralAgents multi-agent orchestration system has been updated from simulated/mocked operations to **real implementations** with database-backed coordination. All 4 sibling projects (Waves, HoneyDo, Seawater, and others) need to implement database requirements to utilize the enhanced agent capabilities.

### Key Changes Made

1. **Real Agent Execution**: All agents now perform actual work instead of simulations
2. **Database Coordination**: Agents use shared PostgreSQL tables for workflow coordination
3. **Multi-Database Support**: PostgreSQL (recommended), MySQL, or SQLite options available
4. **Enhanced Capabilities**: Real security analysis, test execution, pattern harvesting

---

## Database Architecture & Sharing

### Recommended Approach: Shared PostgreSQL Database

**All 4 sibling projects should share a single PostgreSQL database** with project-specific prefixes:

```sql
-- Shared coordination tables (no prefix)
CREATE TABLE agent_workflows (
    workflow_id TEXT PRIMARY KEY,
    workflow_name TEXT NOT NULL,
    project_name TEXT NOT NULL,  -- 'Waves', 'HoneyDo', 'Seawater', etc.
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Project-specific data tables (with prefixes)
CREATE TABLE waves_project_data (...);
CREATE TABLE honeydo_project_data (...);
CREATE TABLE seawater_project_data (...);
```

### Database Connection Configuration

Each sibling project needs these environment variables:

```bash
# Required for all projects
DB_TYPE=postgresql
DB_HOST=your-shared-postgres-host
DB_NAME=equilateral_agents_shared
DB_USER=postgres
DB_PASSWORD=your-password
DB_PORT=5432
DB_SSL_MODE=require

# Project identifier
PROJECT_NAME=Waves  # or HoneyDo, Seawater, etc.
```

---

## Implementation Steps for Each Sibling

### Step 1: Install Dependencies

```bash
npm install pg commander glob
# Optional for SQLite fallback
npm install sqlite3 sqlite
```

### Step 2: Copy Agent System Files

Copy these files from EquilateralAgents to your project:

```
src/agents/
├── core/
│   └── AgentOrchestrator.js
├── specialists/
│   ├── SecurityReviewerAgent.js
│   ├── TestAgent.js
│   ├── PatternHarvestingAgent.js
│   └── [other specialists]
├── helpers/
│   └── responseUtil.js  # Project-agnostic response utilities
├── simple-agent-runner.js
├── simple-db-setup.js
└── config.json
```

### Step 3: Update package.json

Add the agents command to your scripts:

```json
{
  "scripts": {
    "agents": "node src/agents/cli/orchestrator-cli.js"
  }
}
```

### Step 4: Database Setup

Run the database setup script:

```bash
# For PostgreSQL (recommended)
DB_TYPE=postgresql DB_HOST=your-host DB_NAME=equilateral_agents_shared node src/agents/simple-db-setup.js

# For SQLite (local development)
DB_TYPE=sqlite DB_PATH=./agents.db node src/agents/simple-db-setup.js
```

### Step 5: Test Agent Functionality

```bash
# List available agents
npm run agents list-agents

# Execute a workflow
npm run agents deploy-feature --environment dev --branch main
```

---

## Project-Specific Customizations

### Waves Project
```javascript
// In src/agents/config.json
{
  "projectName": "Waves",
  "specializations": ["ocean-data", "wave-analysis"],
  "defaultWorkflow": "oceanographic-analysis"
}
```

### HoneyDo Project
```javascript
{
  "projectName": "HoneyDo",
  "specializations": ["task-management", "productivity"],
  "defaultWorkflow": "task-optimization"
}
```

### Seawater Project
```javascript
{
  "projectName": "Seawater", 
  "specializations": ["water-quality", "marine-systems"],
  "defaultWorkflow": "quality-assessment"
}
```

---

## Database Table Strategy

### Shared Coordination Tables (No Prefix)
- `agent_workflows` - Workflow orchestration
- `agent_executions` - Individual agent runs
- `agent_dependencies` - Inter-agent dependencies
- `agent_results` - Execution results and metrics

### Project-Specific Data Tables (With Prefixes)
- `{project}_project_analysis` - Project-specific analysis results
- `{project}_security_findings` - Security scan results
- `{project}_test_metrics` - Test execution metrics
- `{project}_pattern_catalog` - Harvested patterns

### Example Query Pattern
```javascript
// Get workflow status for specific project
const query = `
  SELECT * FROM agent_workflows 
  WHERE project_name = $1 
  AND status = 'running'
`;
const result = await client.query(query, ['Waves']);
```

---

## Migration Checklist

### For Each Sibling Project:

- [ ] Install required dependencies (`pg`, `commander`, `glob`)
- [ ] Copy agent system files from EquilateralAgents
- [ ] Configure database connection environment variables
- [ ] Set project-specific name in config.json
- [ ] Run database setup script
- [ ] Test agent execution with simple workflow
- [ ] Update project documentation with agent capabilities
- [ ] Configure project-specific workflows and specializations

### Database Administrator Tasks:

- [ ] Create shared PostgreSQL database `equilateral_agents_shared`
- [ ] Run database setup from one project to create shared tables
- [ ] Configure connection credentials for all 4 projects
- [ ] Set up backup strategy for shared coordination data
- [ ] Monitor database performance with multiple projects

---

## Performance Considerations

### Shared Database Benefits
- **Centralized coordination**: All agents can see cross-project workflows
- **Resource optimization**: Single database instance for all projects
- **Cross-project insights**: Agents can learn patterns across all siblings

### Potential Issues & Solutions
- **Concurrent access**: Use connection pooling and proper transaction isolation
- **Data privacy**: Project-specific table prefixes ensure data separation
- **Schema migrations**: Coordinate updates across all 4 projects

---

## Support & Troubleshooting

### Common Issues

1. **Connection failures**: Verify database credentials and network access
2. **Missing tables**: Re-run `simple-db-setup.js` to create schema
3. **Agent execution errors**: Check that all specialist files are copied correctly
4. **Workflow conflicts**: Use unique workflow IDs with project prefixes

### Getting Help

- Check agent logs: `npm run agents status`
- Validate database connection: Test with simple query
- Review agent configuration: Verify config.json settings
- Monitor shared workflows: Query `agent_workflows` table for conflicts

---

## Next Steps After Migration

1. **Test cross-project coordination**: Run workflows from multiple siblings simultaneously
2. **Implement project-specific workflows**: Customize agents for domain needs  
3. **Monitor performance**: Track database usage and optimization opportunities
4. **Enhance capabilities**: Add new specialist agents as needed

This migration enables all sibling projects to benefit from real agent orchestration while maintaining proper data separation and coordination through the shared database approach.