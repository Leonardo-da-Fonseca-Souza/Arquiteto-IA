# Here's a breakdown of the Linux instance and relevant Cloud Shell commands, extracted and organized for clarity:

# 1. Setting up the Environment
# 	Open Cloud Shell: (Press G then S keys or click the "Activate Cloud Shell" button in the Google Cloud Console).
# 	Open Cloud Shell Editor:

cloudshell workspace ~

# 	Install ADK:
export PATH=$PATH:"/home/${USER}/.local/bin"
python3 -m pip install google-adk==1.1.1

# 	Download Lab Files:
gcloud storage cp gs://YOUR_GCP_PROJECT_ID-bucket/adk_to_agent_engine.zip .
unzip adk_to_agent_engine.zip

#  Replace YOUR_GCP_PROJECT_ID with your actual Project ID.
# 	Install Additional Requirements:
python3 -m pip install -r adk_to_agent_engine/requirements.txt

#  2. Working with Agent Code (transcript_summarization_agent Directory)
# 	Navigate to the Agent Directory:
cd ~/adk_to_agent_engine/transcript_summarization_agent

# 	Test Agent Locally:
python3 test_agent_app_locally.py

# 	Deploy to Agent Engine:
python3 deploy_to_agent_engine.py

# 	Query Agent on Agent Engine:
python3 query_app_on_agent_engine.py

# 	List Agent Engine Agents:
python3 agent_engine_utils.py list

# 	Delete Agent Engine Agent:
python3 agent_engine_utils.py delete RESOURCE_ID_FROM_PREVIOUS_OUTPUT

# Replace RESOURCE_ID_FROM_PREVIOUS_OUTPUT with the actual resource ID you obtained from the list command.
