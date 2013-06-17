require "sunspot/queue/sidekiq/index_job"
require "sunspot/queue/sidekiq/removal_job"

module Sunspot::Queue::Sidekiq
  class Backend
    attr_reader :configuration, :delay_for

    def initialize(configuration = Sunspot::Queue.configuration, delay_for = 10)
      @configuration = configuration
      @delay_for = delay_for
    end

    def index(klass, id)
      index_job.delay_for(3 + rand(@delay_for)).perform(klass, id)
    end

    def remove(klass, id)
      removal_job.delay_for(3 + rand(@delay_for)).perform(klass, id)
    end

    private

    def index_job
      configuration.index_job || ::Sunspot::Queue::Sidekiq::IndexJob
    end

    def removal_job
      configuration.removal_job || ::Sunspot::Queue::Sidekiq::RemovalJob
    end
  end
end
