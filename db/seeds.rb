require 'faker'

puts "🧹 清除旧数据..."
Post.destroy_all
User.destroy_all

puts "📸 加载头像和帖子图片..."
avatar_images = Dir[Rails.root.join("app/assets/images/seeds/avatar*.png")]
post_images = Dir[Rails.root.join("app/assets/images/seeds/post*.png")]

# 帖子内容模板（可爱动物遇见语录）
cute_messages = [
  "Just saw the fluffiest kitten ever!",
  "Ran into a squirrel that tried to share my snack 😆",
  "A puppy licked my hand and my heart melted 🐶",
  "Met a tiny duckling at the park. I'm in love!",
  "That bunny looked straight into my soul 🐰"
]

puts "👤 创建 3 位用户并发布帖子..."

3.times do |i|
  user = User.create!(
    username: Faker::Name.unique.first_name.downcase,
    email: "user#{i + 1}@example.com",
    password: "password"
  )

  # 附加头像
  avatar_path = avatar_images[i % avatar_images.length]
  user.avatar.attach(
    io: File.open(avatar_path),
    filename: File.basename(avatar_path),
    content_type: "image/png"
  )

  puts "  ✅ 用户 #{user.username} 创建完成，头像已附加"

  3.times do
    message = cute_messages.sample
    image_path = post_images.sample

    post = user.posts.create!(
      content: message
    )

    post.image.attach(
      io: File.open(image_path),
      filename: File.basename(image_path),
      content_type: "image/png"
    )

    puts "    📝 发帖：#{message.truncate(30)}（含图）"
  end
end

puts "✅ 所有种子数据生成完毕 🎉"
