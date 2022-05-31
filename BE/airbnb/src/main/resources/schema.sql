-- -----------------------------------------------------
-- Schema airbnb_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airbnb_schema
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `airbnb_schema` DEFAULT CHARACTER SET utf8mb4 ;
-- USE `airbnb_schema` ;
USE db_study1;
-- -----------------------------------------------------
-- Table `airbnb_schema`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_study1`.`USER` (
    `USER_ID` BIGINT NOT NULL AUTO_INCREMENT,
    `USERNAME` VARCHAR(45) NOT NULL,
    `PROFILE_IMAGE` VARCHAR(500) NULL,
    `USER_EMAIL` VARCHAR(50) NOT NULL,
    `USER_ROLE` VARCHAR(10) NOT NULL,
    `USER_PHONE` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`USER_ID`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb_schema`.`ROOM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_study1`.`ROOM` (
    `ROOM_ID` BIGINT NOT NULL AUTO_INCREMENT,
    `HOST_ID` BIGINT NOT NULL,
    `ROOM_NAME` VARCHAR(50) NOT NULL,
    `ROOM_STATE` VARCHAR(45) NOT NULL,
    `ROOM_CITY` VARCHAR(45) NOT NULL,
    `ROOM_COUNTRY` VARCHAR(45) NOT NULL,
    `ROOM_LONGITUDE` DECIMAL NULL,
    `ROOM_LATITUDE` DECIMAL NULL,
    `ROOM_DESCRIPTION` VARCHAR(300) NOT NULL,
    `MAX_NUMBER_OF_GUEST` INT NOT NULL,
    `ROOM_TYPE` VARCHAR(10) NOT NULL COMMENT '원룸, 더블룸, 레지던스, 펜션',
    `NUMBER_OF_BED` INT NOT NULL,
    `NUMBER_OF_TOILET` INT NOT NULL,
    `ROOM_PRICE_PER_DAY` INT NOT NULL,
    PRIMARY KEY (`ROOM_ID`),
    INDEX `fk_ROOM_USER_idx` (`HOST_ID` ASC) VISIBLE,
    CONSTRAINT `fk_ROOM_USER`
    FOREIGN KEY (`HOST_ID`)
    REFERENCES `db_study1`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb_schema`.`WISHLIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_study1`.`WISHLIST` (
    `WISHLIST_ID` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `USER_ID` BIGINT NOT NULL,
    `ROOM_ID` BIGINT NOT NULL,
    `IS_DELETED` TINYINT(1) NULL DEFAULT 0,
    INDEX `fk_USER_has_ROOM_ROOM1_idx` (`ROOM_ID` ASC) VISIBLE,
    INDEX `fk_USER_has_ROOM_USER1_idx` (`USER_ID` ASC) VISIBLE,
    CONSTRAINT `fk_USER_has_ROOM_USER1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `db_study1`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_USER_has_ROOM_ROOM1`
    FOREIGN KEY (`ROOM_ID`)
    REFERENCES `db_study1`.`ROOM` (`ROOM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb_schema`.`IMAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_study1`.`IMAGE` (
    `IMAGE_ID` BIGINT NOT NULL AUTO_INCREMENT,
    `ROOM_ID` BIGINT NOT NULL,
    `IMAGE_LINK` VARCHAR(500) NOT NULL,
    `IMAGE_ORDER` INT NOT NULL,
    PRIMARY KEY (`IMAGE_ID`),
    INDEX `fk_IMAGE_ROOM1_idx` (`ROOM_ID` ASC) VISIBLE,
    CONSTRAINT `fk_IMAGE_ROOM1`
    FOREIGN KEY (`ROOM_ID`)
    REFERENCES `db_study1`.`ROOM` (`ROOM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb_schema`.`RESERVATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_study1`.`RESERVATION` (
    `RESERVATION_ID` BIGINT NOT NULL AUTO_INCREMENT,
    `ROOM_ID` BIGINT NOT NULL,
    `GUEST_ID` BIGINT NOT NULL,
    `START_AT` DATE NOT NULL,
    `END_AT` DATE NOT NULL,
    `NUMBER_OF_GUEST` INT NOT NULL,
    `TOTAL_PRICE` INT NOT NULL,
    PRIMARY KEY (`RESERVATION_ID`),
    INDEX `fk_RESERVATION1_ROOM1_idx` (`ROOM_ID` ASC) VISIBLE,
    INDEX `fk_RESERVATION1_USER1_idx` (`GUEST_ID` ASC) VISIBLE,
    CONSTRAINT `fk_RESERVATION1_ROOM1`
    FOREIGN KEY (`ROOM_ID`)
    REFERENCES `db_study1`.`ROOM` (`ROOM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_RESERVATION1_USER1`
    FOREIGN KEY (`GUEST_ID`)
    REFERENCES `db_study1`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


--
-- CREATE TABLE USER
-- (
--     USER_ID BIGINT AUTO_INCREMENT PRIMARY KEY ,
--     USER_LOGIN_ID VARCHAR(100) NOT NULL,
--     USER_PASSWORD VARCHAR(100) NOT NULL,
--     USER_NAME VARCHAR(10) NOT NULL,
--     USER_PROFILE_IMAGE_PATH VARCHAR(1000) NOT NULL
-- );
--
-- -- CREATE TABLE HOST
-- -- (
-- --     HOST_ID INT PRIMARY KEY,
-- --     HOST_NAME VARCHAR(100) NOT NULL,
-- --     PROFILE_IMAGE_PATH VARCHAR(1000) NOT NULL
-- -- );
--
--
-- CREATE TABLE ROOM
-- (
--     ROOM_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
--     HOST_ID BIGINT,
--     ROOM_NAME VARCHAR(100) NOT NULL,
--
--     PROVINCE VARCHAR(10) NOT NULL, -- 주소,좌표 묶어서 임베디드타입
--     CITY VARCHAR(10) NOT NULL,
--     GU VARCHAR(10) NOT NULL, -- 구는 영어가 없는듯
--     COORDINATE VARCHAR(30) NOT NULL,
--
--     PRICE INT NOT NULL,
--     DESCRIPTION VARCHAR(300) NOT NULL,
--     COMPOSITION VARCHAR(300) NOT NULL, -- 방 구성, 따로 값 타입으로 빼야하는가 (EX. 화장실1개, 침실2개)
--
--     GUEST_AMOUNT INT NOT NULL,
--     INFANT_AMOUNT INT NOT NULL,
--
--     FOREIGN KEY(HOST_ID) REFERENCES USER(USER_ID)
-- );
--
-- CREATE TABLE IMAGE
-- (
--     IMAGE_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
--     ROOM_ID BIGINT,
--     IMAGE_URL VARCHAR(1000) NOT NULL,
--     TYPE VARCHAR(10) NOT NULL,
--     FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID)
-- );
--
-- CREATE TABLE IF NOT EXISTS airbnb.airbnb_reservation (
--     reservation_no BIGINT NOT NULL AUTO_INCREMENT,
--     number_of_guest INT NOT NULL DEFAULT 1,
--     number_of_infant INT NULL DEFAULT 0,
--     price DECIMAL NOT NULL,
--     start_at DATE NOT NULL COMMENT '체크인 년,월,일',
--     end_at DATE NOT NULL COMMENT '체크아웃 년,월,일',
--     user_guest_id BIGINT NOT NULL,
--     accomodation_id BIGINT NOT NULL,
--
--     PRIMARY KEY (reservation_no, user_guest_id, accomodation_id),
--     INDEX fk_airbnb_reservation_airbnb_user1_idx (user_guest_id ASC) VISIBLE,
--     INDEX fk_airbnb_reservation_airbnb_accomodation1_idx (accomodation_id ASC) VISIBLE,
--     CONSTRAINT fk_airbnb_reservation_airbnb_user1
--     FOREIGN KEY (user_guest_id)
--     REFERENCES airbnb.airbnb_user (user_id)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
--     CONSTRAINT fk_airbnb_reservation_airbnb_accomodation1
--     FOREIGN KEY (accomodation_id)
--     REFERENCES airbnb.airbnb_accomodation (accomodation_id)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)
--     ENGINE = InnoDB;
--
-- CREATE TABLE REVIEW
-- (
--     REVIEW_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
--     ROOM_ID BIGINT,
--     USER_ID BIGINT,
--     STAR_RATING TINYINT NOT NULL,
--     CONTENT TEXT,
--     WRITE_DATE DATE NOT NULL,
--
--     FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID),
--     FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID)
-- );
--
-- CREATE TABLE WISHLIST
-- (
--     WISHLIST_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
--     USER_ID BIGINT,
--     ROOM_ID BIGINT,
--     FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID)
-- );
