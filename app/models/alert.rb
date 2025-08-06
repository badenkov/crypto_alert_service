class Alert < ApplicationRecord
  enum :direction, %w[ up down ]
end
