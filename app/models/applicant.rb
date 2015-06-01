class Applicant < ActiveRecord::Base

  has_attached_file :resume
  validates_attachment :resume, size: { :in => 0..1000.kilobytes }
  validates_attachment_content_type :resume, :content_type => [ 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/pdf' ]

end