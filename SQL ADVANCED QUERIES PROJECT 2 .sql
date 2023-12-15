-- USING IG_CLONE DATASET
use ig_clone;

-- SQL ADVANCED ASSIGNMENT PROJECT

-- 1. Create an ER diagram or draw a schema for the given database.
-- To See ER Diagram Click On Database > Reverse Engineer and click > Next > Finish
-- From above ER Diagram we should understood that three things
-- Entites,Relationship,Attributes.
-- a).users,photos,follows,comments,likes,photo_tags,tags all these are Entities of Database
-- which we are creating.
-- b).Inside the entites we call them as attributes or columns of a table.these graphical
-- representation helps sql developer to code easily which required which data type and
-- constraints.
-- c).Inside entites yellow color key represents primary key,
-- and rhombus with pink color filled represents as foreign key to another table ,
-- and rhombus with skyblue is not null column,
-- And empty rhombus represents normal column and red color key is composite key in the
-- junction table.
-- d).Line in between table are used to show relationship dotted means weak relation ship
-- And normal line represents strong relationship because both are primary keys.
-- Hence these is about explanation ER diagram of given database.
-------------------------------------------------------------------------------------------------------------------------
/* 2.We want to reward the user who has been around the longest, Find the 5 oldest
users.*/
select * from users
order by year(created_at),month(created_at),day(created_at) 
limit 5;
-------------------------------------------------------------------------------------------------------------------------
/* 3.To target inactive users in an email ad campaign, find the users who have never posted
a photo.*/
select distinct(id),username from users
where id not in
(select user_id from photos);
-------------------------------------------------------------------------------------------------------------------------
/* 4.Suppose you are running a contest to find out who got the most likes on a photo. Find
out who won?*/
select * from photos;
select * from users;
select * from likes;
with Most_Likes_On_Photo as
(
select c.username,c.id,count(*) as Total_count from photos a
inner join likes b
on a.user_id=b.user_id
inner join users c
on c.id=a.user_id
group by c.id
order by Total_count desc
)
select d.username,d.Total_count from Most_Likes_On_Photo d
limit 1;
-------------------------------------------------------------------------------------------------------------------------
/* 5.The investors want to know how many times does the average user post.*/
SELECT avg(user_id) as average_user_post FROM photos;
-------------------------------------------------------------------------------------------------------------------------
/* 6.A brand wants to know which hashtag to use on a post, and find the top 5 most used
hashtags.*/
SELECT * FROM tags;
SELECT * FROM photos;
select t.tag_name,p.user_id,count(*) as Total_Count from tags t
inner join photos p
on p.user_id=t.id
group by p.user_id,t.tag_name
order by count(*) desc
limit 5;
-------------------------------------------------------------------------------------------------------------------------
/* 7.To find out if there are bots, find users who have liked every single photo on the site.*/
select * from users;
select * from likes;
select * from photos;
select u.id,u.username from users u
inner join photos p
on p.user_id=u.id
inner join likes l
on l.user_id=p.user_id
group by u.id;
-------------------------------------------------------------------------------------------------------------------------
/* 8.Find the users who have created instagramid in may and select top 5 newest joinees
from it?*/
select * from users where month(created_at)=6
order by month(created_at),day(created_at) desc limit 5 ;
-------------------------------------------------------------------------------------------------------------------------
/* 9.Can you help me find the users whose name starts with c and ends with any number
and have posted the photos as well as liked the photos?*/
select * from users;
select * from likes;
select * from photos;
with user_c as
(
select p.user_id,username from users u
inner join photos p
on p.user_id=u.id
inner join likes l
on l.user_id=p.user_id
where u.username regexp '^c.*[0-9]$'
group by p.user_id
)
select user_c.username from user_c;
-------------------------------------------------------------------------------------------------------------------------
/*10.Demonstrate the top 30 usernames to the company who have posted photos in the
range of 3 to 5.*/
select * from photos;
select * from users;
with Top_30_user_Names as
(
select u.username,p.user_id,count(*) as Total_Count from users u
inner join photos p
on p.user_id=u.id
group by p.user_id
)
select T.username,T.user_id,T.Total_Count from Top_30_user_Names T
where T.Total_Count between 3 and 5
order by T.Total_Count desc limit 30;

-- ------------------------------------------------------------------------------------------------------