-- #1 Write the SQL that displays the total number of books published by each publisher
Select p.publisher_name, count(b.bookid) as bookCount
From publisher as p
inner join book as b
    on p.publisherid = b.publisherid
group by p.publisher_name;

-- #2 Write the SQL that displays the books that have more than one author
Select b.title, count(ba.author_id) as authorCount
From book as b
inner join book_author as ba
    on b.bookid = ba.bookid
group by b.title
having count(ba.author_id) > 1;

-- #3 Write the SQL that displays a list of authors that have not written any award winning books
-- Filtering with left join on and (more efficient than where)
select a.first_name, a.last_name
	from author as a
	left join (Select bauth.authorid
			From book as b
			inner join book_award as bawrd
				on b.book_id = bauth.book_id
			inner join book_author as bauth
				on b.book_id = bauth.book_id) as aw
		on a.author_id = aw.author_id
			and aw.auth_id is null;

-- Doing it alternate way with a CTE query
;with
    aw as (
        Select bauth.authorid
        From book as b
            inner join book_award as bawrd
                on b.book_id = bauth.book_id
            inner join book_author as bauth
                on b.book_id = bauth.book_id
    )
select a.first_name, a.last_name
from author as a
    left join aw
        on a.author_id = aw.author_id
            and aw.auth_id is null;