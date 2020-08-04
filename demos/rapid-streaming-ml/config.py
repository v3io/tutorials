# %load config.py
from os import getenv, path
import os


V3IO_ACCESS_KEY = getenv('V3IO_ACCESS_KEY')
V3IO_USERNAME = getenv('V3IO_USERNAME')
CONTAINER = 'users'
BATCH_SIZE = 1024
WEB_API = "http://v3io-webapi:8081"
WEB_API_USERS = "{0}/{1}/".format(WEB_API, CONTAINER)
PROJECT_NAME = "model-deployment-with-streaming"
STREAM_CONFIGS = {'generated-stream': {
                        'path': path.join(V3IO_USERNAME, 'examples/{0}/generated-stream'.format(PROJECT_NAME)),
                        'shard_count': 8},
                  'incoming-events-stream': {
                        'path': path.join(V3IO_USERNAME, 'examples/{0}/incoming-events-stream'.format(PROJECT_NAME)),
                        'shard_count': 8
                  },
                  'enriched-events-stream': {
                        'path': path.join(V3IO_USERNAME, 'examples/{0}/enriched-events-stream'.format(PROJECT_NAME)),
                        'shard_count': 8
                  },
                  'serving-stream': {
                        'path': path.join(V3IO_USERNAME, 'examples/{0}/serving-stream'.format(PROJECT_NAME)),
                        'shard_count': 8
                  },
                  'inference-stream': {
                        'path': path.join(V3IO_USERNAME, 'examples/{0}/inference-stream'.format(PROJECT_NAME)),
                        'shard_count': 8
                  }
                 }
PARTITION_ATTR = "user_id"
ENRICHMENT_TABLE_PATH = path.join(os.sep, V3IO_USERNAME, 'examples', PROJECT_NAME, 'enrichment-table')
FEATURE_TABLE_PATH = path.join(os.sep, V3IO_USERNAME, 'examples', PROJECT_NAME, 'feature-table')
MDWS_S2P_TARGET_PATH = path.join(os.sep, V3IO_USERNAME, 'examples', PROJECT_NAME, 'events-pq')