-
-- $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/data/schema.sql $
-- $LastChangedRevision: 977 $
-- $LastChangedDate: 2006-12-18 11:03:16 +0000 (Mon, 18 Dec 2006) $
-- $LastChangedBy: gsultan $
--

--
-- Drop tables in an order that avoids referential integrity problems
--
DROP TABLE IF EXISTS session;
DROP TABLE IF EXISTS db_change_log;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS config;

--
-- Table structure for table `session`
--

CREATE TABLE session (
  id char(72) NOT NULL,
  session_data text,
  expires int(11) default NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE db_change_log (
    id          int(11) NOT NULL auto_increment,
    script_name varchar(31),
    user        varchar(63),
    description varchar(63),
    run_time    timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    version     varchar(31),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- A User
--
CREATE TABLE user (
    id          int(11) NOT NULL auto_increment,
    firstname   varchar(127),
    lastname    varchar(127),
    username    varchar(15),
    email       varchar(255),
    PRIMARY KEY (id),
    UNIQUE KEY  username_2 (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Lexicon of text for localisation
--
CREATE TABLE lexicon (
  id        int(11) NOT NULL auto_increment,
  language  varchar(15),
  path      varchar(255) default NULL,
  message   text,
  value     text,
  notes     text,
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Configuration Table
--
CREATE TABLE config (
  id        int(11) NOT NULL auto_increment,
  section   varchar(32) NOT NULL,
  name      varchar(64) NOT NULL,
  value     text,
  PRIMARY KEY  (id),
  UNIQUE KEY name_2 (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

