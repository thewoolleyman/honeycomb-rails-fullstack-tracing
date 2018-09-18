class ApplicationController < ActionController::Base
  # Don't worry about form authenticity tokens in this simple example app
  skip_before_action :verify_authenticity_token

  around_action :wrap_in_tracing_span

  private

  def wrap_in_tracing_span
    with_span("#{controller_name}##{action_name}") do
      yield
    end
    response.headers['X-Client-Trace-Id'] = Thread.current[:client_parent_span_id] if Thread.current[:client_parent_span_id]
  end
end
