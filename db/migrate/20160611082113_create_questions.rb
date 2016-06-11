class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.integer :language
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
