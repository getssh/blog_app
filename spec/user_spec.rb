RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:post_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should have_many(:posts).with_foreign_key(:author_id) }
    it { should have_many(:comments).with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:author_id) }
  end

  describe "recent_posts" do
    let(:user) { create(:user) }

    it "returns the 3 most recent posts" do
      create_list(:post, 5, author: user)
      
      recent_posts = user.recent_posts
      
      expect(recent_posts.length).to eq(3)
      expect(recent_posts).to eq(user.posts.order(created_at: :desc).limit(3))
    end
  end
end
