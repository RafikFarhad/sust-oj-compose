import logging
import logstash
import sys

host = 'localhost'

test_logger = logging.getLogger('python-logstash-logger')
test_logger.setLevel(logging.INFO)
# test_logger.addHandler(logstash.LogstashHandler(host, 31311, version=1))
test_logger.addHandler(logstash.TCPLogstashHandler(host, 6000, message_type='judgemod-main-log', version=1, tags=['judge', 'fileserver']))

test_logger.error('2020-15-12T10:49:21.174 MainThread botocore.hooks     DEBUG    Event creating-client-class.s3: calling handler <function add_generate_presigned_post at 0x7f4f545a1730>')
test_logger.debug('2020-15-12T10:49:24.219 45 sustoj.resource_manager.thread_pool INFO     Released Thread : [ 45 ] from submission : 45')
# test_logger.info('log python-logstash: test logstash info message.')
# test_logger.warning('log python-logstash: test logstash warning message.')

# # add extra field to logstash message
# extra = {
#     'test_string': 'python version: ' + repr(sys.version_info),
#     'test_boolean': True,
#     'test_dict': {'a': 1, 'b': 'c'},
#     'test_float': 1.23,
#     'test_integer': 123,
#     'test_list': [1, 2, '3'],
# }
# test_logger.info('python-logstash: test extra fields', extra=extra)
