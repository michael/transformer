require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'haml'

gem 'jnunemaker-matchy', '0.4.0'
require 'matchy'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'transformers'

# load transformer classes
Dir.glob(Transformers.transformer_root + '*.rb').each {|f| require f }

class Test::Unit::TestCase
  custom_matcher :be_nil do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be nil but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be nil but it was"
    receiver.nil?
  end
  
  custom_matcher :have do |receiver, matcher, args|
    count = args[0]
    something = matcher.chained_messages[0].name
    actual = receiver.send(something).size
    actual == count
  end
  
  custom_matcher :be_true do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be true but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be true but it was"
    receiver.eql?(true)
  end
  
  custom_matcher :be_false do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be false but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be false but it was"
    receiver.eql?(false)
  end
end