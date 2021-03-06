doc_apps = @doctor.appointments.where(
  start_time: (Time.now)..(Time.now + 6.day),
  patient_id: nil)

doctor_reviews = @doctor.reviews
all_review_ratings = doctor_reviews.to_a.map(&:overall_rating)
if doctor_reviews.empty?
  average_rating = "Not rated"
else
  average_rating = all_review_ratings.reduce(:+) / all_review_ratings.length.to_f
end

json.doctor do
  json.extract! @doctor, :id,
                         :first_name,
                         :last_name,
                         :degree,
                         :lat,
                         :lng,
                         :education,
                         :quote
  json.address @doctor.address
  json.average_rating average_rating
  json.specialties @doctor.specialties.to_a.map(&:name)
  json.appointment_ids doc_apps.to_a.map(&:id)
  json.review_ids doctor_reviews.to_a.map(&:id)
end

json.appointments do
  doc_apps.each do |appointment|
    json.set! appointment.id do
      json.extract! appointment, :id,
                                 :doctor_id,
                                 :start_time,
                                 :address,
                                 :first_name,
                                 :last_name
    end
  end
end

json.reviews do
  doctor_reviews.each do |review|
    json.set! review.id do
      json.extract! review, :id,
                            :appointment_id,
                            :overall_rating,
                            :bedside_manner,
                            :wait_time,
                            :body,
                            :updated_at
    end
  end
end
