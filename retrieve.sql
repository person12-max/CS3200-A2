-- PART1

-- a
SELECT id FROM developers;

-- b
SELECT id FROM developers
WHERE id = 34;

-- c
SELECT website_roles.developer_id FROM  website_roles
WHERE website_roles.website_id = 234 AND website_roles.role  != "owner";

-- d
SELECT developer_id FROM page_roles
WHERE page_id = ANY(SELECT id FROM pages WHERE pages.views < 300000) AND role = "reviewer";

-- e
SELECT developer_id FROM page_roles
WHERE page_id = ANY(SELECT id FROM pages 
					WHERE pages.title = "home" 
					AND pages.website_id = ANY(SELECT id from websites WHERE name = "CNET"))
AND role = "writer";


-- PART2

-- a
SELECT id FROM websites
WHERE visits = (SELECT min(visits) FROM websites);

-- b
SELECT name FROM websites 
WHERE id = 678;

-- c
SELECT websites.id FROM websites
INNER JOIN pages ON websites.id = pages.website_id
INNER JOIN widgets ON pages.id = widgets.page_id
INNER JOIN page_roles ON page_roles.page_id = pages.id
WHERE widgets.dtype = "youtube" AND page_roles.developer_id = 23 AND page_roles.role = "reviewer"; 
    																	
-- d
SELECT website_id FROM website_roles
WHERE role = "owner" AND developer_id = 
ANY(SELECT id FROM developers WHERE id = ANY(SELECT id FROM persons WHERE firstName = "Alice"));

-- e
SELECT website_id FROM website_roles
WHERE role = "admin" AND developer_id = 
ANY(SELECT id FROM developers WHERE id = ANY(SELECT id FROM persons WHERE firstName = "Charles"))
AND website_id = ANY(SELECT id FROM websites WHERE visits > 600000);


-- PART3

-- a
SELECT id FROM pages 
WHERE views = ANY(SELECT min(views) FROM pages);

-- b
SELECT title from pages
WHERE id = 234;

-- c
SELECT page_id FROM page_roles
WHERE role = "editor" 
AND developer_id = ANY(SELECT developer_id FROM developers WHERE 
						developer_id = ANY(SELECT id FROM persons WHERE firstName = "Alice"));

-- d
SELECT SUM(views) FROM pages
WHERE website_id = ANY(SELECT id FROM websites WHERE name = "CNET"); 

-- e
SELECT AVG(views) FROM pages
WHERE website_id = ANY(SELECT id FROM websites WHERE name = "Wikipedia"); 

-- PART4

-- a
SELECT id FROM widgets 
WHERE page_id = ANY(SELECT id FROM pages WHERE title = "Home"
					AND id = ANY(SELECT page_id FROM websites WHERE name = "CNET"));
                    
-- b               
SELECT id FROM widgets
WHERE page_id = ANY(SELECT id FROM pages 
					WHERE id= ANY(SELECT page_id FROM websites WHERE name = "CNN"))
	  AND dtype = "youtube";
      
-- c
SELECT id FROM widgets 
WHERE page_id = ANY(SELECT id FROM pages 
					WHERE id = ANY(SELECT page_id FROM page_roles 
								  WHERE developer_id = ANY(SELECT id FROM persons WHERE firstName = "Alice" ) AND role = "reviewer"))
	  AND dtype = "image";

-- d
SELECT count(id) FROM widgets
WHERE page_id = ANY(SELECT id FROM pages 
					WHERE website_id = ANY(SELECT id FROM websites WHERE name = "Wikipedia"));
                    

-- PART5
-- a
SELECT name FROM websites
WHERE id = ANY(SELECT website_id FROM website_priviledges 
			  WHERE priviledge = "delete"
              AND developer_id = 
					ANY(SELECT id FROM persons WHERE firstName = "Bob"));
-- b
SELECT title FROM pages
WHERE id = ANY(SELECT page_id FROM page_priviledges 
			  WHERE priviledge = "write"
              AND developer_id = ANY(SELECT id FROM persons WHERE firstName = "Charles"));
                    





