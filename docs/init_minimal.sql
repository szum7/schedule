CREATE TABLE users (
    id      				BIGINT NOT NULL AUTO_INCREMENT,
	username			VARCHAR(255) NOT NULL,
	password			VARCHAR(255) NOT NULL,
	salt					VARCHAR(255),
	image				VARCHAR(255),
	created_date		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified_date	TIMESTAMP NOT NULL,
	last_login_date	TIMESTAMP NOT NULL,
    PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE tasks (
	-- default fields
    id      						BIGINT NOT NULL AUTO_INCREMENT,
    title							VARCHAR(255),
	description				TEXT,
	created_date				TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified_date			TIMESTAMP NOT NULL,
	
	-- functions	
	start_date					TIMESTAMP,
	end_date					TIMESTAMP,
	color							VARCHAR(100),
	is_archive					BOOLEAN DEFAULT FALSE,
	
	-- users
	creator_id					BIGINT NOT NULL,
	modified_by				BIGINT NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(creator_id) REFERENCES users(id),
	FOREIGN KEY(modified_by) REFERENCES users(id)
) ENGINE=InnoDB;

