# CLA Bot Configuration - Zisk Project

This repository contains the automated configuration of the CLA (Contributor License Agreement) for the Zisk project.

## 🤖 CLA Automation

### Automatic Process

1. **Automatic detection**: When someone opens a PR, the bot automatically checks if they have signed the CLA
2. **Notification**: If not signed, a comment with instructions is added
3. **Automatic signature**: The contributor comments "I have read and agree to the CLA" and is automatically added
4. **Label management**: Automatically manages `cla-required` and `cla-signed` labels

### Available Workflows

#### 1. Auto Update CLA Contributors (`auto-update-cla.yml`)
- **Trigger**: New PRs, PR comments, manual execution
- **Function**: Automatic CLA process management

#### 2. CLA Management Admin (`cla-admin.yml`)
- **Trigger**: Manual execution
- **Function**: Administrative CLA management
- **Available actions**:
  - `add-user`: Manually add user
  - `remove-user`: Remove user
  - `list-users`: List all contributors
  - `export-report`: Generate JSON report

### Utility Scripts

#### `update-cla.sh`
Local script to add contributors:
```bash
./update-cla.sh <github-username>
```

#### `scripts/check-pending-cla.sh`
Script to check PRs with pending CLA:
```bash
GITHUB_TOKEN=your_token ./scripts/check-pending-cla.sh
```

## 📋 For Contributors

### How to accept the CLA (Simplified Process)

1. **Read the document**: [Individual CLA Document](./CLA%20Zisk.pdf)
2. **Accept digitally**: Comment with **exactly** this text (no additional words):
   ```
   I have read and agree to the CLA
   ```
3. **Automatic**: The bot will automatically add you using your verified GitHub account

⚠️ **Important**: The comment must contain exactly the phrase above, with no additional text or modifications. This ensures legal compliance and prevents accidental acceptance.

### CLA States

- 🔴 **CLA Required**: You need to accept the CLA
- 🟢 **CLA Signed**: You have already accepted and are on the list

## 🛠️ For Administrators

### Add user manually

1. **Via GitHub Actions**:
   - Go to "Actions" → "CLA Management Admin"
   - Select "Run workflow"
   - Choose "add-user" and provide the username

2. **Via local script**:
   ```bash
   ./update-cla.sh new-user
   ```

3. **Via workflow dispatch**:
   - In the "Actions" tab, run "Auto Update CLA Contributors"
   - Provide the username in the input

### Generate reports

```bash
# Via GitHub Actions
Actions → CLA Management Admin → export-report

# Via script
GITHUB_TOKEN=token ./scripts/check-pending-cla.sh
```

### Notification configuration

To receive email notifications for pending CLAs:

```bash
export NOTIFICATION_EMAIL="admin@example.com"
export GITHUB_TOKEN="your_github_token"
./scripts/check-pending-cla.sh
```

## 📁 File structure

```
.
├── .clabot                          # CLA bot configuration
├── CLA Zisk.pdf                     # CLA document
├── .github/
│   ├── workflows/
│   │   ├── auto-update-cla.yml      # Main workflow
│   │   └── cla-admin.yml            # Administrative management
│   └── ISSUE_TEMPLATE/
│       └── cla-request.md           # Request template
├── scripts/
│   └── check-pending-cla.sh         # Monitoring script
├── update-cla.sh                    # Local update script
└── README.md                        # This documentation
```

## 🔧 Configuration

### Required environment variables

- `GITHUB_TOKEN`: Token with repository write permissions
- `NOTIFICATION_EMAIL`: (Optional) Email for notifications

### Required permissions

The GitHub token needs:
- `repo`: Full repository access
- `workflow`: Execute workflows

## 📞 Support

For questions about the CLA or technical issues:
- **Technical issues**: Open an issue in this repository
- **General questions**: Contact the development team
