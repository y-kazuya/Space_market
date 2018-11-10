class ReserveDate < ApplicationRecord
  belongs_to :reserve, optional: true
end
