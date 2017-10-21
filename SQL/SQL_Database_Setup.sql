-- WTA Database Setup
-- SEGR-5260 (SW Construction & Environments)

DROP SCHEMA IF EXISTS WTA;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema wta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wta` DEFAULT CHARACTER SET utf8 ;
USE `wta` ;

-- -----------------------------------------------------
-- Table `wta`.`size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS size;
CREATE TABLE size (
  id INT NOT NULL AUTO_INCREMENT,
  size VARCHAR(250),
  PRIMARY KEY(id)
);


-- -----------------------------------------------------
-- Table `wta`.`gender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS gender;
CREATE TABLE gender (
  id INT NOT NULL AUTO_INCREMENT,
  gender VARCHAR(250),
  PRIMARY KEY(id)
);


-- -----------------------------------------------------
-- Table `wta`.`gear_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS gear_item;
CREATE TABLE gear_item (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(1000) NOT NULL,
  image_url VARCHAR(1000),
  care_maintenance VARCHAR(1000),
  sizing_table VARCHAR(1000),
  description VARCHAR(1000),
  gender_id INT NOT NULL,
  size_id INT NOT NULL,
  total_quantity INT NOT NULL,
  PRIMARY KEY(id),
  CONSTRAINT fk_gender_id FOREIGN KEY (gender_id) REFERENCES gender(id), 
  CONSTRAINT fk_size_id FOREIGN KEY (size_id) REFERENCES size(id)
);



-- -----------------------------------------------------
-- Table `wta`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
  id INT NOT NULL AUTO_INCREMENT,
  role_id INT NOT NULL,
  group_name VARCHAR(250),
  PRIMARY KEY(id),
  CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES `role`(id)
);

-- -----------------------------------------------------
-- Table `wta`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS role;
CREATE TABLE `role` (
  id INT NOT NULL AUTO_INCREMENT,
  role_name VARCHAR(250),
  PRIMARY KEY(id)
);

-- -----------------------------------------------------
-- Table `wta`.`personnel_information`
-- -----------------------------------------------------
DROP TABLE IF EXISTS personnel_info;
CREATE TABLE personnel_info (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(1000) NOT NULL,
  groups_id INT NOT NULL,
  email VARCHAR(1000),
  phone_number VARCHAR(1000),
  address_line_1 VARCHAR(1000),
  address_line_2 VARCHAR(1000),
  address_line_3 VARCHAR(1000),
  city VARCHAR(1000),
  state VARCHAR(2),
  zip_code VARCHAR(12),
  PRIMARY KEY(id),
  CONSTRAINT fk_groups_id FOREIGN KEY (groups_id) REFERENCES `groups`(id)
);


-- -----------------------------------------------------
-- Table `wta`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS wta.status;
CREATE TABLE `status` (
  id INT NOT NULL AUTO_INCREMENT,
  status VARCHAR(250),
  PRIMARY KEY(id)
);


-- -----------------------------------------------------
-- Table `wta`.`request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS request;
CREATE TABLE request (
  id INT NOT NULL AUTO_INCREMENT,
  customer_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status_id INT NOT NULL,
  PRIMARY KEY(id),
  CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES personnel_info(id),
  CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES status(id)
);


-- -----------------------------------------------------
-- Table `wta`.`reserved_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS reserved_item;
CREATE TABLE reserved_item (
  id INT NOT NULL AUTO_INCREMENT,
  request_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY(id),
  CONSTRAINT fk_request_id FOREIGN KEY (request_id) REFERENCES request(id),
  CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES gear_item(id)
);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Inserting data into Database
USE `wta`;

INSERT INTO gender VALUES(1, 'Women''s');
INSERT INTO gender VALUES(2, 'Men''s');
INSERT INTO gender VALUES(3, 'Youth''s');
INSERT INTO gender VALUES(4, 'Kid''s');
INSERT INTO gender VALUES(5, 'Adult');
INSERT INTO gender VALUES(6, 'N/A');

INSERT INTO `status` VALUES(1, 'requested');
INSERT INTO `status` VALUES(2, 'approved');
INSERT INTO `status` VALUES(3, 'picked_up');
INSERT INTO `status` VALUES(4, 'returned');

INSERT INTO role VALUES(1, 'Root');
INSERT INTO role VALUES(2, 'Administrator');
INSERT INTO role VALUES(3, 'Trip Leader');
INSERT INTO role VALUES(4, 'Volunteer');

INSERT INTO groups(role_id, group_name) values(1, 'Root Group');
INSERT INTO groups(role_id, group_name) values(2, 'Group A');
INSERT INTO groups(role_id, group_name) values(3, 'Group B');
INSERT INTO groups(role_id, group_name) values(4, 'Group C');
INSERT INTO groups(role_id, group_name) values(3, 'New User');

INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(1, 'Scott Shipp', 2, 'shipps@seattleu.edu');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(2, 'Temourshah Ahmady', 2, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(3, 'Hatoon Almoajel', 2, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(4, 'Hesham Alsaeedi', 2, 'alsaeedi@seattleu.edu');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(5, 'Michael Cheung', 3, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(6, 'Kellie Fontes', 3, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(7, 'Nitika Goyal', 3, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(8, 'Kyle McNutt', 3, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(9, 'Bakkiyalakshmi Ramanjulu', 4, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(10, 'Jaysheel Shah', 4, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(11, 'Matthew Smith', 4, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(12, 'Lyza Thenumkal', 4, '');
INSERT INTO personnel_info(id, `name`, groups_id, email) VALUES(13, 'Martina Ugwuh', 4, '');


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


INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(10, 'Fleece Jacket', 3, 3, 8, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/7kzyliI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Youth (M), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Youth Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(20, 'Fleece Jacket', 3, 4, 12, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/7kzyliI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Youth (L), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Youth Lg */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(30, 'Fleece Jacket', 3, 5, 10, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/7kzyliI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Youth (XL), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Youth XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(40, 'Fleece Jacket', 5, 2, 3, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Adult (S), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Adult sm */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(50, 'Fleece Jacket', 5, 3, 8, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Adult (M), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(60, 'Fleece Jacket', 5, 4, 8, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Adult (L), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(70, 'Fleece Jacket', 5, 5, 4, 'http://i.imgur.com/1ivJIdt.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'The next generation of a Columbia classic, this outdoor staple features a finely tuned fit and a soft-yet-rugged filament-fleece fabrication to keep you warm when temperatures plummet. Item model name: FJ3200, Size: Adult (M), 100% Polyester, Imported, Zipper closure, Machine Wash, Front-zip fleece jacket with standing collar and logo at chest, On-seam zippered side-entry pockets'); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(80, 'Rain Jacket', 3, 3, 7, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/7kzyliI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Youth (M), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Youth M */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(90, 'Rain Jacket', 3, 4, 12, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/7kzyliI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Youth (L), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Youth L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(100, 'Rain Jacket', 3, 5, 10, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/7kzyliI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Youth (XL), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Youth XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(110, 'Rain Jacket', 5, 2, 4, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Adult (S), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Adult sm */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(120, 'Rain Jacket', 5, 3, 22, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Adult (M), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(130, 'Rain Jacket', 5, 4, 5, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Adult (L), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(140, 'Rain Jacket', 5, 5, 2, 'http://i.imgur.com/WtTNmPc.png', 'Machine Wash', 'http://i.imgur.com/nEm1tjI.png', 'Clean, modern lines in a tried-and-true waterproof fabric-this lightweight nylon Columbia rain jacket is an everyday favorite in the making thanks to its stylish, efficient, and comfortable take on protecting you from the wind and wet weather. Item model name: RJ 5000. Size: Adult (XL), Shell: 100% Nylon, Lining: 100% Polyester, Imported, Zipper closure, Machine Wash, Zip-front waterproof jacket featuring adjustable hook-and-loop cuffs and logo at left chest, Attached adjustable hood, Zippered hand pockets, Adjustable drawcord hem'); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(150, 'Rain Pants', 5, 2, 12, 'http://i.imgur.com/D0JWSXC.png' , 'Machine Wash' , 'http://i.imgur.com/5NRU6gO.png', 'The Frogg Toggs Pro Action Pants have an elastic waistband with drawstring and barrel-pull and a full-cut hook-and-loop ankle closure with tension adjustment. Model name: Pro Action Pants. Size: Adult (S) Textile, Ultra-Lightweight, Breathable Material, One inch Ankle Band, One inch Waistband, 4" Back rise'); /* Adult sm */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(160, 'Rain Pants', 5, 3, 7, 'http://i.imgur.com/D0JWSXC.png' , 'Machine Wash' , 'http://i.imgur.com/5NRU6gO.png', 'The Frogg Toggs Pro Action Pants have an elastic waistband with drawstring and barrel-pull and a full-cut hook-and-loop ankle closure with tension adjustment. Model name: Pro Action Pants. Size: Adult (M) Textile, Ultra-Lightweight, Breathable Material, One inch Ankle Band, One inch Waistband, 4" Back rise'); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(170, 'Rain Pants', 5, 4, 8, 'http://i.imgur.com/D0JWSXC.png' , 'Machine Wash' , 'http://i.imgur.com/5NRU6gO.png', 'The Frogg Toggs Pro Action Pants have an elastic waistband with drawstring and barrel-pull and a full-cut hook-and-loop ankle closure with tension adjustment. Model name: Pro Action Pants. Size: Adult (L) Textile, Ultra-Lightweight, Breathable Material, One inch Ankle Band, One inch Waistband, 4" Back rise'); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(180, 'Rain Pants', 5, 5, 4, 'http://i.imgur.com/D0JWSXC.png' , 'Machine Wash' , 'http://i.imgur.com/5NRU6gO.png', 'The Frogg Toggs Pro Action Pants have an elastic waistband with drawstring and barrel-pull and a full-cut hook-and-loop ankle closure with tension adjustment. Model name: Pro Action Pants. Size: Adult (XL) Textile, Ultra-Lightweight, Breathable Material, One inch Ankle Band, One inch Waistband, 4" Back rise'); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(190, 'Hiking Boots', 2, 17, 1, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 5.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 5.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(200, 'Hiking Boots', 2, 20, 4, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 7. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 7 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(210, 'Hiking Boots', 2, 21, 6, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 7.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 7.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(220, 'Hiking Boots', 2, 22, 6, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 8. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 8 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(230, 'Hiking Boots', 2, 23, 5, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 8.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 8.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(240, 'Hiking Boots', 2, 24, 11, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 9. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 9 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(250, 'Hiking Boots', 2, 25, 7, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 9.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 9.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(260, 'Hiking Boots', 2, 26, 5, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 10. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 10 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(270, 'Hiking Boots', 2, 27, 5, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 10.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 10.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(280, 'Hiking Boots', 2, 28, 5, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 11. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 11 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(290, 'Hiking Boots', 2, 29, 4, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 11.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 11.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(300, 'Hiking Boots', 2, 30, 3, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 12. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 12 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(310, 'Hiking Boots', 2, 32, 2, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 13. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 13 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(320, 'Hiking Boots', 2, 36, 2, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/QXGdWaJ.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Men\'s 15. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Men's 15 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(330, 'Hiking Boots', 1, 16, 6, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(340, 'Hiking Boots', 1, 17, 6, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 5.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 5.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(350, 'Hiking Boots', 1, 18, 10, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 6. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 6 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(360, 'Hiking Boots', 1, 19, 7, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 6.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 6.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(370, 'Hiking Boots', 1, 20, 9, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 7. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 7 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(380, 'Hiking Boots', 1, 21, 11, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 7.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 7.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(390, 'Hiking Boots', 1, 22, 6, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 8. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 8 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(400, 'Hiking Boots', 1, 23, 3, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 8.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 8.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(410, 'Hiking Boots', 1, 24, 5, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 9. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 9 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(420, 'Hiking Boots', 1, 25, 4, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 9.5. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 9.5 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(430, 'Hiking Boots', 1, 26, 1, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 10. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 10 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(440, 'Hiking Boots', 1, 28, 1, 'http://i.imgur.com/POr2e5s.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/aHxnhso.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Women\'s 11. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Women's 11 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(450, 'Hiking Boots', 3, 8, 3, 'http://i.imgur.com/G52RUwM.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/TeRLWfn.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Youth 1. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Youth 1 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(460, 'Hiking Boots', 1, 10, 4, 'http://i.imgur.com/G52RUwM.png', 'Clean boots after every hike. A brush and some water are the basic tools. Remove insoles/inserts after a hike to permit the whole boot to dry. Do not expose boots to excessive heat; store them at room temperature. When water stops beading on boot uppers, add a waterproofing treatment to restore their water resistance.', 'http://i.imgur.com/TeRLWfn.png', 'Traversing wet terrain will be a cinch in these Hi-Tec® men\'s Bandera waterproof mid hiking boots. Their Dri-Tec membrane and moisture-wicking lining will keep your feet nice and dry, while rustproof hardware prevents damage caused by the elements. The upper is comprised of a powerhouse suede/mesh combo for durability and breathability. Model name: Bandera Dri-Tec. Size: Youth 2. Leather/Textile, Imported, Rubber sole, Shaft measures approximately 5" from arch, Lace-up hiking boot featuring suede overlays, striped nylon straps, and logo on tongue/heel, Removable molded insole, Traction rubber cupsole'); /* Youth 2 */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(470, 'Synthetic or Down Puffies, SoftShells', 5, 3, 2, 'http://i.imgur.com/klRvRSQ.png', 'Empty out all pockets, Close all hook and loop (AKA velcro) fasteners and pockets, Set washing machine to normal cycle (usually) and use warm water, Add a sport-wash detergent, Allow machine to cycle through and completely rinse, Remove the garment from washing machine and dry on low in dryer until the jacket is dry to the touch. Often drying the garment will restore the DWR (durable water repellent finish)', 'http://i.imgur.com/nEm1tjI.png', 'The Condor Summit Zero Soft Shell Jacket is practical and durable outer garment featuring a three layer integrated shell fabric technology and reinforced elbows. Moreover being a reconstructed version of the Summit Soft Shell Jacket it\'s 30% lighter which allows better and more comfortable performance while out in the field. Model name: Summit Zero. Size: Adult (M). 100% Polyester, Lined stand-up collar. Stow-away hood. Full front 2-way YKK zipper. 2 high-rise slash chest pockets, 2 internal pockets. 2 shoulder pockets. Forearm pocket. Double zipper back pocket, 2 4"x4" (10x10cm) shoulder patch panels. Underarm vent zippers. Drawstring waistband & hood, Abrasion-reinforced elbows. Adjustable wrist cuff. Genuine Crye Precision Multicam fabric, 4 way elastic high density fabric. Polyurethane membrane. Laminated Poly/spandex inner layer'); /* Adult Med */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(480, 'Synthetic or Down Puffies, SoftShells', 5, 4, 17, 'http://i.imgur.com/klRvRSQ.png', 'Empty out all pockets, Close all hook and loop (AKA velcro) fasteners and pockets, Set washing machine to normal cycle (usually) and use warm water, Add a sport-wash detergent, Allow machine to cycle through and completely rinse, Remove the garment from washing machine and dry on low in dryer until the jacket is dry to the touch. Often drying the garment will restore the DWR (durable water repellent finish)', 'http://i.imgur.com/nEm1tjI.png', 'The Condor Summit Zero Soft Shell Jacket is practical and durable outer garment featuring a three layer integrated shell fabric technology and reinforced elbows. Moreover being a reconstructed version of the Summit Soft Shell Jacket it\'s 30% lighter which allows better and more comfortable performance while out in the field. Model name: Summit Zero. Size: Adult (L). 100% Polyester, Lined stand-up collar. Stow-away hood. Full front 2-way YKK zipper. 2 high-rise slash chest pockets, 2 internal pockets. 2 shoulder pockets. Forearm pocket. Double zipper back pocket, 2 4"x4" (10x10cm) shoulder patch panels. Underarm vent zippers. Drawstring waistband & hood, Abrasion-reinforced elbows. Adjustable wrist cuff. Genuine Crye Precision Multicam fabric, 4 way elastic high density fabric. Polyurethane membrane. Laminated Poly/spandex inner layer'); /* Adult L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(490, 'Synthetic or Down Puffies, SoftShells', 5, 5, 13, 'http://i.imgur.com/klRvRSQ.png', 'Empty out all pockets, Close all hook and loop (AKA velcro) fasteners and pockets, Set washing machine to normal cycle (usually) and use warm water, Add a sport-wash detergent, Allow machine to cycle through and completely rinse, Remove the garment from washing machine and dry on low in dryer until the jacket is dry to the touch. Often drying the garment will restore the DWR (durable water repellent finish)', 'http://i.imgur.com/nEm1tjI.png', 'The Condor Summit Zero Soft Shell Jacket is practical and durable outer garment featuring a three layer integrated shell fabric technology and reinforced elbows. Moreover being a reconstructed version of the Summit Soft Shell Jacket it\'s 30% lighter which allows better and more comfortable performance while out in the field. Model name: Summit Zero. Size: Adult (XL). 100% Polyester, Lined stand-up collar. Stow-away hood. Full front 2-way YKK zipper. 2 high-rise slash chest pockets, 2 internal pockets. 2 shoulder pockets. Forearm pocket. Double zipper back pocket, 2 4"x4" (10x10cm) shoulder patch panels. Underarm vent zippers. Drawstring waistband & hood, Abrasion-reinforced elbows. Adjustable wrist cuff. Genuine Crye Precision Multicam fabric, 4 way elastic high density fabric. Polyurethane membrane. Laminated Poly/spandex inner layer'); /* Adult XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(500, 'Gloves', 4, 4, 20, 'http://i.imgur.com/yP3GPt6.png', 'We recommend washing your gloves periodically to remove salt and mineral build-up from perspiration. Machine wash in cold water using a mild laundry detergent. Do NOT use bleach or solvents. We recommend air-drying your gloves to maintain proper sizing and preserve material quality. Do NOT machine dry.', 'http://i.imgur.com/8LdOlRv.gif', 'These HAWEEL Full Finger Gloves have the following highlights - 1. High quality thick Neoprene Wind-stopper material for keeping warm,wind-stopper and easy to touch screen. 2. Thermal properties with touchscreen technology is the ultimate outdoor gloves. 3. Breathable, comfortable, wind-stopper, and multi-directional stretch fit. 4. Top grade silicone for anti-slip designed on palm. Model name: McHandy. Size: Kids L'); /* Kids L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(510, 'Gloves', 2, 2, 20, 'http://i.imgur.com/yP3GPt6.png', 'We recommend washing your gloves periodically to remove salt and mineral build-up from perspiration. Machine wash in cold water using a mild laundry detergent. Do NOT use bleach or solvents. We recommend air-drying your gloves to maintain proper sizing and preserve material quality. Do NOT machine dry.', 'http://i.imgur.com/8LdOlRv.gif', 'These HAWEEL Full Finger Gloves have the following highlights - 1. High quality thick Neoprene Wind-stopper material for keeping warm,wind-stopper and easy to touch screen. 2. Thermal properties with touchscreen technology is the ultimate outdoor gloves. 3. Breathable, comfortable, wind-stopper, and multi-directional stretch fit. 4. Top grade silicone for anti-slip designed on palm. Model name: McHandy. Size: Mens S'); /* Mens S */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(520, 'Gloves', 2, 3, 15, 'http://i.imgur.com/yP3GPt6.png', 'We recommend washing your gloves periodically to remove salt and mineral build-up from perspiration. Machine wash in cold water using a mild laundry detergent. Do NOT use bleach or solvents. We recommend air-drying your gloves to maintain proper sizing and preserve material quality. Do NOT machine dry.', 'http://i.imgur.com/8LdOlRv.gif', 'These HAWEEL Full Finger Gloves have the following highlights - 1. High quality thick Neoprene Wind-stopper material for keeping warm,wind-stopper and easy to touch screen. 2. Thermal properties with touchscreen technology is the ultimate outdoor gloves. 3. Breathable, comfortable, wind-stopper, and multi-directional stretch fit. 4. Top grade silicone for anti-slip designed on palm. Model name: McHandy. Size: Mens M'); /* Mens M */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(530, 'Gloves', 2, 4, 10, 'http://i.imgur.com/yP3GPt6.png', 'We recommend washing your gloves periodically to remove salt and mineral build-up from perspiration. Machine wash in cold water using a mild laundry detergent. Do NOT use bleach or solvents. We recommend air-drying your gloves to maintain proper sizing and preserve material quality. Do NOT machine dry.', 'http://i.imgur.com/8LdOlRv.gif', 'These HAWEEL Full Finger Gloves have the following highlights - 1. High quality thick Neoprene Wind-stopper material for keeping warm,wind-stopper and easy to touch screen. 2. Thermal properties with touchscreen technology is the ultimate outdoor gloves. 3. Breathable, comfortable, wind-stopper, and multi-directional stretch fit. 4. Top grade silicone for anti-slip designed on palm. Model name: McHandy. Size: Mens L'); /* Mens L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(540, 'Gloves', 2, 5, 5, 'http://i.imgur.com/yP3GPt6.png', 'We recommend washing your gloves periodically to remove salt and mineral build-up from perspiration. Machine wash in cold water using a mild laundry detergent. Do NOT use bleach or solvents. We recommend air-drying your gloves to maintain proper sizing and preserve material quality. Do NOT machine dry.', 'http://i.imgur.com/8LdOlRv.gif', 'These HAWEEL Full Finger Gloves have the following highlights - 1. High quality thick Neoprene Wind-stopper material for keeping warm,wind-stopper and easy to touch screen. 2. Thermal properties with touchscreen technology is the ultimate outdoor gloves. 3. Breathable, comfortable, wind-stopper, and multi-directional stretch fit. 4. Top grade silicone for anti-slip designed on palm. Model name: McHandy. Size: Mens XL'); /* Mens XL */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(550, 'Day Pack', 3, 39, 69, 'http://i.imgur.com/VXqjuqQ.png', '1.Don\'t wash with liquid detergent or bleach. 2. Clean with wet cloth if necessary. 3. Dry naturally.', 'http://i.imgur.com/F814Vzt.jpg', 'This SUNHIKER daypack is one of the best on the market. Material:Highly tear resistant nylon,water-resistant, MatReflective stripe,volume control system,adjustable shoulder straps, Breathable mesh shoulder straps, bottle holder on the both sides, Suitable for all hiking,camping,climbing,traveling outdoor activities, Dimensions:15.7x9.1x5.9 inches. Weight:12.3oz. Model Name: DayTripperLite. Size: Youth 20 Liter'); /* Youth 20 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(560, 'Day Pack', 5, 40, 6, 'http://i.imgur.com/8NMNeZp.png', '1.Don\'t wash with liquid detergent or bleach. 2. Clean with wet cloth if necessary. 3. Dry naturally.', 'http://i.imgur.com/F814Vzt.jpg', 'This HIKPRO daypack sure is swell. Model name: Fitz. Some highlights: 3 zippered compartments, 1 main pocket to place bulkier items, 1 outer smaller pocket, 1 inner zippered pocket which doubles and 2 large side mesh pockets.'); /* Adult 35 Liter M */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(570, 'Day Pack', 5, 41, 16, 'http://i.imgur.com/8NMNeZp.png', '1.Don\'t wash with liquid detergent or bleach. 2. Clean with wet cloth if necessary. 3. Dry naturally.', 'http://i.imgur.com/F814Vzt.jpg', 'This HIKPRO daypack sure is swell. Model name: Fitz. Some highlights: 3 zippered compartments, 1 main pocket to place bulkier items, 1 outer smaller pocket, 1 inner zippered pocket which doubles and 2 large side mesh pockets.'); /* Adult 35 Liter L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(580, 'Backpacking Pack', 6, 42, 7, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 50 Liter.'); /* 50 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(590, 'Backpacking Pack', 6, 43, 2, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 58 Liter.'); /* 58 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(600, 'Backpacking Pack', 6, 44, 7, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 60 Liter.'); /* 60 Liter L */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(610, 'Backpacking Pack', 6, 45, 8, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 65 Liter.'); /* 65 Liter */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(620, 'Backpacking Pack', 6, 46, 3, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 68 Liter.'); /* 68 Liter  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(630, 'Backpacking Pack', 6, 47, 8, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 70 Liter.'); /* 70 Liter  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(640, 'Backpacking Pack', 6, 48, 3, 'http://i.imgur.com/sJonMXD.png', 'After each trip be sure to clean out your pack thoroughly.Use mild soap like Nikwax Tech Wash, warm water and a soft brush to clean zippers often to prevent them from failing.If your pack is wet, hang it to dry. Loosen all the straps. Wash your pack if dirt, sweat, salt and stains have worked their way into fabrics, webbing or mesh.', 'http://i.imgur.com/F814Vzt.jpg', 'The Teton Scout 3400 is perfect for short day hikes. Side mesh pockets hold water bottle snugly or provide access to snacks. Front mesh pocket and bungee storage for stashing shoes, jacket, sunscreen or map. Zippered pockets on each side. Internal and external hood pockets. Keep a water bladder cool in a padded pocket inside main compartment, with tube clips both left and right to accommodate personal preference. Bladder not included. Model name: Sports Scout 3400. Size: 90 Liter.'); /* 90 Liter  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(650, 'Tent', 6, 55, 7, 'http://i.imgur.com/nobRvno.png', 'Clean the tent poles with a soft, dry cloth. This is especially necessary after oceanside camping trips to remove salt spray so the poles don\'t corrode or stay gritty. Clean the zippers with a quick dip in water and then dry them off. This is especially important if you\'ve been camping in a location with sand/dirt.', '2 person', 'The Coleman Sundome 2, 7\'x5\', dome tent is part of the classic Sundome series of tents from Coleman. The Sundome 2 sleeps 2 happy campers and includes a large door for easy entry/exit with a hooded fly to provide ventilation even in rain. A large rear hooded window also provides airflow for cross ventilation. Model name: Sundome 2.'); /* 2 person  */
INSERT INTO gear_item(id, name, gender_id, size_id, total_quantity, image_url, care_maintenance, sizing_table, description) VALUES(660, 'Tent', 6, 56, 13, 'http://i.imgur.com/jrn7J8T.png', 'Clean the tent poles with a soft, dry cloth. This is especially necessary after oceanside camping trips to remove salt spray so the poles don\'t corrode or stay gritty. Clean the zippers with a quick dip in water and then dry them off. This is especially important if you\'ve been camping in a location with sand/dirt.', '4 person', 'The Coleman Sundome 4, 9\'x7\', dome tent is part of the classic Sundome series of tents from Coleman. The Sundome 4 sleeps 4 happy campers and includes a large door for easy entry/exit with a hooded fly to provide ventilation even in rain. Model name: Sundome 4.'); /* 4 person  */


-- Reserve two 2-person tents, 2 pair of Men's 10 hiking boots, 2 pair of omen's 8 hiking boots, and 4 50 liter backpacking packs
INSERT INTO request VALUES(1, 2, '2016-11-04', '2016-11-08', 3); -- Picked up
INSERT INTO reserved_item VALUES(1, 1, 260, 2); -- 2 men's 10 hiking boots
INSERT INTO reserved_item VALUES(2, 1, 390, 2); -- 2 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(3, 1, 650, 2); -- 2 2-person tents 
INSERT INTO reserved_item VALUES(4, 1, 580, 3); -- 4 50 liter backpacking packs

-- Overlapping request 3 2-person tents, 1 men's 10 hiking boot, 5 50 liter backpacking pack, 1 women's 8 hiking boot
INSERT INTO request VALUES(2, 2, '2016-11-08', '2016-11-12', 3); -- Picked up 
INSERT INTO reserved_item VALUES(5, 2, 260, 1); -- 1 men's 10 hiking boots 
INSERT INTO reserved_item VALUES(6, 2, 390, 1); -- 1 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(7, 2, 650, 3); -- 3 2-person tents 
INSERT INTO reserved_item VALUES(8, 2, 580, 4); -- 5 50 liter backpacking packs

-- Another request, overlapping but not same items
INSERT INTO request VALUES(3, 2, '2016-11-05', '2016-11-07', 3); -- Picked up
INSERT INTO reserved_item VALUES(9, 3, 10, 1);  -- 1 youth med fleece jacket 
INSERT INTO reserved_item VALUES(10, 3, 510, 1);  -- 1 Men's sm gloves 
INSERT INTO reserved_item VALUES(11, 3, 630, 1); -- 1 75 liter backpacking pack 

INSERT INTO request VALUES(4, 2, '2016-12-01', '2016-12-04', 2); -- Approved Status
INSERT INTO reserved_item VALUES(13, 4, 390, 2); -- 2 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(14, 4, 650, 2); -- 2 2-person tents 
INSERT INTO reserved_item VALUES(15, 4, 580, 3); -- 4 50 liter backpacking packs

INSERT INTO request VALUES(5, 2, '2016-12-13', '2016-12-19', 1); -- Requested Status
INSERT INTO reserved_item VALUES(16, 5, 70, 1); -- 1 men's 10 hiking boots 
INSERT INTO reserved_item VALUES(17, 5, 80, 1); -- 1 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(18, 5, 150, 3); -- 3 2-person tents 
INSERT INTO reserved_item VALUES(19, 5, 190, 1); -- 5 50 liter backpacking packs

INSERT INTO request VALUES(6, 2, '2016-12-22', '2016-12-24', 1); -- Requested Status
INSERT INTO reserved_item VALUES(20, 6, 10, 1);  -- 1 youth med fleece jacket 
INSERT INTO reserved_item VALUES(21, 6, 510, 1);  -- 1 Men's sm gloves 
INSERT INTO reserved_item VALUES(22, 6, 630, 1); -- 1 75 liter backpacking pack

INSERT INTO request VALUES(7, 2, '2017-01-03', '2017-01-09', 1); -- Requested Status
INSERT INTO reserved_item VALUES(23, 7, 470, 2); -- 2 men's 10 hiking boots
INSERT INTO reserved_item VALUES(24, 7, 80, 2); -- 2 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(25, 7, 500, 10); -- 2 2-person tents 
INSERT INTO reserved_item VALUES(26, 7, 550, 8); -- 4 50 liter backpacking packs

INSERT INTO request VALUES(8, 2, '2017-01-11', '2017-01-15', 1); -- Requested Status
INSERT INTO reserved_item VALUES(27, 8, 70, 1); -- 1 men's 10 hiking boots 
INSERT INTO reserved_item VALUES(28, 8, 500, 1); -- 1 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(29, 8, 650, 3); -- 3 2-person tents 
INSERT INTO reserved_item VALUES(30, 8, 580, 4); -- 5 50 liter backpacking packs

INSERT INTO request VALUES(9, 2, '2017-01-28', '2017-01-31', 1); -- Requested Status
INSERT INTO reserved_item VALUES(32, 9, 180, 3);  -- 1 youth med fleece jacket 
INSERT INTO reserved_item VALUES(33, 9, 510, 1);  -- 1 Men's sm gloves 
INSERT INTO reserved_item VALUES(34, 9, 120, 1); -- 1 75 liter backpacking pack

INSERT INTO request VALUES(10, 2, '2015-11-04', '2015-11-08', 3); -- Picked up
INSERT INTO reserved_item VALUES(35, 10, 260, 2); -- 2 men's 10 hiking boots
INSERT INTO reserved_item VALUES(36, 10, 390, 2); -- 2 women's 8 hiking boots 
INSERT INTO reserved_item VALUES(37, 10, 650, 2); -- 2 2-person tents 
INSERT INTO reserved_item VALUES(38, 10, 580, 3); -- 4 50 liter backpacking packs


-- ====================================================================================================================================
-- ====================================================================================================================================
-- ====================================================================================================================================
-- ====================================================================================================================================
-- ====================================================================================================================================


-- User Stories
-- SEGR-5260 (SW Construction & Environments)
use WTA;

-- ================================================
-- US 1 and US 12
-- ================================================
DELIMITER $$

DROP PROCEDURE IF EXISTS gear_availability$$
DROP TABLE IF EXISTS output$$
DROP TABLE IF EXISTS temp$$
SET SQL_SAFE_UPDATES=0$$

CREATE PROCEDURE gear_availability(IN StartDate DATE, IN EndDate DATE)
BEGIN

	DECLARE item_id INT;
	DECLARE item_name VARCHAR(45);
	DECLARE size VARCHAR(45);
    DECLARE total_quantity INT;
	DECLARE reserved_quantity INT;
    DECLARE temp_date DATE;
    DECLARE done INT DEFAULT 0;
    
    DECLARE item_cur CURSOR FOR
		SELECT i.id, i.name, s.size, i.total_quantity FROM gear_item i JOIN size s ON i.size_id=s.id;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	CREATE TEMPORARY TABLE output
			(id INT, name VARCHAR(45), size VARCHAR(45), availability INT);

	CREATE TEMPORARY TABLE temp
			(requested_date DATE, availability INT);
	
    OPEN item_cur;
    item_loop:
    LOOP FETCH item_cur INTO item_id, item_name, size, total_quantity;

			IF done = 1 THEN
				LEAVE item_loop;
			END IF;
            
            SET temp_date = StartDate;
            DELETE FROM temp;
            
            /*Loops through each date of given date range*/
			WHILE(temp_date <= EndDate) DO
                
                /*Calcuates approved quantity for each date*/
				SELECT SUM(ri.quantity) INTO reserved_quantity FROM REQUEST r, RESERVED_ITEM ri 
				WHERE r.id = ri.request_id AND r.status_id IN (1, 2, 3)
				AND temp_date BETWEEN r.start_date AND r.end_date
				AND ri.item_id=item_id;
                
				INSERT INTO temp VALUES(temp_date, total_quantity-reserved_quantity);
                SET temp_date = DATE_ADD(temp_date, INTERVAL 1 DAY);
                
                
                
			END WHILE;
            INSERT INTO output VALUES
				(item_id, item_name, size,IFNULL((SELECT MIN(availability) FROM temp), total_quantity));

	END LOOP item_loop;
    CLOSE item_cur;
	
	/*Item Name and their available quantity for the given date range*/
    SELECT output.id, output.name, size.size, gender.gender, output.availability AS QuantityAvailable FROM output
    JOIN gear_item on gear_item.id = output.id
    JOIN size on size.id = gear_item.size_id 
    JOIN gender on gear_item.size_id = gender.id WHERE availability <> 0;

	DROP TABLE output;
    DROP TABLE temp;
    SET SQL_SAFE_UPDATES=0;

END$$



-- ================================================
-- US 2
-- ================================================
DELIMITER ;
DROP PROCEDURE IF EXISTS GetMoreGearDetails;
DELIMITER $$
CREATE PROCEDURE GetMoreGearDetails(IN `GearId` INT)
BEGIN
	SELECT id, `name`, image_url, care_maintenance, sizing_table, description FROM gear_item WHERE gear_item.id = GearId;
END$$
-- ================================================
-- US 3
-- ================================================
DELIMITER ;
DROP PROCEDURE IF EXISTS create_request;
DELIMITER $$
CREATE PROCEDURE create_request(IN StartDate DATE, IN EndDate DATE, IN JSON_data JSON, IN UserID INT)
BEGIN
-- This procedure creates the WTA Request

SET @gears := (SELECT JSON_EXTRACT(JSON_data, '$.gears'));

-- Create request in request table
select id into @status_id from status 
where status like '%requested%';
INSERT INTO request(start_date, end_date,customer_id,status_id) values(StartDate, EndDate, UserID, @status_id);
SET @request_id := (SELECT last_insert_id()); -- into RequestID;

-- Reserve the gear for the request
CALL reserve_gear(@gears, @request_id);

END$$
DELIMITER ;
DROP PROCEDURE IF EXISTS reserve_gear;
DELIMITER $$
CREATE PROCEDURE reserve_gear(IN gears JSON, IN requestID INT)
BEGIN
-- This procedure reserves the gears for the request
  DECLARE int_i INT DEFAULT 0;
  DECLARE int_length INT DEFAULT 0;
  DECLARE gear_id INT DEFAULT 0;
  DECLARE quantity INT DEFAULT 0;
  
  SET int_length := (SELECT JSON_LENGTH(gears));

  -- Looping through gears and inserted them in the reserved_item table
  label1 : LOOP
    IF(int_i < int_length) THEN
		SET gear_id := (SELECT JSON_EXTRACT(gears, CONCAT('$[',int_i,'].id')));
        SET quantity := (SELECT JSON_EXTRACT(gears, CONCAT('$[',int_i,'].quantity')));
		INSERT INTO reserved_item(Quantity, request_id, item_id) values(quantity, requestID, gear_id);
		SET int_i = int_i + 1;
		ITERATE label1;
    END IF;
	LEAVE label1;
  END LOOP;
END$$
DELIMITER ;

-- ================================================
-- US 5
-- ================================================
DELIMITER ;
DROP PROCEDURE IF EXISTS get_gear_request_details;
DELIMITER $$
CREATE PROCEDURE get_gear_request_details(IN RequestID INT)
BEGIN
-- This procedure gets the details of a gear request

SELECT req.start_date, req.end_date, quantity, st.status, gi.name, gi.image_url, gi.care_maintenance, gi.sizing_table, gi.description, gi.total_quantity, g.gender, si.size FROM wta.request req
join reserved_item itm on req.id = itm.request_id
join status st on req.status_id = st.id
join gear_item gi on itm.item_id = gi.id
join gender g on gi.gender_id = g.id
join size si on gi.size_id = si.id
where req.id = RequestID;

END$$

-- ================================================
-- US 6
-- ================================================
DELIMITER ;
DROP PROCEDURE IF EXISTS get_admin_emails;
DELIMITER $$
CREATE PROCEDURE get_admin_emails()
BEGIN
		SELECT email
	        FROM personnel_info
            JOIN role
            ON personnel_info.role_id = role.id
	        WHERE role.role_name LIKE '%Administrator%';
END$$
DELIMITER ;

DROP procedure IF EXISTS get_upcoming_pickups;

DELIMITER $$
CREATE PROCEDURE get_upcoming_pickups(IN DAYS_FROM_PICK_UP INT)
BEGIN
    SELECT personnel_info.name, email
	    FROM personnel_info
        JOIN request
        ON personnel_info.id = request.customer_id
        JOIN status
        ON request.status_id = status.id
        /* find email when request start date - DAYS_FROM_PICK_UP equals today and the request
           status is approved */
	    WHERE SUBDATE(request.start_date, INTERVAL DAYS_FROM_PICK_UP DAY) = CURDATE() 
		    AND
		    status.status LIKE '%approved%';
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS get_upcoming_returns;
DELIMITER $$
CREATE PROCEDURE get_upcoming_returns(IN DAYS_FROM_RETURN INT)
BEGIN
		SELECT personnel_info.name, email
	        FROM personnel_info
            JOIN request
            ON personnel_info.id = request.customer_id
            JOIN status
            ON request.status_id = status.id
            /* find requests when request end date - DAYS_FROM_RETURN equals today and the request
               status is 'picked up' or 'approved' */
	        WHERE SUBDATE(request.end_date, INTERVAL DAYS_FROM_RETURN DAY) = CURDATE() 
		        AND
                (status.status LIKE '%approved%' OR status.status LIKE '%picked_up%');
END$$
DELIMITER ;

-- ================================================
-- US 7
-- ================================================
DELIMITER ;
DROP PROCEDURE IF EXISTS approve_request;
DELIMITER $$
CREATE PROCEDURE approve_request(IN `RequestId` INT)
BEGIN
-- This procedure approves given request

UPDATE request set status_id=2 WHERE request.id = RequestId;

END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS get_new_requests;
DELIMITER $$
CREATE PROCEDURE get_requests() READS SQL DATA
BEGIN
	-- This procedure returns list of gear requests which is in 'Requested' and 'Approved' status
	SELECT rq.id request_id, rq.start_date, rq.end_date , cr.`name` requester, st.`status`
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        WHERE st.id IN (1,2);
        
END$$

-- ================================================
-- US 8
-- ================================================   
DELIMITER ;
DROP PROCEDURE IF EXISTS RequestsDueForReturn;
DELIMITER $$
CREATE PROCEDURE RequestsDueForReturn() READS SQL DATA
BEGIN
	SELECT rq.id request_id, rq.end_date due_date, st.`status`, cr.`name` borrower, cr.email, 
			gr.gender, sz.size, gi.`name`, ri.quantity
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        JOIN reserved_item ri ON rq.id = ri.request_id
        JOIN gear_item gi ON ri.item_id = gi.id
        JOIN size sz ON gi.size_id = sz.id JOIN gender gr on gi.gender_id = gr.id
        WHERE st.id = 3;
END$$

DELIMITER ;        
DROP PROCEDURE IF EXISTS SetRequestStatus;
DELIMITER $$
CREATE PROCEDURE SetRequestStatus(IN `RequestId` INT, IN `Status` INT)
BEGIN
	UPDATE request set status_id=`Status` WHERE request.id = RequestId;
END$$

DELIMITER ;        
DROP PROCEDURE IF EXISTS MarkRequestReturned;

DELIMITER $$
CREATE PROCEDURE MarkRequestReturned(IN `RequestId` INT)
BEGIN
	UPDATE request set status_id=4 WHERE request.id = RequestId;
END$$

DELIMITER ;            
DROP PROCEDURE IF EXISTS ViewRequestDetail;

DELIMITER $$
CREATE PROCEDURE ViewRequestDetail(IN `RequestId` INT) READS SQL DATA
BEGIN
	SELECT rq.id request_id, rq.end_date due_date, st.`status`, cr.`name` borrower, cr.email, 
			gr.gender, sz.size, gi.`name`, ri.quantity
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        JOIN reserved_item ri ON rq.id = ri.request_id
        JOIN gear_item gi ON ri.item_id = gi.id
        JOIN size sz ON gi.size_id = sz.id JOIN gender gr on gi.gender_id = gr.id
        WHERE rq.id = RequestId;
END$$

-- ================================================
-- US 9a
-- ================================================
DELIMITER ;
DROP PROCEDURE IF EXISTS get_gear_inventory;
DELIMITER $$
CREATE PROCEDURE `get_gear_inventory`()
BEGIN
		SELECT  Inventory.id, Inventory.name, 
			size.size,
			Inventory.total_quantity as TotalQuantity	 
		FROM gear_item as Inventory
		JOIN size
			ON size.id = Inventory.size_id
		GROUP BY Inventory.id, Inventory.name, size.size;
 END$$
DELIMITER ;

-- ================================================
-- US 9b
-- ================================================

DELIMITER ;
DROP PROCEDURE IF EXISTS update_gear_inventory;
DELIMITER $$
CREATE PROCEDURE `update_gear_inventory`(IN `GearID` INT, IN `NewQuantity` INT)
BEGIN

UPDATE gear_item g 
SET g.total_quantity = NewQuantity 
WHERE g.id = GearID;

END$$
DELIMITER ;

-- ================================================
-- US 10
-- ================================================
DELIMITER ;            
DROP PROCEDURE IF EXISTS RequestHistoryByTripLeader;
CREATE PROCEDURE RequestHistoryByTripLeader(IN `TripLeader` VARCHAR(50)) READS SQL DATA
	SELECT DISTINCT pi.name, gi.name, r.start_date, r.end_date, gi.total_quantity, s.status, gi.care_maintenance
	FROM personnel_info pi
	JOIN role c ON c.id = 1
	JOIN request r ON r.customer_id = pi.id
	JOIN reserved_item ri ON ri.request_id = r.id
	JOIN gear_item gi ON gi.id = ri.item_id
	JOIN status s ON r.status_id = s.id
	WHERE (pi.name = TripLeader AND r.end_date < CURDATE())
    ORDER BY (r.end_date);
DELIMITER $$
    
DELIMITER ;            
DROP PROCEDURE IF EXISTS RequestHistoryByDate;
CREATE PROCEDURE RequestHistoryByDate(IN `start_date` DATE, IN `end_date` DATE) READS SQL DATA
	SELECT DISTINCT pi.name, gi.name, r.start_date, r.end_date, gi.total_quantity, s.status, gi.care_maintenance
	FROM personnel_info pi
	JOIN role c ON c.id = 1
	JOIN request r ON r.customer_id = pi.id
	JOIN reserved_item ri ON ri.request_id = r.id
	JOIN gear_item gi ON gi.id = ri.item_id
	JOIN status s ON r.status_id = s.id
	WHERE (r.start_date >= start_date AND r.end_date <= end_date)
    ORDER BY (r.end_date);
DELIMITER $$

-- ================================================
-- US 11
-- ================================================

DELIMITER ;
DROP PROCEDURE IF EXISTS gear_request_trend;
DELIMITER $$
CREATE PROCEDURE gear_request_trend(IN ReportYear INT)
BEGIN
-- This procedure gets report of gear request trend across given year

SELECT
    trend.name,  
    SUM(CASE WHEN (trend.month='January') THEN trend.quantity ELSE 0 END) AS January,
    SUM(CASE WHEN (trend.month='February') THEN trend.quantity ELSE 0 END) AS February,
    SUM(CASE WHEN (trend.month='March') THEN trend.quantity ELSE 0 END) AS March,
    SUM(CASE WHEN (trend.month='April') THEN trend.quantity ELSE 0 END) AS April,
    SUM(CASE WHEN (trend.month='May') THEN trend.quantity ELSE 0 END) AS May,
    SUM(CASE WHEN (trend.month='June') THEN trend.quantity ELSE 0 END) AS June,
    SUM(CASE WHEN (trend.month='July') THEN trend.quantity ELSE 0 END) AS July,
    SUM(CASE WHEN (trend.month='August') THEN trend.quantity ELSE 0 END) AS August,
    SUM(CASE WHEN (trend.month='September') THEN trend.quantity ELSE 0 END) AS September,
    SUM(CASE WHEN (trend.month='October') THEN trend.quantity ELSE 0 END) AS October,
    SUM(CASE WHEN (trend.month='November') THEN trend.quantity ELSE 0 END) AS November,
    SUM(CASE WHEN (trend.month='December') THEN trend.quantity ELSE 0 END) AS December
FROM 
    (SELECT gear_item.name AS name,
	MONTHNAME(request.start_date) AS month,
	sum(reserved_item.quantity) AS quantity
	FROM reserved_item 
    LEFT JOIN gear_item ON reserved_item.item_id=gear_item.id
	INNER JOIN request
	ON reserved_item.request_id=request.id
	WHERE YEAR(request.start_date) = ReportYear OR YEAR(request.end_date) = ReportYear 
	GROUP BY gear_item.name, MONTHNAME(request.start_date)) 
AS trend
GROUP BY trend.name;

END$$

-- ===========================================================
-- User story to fecth all the gear requests of logged in user
-- ===========================================================

DELIMITER ;
DROP PROCEDURE IF EXISTS get_user_gear_requests;
DELIMITER $$
CREATE PROCEDURE get_user_gear_requests(IN `userId` INT) READS SQL DATA
BEGIN
	-- This procedure returns list of gear requests which is in 'Requested' and 'Approved' status
	SELECT rq.id request_id, rq.start_date, rq.end_date , cr.`name` requester, st.`status`
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        WHERE cr.id = userId;
        
END$$


-- ================================================
-- Handling User Groups and Roles
-- ================================================

DELIMITER ;
DROP PROCEDURE IF EXISTS getGroups;
DELIMITER $$
CREATE PROCEDURE getGroups()
BEGIN
	SELECT g.*, r.role_name
    FROM wta.groups as g
    JOIN wta.role as r
    ON r.id = g.role_id;
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS createGroup;
DELIMITER $$
CREATE PROCEDURE createGroup(IN groupName VARCHAR(255), IN roleID INT)
BEGIN
	INSERT groups(group_name, role_id) values(groupName, roleID);
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS getGroupMembers;
DELIMITER $$
CREATE PROCEDURE getGroupMembers(IN groupID INT)
BEGIN
	SELECT g.id as group_id, g.role_id as role_id, g.group_name, p.id as UserID, p.name, p.email, p.phone_number, p.address_line_1, p.address_line_2, p.address_line_3, p.city, p.state, p.zip_code 
    FROM groups as g
    JOIN personnel_info as p 
    ON p.groups_id = g.id
    WHERE g.id = groupID;
END$$
DELIMITER ;


DELIMITER ;
DROP PROCEDURE IF EXISTS getRoles;
DELIMITER $$
CREATE PROCEDURE getRoles()
BEGIN
	SELECT r.*
    FROM wta.role as r;
END$$


DELIMITER ;
DROP PROCEDURE IF EXISTS moveUser;
DELIMITER $$
CREATE PROCEDURE moveUser(IN UserID INT, IN GroupID INT)
BEGIN
	UPDATE personnel_info SET groups_id = GroupID WHERE id = UserID;
END$$

-- ================================================
-- Handling User
-- ================================================

DELIMITER ;
DROP PROCEDURE IF EXISTS getUserInfo;
DELIMITER $$
CREATE PROCEDURE getUserInfo(IN UserID INT)
BEGIN
    SELECT userInfo.id as user_id, userInfo.name, g.id as group_id, g.group_name, r.id as role_id, r.role_name from personnel_info as userInfo
    JOIN groups as g
    ON g.id = userInfo.groups_id
    JOIN role as r
    ON r.id = g.role_id
    WHERE userInfo.id = UserID;
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS getUserInfoByEmail;
DELIMITER $$
CREATE PROCEDURE getUserInfoByEmail(IN Email VARCHAR(50))
BEGIN
    SELECT userInfo.id as user_id, userInfo.name, userInfo.email, userInfo.phone_number, userInfo.address_line_1, 
		userInfo.address_line_2, userInfo.address_line_3, userInfo.city, userInfo.state, userInfo.zip_code, g.id as group_id, 
        g.group_name, r.id as role_id, r.role_name 
    from personnel_info as userInfo
    JOIN groups as g
    ON g.id = userInfo.groups_id
    JOIN role as r
    ON r.id = g.role_id
    WHERE userInfo.email = Email;
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS createUser;
DELIMITER $$
CREATE PROCEDURE createUser(IN Email VARCHAR(50), IN UserName VARCHAR(50))
BEGIN
    INSERT INTO personnel_info(`name`, groups_id, email) VALUES(UserName, 5, Email);
END$$