-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
select cf_id, backers_count, outcome
from campaign
where outcome = 'live'
order by backers_count desc;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select campaign.cf_id, campaign.backers_count, campaign.outcome, count(backers.backer_id)
from campaign
join backers on campaign.cf_id = backers.cf_id
where outcome = 'live'
group by campaign.cf_id, campaign.backers_count, campaign.outcome
order by backers_count desc;



-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
create table email_contacts_remaining_goal_amount as
select contacts.first_name, 
	contacts.last_name, 
	contacts.email,
	--- campaign.company_name,
	--- campaign.goal,
	--- campaign.pledged, 
	campaign.goal - campaign.pledged AS "Remaining Goal Amount"
from campaign
join contacts on contacts.contact_id = campaign.contact_id
where outcome = 'live'
order by "Remaining Goal Amount" desc;


-- Check the table
select *
from email_contacts_remaining_goal_amount;


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

create table email_backers_remaining_goal_amount as
select backers.email,
	backers.first_name, 
	backers.last_name,
	backers.cf_id,
	campaign.company_name,
	campaign.description,
	campaign.end_date,
	--- campaign.goal,
	--- campaign.pledged, 
	campaign.goal - campaign.pledged AS "Left of Goal"
from campaign
join backers on backers.cf_id = campaign.cf_id
where outcome = 'live'
order by backers.email desc;


-- Check the table

select *
from email_backers_remaining_goal_amount;