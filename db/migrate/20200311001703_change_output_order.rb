class ChangeOutputOrder < ActiveRecord::Migration[6.0]
  def change
    change_table :contacts do |t|
      t.change :middle_name, :string, after: :first_name
      t.change :last_name, :string, after: :middle_name
    end
  end
end
