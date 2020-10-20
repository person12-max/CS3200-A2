

-- 1
UPDATE phones
SET phones.phone = "333-444-5555"
WHERE person_id = ANY(SELECT id FROM persons WHERE firstName = "Charles") AND phones.primary = 1;

-- 2
SET @old_order = (SELECT widgets.order FROM widgets WHERE name = "head345");
SET @other_widget = (SELECT widgets.id FROM widgets WHERE widgets.order = 3);

UPDATE widgets
SET widgets.order = 3
WHERE name = "head345";

UPDATE widgets
SET widgets.order = @old_order
WHERE widgets.id = @other_widget;


-- 3
UPDATE pages
SET title = CONCAT("CNET - " , title)
WHERE website_id = ANY(SELECT id FROM websites WHERE websites.name = "CNET");


-- 4

SET @bob_role = (SELECT role FROM page_roles WHERE page_id = ANY(SELECT id FROM pages WHERE title = "CNET - Home")
								  AND developer_id = ANY(SELECT id FROM persons WHERE firstName = "Bob"));
SET @charles_role = (SELECT role FROM page_roles WHERE page_id = ANY(SELECT id FROM pages WHERE title = "CNET - Home")
								  AND developer_id = ANY(SELECT id FROM persons WHERE firstName = "Charles"));
			
UPDATE page_roles 
SET role = @bob_role
WHERE developer_id = ANY(SELECT id FROM persons WHERE firstName = "Charles");

UPDATE page_roles 
SET role = @charles_role
WHERE developer_id = ANY(SELECT id FROM persons WHERE firstName = "Bob");
















