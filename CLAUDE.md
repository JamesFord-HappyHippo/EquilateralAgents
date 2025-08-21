# Claude Code AI Assistant Configuration - Equilateral AI

**Developed by Equilateral AI (Pareidolia LLC)**

This file provides configuration and guidelines for Claude Code AI assistant to work effectively with the Equilateral AI multi-agent orchestration system.

## Multi-Agent Orchestration System 🤖

**Status**: Production Ready ✅ (11 agents operational, 4 workflows active)

This project includes a comprehensive multi-agent orchestration system for coordinating complex development workflows.

### Quick Start Commands
```bash
# List available workflows and agents
npm run agents list-workflows
npm run agents list-agents

# Execute workflows
npm run agents deploy-feature --environment dev --branch feature/name
npm run agents security-review --include-cost-analysis --severity high
npm run agents quality-check --standards-check --include-patterns
npm run agents full-stack-deploy --environment production --validate-costs

# Monitor execution
npm run agents status
```

### 11 Specialist Agents Available
1. **SecurityReviewerAgent** - Security analysis with cost controls (18 capabilities)
2. **AuditorAgent** - Standards compliance validation (19 capabilities)  
3. **PatternHarvestingAgent** - Code pattern analysis (44 capabilities)
4. **DeploymentAgent** - Multi-account deployment (31 capabilities)
5. **TestDataAgent** - Database coherence and test data generation (12 capabilities)
6. **KnowledgeSynthesisAgent** - Knowledge capture and synthesis (30 capabilities)
7. **AgentClassifier** - Task classification and routing (11 capabilities)
8. **AgentMemoryManager** - Context and state management (13 capabilities)
9. **TestAgent** - UI testing with intelligent element remapping (15 capabilities)
10. **UIUXSpecialistAgent** - Design consistency and accessibility automation (15 capabilities)
11. **AgentFactoryAgent** - Self-bootstrapping agent generation system (12 capabilities)

### 4 Pre-defined Workflows
- **deploy-feature**: Full validation pipeline with cost analysis gates
- **security-review**: Comprehensive security assessment with parallel execution
- **quality-check**: Code quality analysis with .clinerules validation
- **full-stack-deploy**: Complete deployment with all validations

### Key Features
- **Event-driven Architecture**: Real-time progress tracking
- **Cost Analysis Gates**: SecurityReviewerAgent validates infrastructure costs before deployment
- **Automatic Standards Enforcement**: All workflows enforce .clinerules patterns
- **Parallel Execution**: Up to 5 concurrent agents with dependency management
- **Environment-Aware**: Appropriate thresholds for dev/sandbox/production

**Reference**: `.clinerules/agent_orchestration_standards.md` for complete documentation

## Core Standards Reference

All development standards are centrally maintained in `.clinerules/` directory. Key reference files:

### API Standards
**Primary File**: `.clinerules/api_standards.md`

Core patterns:
- **API Response Format**: Always use `APIResponse<T>` with `Records` array wrapping
- **Field Naming**: Use exact DB field names (no transformation), PascalCase_With_Underscores for most fields
- **Error Handling**: Implement `APIErrorResponse` format with specific error codes
- **Endpoint Configuration**: All endpoints in appropriate API client file

### Backend Handler Standards  
**Primary File**: `.clinerules/backend_handler_standards.md`

Critical requirements:
- **Required Imports**: `wrapHandler`, `executeQuery`, `createSuccessResponse`, `handleError`
- **Standard Pattern**: Use wrapper function with proper parameter destructuring
- **Helper Verification**: Always verify helper existence before import
- **ID Generation**: Use business-scoped IDs (not random UUIDs) for traceability

### Frontend Standards
**Primary File**: `.clinerules/frontend_standards.md`

Key patterns:
- **Technology Stack**: React + TypeScript + Flowbite React + TailwindCSS
- **Context Architecture**: Layered providers (Auth → Status → Account → Company → Feature)
- **Component Structure**: Feature-based organization with performance optimization
- **Role-Based Access**: Implement RBAC with permission-based rendering

### Development Principles
**Primary File**: `.clinerules/development_principles.md`

Core tenets:
1. **No Mocks, No Fallback Data** - Failures must be visible for root cause fixes
2. **Fail Fast, Fail Loudly** - Make failures obvious and immediate  
3. **Consistent Error Handling** - Use established patterns across application
4. **Error-First Design** - Design error states before happy path
5. **Cost-First Infrastructure Design** - Always perform cost analysis during planning

### Cost Optimization Standards
**Primary File**: `.clinerules/cost_optimization_standards.md`

Key principles:
- **Environment-Appropriate Sizing** - Dev templates for dev, production for production
- **Pay-Per-Use Default** - Only add fixed costs when measured need exists
- **ARM64 Optimization** - Use Graviton2 for 20% cost savings by default
- **Cost Analysis Gates** - Validate costs before deployment

## Implementation Guidelines

### When Generating API Code
Always reference API standards:
```javascript
// Correct API call pattern (from api_standards.md)
const result = await Make_Authorized_API_Call<DataType>(
  API_ENDPOINTS.DOMAIN.ACTION,
  'GET',
  undefined,
  { params: { Company_ID: companyId } }
);

if (result.success) {
  // Use result.data.Records (always wrapped in Records array)
  const records = result.data.Records;
} else {
  // Handle error following established patterns
  console.error('API Error:', result.message);
}
```

### When Creating Backend Handlers
Follow handler standards pattern:
```javascript
// Required imports (from backend_handler_standards.md)
const { wrapHandler } = require('./lambdaWrapper');
const { executeQuery } = require('./dbOperations');
const { createSuccessResponse, createErrorResponse } = require('./responseUtil');
const { handleError } = require('./errorHandler');

async function handlerName({ queryParams = {}, requestBody = {}, requestContext }) {
    try {
        const Request_ID = requestContext.requestId;
        // Handler logic here
        return createSuccessResponse(
            { Records: results },
            'Success message',
            {
                Total_Records: results.length,
                Request_ID,
                Timestamp: new Date().toISOString()
            }
        );
    } catch (error) {
        console.error('Handler Error:', error);
        return handleError(error);
    }
}

exports.handler = wrapHandler(handlerName);
```

### When Building Frontend Components
Reference frontend standards:
```tsx
// Context provider pattern (from frontend_standards.md)
<AuthProvider>
  <StatusProvider>
    <AccountProvider>
      <CompanyProvider>
        <FeatureProviders>
          <RouteComponent />
        </FeatureProviders>
      </CompanyProvider>
    </AccountProvider>
  </StatusProvider>
</AuthProvider>
```

## Validation Checklist

Before completing any implementation:

### API Implementation
- [ ] Follows `APIResponse<T>` format with Records array
- [ ] Uses exact DB field names (no transformation)  
- [ ] Implements proper error handling with `APIErrorResponse`
- [ ] Endpoint defined in appropriate API client
- [ ] Includes `Query_Context` and `Analytics` when applicable

### Backend Handler Implementation  
- [ ] Uses `wrapHandler` and standard parameter destructuring
- [ ] Includes all required imports (`handleError`, `executeQuery`, etc.)
- [ ] Uses AWS-native request ID from `requestContext.requestId`
- [ ] Returns data in `Records` array format
- [ ] Implements business-scoped ID generation patterns

### Frontend Component Implementation
- [ ] Uses appropriate context layer for data access
- [ ] Implements role-based access control
- [ ] Follows performance optimization patterns (memo, useMemo, useCallback)
- [ ] Includes proper error boundary handling
- [ ] Uses Flowbite React components with TailwindCSS

### Error Handling Implementation
- [ ] No mock data or fallback values in production
- [ ] Failures are visible and descriptive
- [ ] Consistent error handling patterns used
- [ ] Error states designed as first-class UI elements

### Cost Analysis Implementation
- [ ] Infrastructure costs validated before deployment
- [ ] Environment-appropriate template selection
- [ ] ARM64 optimization where applicable
- [ ] Fixed costs justified with business requirements

## Testing & Validation Commands

When implementing changes, run:
```bash
# Multi-agent validation
npm run agents quality-check --standards-check
npm run agents security-review --include-cost-analysis

# Standard validation (add your specific commands)
npm run lint
npm run typecheck  
npm run test
```

## Getting Help

For clarification on any patterns:
1. **Check specific `.clinerules/` file** for detailed implementation guidance
2. **Reference existing similar implementations** in codebase
3. **Validate against checklists** provided in standards files
4. **Use multi-agent orchestration** for complex tasks

## Best Practices

1. **Always reference standards** when generating any code
2. **Use multi-agent workflows** for complex development tasks
3. **Validate implementations** against provided checklists before completion
4. **Maintain consistency** between frontend and backend patterns
5. **Follow error-first design** principles in all implementations
6. **Use business-scoped IDs** for traceability and debugging efficiency
7. **Perform cost analysis** during planning phase to prevent expensive mistakes

---

**This template provides a complete development environment with proven methodology and multi-agent orchestration capabilities for systematic software development.**