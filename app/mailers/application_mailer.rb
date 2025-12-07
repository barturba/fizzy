class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM_ADDRESS", "Fizzy <support@fizzy.do>")

  layout "mailer"

  # Override mail() to set From/Reply-To from ENV at send time
  # Note: Some SMTP providers (like ForwardEmail) require From to be exactly
  # the SMTP username with no display name. Adjust as needed for your provider.
  def mail(headers = {}, &block)
    # Set From to SMTP_USERNAME if available (no display name for SMTP compatibility)
    headers.delete(:from)
    headers[:from] = ENV['SMTP_USERNAME'] if ENV['SMTP_USERNAME']
    headers[:reply_to] ||= ENV['REPLY_TO_EMAIL'] if ENV['REPLY_TO_EMAIL']
    result = super(headers, &block)
    # Ensure From header remains plain email address after super() call
    if result.header[:from] && ENV['SMTP_USERNAME']
      result.header[:from] = ENV['SMTP_USERNAME']
    end
    result
  end

  append_view_path Rails.root.join("app/views/mailers")
  helper AvatarsHelper, HtmlHelper

  private
    def default_url_options
      if Current.account
        super.merge(script_name: Current.account.slug)
      else
        super
      end
    end
end
