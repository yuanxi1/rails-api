class User < ApplicationRecord
    has_secure_password
    before_save :downcase_email
    
    has_many :tasks
    has_many :tags
    validates :email, presence: true, uniqueness: {case_sensitive: false}

    private
    def downcase_email
        self.email = self.email.downcase
   end

end
