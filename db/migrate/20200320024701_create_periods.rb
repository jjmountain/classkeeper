class CreatePeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :periods do |t|
      t.references :faculty, null: false, foreign_key: true
      t.time :start_time
      t.integer :minutes
      t.integer :period_number

      t.timestamps
    end
  end
end
