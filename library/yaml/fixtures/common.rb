require 'syck' rescue nil
require 'yaml'

$test_file = tmp("yaml_test_file")
$test_parse_file = File.dirname(__FILE__) + "/test_yaml.yml"