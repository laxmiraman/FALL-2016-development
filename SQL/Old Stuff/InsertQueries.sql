USE `wta`;

DELETE FROM reserved_item;
DELETE FROM gear_item;
DELETE FROM gender;
DELETE FROM request;
DELETE FROM personnel_info;
DELETE FROM role;
DELETE FROM size;
DELETE FROM status;

INSERT INTO gender(name) VALUES('Women''s');
INSERT INTO gender(name) VALUES('Men''s');
INSERT INTO gender(name) VALUES('Youth''s');
INSERT INTO gender(name) VALUES('Kid''s');
INSERT INTO gender(name) VALUES('Adult');
INSERT INTO gender(name) VALUES('N/A');

INSERT INTO status(request_status) VALUES('Requested');
INSERT INTO status(request_status) VALUES('Approved');
INSERT INTO status(request_status) VALUES('Picked_up');
INSERT INTO status(request_status) VALUES('Returned');

INSERT INTO role(name) VALUES('Trip Leader');
INSERT INTO role(name) VALUES('Administrator');

INSERT INTO personnel_information(id, name, role_id, email) VALUES(1, 'Scott Shipp', 2, 'shipps@seattleu.edu');
INSERT INTO personnel_info(id, name, role_id, email) VALUES(2, 'Joe Gearborrower', 1, 'joegearborrower@gmail.com');

INSERT INTO size VALUES(1, 'X-Sm');
INSERT INTO size VALUES(2, 'Sm');
INSERT INTO size VALUES(3, 'Med');
INSERT INTO size VALUES(4, 'Lg');
INSERT INTO size VALUES(5, 'XL');
INSERT INTO size VALUES(6, 'XXL');
INSERT INTO size VALUES(7, 'XXL');
INSERT INTO size VALUES(8, '1');
INSERT INTO size VALUES(9, '1.5');
INSERT INTO size VALUES(10, '2');
INSERT INTO size VALUES(11, '2.5');
INSERT INTO size VALUES(12, '3');
INSERT INTO size VALUES(13, '3,5');
INSERT INTO size VALUES(14, '4');
INSERT INTO size VALUES(15, '4,5');
INSERT INTO size VALUES(16, '5');
INSERT INTO size VALUES(17, '5.5');
INSERT INTO size VALUES(18, '6');
INSERT INTO size VALUES(19,'6.5');
INSERT INTO size VALUES(20, '7');
INSERT INTO size VALUES(21, '7.5');
INSERT INTO size VALUES(22, '8');
INSERT INTO size VALUES(23, '8.5');
INSERT INTO size VALUES(24, '9');
INSERT INTO size VALUES(25, '9.5');
INSERT INTO size VALUES(26, '10');
INSERT INTO size VALUES(27, '10.5');
INSERT INTO size VALUES(28, '11');
INSERT INTO size VALUES(29, '11.5');
INSERT INTO size VALUES(30, '12');
INSERT INTO size VALUES(31, '12.5');
INSERT INTO size VALUES(32, '13');
INSERT INTO size VALUES(33, '13.5');
INSERT INTO size VALUES(34, '14');
INSERT INTO size VALUES(35, '14.5');
INSERT INTO size VALUES(36, '15');
INSERT INTO size VALUES(37, '15.5');
INSERT INTO size VALUES(38, '16');
INSERT INTO size VALUES(39, '20 Liter');
INSERT INTO size VALUES(40, '35 Liter M');
INSERT INTO size VALUES(41, '35 Liter L');
INSERT INTO size VALUES(42, '50 Liter');
INSERT INTO size VALUES(43, '58 Liter');
INSERT INTO size VALUES(44, '60 Liter');
INSERT INTO size VALUES(45, '65 Liter');
INSERT INTO size VALUES(46, '68 Liter');
INSERT INTO size VALUES(47, '70 Liter');
INSERT INTO size VALUES(48, '75 Liter');
INSERT INTO size VALUES(49, '90 Liter');
INSERT INTO size VALUES(50, '1 Liter');
INSERT INTO size VALUES(51, 'Reg Length');
INSERT INTO size VALUES(52, 'Long Length');
INSERT INTO size VALUES(53, 'Short Length');
INSERT INTO size VALUES(54, 'Full Size');
INSERT INTO size VALUES(55, '2 Person');
INSERT INTO size VALUES(56, '4 Person');
INSERT INTO size VALUES(57, 'One size fits all');

INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(10, 'Fleece Jacket', 3, 3, 8); /* Youth Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(20, 'Fleece Jacket', 3, 4, 12); /* Youth Lg */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(30, 'Fleece Jacket', 3, 5, 10); /* Youth XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(40, 'Fleece Jacket', 5, 2, 3); /* Adult sm */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(50, 'Fleece Jacket', 5, 3, 8); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(60, 'Fleece Jacket', 5, 4, 8); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(70, 'Fleece Jacket', 5, 5, 4); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(80, 'Rain Jacket', 3, 3, 7); /* Youth M */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(90, 'Rain Jacket', 3, 4, 12); /* Youth L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(100, 'Rain Jacket', 3, 5, 10); /* Youth XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(110, 'Rain Jacket', 5, 2, 4); /* Adult sm */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(120, 'Rain Jacket', 5, 3, 22); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(130, 'Rain Jacket', 5, 4, 5); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(140, 'Rain Jacket', 5, 5, 2); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(150, 'Rain Pants', 5, 2, 12); /* Adult sm */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(160, 'Rain Pants', 5, 3, 7); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(170, 'Rain Pants', 5, 4, 8); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(180, 'Rain Pants', 5, 5, 4); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(190, 'Hiking Boots', 2, 17, 1); /* Men's 5.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(200, 'Hiking Boots', 2, 20, 4); /* Men's 7 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(210, 'Hiking Boots', 2, 21, 6); /* Men's 7.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(220, 'Hiking Boots', 2, 22, 6); /* Men's 8 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(230, 'Hiking Boots', 2, 23, 5); /* Men's 8.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(240, 'Hiking Boots', 2, 24, 11); /* Men's 9 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(250, 'Hiking Boots', 2, 25, 7); /* Men's 9.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(260, 'Hiking Boots', 2, 26, 5); /* Men's 10 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(270, 'Hiking Boots', 2, 27, 5); /* Men's 10.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(280, 'Hiking Boots', 2, 28, 5); /* Men's 11 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(290, 'Hiking Boots', 2, 29, 4); /* Men's 11.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(300, 'Hiking Boots', 2, 30, 3); /* Men's 12 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(310, 'Hiking Boots', 2, 32, 2); /* Men's 13 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(320, 'Hiking Boots', 2, 36, 2); /* Men's 15 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(330, 'Hiking Boots', 1, 16, 6); /* Women's 5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(340, 'Hiking Boots', 1, 17, 6); /* Women's 5.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(350, 'Hiking Boots', 1, 18, 10); /* Women's 6 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(360, 'Hiking Boots', 1, 19, 7); /* Women's 6.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(370, 'Hiking Boots', 1, 20, 9); /* Women's 7 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(380, 'Hiking Boots', 1, 21, 11); /* Women's 7.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(390, 'Hiking Boots', 1, 22, 6); /* Women's 8 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(400, 'Hiking Boots', 1, 23, 3); /* Women's 8.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(410, 'Hiking Boots', 1, 24, 5); /* Women's 9 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(420, 'Hiking Boots', 1, 25, 4); /* Women's 9.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(430, 'Hiking Boots', 1, 26, 1); /* Women's 10 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(440, 'Hiking Boots', 1, 28, 1); /* Women's 11 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(450, 'Hiking Boots', 3, 8, 3); /* Youth 1 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(460, 'Hiking Boots', 1, 10, 4); /* Youth 2 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(470, 'Synthetic or Down Puffies, SoftShells', 5, 3, 2); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(480, 'Synthetic or Down Puffies, SoftShells', 5, 4, 17); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(490, 'Synthetic or Down Puffies, SoftShells', 5, 5, 13); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(500, 'Gloves', 4, 4, 20); /* Kids L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(510, 'Gloves', 2, 2, 20); /* Mens S */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(520, 'Gloves', 2, 3, 15); /* Mens M */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(530, 'Gloves', 2, 4, 10); /* Mens L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(540, 'Gloves', 2, 5, 5); /* Mens XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(550, 'Day Pack', 3, 39, 69); /* Youth 20 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(560, 'Day Pack', 5, 40, 6); /* Adult 35 Liter M */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(570, 'Day Pack', 5, 41, 16); /* Adult 35 Liter L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(580, 'Backpacking Pack', 6, 42, 7); /* 50 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(590, 'Backpacking Pack', 6, 43, 2); /* 58 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(600, 'Backpacking Pack', 6, 44, 7); /* 60 Liter L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(610, 'Backpacking Pack', 6, 45, 8); /* 65 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(620, 'Backpacking Pack', 6, 46, 3); /* 68 Liter  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(630, 'Backpacking Pack', 6, 47, 8); /* 70 Liter  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(640, 'Backpacking Pack', 6, 48, 3); /* 90 Liter  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(650, 'Tent', 6, 55, 7); /* 2 person  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity) VALUES(660, 'Tent', 6, 56, 13); /* 4 person  */

/* Reserve two 2-person tents, 2 pair of Men's 10 hiking boots, 2 pair of omen's 8 hiking boots, and 4 50 liter backpacking packs */
INSERT INTO request VALUES(1, 2, '2016-11-04', '2016-11-08', 7); /* Picked up */
INSERT INTO reserved_item VALUES(1, 1, 260, 2, 5); /* 2 men's 10 hiking boots */
INSERT INTO reserved_item VALUES(2, 1, 390, 2, 5); /* 2 women's 8 hiking boots */
INSERT INTO reserved_item VALUES(3, 1, 650, 2, 5); /* 2 2-person tents */
INSERT INTO reserved_item VALUES(4, 1, 580, 3, 5); /* 4 50 liter backpacking packs */

/* Overlapping request 3 2-person tents, 1 men's 10 hiking boot, 5 50 liter backpacking pack, 1 women's 8 hiking boot */
INSERT INTO request VALUES(2, 2, '2016-11-08', '2016-11-12', 7); /* Picked up */
INSERT INTO reserved_item VALUES(5, 2, 260, 1, 5); /* 1 men's 10 hiking boots */
INSERT INTO reserved_item VALUES(6, 2, 390, 1, 5); /* 1 women's 8 hiking boots */
INSERT INTO reserved_item VALUES(7, 2, 650, 3, 5); /* 3 2-person tents */
INSERT INTO reserved_item VALUES(8, 2, 580, 4, 5); /* 5 50 liter backpacking packs */

/* Another request, overlapping but not same items */
INSERT INTO request VALUES(3, 2, '2016-11-05', '2016-11-07', 7); /* Picked up */
INSERT INTO reserved_item VALUES(9, 3, 10, 1, 5); /* 1 youth med fleece jacket */
INSERT INTO reserved_item VALUES(10, 3, 510, 1, 5);  /* 1 Men's sm gloves */
INSERT INTO reserved_item VALUES(11, 3, 630, 1, 5); /* 1 75 liter backpacking pack */