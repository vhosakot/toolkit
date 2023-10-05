require 'bundler'
Bundler.require

ENV['KEY_POOL'] = '[{"keyId":"EscherExample","secret":"TheBeginningOfABeautifulFriendship","acceptOnly":0}]'
ENV['ESCHEREXAMPLE_KEYID'] = 'EscherExample'

CredentialScope = 'example/credential/scope'
AuthOptions = {}

require_relative('your_awesome_app')
require_relative('escher/rack_middleware')
