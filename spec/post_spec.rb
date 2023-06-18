RSpec.describe Post, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to(:author).class_name("User") }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end

  describe "recent_comments" do
    let(:post) { create(:post) }

    it "returns the 5 most recent comments" do
      create_list(:comment, 10, post: post)

      recent_comments = post.recent_comments

      expect(recent_comments.length).to eq(5)
      expect(recent_comments).to eq(post.comments.order(created_at: :desc).limit(5))
    end
  end

  describe "update_comments_counter" do
    let(:post) { create(:post) }

    it "updates the comments_counter attribute" do
      create_list(:comment, 3, post: post)

      post.update_comments_counter

      expect(post.comments_counter).to eq(3)
    end
  end

  describe "update_likes_counter" do
    let(:post) { create(:post) }

    it "updates the likes_counter attribute" do
      create_list(:like, 4, post: post)

      post.update_likes_counter

      expect(post.likes_counter).to eq(4)
    end
  end

  describe "update_posts_counter" do
    let(:user) { create(:user) }

    it "updates the post_counter attribute of the associated user" do
      create_list(:post, 6, author: user)

      user.posts.first.update_posts_counter

      expect(user.post_counter).to eq(6)
    end
  end
end
