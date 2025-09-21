This folder contains my Python exercises and small projects used to practice algorithms, problem solving, and small utilities.

## How to run projects
1. \`cd\` into the project folder (e.g. \`cd 02-python-algos/weather-cli\`).
2. Create and activate a virtual environment:
\`\`\`bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\\Scripts\\activate
\`\`\`
3. Install dependencies (if \`requirements.txt\` exists):
\`\`\`bash
pip install -r requirements.txt
\`\`\`
4. Run the script (adjust filename if different):
\`\`\`bash
python weather_cli.py
# or pass parameters if supported:
python weather_cli.py "Casablanca"
\`\`\`