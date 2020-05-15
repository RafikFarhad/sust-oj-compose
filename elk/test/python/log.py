import logging
import logstash
import sys

host = 'localhost'

# basic_format = '%(asctime)s %(threadName)s %(name)-18s %(message)s'
# logging.basicConfig(level=logging.DEBUG,
#                     format=basic_format,
#                     datefmt="%y-%m-%d'T'%H:%M")

# test_logger = logging.getLogger()
# test_logger.setLevel(logging.DEBUG)

# test_logger.addHandler(logstash.TCPLogstashHandler(host, 6002))

# test_logger.error('My message')
# # test_logger.debug('2020-15-12T10:49:24.219 45 sustoj.resource_manager.thread_pool INFO     Released Thread : [ 45 ] from submission : 45')

n_logger = logging.getLogger()
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s %(threadName)s %(name)-12s %(levelname)-8s %(message)s')
stream_handler.setFormatter(formatter)
n_logger.addHandler(stream_handler)
n_logger.addHandler(logstash.TCPLogstashHandler(host, 6002))

n_logger.error("okay dokey")