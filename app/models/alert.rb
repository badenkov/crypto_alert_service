class Alert < ApplicationRecord
  enum :status, %w[ pending active completed ].index_by(&:itself), default: :pending
  enum :direction, %w[ up down ]

  validates :symbol, presence: true,
    inclusion: { in: -> { Alert.available_symbols.map { it[:value] } } }
  validates :threshold, presence: true, numericality: { greater_than: 0 }
  validates :direction, presence: true
  validates :email_address,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    allow_blank: true
  validates :webhook_url,
    format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) },
    allow_blank: true

  after_commit :generate_price_threshold
  after_commit :send_notification

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(alert) { [ "alerts" ] }, inserts_by: :prepend

  cattr_reader :available_symbols do
    file_path = Rails.root.join("lib", "available_symbols.json")
    JSON.load_file(file_path, symbolize_names: true)
  end

  private
    def generate_price_threshold
      GeneratePriceThresholdJob.perform_later(self) if pending?
    end

    def send_notification
      if saved_change_to_status? && status == "completed"
        AlertDelivery.with(alert: self).triggered.deliver_now
      end
    end
end
