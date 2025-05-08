# Direct CSS tasks for development
namespace :css do
  desc "Build CSS for development"
  task :build do
    system "npm run build:css"
  end

  desc "Watch CSS for changes and rebuild"
  task :watch do
    system "npx tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --watch"
  end
end

