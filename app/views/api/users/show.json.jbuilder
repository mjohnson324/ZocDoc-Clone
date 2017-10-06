user_apps = @user.appointments.includes(:review,
                                        doctor: [:specialties,
                                                 :certifications,
                                                 :appointments,
                                                 :reviews])
user_revs = []
user_docs = []

json.session do
  json.partial! "api/users/user", user: @user
  json.appointment_ids user_apps.map(&:id)
  json.review_ids @user.reviews.pluck(:id)
end

json.appointments do
  user_apps.each do |app|
    user_revs << app.review
    user_docs << app.doctor
    json.set! app.id do
      json.partial! "api/appointments/appointment", appointment: app
      json.reason app.reason
    end
  end
end
json.reviews do
  user_revs.each do |review|
    if review
      json.set! review.id do
        json.partial! "api/reviews/review", review: review
      end
    end
  end
end
user_docs.uniq!
json.doctors do
  user_docs.each do |doctor|
    json.set! doctor.id do
      json.partial! "api/doctors/doctor", doctor: doctor
    end
  end
end
