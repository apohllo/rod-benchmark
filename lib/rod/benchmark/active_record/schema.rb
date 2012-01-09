ActiveRecord::Schema.define(:version => 20111214135300) do
  create_table "flexemes", :force => true do |t|
    t.string   "lemma"
    t.references "base_form"
  end
  add_index :flexemes, [:lemma], :unique => true

  create_table "flexemes_word_forms", :force => true, :id => false do |t|
    t.references "flexeme"
    t.references "word_form"
  end
  add_index :flexemes_word_forms, [:flexeme_id,:word_form_id]
  add_index :flexemes_word_forms, [:flexeme_id]
  add_index :flexemes_word_forms, [:word_form_id]

  create_table "word_forms", :force => true do |t|
    t.string   "value"
  end
  add_index :word_forms, [:value], :unique => true

  create_table "taggings", :force => true do |t|
    t.references "flexeme"
    t.references "word_form"
  end
  add_index :taggings, [:flexeme_id]

  create_table "tags", :force => true do |t|
    t.string "value"
  end
  add_index :tags, [:value], :unique => true

  create_table "taggings_tags", :force => true, :id => false do |t|
    t.references "tag"
    t.references "tagging"
  end
  add_index :taggings_tags, [:tag_id,:tagging_id], :unique => true
  add_index :taggings_tags, [:tag_id]
  add_index :taggings_tags, [:tagging_id]

end
