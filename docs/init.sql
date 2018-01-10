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

CREATE TABLE groups (
    id      				BIGINT NOT NULL AUTO_INCREMENT,
    title					VARCHAR(255),
	description		TEXT,
	created_date		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified_date	TIMESTAMP NOT NULL,
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
	project_id					BIGINT,
	project_priority			INT, -- projecten belül lehet szabályozni ezt a számot: pl nem lehet két egyforma érték
	color							VARCHAR(100),
	is_archive					BOOLEAN DEFAULT FALSE,
	
	-- users
	creator_id					BIGINT NOT NULL,
	modified_by				BIGINT NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(creator_id) REFERENCES users(id),
	FOREIGN KEY(modified_by) REFERENCES users(id),
	FOREIGN KEY(project_id) REFERENCES projects(id)
) ENGINE=InnoDB;

CREATE TABLE projects (
    id      				BIGINT NOT NULL AUTO_INCREMENT,
    title					VARCHAR(255),
	description		TEXT,
	created_date		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified_date	TIMESTAMP NOT NULL,	
	is_archive			BOOLEAN DEFAULT FALSE,
    PRIMARY KEY(id)	
) ENGINE=InnoDB;

CREATE TABLE task_dependencies (
    id      				BIGINT NOT NULL AUTO_INCREMENT,
	prior_task_id		BIGINT NOT NULL,
	post_task_id		BIGINT NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(prior_task_id) REFERENCES tasks(id),
	FOREIGN KEY(post_task_id) REFERENCES tasks(id)	
) ENGINE=InnoDB;

CREATE TABLE assignees (
    id      				BIGINT NOT NULL AUTO_INCREMENT,
    task_id				BIGINT NOT NULL,
	user_id				BIGINT NOT NULL,	
	role_id				BIGINT,			
    PRIMARY KEY(id)	,
	FOREIGN KEY(task_id) REFERENCES tasks(id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(role_id) REFERENCES roles(id)
) ENGINE=InnoDB;

CREATE TABLE roles (
    id      				BIGINT NOT NULL AUTO_INCREMENT,
	title					VARCHAR(255),
	description		TEXT,	
    PRIMARY KEY(id)	
) ENGINE=InnoDB;

-- TODO
-- - task/project rendezés túl sok beállítást követel a usertől, lehet nem kéne túlbonyolítani
-- - is_archive: 
-- 	- project is_archive, de a task nem -> task nem jelenik meg csak az archive projektek oldalán
-- 	- project is_archive, és task is -> task nem jelenik meg csak az archive projektek oldalán
-- 	- project nem is_archive, és task se -> task és project aktív, archiv oldalon nincs
-- 	- project nem is_archive, de task is_archive -> task nem jelenik meg, csak archiv oldalon, a (nem archivált) projekt alatt (kis indikátor, hogy a projekt aktív)

