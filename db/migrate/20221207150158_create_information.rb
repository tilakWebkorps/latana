class CreateInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :information do |t|
      t.string :package
      t.string :version
      t.string :r_version_needed
      t.string :depends
      t.datetime :date_publication
      t.string :title
      t.string :author
      t.string :maintainer
      t.string :license

      t.timestamps
    end
  end
end
