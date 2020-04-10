import logging
import logstash
import sys

host = 'localhost'

test_logger = logging.getLogger('python-logstash-logger')
test_logger.setLevel(logging.INFO)
# test_logger.addHandler(logstash.LogstashHandler(host, 31311, version=1))
test_logger.addHandler(logstash.TCPLogstashHandler(host, 6000, message_type='judgemod-main-log', version=1, tags=['judge', 'fileserver']))

test_logger.error('test logging')
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
