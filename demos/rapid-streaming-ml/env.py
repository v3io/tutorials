# %load env.py
import os
os.environ["MDWS_PROJECT_NAME"] = PROJECT_NAME

#2
os.environ["MDWS_EH_OUTPUT_STREAM_PATH"] = STREAM_CONFIGS['incoming-events-stream']['path']
os.environ["MDWS_EH_PARTITION_ATTR"] = PARTITION_ATTR
os.environ["MDWS_EH_INPUT_STREAM_URL"] = path.join(WEB_API_USERS, STREAM_CONFIGS['generated-stream']['path']) + "@incomingeventhandler"
#2a
os.environ["MDWS_S2P_BATCH_SIZE"] = '1024'
os.environ["MDWS_S2P_TARGET_PATH"] = MDWS_S2P_TARGET_PATH
os.environ["MDWS_S2P_INPUT_URL"] = path.join(WEB_API_USERS, STREAM_CONFIGS['generated-stream']['path']) + "@stream2pq"
#3a
os.environ["PARTITION_ATTR"] = PARTITION_ATTR
#3b
os.environ["MDWS_ES_OUTPUT_STREAM_PATH"] = STREAM_CONFIGS['enriched-events-stream']['path']
os.environ["MDWS_ENRICHMENT_TABLE_PATH"] = V3IO_USERNAME + ENRICHMENT_TABLE_PATH
os.environ["MDWS_ES_INPUT_INPUT_STREAM_PATH"] = path.join(WEB_API_USERS, STREAM_CONFIGS['incoming-events-stream']['path']) + "@enrichstream"
#4
os.environ["MDWS_S2F_OUTPUT_STREAM_PATH"] = STREAM_CONFIGS['serving-stream']['path']
os.environ["FEATURE_TABLE_PATH"] = FEATURE_TABLE_PATH
os.environ["MDWS_S2F_INPUT_STREAM_PATH"] = path.join(WEB_API_USERS, STREAM_CONFIGS['enriched-events-stream']['path']) + "@stream2features"