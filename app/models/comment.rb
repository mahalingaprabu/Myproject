class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :commenter_emp_id
  belongs_to :article
  validates_presence_of :body
end
