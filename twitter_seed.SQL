ALTER TABLE members 
ADD column twitter_participation_score decimal(10,1) 
;Update members 
Set twitter_participation_score = cast ('8.6' as decimal(10,1))
