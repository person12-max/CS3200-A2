-- DELETES
-- 1
DELETE FROM addresses
WHERE addresses.primary = 1 AND person_id = ANY(SELECT id FROM persons WHERE firstName = 'Alice');


-- -- 2 
SET @min = (SELECT MIN(widgets.order) FROM widgets WHERE page_id = ANY(SELECT id FROM pages WHERE title = "Contact"));
DELETE FROM widgets 
WHERE widgets.order = @min;

-- -- 3
SET @get_page_id = 	(SELECT id FROM pages
					WHERE website_id = ANY(SELECT id FROM websites WHERE name = "Wikipedia")
					ORDER BY updated DESC
					LIMIT 1);

DELETE FROM widgets
WHERE page_id = @get_page_id;

DELETE FROM page_priviledges
WHERE page_id = @get_page_id;

DELETE FROM page_roles
WHERE page_id = @get_page_id;

DELETE FROM pages
WHERE id = @get_page_id;

-- -- 4
SET @get_website_id = (SELECT id FROM websites
						WHERE name = "CNET");

DELETE FROM website_roles
WHERE website_id = @get_website_id;

DELETE FROM website_priviledges
WHERE website_id = @get_website_id;

DELETE FROM widgets
WHERE page_id = ANY(SELECT id FROM pages WHERE website_id = @get_website_id);

DELETE FROM page_priviledges
WHERE page_id = ANY(SELECT id FROM pages WHERE website_id = @get_website_id);

DELETE FROM page_roles
WHERE page_id = ANY(SELECT id FROM pages WHERE website_id = @get_website_id);

DELETE FROM pages
WHERE website_id = @get_website_id;

DELETE FROM websites
WHERE id = @get_website_id;