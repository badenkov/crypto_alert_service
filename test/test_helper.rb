ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock

  config.filter_sensitive_data("<AUTH_TOKEN>") do |interaction|
    auth = interaction.request.headers["Authorization"]&.first
    auth if auth&.start_with?("Bearer ")
  end

  config.before_record do |interaction|
    allowed_request_headers = [
      "Accept", "Content-Type", "Authorization"
    ]
    allowed_response_headers = [
      "Content-Type"
    ]

    # Удаляем все заголовки, которые не находятся в белом списке
    interaction.request.headers.keys.each do |header|
      interaction.request.headers.delete(header) unless allowed_request_headers.include?(header)
    end

    interaction.response.headers.keys.each do |header|
      interaction.response.headers.delete(header) unless allowed_response_headers.include?(header)
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
