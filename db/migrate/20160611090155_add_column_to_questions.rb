class AddColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :category_id, :integer
    add_column :questions, :language_id, :integer
  end
end
