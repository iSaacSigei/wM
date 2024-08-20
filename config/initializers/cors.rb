# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://womall.vercel.app'  # Your frontend domain

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization'],
      credentials: true,  # Allows cookies to be sent
      max_age: 600
  end
end
