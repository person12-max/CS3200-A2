
CREATE VIEW deleveloper_roles_and_privileges AS
SELECT persons.firstName, persons.lastName, persons.username, persons.email
	,websites.name, websites.visits
    ,websites.updated AS w_updated
	,website_roles.role AS w_role
    ,website_priviledges.priviledge AS w_priviledge
    ,pages.title, pages.views
    ,pages.updated AS p_updated
    ,page_priviledges.priviledge AS p_priviledge
    ,page_roles.role AS p_role
    
FROM persons
INNER JOIN developers ON developers.id = persons.id
INNER JOIN website_roles ON persons.id = website_roles.developer_id 
INNER JOIN websites ON websites.id = website_roles.website_id 
INNER JOIN website_priviledges ON website_priviledges.website_id = websites.id AND developers.id = website_priviledges.developer_id
INNER JOIN pages ON pages.website_id = websites.id
INNER JOIN page_roles ON page_roles.page_id = pages.id AND page_roles.developer_id = persons.id
INNER JOIN page_priviledges ON page_priviledges.page_id = pages.id AND page_priviledges.developer_id = persons.id;



