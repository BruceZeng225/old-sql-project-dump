-- avg_exam_score_by_study_and_extracurricular
SELECT hours_studied, AVG(exam_score) AS avg_exam_score
FROM student_performance
WHERE hours_studied > 10 
	AND extracurricular_activities = 'Yes'
GROUP BY hours_studied
ORDER BY hours_studied DESC;

-- avg_exam_score_by_hours_studied_range
SELECT
CASE WHEN hours_studied >= 1 AND hours_studied <= 5 THEN '1-5 hours'
	 WHEN hours_studied >= 2 AND hours_studied <= 10 THEN '6-10 hours'
	 WHEN hours_studied >= 11 AND hours_studied <= 15 THEN '11-15 hours'
	 ELSE '16+ hours'
	 END AS hours_studied_range,
AVG(exam_score) as avg_exam_score
FROM public.student_performance
GROUP BY hours_studied_range
ORDER BY avg_exam_score DESC;

-- student_exam_ranking
SELECT attendance, hours_studied, sleep_hours,tutoring_sessions, 
	DENSE_RANK() OVER(ORDER BY exam_score DESC) as exam_rank
FROM student_performance
ORDER BY exam_rank ASC
limit 30;

