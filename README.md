# CLA Bot Configuration

This repository contains the Contributor License Agreement (CLA) configuration for [ZisK](https://github.com/0xPolygonHermez) projects.

## Signing the CLA

To contribute to any ZisK repository, you must sign the [Individual CLA](CLA%20Zisk.pdf).

### Steps

1. Read the [Individual CLA document](CLA%20Zisk.pdf).
2. Fork this repository.
3. Add your GitHub username to the `contributors` list in the [`.clabot`](.clabot) file.
4. Commit the change with a **signed commit** and include the phrase:
   > I have read and agree to the CLA
   
   in the commit message.
5. Open a Pull Request against this repository.

### Example

```bash
# Fork and clone the repo
git clone https://github.com/<your-username>/clabot-config.git
cd clabot-config

# Edit .clabot and add your username to the "contributors" array
# Then commit with a signed commit
git commit -S -m "Add <your-username> to CLA signers - I have read and agree to the CLA"

# Push and open a PR
git push origin HEAD
```