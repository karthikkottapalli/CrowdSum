 require 'rails_helper'
 
 describe User do
 
   include TestFactories
 
   describe "#favorited(post)" do
     before do
       @post = associated_post
       current_user = authenticated_user
       @favorite = current_user.favorites.find_by_post_id(@post.id)
     end

     it "returns `nil` if the user has not favorited the post" do
       expect(@favorite).to eq(nil)
     end
 
     it "returns the appropriate favorite if it exists" do
       current_user = authenticated_user
       @favorite = current_user.favorites.build(post: @post)
       expect(@favorite).to be_truthy

     end
   end
 end