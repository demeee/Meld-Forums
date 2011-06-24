-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.47-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema meld_forums_v2_final
--

CREATE DATABASE IF NOT EXISTS meld_forums_v2_final;
USE meld_forums_v2_final;

--
-- Definition of table `mf_conference`
--

DROP TABLE IF EXISTS `mf_conference`;
CREATE TABLE `mf_conference` (
  `conferenceID` char(35) NOT NULL,
  `siteID` varchar(25) NOT NULL,
  `configurationID` char(35) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text,
  `isActive` tinyint(3) unsigned NOT NULL,
  `friendlyName` varchar(200) NOT NULL,
  `orderNo` int(10) unsigned NOT NULL,
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  `idx` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`conferenceID`),
  KEY `idxFriendlyName` (`friendlyName`),
  KEY `idxRemoteID` (`remoteID`),
  KEY `idxIdx` (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_conference`
--

/*!40000 ALTER TABLE `mf_conference` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_conference` ENABLE KEYS */;


--
-- Definition of table `mf_configuration`
--

DROP TABLE IF EXISTS `mf_configuration`;
CREATE TABLE `mf_configuration` (
  `configurationID` char(35) NOT NULL,
  `siteID` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isActive` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `restrictReadGroups` varchar(255) DEFAULT NULL,
  `restrictContributeGroups` varchar(255) DEFAULT NULL,
  `restrictModerateGroups` varchar(255) DEFAULT 'RestrictAll',
  `doRequireConfirmation` tinyint(3) unsigned DEFAULT '0',
  `doAvatars` tinyint(3) unsigned DEFAULT '0',
  `doClosed` tinyint(3) unsigned DEFAULT '0',
  `allowAttachmentExtensions` text,
  `doAttachments` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isMaster` tinyint(3) unsigned DEFAULT '0',
  `filesizeLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `characterLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `doInlineImageAttachments` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `imageWidthLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `imageHeightLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`configurationID`),
  KEY `remoteID` (`remoteID`),
  KEY `idxRead` (`restrictReadGroups`),
  KEY `idxContrib` (`restrictContributeGroups`),
  KEY `idxMod` (`restrictModerateGroups`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_configuration`
--

/*!40000 ALTER TABLE `mf_configuration` DISABLE KEYS */;
INSERT INTO `mf_configuration` (`configurationID`,`siteID`,`name`,`description`,`isActive`,`restrictReadGroups`,`restrictContributeGroups`,`restrictModerateGroups`,`doRequireConfirmation`,`doAvatars`,`doClosed`,`allowAttachmentExtensions`,`doAttachments`,`isMaster`,`filesizeLimit`,`characterLimit`,`doInlineImageAttachments`,`imageWidthLimit`,`imageHeightLimit`,`remoteID`,`dateCreate`,`dateLastUpdate`) VALUES 
 ('00000000-0000-0000-0000000000000001','default','Default','<br />\r\n',1,NULL,NULL,'RestrictAll',0,1,0,'jpg,png,gif,png,pdf',1,1,20000,1000,1,250,250,NULL,'2011-03-04 15:28:51','2011-06-09 13:02:35');
/*!40000 ALTER TABLE `mf_configuration` ENABLE KEYS */;


--
-- Definition of table `mf_display`
--

DROP TABLE IF EXISTS `mf_display`;
CREATE TABLE `mf_display` (
  `displayID` char(35) NOT NULL,
  `displayTypeID` char(35) NOT NULL,
  `objectID` char(35) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  `siteID` varchar(25) NOT NULL,
  `params` text,
  `notes` text,
  `isActive` tinyint(3) unsigned DEFAULT '0',
  `adminID` char(35) DEFAULT NULL,
  `moduleID` char(35) DEFAULT NULL,
  `contentID` char(35) DEFAULT NULL,
  `isValid` tinyint(3) unsigned DEFAULT '0',
  `settings` text,
  PRIMARY KEY (`displayID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_display`
--

/*!40000 ALTER TABLE `mf_display` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_display` ENABLE KEYS */;


--
-- Definition of table `mf_displaytype`
--

DROP TABLE IF EXISTS `mf_displaytype`;
CREATE TABLE `mf_displaytype` (
  `displaytypeid` char(35) NOT NULL,
  `objectID` char(35) DEFAULT NULL,
  `package` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` text,
  `settings` text,
  `isConfigurable` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isActive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `version` varchar(12) NOT NULL,
  `defaults` text,
  `moduleID` char(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`displaytypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_displaytype`
--

/*!40000 ALTER TABLE `mf_displaytype` DISABLE KEYS */;
INSERT INTO `mf_displaytype` (`displaytypeid`,`objectID`,`package`,`name`,`description`,`settings`,`isConfigurable`,`isActive`,`version`,`defaults`,`moduleID`,`dateCreate`,`dateLastUpdate`) VALUES 
 ('63C75F85-6290-4547-AEB22844C1DFC84E','73D52102-0769-4E9A-82502DABFC844D49','forum','Forums',NULL,NULL,0,1,'1',NULL,'95119BB4-DD49-4353-B1FEB423BE7B9C0A','2011-03-29 15:28:33','2011-04-16 15:48:55');
/*!40000 ALTER TABLE `mf_displaytype` ENABLE KEYS */;


--
-- Definition of table `mf_forum`
--

DROP TABLE IF EXISTS `mf_forum`;
CREATE TABLE `mf_forum` (
  `forumID` char(35) NOT NULL,
  `conferenceID` char(35) NOT NULL,
  `configurationID` char(35) DEFAULT NULL,
  `siteID` varchar(25) NOT NULL,
  `name` varchar(150) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext,
  `friendlyName` varchar(200) DEFAULT NULL,
  `isActive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `adminID` char(35) DEFAULT NULL,
  `orderNo` int(10) unsigned NOT NULL DEFAULT '1000',
  `threadCounter` int(10) unsigned NOT NULL DEFAULT '0',
  `lastPostID` char(35) DEFAULT NULL,
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  `idx` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentID` char(35) DEFAULT NULL,
  PRIMARY KEY (`forumID`),
  KEY `idxConferenceID` (`conferenceID`),
  KEY `idxRemoteID` (`remoteID`),
  KEY `idxSiteID` (`siteID`),
  KEY `idxIdx` (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_forum`
--

/*!40000 ALTER TABLE `mf_forum` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_forum` ENABLE KEYS */;


--
-- Definition of table `mf_post`
--

DROP TABLE IF EXISTS `mf_post`;
CREATE TABLE `mf_post` (
  `postID` char(35) NOT NULL,
  `threadID` char(35) NOT NULL,
  `userID` char(35) NOT NULL,
  `adminID` char(35) DEFAULT NULL,
  `message` longtext NOT NULL,
  `isActive` tinyint(3) unsigned DEFAULT '0',
  `isDisabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isApproved` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isUserDisabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isModerated` tinyint(3) unsigned DEFAULT '0',
  `dateModerated` datetime DEFAULT NULL,
  `doBlockAttachment` tinyint(3) unsigned DEFAULT '0',
  `attachmentID` char(35) DEFAULT NULL,
  `postPosition` int(10) unsigned NOT NULL DEFAULT '0',
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  `idx` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentID` char(35) DEFAULT NULL,
  PRIMARY KEY (`postID`),
  KEY `idxUserID` (`userID`),
  KEY `idxThread` (`threadID`),
  KEY `idxRemoteID` (`remoteID`),
  KEY `idxDateCreate` (`dateCreate`),
  KEY `idxPostIdent` (`postPosition`),
  KEY `idxIdx` (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_post`
--

/*!40000 ALTER TABLE `mf_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_post` ENABLE KEYS */;


--
-- Definition of table `mf_searchable`
--

DROP TABLE IF EXISTS `mf_searchable`;
CREATE TABLE `mf_searchable` (
  `threadID` char(35) NOT NULL,
  `postID` char(35) NOT NULL,
  `searchblock` text NOT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`postID`) USING BTREE,
  KEY `idx_thread` (`threadID`,`postID`),
  KEY `idx_dateLastUpdate` (`dateLastUpdate`),
  FULLTEXT KEY `idxFullText` (`searchblock`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_searchable`
--

/*!40000 ALTER TABLE `mf_searchable` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_searchable` ENABLE KEYS */;


--
-- Definition of table `mf_settings`
--

DROP TABLE IF EXISTS `mf_settings`;
CREATE TABLE `mf_settings` (
  `settingsID` char(35) NOT NULL,
  `siteID` varchar(25) NOT NULL,
  `isMaster` tinyint(3) unsigned DEFAULT '0',
  `permissionGroups` varchar(255) DEFAULT 'RestrictAll',
  `themeID` char(35) DEFAULT NULL,
  `threadsPerPage` int(10) unsigned NOT NULL DEFAULT '20',
  `postsPerPage` int(10) unsigned NOT NULL DEFAULT '20',
  `subscriptionLimit` int(10) unsigned DEFAULT '100',
  `allowedExtensions` varchar(255) DEFAULT NULL,
  `deniedExtensions` varchar(255) DEFAULT NULL,
  `filesizeLimit` int(10) unsigned DEFAULT '100',
  `avatarID` char(35) DEFAULT NULL,
  `avatarResizeType` varchar(45) NOT NULL DEFAULT 'CropResize',
  `avatarQualityType` varchar(45) NOT NULL DEFAULT 'highQuality',
  `avatarAspectType` varchar(45) NOT NULL DEFAULT 'MaxAspectXY',
  `avatarCropType` varchar(45) NOT NULL DEFAULT 'BestXY',
  `userCacheSize` int(10) unsigned NOT NULL DEFAULT '250',
  `resetAvatar` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `doInit` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `activeWithinMinutes` int(10) unsigned NOT NULL DEFAULT '15',
  `searchMode` varchar(45) NOT NULL DEFAULT 'SIMPLE',
  `tempDir` char(35) NOT NULL,
  `baseTempDir` varchar(150) DEFAULT NULL,
  `URLKey` varchar(10) NOT NULL,
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`siteID`),
  KEY `siteID` (`siteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_settings`
--

/*!40000 ALTER TABLE `mf_settings` DISABLE KEYS */;
INSERT INTO `mf_settings` (`settingsID`,`siteID`,`isMaster`,`permissionGroups`,`themeID`,`threadsPerPage`,`postsPerPage`,`subscriptionLimit`,`allowedExtensions`,`deniedExtensions`,`filesizeLimit`,`avatarID`,`avatarResizeType`,`avatarQualityType`,`avatarAspectType`,`avatarCropType`,`userCacheSize`,`resetAvatar`,`doInit`,`activeWithinMinutes`,`searchMode`,`tempDir`,`baseTempDir`,`URLKey`,`remoteID`,`dateCreate`,`dateLastUpdate`) VALUES 
 ('00000000-0000-0000-0000000000000002','default',0,'RestrictAll','00000000-0000-0000-0000000000000001',10,9,100,'jpg,gif,png,jpeg,pdf,txt,doc,xls,zip','html,htm,php,php2,php3,php4,php5,phtml,pwml,inc,asp,aspx,ascx,jsp,cfm,cfml,cfc,pl,bat,exe,com,dll,vbs,js,reg,cgi,htaccess,asis,sh,shtml,shtm,phtm',250,NULL,'CROPRESIZE','highestQuality','MaxAspectXY','BestXY',250,0,0,15,'simple','3B7E866E-97D7-4919-BFEA4E8C2641147A',NULL,'mf/',NULL,'2011-03-29 15:28:33','2011-06-07 16:25:02');
/*!40000 ALTER TABLE `mf_settings` ENABLE KEYS */;


--
-- Definition of table `mf_subscribe`
--

DROP TABLE IF EXISTS `mf_subscribe`;
CREATE TABLE `mf_subscribe` (
  `subscribeID` char(35) NOT NULL,
  `conferenceID` char(35) DEFAULT NULL,
  `forumID` char(35) DEFAULT NULL,
  `threadID` char(35) DEFAULT NULL,
  `userID` char(35) NOT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  `isEmail` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`subscribeID`),
  KEY `idxConf` (`conferenceID`),
  KEY `idxForum` (`forumID`),
  KEY `idxThread` (`threadID`),
  KEY `idxUser` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_subscribe`
--

/*!40000 ALTER TABLE `mf_subscribe` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_subscribe` ENABLE KEYS */;


--
-- Definition of table `mf_theme`
--

DROP TABLE IF EXISTS `mf_theme`;
CREATE TABLE `mf_theme` (
  `themeID` char(35) NOT NULL,
  `name` varchar(35) NOT NULL,
  `packageName` varchar(25) NOT NULL,
  `avatarSmallWidth` int(10) unsigned NOT NULL DEFAULT '125',
  `avatarSmallHeight` int(10) unsigned NOT NULL DEFAULT '125',
  `avatarMediumWidth` int(10) unsigned NOT NULL DEFAULT '250',
  `avatarMediumHeight` int(10) unsigned NOT NULL DEFAULT '250',
  `avatarDimensionType` varchar(25) NOT NULL DEFAULT 'square',
  `settings` text,
  `defaultAvatar` varchar(80) DEFAULT NULL,
  `isMaster` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `style` varchar(12) DEFAULT NULL,
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`themeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_theme`
--

/*!40000 ALTER TABLE `mf_theme` DISABLE KEYS */;
INSERT INTO `mf_theme` (`themeID`,`name`,`packageName`,`avatarSmallWidth`,`avatarSmallHeight`,`avatarMediumWidth`,`avatarMediumHeight`,`avatarDimensionType`,`settings`,`defaultAvatar`,`isMaster`,`style`,`remoteID`,`dateCreate`,`dateLastUpdate`) VALUES 
 ('00000000-0000-0000-0000000000000001','Preen','preen',125,125,250,250,'square',NULL,NULL,1,'TABLE',NULL,'2011-03-29 15:28:33','2011-03-29 15:28:33');
/*!40000 ALTER TABLE `mf_theme` ENABLE KEYS */;


--
-- Definition of table `mf_thread`
--

DROP TABLE IF EXISTS `mf_thread`;
CREATE TABLE `mf_thread` (
  `threadID` char(35) NOT NULL,
  `forumID` char(35) NOT NULL,
  `typeID` int(10) unsigned NOT NULL DEFAULT '0',
  `siteID` varchar(25) NOT NULL,
  `isActive` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isClosed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isDisabled` tinyint(3) unsigned DEFAULT '0',
  `isUserDisabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isDraft` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `userID` char(35) NOT NULL,
  `adminID` char(35) DEFAULT NULL,
  `adminMessage` longtext,
  `title` varchar(150) NOT NULL,
  `friendlyName` varchar(200) DEFAULT NULL,
  `orderNo` int(10) unsigned NOT NULL DEFAULT '0',
  `postCounter` int(10) unsigned NOT NULL DEFAULT '0',
  `lastPostID` char(35) DEFAULT NULL,
  `dateLastPost` datetime DEFAULT NULL,
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  `idx` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isAnnouncement` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`threadID`),
  KEY `idxForumID` (`forumID`),
  KEY `idxUserID` (`userID`),
  KEY `idxAdminID` (`adminID`),
  KEY `idxSiteID` (`siteID`),
  KEY `idxRemoteID` (`remoteID`),
  KEY `idxIdx` (`idx`),
  KEY `idxDateLastPost` (`dateLastPost`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_thread`
--

/*!40000 ALTER TABLE `mf_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_thread` ENABLE KEYS */;


--
-- Definition of table `mf_user`
--

DROP TABLE IF EXISTS `mf_user`;
CREATE TABLE `mf_user` (
  `userID` char(35) NOT NULL,
  `siteID` char(35) DEFAULT NULL,
  `screenname` varchar(50) DEFAULT NULL,
  `avatarID` char(35) DEFAULT NULL,
  `redoAvatar` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `threadCounter` int(10) unsigned NOT NULL DEFAULT '0',
  `lastPostID` char(35) DEFAULT NULL,
  `lastThreadID` char(35) DEFAULT NULL,
  `adminMessage` text,
  `isConfirmed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isPrivate` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `isPostBlocked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isBlocked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `doShowOnline` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `doReplyNotifications` tinyint(3) unsigned DEFAULT '1',
  `postCounter` int(10) unsigned NOT NULL DEFAULT '0',
  `customValues` text,
  `dateLastAction` datetime DEFAULT NULL,
  `dateLastLogin` datetime DEFAULT NULL,
  `dateIsNewFrom` datetime DEFAULT NULL,
  `remoteID` varchar(35) DEFAULT NULL,
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `siteID` (`siteID`),
  KEY `remoteID` (`remoteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_user`
--

/*!40000 ALTER TABLE `mf_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_user` ENABLE KEYS */;


--
-- Definition of table `mf_viewcounter`
--

DROP TABLE IF EXISTS `mf_viewcounter`;
CREATE TABLE `mf_viewcounter` (
  `forumID` char(35) NOT NULL,
  `threadID` char(35) NOT NULL,
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `dateCreate` datetime NOT NULL,
  `dateLastUpdate` datetime NOT NULL,
  PRIMARY KEY (`forumID`,`threadID`),
  KEY `idxThread` (`threadID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mf_viewcounter`
--

/*!40000 ALTER TABLE `mf_viewcounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `mf_viewcounter` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
