class Commentary < ApplicationRecord
    belongs_to :maze
    belongs_to :user
end
