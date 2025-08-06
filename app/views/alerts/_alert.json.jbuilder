json.extract! alert, :id, :symbol, :threshold, :direction, :created_at, :updated_at
json.url alert_url(alert, format: :json)
