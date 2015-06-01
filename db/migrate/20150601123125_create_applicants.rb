class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :contact
    end

    add_attachment :applicants, :resume

  end
end
