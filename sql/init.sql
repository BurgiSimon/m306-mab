-- Database initialization script for MAB project
-- Creates minimal tables if not already present.

CREATE TABLE IF NOT EXISTS tMABStatus (
    idMABStatus INT PRIMARY KEY AUTO_INCREMENT,
    MABStatusName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tRatingScale (
    idRatingScale INT PRIMARY KEY AUTO_INCREMENT,
    RatingScaleName VARCHAR(50) NOT NULL,
    SortOrder INT
);

CREATE TABLE IF NOT EXISTS tRating (
    idRating INT PRIMARY KEY AUTO_INCREMENT,
    tRatingScaleId INT,
    RatingName VARCHAR(50),
    Points INT,
    SortOrder INT,
    FOREIGN KEY (tRatingScaleId) REFERENCES tRatingScale(idRatingScale)
);

CREATE TABLE IF NOT EXISTS tCompetence (
    idCompetence INT PRIMARY KEY AUTO_INCREMENT,
    tRatingScaleId INT NOT NULL,
    CompetenceName VARCHAR(50) NOT NULL,
    CompetenceActive BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (tRatingScaleId) REFERENCES tRatingScale(idRatingScale)
);

CREATE TABLE IF NOT EXISTS tMAB (
    idMAB INT PRIMARY KEY AUTO_INCREMENT,
    tMABStatusId INT NOT NULL,
    AssessmentFrom DATE NOT NULL,
    AssessmentTo DATE NOT NULL,
    CommentText VARCHAR(1000),
    IsOnlineApproval BIT NOT NULL DEFAULT 0,
    CreateDate DATETIME NOT NULL,
    AppraiseeComment VARCHAR(1000),
    SupervisorComment VARCHAR(1000),
    HRComment VARCHAR(1000),
    FOREIGN KEY (tMABStatusId) REFERENCES tMABStatus(idMABStatus)
);

CREATE TABLE IF NOT EXISTS tRole (
    idRole INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tMABRole (
    idMABRole INT PRIMARY KEY AUTO_INCREMENT,
    tMABId INT NOT NULL,
    tRoleId INT NOT NULL,
    EmpNum INT,
    Login VARCHAR(50),
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Mail VARCHAR(100),
    HasApproved BIT NOT NULL DEFAULT 0,
    ApprovedDate DATE,
    FOREIGN KEY (tMABId) REFERENCES tMAB(idMAB),
    FOREIGN KEY (tRoleId) REFERENCES tRole(idRole)
);

CREATE TABLE IF NOT EXISTS tMABCompetence (
    idMABCompetence INT PRIMARY KEY AUTO_INCREMENT,
    tMABId INT NOT NULL,
    tCompetenceId INT NOT NULL,
    tRatingId INT,
    DescriptionText VARCHAR(1500),
    AssessmentText VARCHAR(500),
    FOREIGN KEY (tMABId) REFERENCES tMAB(idMAB),
    FOREIGN KEY (tCompetenceId) REFERENCES tCompetence(idCompetence),
    FOREIGN KEY (tRatingId) REFERENCES tRating(idRating)
);

-- Insert default status values
INSERT INTO tMABStatus (idMABStatus, MABStatusName) VALUES
    (1, 'Bewertung Vorgesetzter'),
    (2, 'Freigabe Supervisor'),
    (3, 'MA-Gespräch'),
    (4, 'MAB Signieren'),
    (5, 'MAB abgeschlossen')
ON DUPLICATE KEY UPDATE MABStatusName=VALUES(MABStatusName);

