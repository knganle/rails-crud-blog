namespace :check_need_archive do
  desc 'Check need archive'
  task enforcement: :environment do
    RakeCheckNeedArchive.perform_now
  end
end
