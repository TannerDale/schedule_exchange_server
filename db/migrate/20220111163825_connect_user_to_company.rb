class ConnectUserToCompany < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :company, forgeign_key: true
  end
end
