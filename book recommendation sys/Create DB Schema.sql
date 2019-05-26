-- MySQL Script generated by MySQL Workbench
-- Fri May  3 15:40:29 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema 18200022_Shivam_Saxena_BRS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 18200022_Shivam_Saxena_BRS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `18200022_Shivam_Saxena_BRS` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `18200022_Shivam_Saxena_BRS` ;

-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`books` (
  `isbn` BIGINT(13) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `pub_year` YEAR(4) NOT NULL,
  `price` INT(11) NOT NULL DEFAULT '0',
  `available_qty` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`isbn`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`authors` (
  `isbn` BIGINT(13) NOT NULL,
  `author` VARCHAR(50) NOT NULL,
  `rank` INT(2) NOT NULL,
  PRIMARY KEY (`isbn`, `rank`),
  CONSTRAINT ` isbn_author_fk`
    FOREIGN KEY (`isbn`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`books` (`isbn`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`cities` (
  `cities_id` INT(11) NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cities_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`readers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`readers` (
  `reader_id` BIGINT(12) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `age` INT(11) NOT NULL,
  `gender` VARCHAR(1) NULL DEFAULT NULL,
  `profession` VARCHAR(45) NULL DEFAULT NULL,
  `house_address` VARCHAR(45) NOT NULL,
  `cities_id` INT(11) NOT NULL,
  PRIMARY KEY (`reader_id`),
  INDEX `cities_id_fk_idx` (`cities_id` ASC),
  CONSTRAINT `cities_id_fk`
    FOREIGN KEY (`cities_id`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`cities` (`cities_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`book_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`book_reviews` (
  `isbn` BIGINT(13) NOT NULL,
  `reader_id` BIGINT(12) NOT NULL,
  `rating` INT(1) NOT NULL,
  `review_comments` TEXT NULL DEFAULT NULL,
  `review_date` DATETIME NOT NULL,
  PRIMARY KEY (`isbn`, `reader_id`),
  INDEX `reader_id_review_fk_idx` (`reader_id` ASC),
  CONSTRAINT `isbn_fk`
    FOREIGN KEY (`isbn`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`books` (`isbn`),
  CONSTRAINT `reader_id_review_fk`
    FOREIGN KEY (`reader_id`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`readers` (`reader_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`books_sold`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`books_sold` (
  `order_id` BIGINT(12) NOT NULL AUTO_INCREMENT,
  `isbn` BIGINT(12) NOT NULL,
  `reader_id` BIGINT(12) NOT NULL,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity` INT(11) NOT NULL DEFAULT '1',
  `total_cost` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `isbn_fk_idx` (`isbn` ASC),
  INDEX `reader_fk_idx` (`reader_id` ASC),
  CONSTRAINT `order_isbn_fk`
    FOREIGN KEY (`isbn`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`books` (`isbn`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `order_reader_fk`
    FOREIGN KEY (`reader_id`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`readers` (`reader_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`past_recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`past_recommendation` (
  `pr_id` INT(11) NOT NULL AUTO_INCREMENT,
  `reader_id` BIGINT(12) NOT NULL,
  `isbn` BIGINT(13) NOT NULL,
  `is_bought` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`pr_id`, `reader_id`, `isbn`),
  INDEX `pr_isbn_fk_idx` (`isbn` ASC),
  INDEX `pr_reader_id_idx` (`reader_id` ASC),
  CONSTRAINT `pr_isbn_fk`
    FOREIGN KEY (`isbn`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`books` (`isbn`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `pr_reader_id`
    FOREIGN KEY (`reader_id`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`readers` (`reader_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`qualities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`qualities` (
  `isbn` BIGINT(13) NOT NULL,
  `quality` VARCHAR(50) NOT NULL,
  `rank` INT(2) NOT NULL,
  PRIMARY KEY (`isbn`, `rank`),
  CONSTRAINT `isbn_qualities_fk`
    FOREIGN KEY (`isbn`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`books` (`isbn`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `18200022_Shivam_Saxena_BRS`.`themes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`themes` (
  `isbn` BIGINT(13) NOT NULL,
  `theme` VARCHAR(50) NOT NULL,
  `rank` INT(2) NOT NULL,
  PRIMARY KEY (`isbn`, `rank`),
  CONSTRAINT `isbn_theme_fk`
    FOREIGN KEY (`isbn`)
    REFERENCES `18200022_Shivam_Saxena_BRS`.`books` (`isbn`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `18200022_Shivam_Saxena_BRS` ;

-- -----------------------------------------------------
-- Placeholder table for view `18200022_Shivam_Saxena_BRS`.`all_time_most_bought`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`all_time_most_bought` (`isbn` INT, `title` INT, `pub_year` INT, `price` INT, `available_qty` INT, `order_cnt` INT);

-- -----------------------------------------------------
-- Placeholder table for view `18200022_Shivam_Saxena_BRS`.`all_time_top_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`all_time_top_books` (`isbn` INT, `title` INT, `author` INT, `theme` INT, `quality` INT, `avg_reader_rating` INT);

-- -----------------------------------------------------
-- Placeholder table for view `18200022_Shivam_Saxena_BRS`.`country_usa_pref_atq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`country_usa_pref_atq` (`author` INT, `theme` INT, `quality` INT);

-- -----------------------------------------------------
-- Placeholder table for view `18200022_Shivam_Saxena_BRS`.`gender_m_pref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`gender_m_pref` (`author` INT, `theme` INT, `quality` INT);

-- -----------------------------------------------------
-- Placeholder table for view `18200022_Shivam_Saxena_BRS`.`reader_id_past_reviews_based_rec_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`reader_id_past_reviews_based_rec_books` (`isbn` INT, `title` INT, `pub_year` INT, `author` INT, `theme` INT, `quality` INT, `price` INT);

-- -----------------------------------------------------
-- Placeholder table for view `18200022_Shivam_Saxena_BRS`.`unemployed_teenage_pref_atq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `18200022_Shivam_Saxena_BRS`.`unemployed_teenage_pref_atq` (`author` INT, `theme` INT, `quality` INT);

-- -----------------------------------------------------
-- procedure GetRecForReader
-- -----------------------------------------------------

DELIMITER $$
USE `18200022_Shivam_Saxena_BRS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRecForReader`(IN reader_id Bigint)
BEGIN
select distinct b.isbn, title, pub_year, price
from books b, themes th, authors a, qualities q
	where b.isbn = th.isbn and 
          a.isbn = b.isbn and
          q.isbn = b.isbn and b.isbn in (
			-- books containing those qualities
			select distinct isbn from qualities where quality in (
				-- which qualities the reader prefers
				select distinct quality from qualities where isbn in (
					-- to retrieve the books specific reader liked
					select isbn from 18200022_Shivam_Saxena_BRS.book_reviews where reader_id = reader_id and rating > 2
				)
			)
            union
            select distinct isbn from themes where theme in (                 
				-- which themes the reader prefers
				select distinct theme from themes where isbn in ( 
					-- to retrieve the books specific reader liked
					select isbn from 18200022_Shivam_Saxena_BRS.book_reviews where reader_id = reader_id and rating > 2
				)
			)
			union
			select distinct isbn from authors where author in (                 
				-- which themes the reader prefers
				select distinct author from authors where isbn in ( 
					-- to retrieve the books specific reader liked
					select isbn from 18200022_Shivam_Saxena_BRS.book_reviews where reader_id = reader_id and rating > 2
				)
			)

			) ;	
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure checkIsBought
-- -----------------------------------------------------

DELIMITER $$
USE `18200022_Shivam_Saxena_BRS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkIsBought`(IN new_isbn Bigint(13) ,IN new_reader_id Bigint(12))
BEGIN
 DECLARE counter int;
 select count(1) into counter from past_recommendation where isbn=new_isbn and reader_id = new_reader_id ;
    IF (counter > 0) THEN 
  		update past_recommendation pr set is_bought = 1
	   where pr.isbn = new_isbn and pr.reader_id = new_reader_id;
 END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getHighRatedBooks
-- -----------------------------------------------------

DELIMITER $$
USE `18200022_Shivam_Saxena_BRS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getHighRatedBooks`(IN num_books INT)
BEGIN
	SELECT * FROM 18200022_Shivam_Saxena_BRS.all_time_top_books limit num_books;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure topbooks
-- -----------------------------------------------------

DELIMITER $$
USE `18200022_Shivam_Saxena_BRS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `topbooks`(IN book_numbers INT)
BEGIN
  SELECT * FROM books.bestbooks limit book_numbers;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `18200022_Shivam_Saxena_BRS`.`all_time_most_bought`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `18200022_Shivam_Saxena_BRS`.`all_time_most_bought`;
USE `18200022_Shivam_Saxena_BRS`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `18200022_Shivam_Saxena_BRS`.`all_time_most_bought` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`b`.`pub_year` AS `pub_year`,`b`.`price` AS `price`,`b`.`available_qty` AS `available_qty`,count(`bs`.`isbn`) AS `order_cnt` from (`18200022_Shivam_Saxena_BRS`.`books_sold` `bs` join `18200022_Shivam_Saxena_BRS`.`books` `b`) where (`bs`.`isbn` = `b`.`isbn`) group by `bs`.`isbn` order by `order_cnt` desc;

-- -----------------------------------------------------
-- View `18200022_Shivam_Saxena_BRS`.`all_time_top_books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `18200022_Shivam_Saxena_BRS`.`all_time_top_books`;
USE `18200022_Shivam_Saxena_BRS`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `18200022_Shivam_Saxena_BRS`.`all_time_top_books` AS select `br`.`isbn` AS `isbn`,`b`.`title` AS `title`,`a`.`author` AS `author`,`th`.`theme` AS `theme`,`q`.`quality` AS `quality`,avg(`br`.`rating`) AS `avg_reader_rating` from ((((`18200022_Shivam_Saxena_BRS`.`book_reviews` `br` join `18200022_Shivam_Saxena_BRS`.`books` `b`) join `18200022_Shivam_Saxena_BRS`.`themes` `th`) join `18200022_Shivam_Saxena_BRS`.`authors` `a`) join `18200022_Shivam_Saxena_BRS`.`qualities` `q`) where ((`b`.`isbn` = `th`.`isbn`) and (`br`.`isbn` = `b`.`isbn`) and (`a`.`isbn` = `b`.`isbn`) and (`q`.`isbn` = `b`.`isbn`)) group by `br`.`isbn` order by `br`.`rating` desc;

-- -----------------------------------------------------
-- View `18200022_Shivam_Saxena_BRS`.`country_usa_pref_atq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `18200022_Shivam_Saxena_BRS`.`country_usa_pref_atq`;
USE `18200022_Shivam_Saxena_BRS`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `18200022_Shivam_Saxena_BRS`.`country_usa_pref_atq` AS select `a`.`author` AS `author`,`th`.`theme` AS `theme`,`q`.`quality` AS `quality` from (((`18200022_Shivam_Saxena_BRS`.`books` `b` join `18200022_Shivam_Saxena_BRS`.`themes` `th`) join `18200022_Shivam_Saxena_BRS`.`authors` `a`) join `18200022_Shivam_Saxena_BRS`.`qualities` `q`) where ((`b`.`isbn` = `th`.`isbn`) and (`a`.`isbn` = `b`.`isbn`) and (`q`.`isbn` = `b`.`isbn`) and `b`.`isbn` in (select `bs`.`isbn` from (`18200022_Shivam_Saxena_BRS`.`readers` `r` join `18200022_Shivam_Saxena_BRS`.`books_sold` `bs`) where ((`r`.`reader_id` = `bs`.`reader_id`) and `r`.`cities_id` in (select `18200022_Shivam_Saxena_BRS`.`cities`.`cities_id` from `18200022_Shivam_Saxena_BRS`.`cities` where (`18200022_Shivam_Saxena_BRS`.`cities`.`country` = 'usa')))) and (`th`.`rank` < 3) and (`a`.`rank` < 3) and (`q`.`rank` < 3));

-- -----------------------------------------------------
-- View `18200022_Shivam_Saxena_BRS`.`gender_m_pref`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `18200022_Shivam_Saxena_BRS`.`gender_m_pref`;
USE `18200022_Shivam_Saxena_BRS`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `18200022_Shivam_Saxena_BRS`.`gender_m_pref` AS select `a`.`author` AS `author`,`th`.`theme` AS `theme`,`q`.`quality` AS `quality` from (((`18200022_Shivam_Saxena_BRS`.`books` `b` join `18200022_Shivam_Saxena_BRS`.`themes` `th`) join `18200022_Shivam_Saxena_BRS`.`authors` `a`) join `18200022_Shivam_Saxena_BRS`.`qualities` `q`) where ((`b`.`isbn` = `th`.`isbn`) and (`a`.`isbn` = `b`.`isbn`) and (`q`.`isbn` = `b`.`isbn`) and `b`.`isbn` in (select `bs`.`isbn` from (`18200022_Shivam_Saxena_BRS`.`readers` `r` join `18200022_Shivam_Saxena_BRS`.`books_sold` `bs`) where ((`r`.`reader_id` = `bs`.`reader_id`) and (`r`.`gender` = 'M'))) and (`th`.`rank` < 3) and (`a`.`rank` < 3) and (`q`.`rank` < 3));

-- -----------------------------------------------------
-- View `18200022_Shivam_Saxena_BRS`.`reader_id_past_reviews_based_rec_books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `18200022_Shivam_Saxena_BRS`.`reader_id_past_reviews_based_rec_books`;
USE `18200022_Shivam_Saxena_BRS`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `18200022_Shivam_Saxena_BRS`.`reader_id_past_reviews_based_rec_books` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`b`.`pub_year` AS `pub_year`,`a`.`author` AS `author`,`th`.`theme` AS `theme`,`q`.`quality` AS `quality`,`b`.`price` AS `price` from (((`18200022_Shivam_Saxena_BRS`.`books` `b` join `18200022_Shivam_Saxena_BRS`.`themes` `th`) join `18200022_Shivam_Saxena_BRS`.`authors` `a`) join `18200022_Shivam_Saxena_BRS`.`qualities` `q`) where ((`b`.`isbn` = `th`.`isbn`) and (`a`.`isbn` = `b`.`isbn`) and (`q`.`isbn` = `b`.`isbn`) and `b`.`isbn` in (select distinct `18200022_Shivam_Saxena_BRS`.`qualities`.`isbn` from `18200022_Shivam_Saxena_BRS`.`qualities` where `18200022_Shivam_Saxena_BRS`.`qualities`.`quality` in (select distinct `18200022_Shivam_Saxena_BRS`.`qualities`.`quality` from `18200022_Shivam_Saxena_BRS`.`qualities` where `18200022_Shivam_Saxena_BRS`.`qualities`.`isbn` in (select `18200022_Shivam_Saxena_BRS`.`book_reviews`.`isbn` from `18200022_Shivam_Saxena_BRS`.`book_reviews` where ((`18200022_Shivam_Saxena_BRS`.`book_reviews`.`reader_id` = 3) and (`18200022_Shivam_Saxena_BRS`.`book_reviews`.`rating` > 2)))) union select distinct `18200022_Shivam_Saxena_BRS`.`themes`.`isbn` from `18200022_Shivam_Saxena_BRS`.`themes` where `18200022_Shivam_Saxena_BRS`.`themes`.`theme` in (select distinct `18200022_Shivam_Saxena_BRS`.`themes`.`theme` from `18200022_Shivam_Saxena_BRS`.`themes` where `18200022_Shivam_Saxena_BRS`.`themes`.`isbn` in (select `18200022_Shivam_Saxena_BRS`.`book_reviews`.`isbn` from `18200022_Shivam_Saxena_BRS`.`book_reviews` where ((`18200022_Shivam_Saxena_BRS`.`book_reviews`.`reader_id` = 3) and (`18200022_Shivam_Saxena_BRS`.`book_reviews`.`rating` > 2)))) union select distinct `18200022_Shivam_Saxena_BRS`.`authors`.`isbn` from `18200022_Shivam_Saxena_BRS`.`authors` where `18200022_Shivam_Saxena_BRS`.`authors`.`author` in (select distinct `18200022_Shivam_Saxena_BRS`.`authors`.`author` from `18200022_Shivam_Saxena_BRS`.`authors` where `18200022_Shivam_Saxena_BRS`.`authors`.`isbn` in (select `18200022_Shivam_Saxena_BRS`.`book_reviews`.`isbn` from `18200022_Shivam_Saxena_BRS`.`book_reviews` where ((`18200022_Shivam_Saxena_BRS`.`book_reviews`.`reader_id` = 3) and (`18200022_Shivam_Saxena_BRS`.`book_reviews`.`rating` > 2))))));

-- -----------------------------------------------------
-- View `18200022_Shivam_Saxena_BRS`.`unemployed_teenage_pref_atq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `18200022_Shivam_Saxena_BRS`.`unemployed_teenage_pref_atq`;
USE `18200022_Shivam_Saxena_BRS`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `18200022_Shivam_Saxena_BRS`.`unemployed_teenage_pref_atq` AS select `a`.`author` AS `author`,`th`.`theme` AS `theme`,`q`.`quality` AS `quality` from (((`18200022_Shivam_Saxena_BRS`.`books` `b` join `18200022_Shivam_Saxena_BRS`.`themes` `th`) join `18200022_Shivam_Saxena_BRS`.`authors` `a`) join `18200022_Shivam_Saxena_BRS`.`qualities` `q`) where ((`b`.`isbn` = `th`.`isbn`) and (`a`.`isbn` = `b`.`isbn`) and (`q`.`isbn` = `b`.`isbn`) and `b`.`isbn` in (select `18200022_Shivam_Saxena_BRS`.`books`.`isbn` from `18200022_Shivam_Saxena_BRS`.`books` where `18200022_Shivam_Saxena_BRS`.`books`.`isbn` in (select `bs`.`isbn` from (`18200022_Shivam_Saxena_BRS`.`readers` `r` join `18200022_Shivam_Saxena_BRS`.`books_sold` `bs`) where ((`r`.`reader_id` = `bs`.`reader_id`) and (`r`.`age` between 13 and 20) and (`r`.`profession` = '')))) and (`th`.`rank` < 3) and (`a`.`rank` < 3) and (`q`.`rank` < 3));
USE `18200022_Shivam_Saxena_BRS`;

DELIMITER $$
USE `18200022_Shivam_Saxena_BRS`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `18200022_Shivam_Saxena_BRS`.`update_book_quantity`
AFTER INSERT ON `18200022_Shivam_Saxena_BRS`.`books_sold`
FOR EACH ROW
BEGIN
       UPDATE books 
       SET available_qty = available_qty - NEW.quantity 
       WHERE isbn = NEW.isbn;
    END$$

USE `18200022_Shivam_Saxena_BRS`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `18200022_Shivam_Saxena_BRS`.`update_is_bought`
AFTER INSERT ON `18200022_Shivam_Saxena_BRS`.`books_sold`
FOR EACH ROW
BEGIN
       CALL `18200022_Shivam_Saxena_BRS`.`checkIsBought`(NEW.isbn, NEW.reader_id);
    END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;