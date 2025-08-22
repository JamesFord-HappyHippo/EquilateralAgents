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
# Optional for SQLite fallback (recommended for development)
npm install sqlite3 sqlite
```

**Note**: SQLite is recommended for initial setup and testing as it requires no external database configuration.

### Step 2: Copy Agent System Files

Copy these files from EquilateralAgents to your project:

**For projects with `src/` directory (most React/Node projects):**
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

**For projects without `src/` directory (like oxide-performance-poc):**
```
agents/
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

**Important**: Update the orchestrator CLI path in `agents/cli/orchestrator-cli.js` to match your structure:
- For `src/agents/`: Use `agentDirectory: 'src/agents/specialists'`
- For `agents/`: Use `agentDirectory: 'agents/specialists'`

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
# For PostgreSQL (recommended for production)
DB_TYPE=postgresql DB_HOST=your-host DB_NAME=equilateral_agents_shared node src/agents/simple-db-setup.js

# For SQLite (recommended for development/testing)
DB_TYPE=sqlite DB_PATH=./agents.db node src/agents/simple-db-setup.js
```

**Expected Output**:
```
🔧 Setting up agent database...
📊 Database type: sqlite
🔌 Connecting to SQLite at ./agents.db...
✅ Database connection successful
✅ Agent coordination tables created
🚀 Agent database ready for coordination!
```

### Step 5: Test Agent Functionality

```bash
# List available agents
npm run agents list-agents

# List available workflows
npm run agents list-workflows

# Execute a workflow (simple commands, no arguments)
npm run agents security-review
npm run agents code-quality-check
```

**Expected Output**:
```
✅ Orchestrator initialized - 11 agents, 4 workflows
🤖 Available Agents:
  AgentClassifier (loaded)
  SecurityReviewerAgent (loaded)  
  TestAgent (loaded)
  [... 8 more agents]
```

**Note**: You may see "❌ Orchestrator initialization timeout" - this is cosmetic and can be ignored if agents load successfully.

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

1. **"Cannot find module 'commander'" Error**: 
   - **Solution**: Run `npm install commander glob` in your project directory
   - **Root Cause**: Missing CLI dependencies for orchestrator

2. **"Agent directory not found" Error**:
   - **Solution**: Verify file paths in orchestrator CLI configuration
   - **Check**: Ensure `agentDirectory` matches your project structure (`src/agents/specialists` vs `agents/specialists`)

3. **"Cannot find module '../helpers/responseUtil'" Error**:
   - **Solution**: Ensure you copied the `helpers/` folder from EquilateralAgents
   - **Verify**: All agents should import from `../helpers/responseUtil`

4. **"❌ Orchestrator initialization timeout"**:
   - **Status**: Cosmetic issue - can be ignored if agents load successfully
   - **Evidence**: Look for "✅ Orchestrator initialized - X agents, Y workflows"

5. **Some agents fail to load with "AgentClass is not a constructor"**:
   - **Status**: Normal for some legacy agents with export format differences
   - **Impact**: Core agents (SecurityReviewerAgent, TestAgent, AgentClassifier) should still load

6. **Connection failures**: Verify database credentials and network access
7. **Missing tables**: Re-run `simple-db-setup.js` to create schema
8. **Workflow conflicts**: Use unique workflow IDs with project prefixes

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