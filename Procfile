web: bundle exec puma -C config/puma.rb
release: bin/rails db:migrate
worker: bundle exec sidekiq -e production -c 3
