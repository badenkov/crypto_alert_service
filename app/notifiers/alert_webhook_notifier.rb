class AlertWebhookNotifier < ApplicationNotifier
  self.driver = proc do |data|
    data => { body: }
    HTTP.post("https://webhook.site/ac63997c-fe71-47f5-8fda-5ba3f761defc", json: body)
  end

  def triggered
    notification(
      body: {
        hello_world: true
      },
      subject: "Hello, world!"
    )
  end
end
