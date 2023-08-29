# frozen_string_literal: true

module Whats
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :base_path, :token, :phone_id
  end
end
