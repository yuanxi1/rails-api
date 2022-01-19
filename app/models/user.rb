class User < ApplicationRecord
    has_secure_password
    before_save :downcase_email
    
    has_many :tasks, dependent: :destroy
    has_many :tags, dependent: :destroy
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates :password, presence: true, allow_nil: true

    private
    def downcase_email
        self.email = self.email.downcase
   end

end
