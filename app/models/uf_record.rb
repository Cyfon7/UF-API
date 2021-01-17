class UfRecord < ApplicationRecord
    validates :client, :resquest_date, :uf_value, presence: true
end
