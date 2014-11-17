class Province < ActiveRecord::Base
  has_many :rekaps, foreign_key: "provinsi_id"
end
