# db/seeds.rb

# Create default users
default_users = [
  { email: "user1@example.com", password: "password123" },
  { email: "user2@example.com", password: "password123" }
]

default_users.each do |user_data|
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.password = user_data[:password]
    user.password_confirmation = user_data[:password]
  end
end

# Create default books
default_books = [
  { title: "To Kill a Mockingbird", author: "Harper Lee", description: "A novel about racial injustice.", image_url: "https://via.placeholder.com/150" },
  { title: "1984", author: "George Orwell", description: "A dystopian novel about totalitarianism.", image_url: "https://via.placeholder.com/150" },
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", description: "A critique of the American Dream.", image_url: "https://via.placeholder.com/150" }
]

default_books.each do |book_data|
  Book.find_or_create_by!(title: book_data[:title], author: book_data[:author]) do |book|
    book.description = book_data[:description]
    book.image_url = book_data[:image_url]
  end
end

# Create default reviews
default_reviews = [
  { content: "A masterpiece of modern literature.", rating: 5, book_title: "To Kill a Mockingbird", user_email: "user1@example.com" },
  { content: "Profound and thought-provoking.", rating: 5, book_title: "1984", user_email: "user2@example.com" },
  { content: "An interesting critique of wealth and society.", rating: 4, book_title: "The Great Gatsby", user_email: "user1@example.com" }
]

default_reviews.each do |review_data|
  book = Book.find_by(title: review_data[:book_title])
  user = User.find_by(email: review_data[:user_email])

  if book && user
    Review.find_or_create_by!(content: review_data[:content], book_id: book.id, user_id: user.id) do |review|
      review.rating = review_data[:rating]
    end
  else
    puts "Could not create review: Book or User missing for #{review_data[:book_title]} by #{review_data[:user_email]}"
  end
end

puts "Database seeding completed!"
