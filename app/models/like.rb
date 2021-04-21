class Like < ApplicationRecord
  belongs_to :fan, class_name: "User", counter_cache: true
  belongs_to :photo

end
