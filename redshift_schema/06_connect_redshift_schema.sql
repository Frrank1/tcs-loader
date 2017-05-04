/****************************************************
Amazon Red Shift Schema for Connect Postgres Tables
****************************************************/
CREATE TABLE projects (
  id 				BIGINT 			NOT NULL,
  directProjectId 	BIGINT,
  billingAccountId 	BIGINT,
  name 				VARCHAR(255),
  external 			VARCHAR(65535),
  bookmarks 		VARCHAR(65535),
  utm 				VARCHAR(65535),
  estimatedPrice    numeric(10,2),
  actualPrice    	numeric(10,2),
  [type]			VARCHAR(255),
  status			VARCHAR(255),
  details 			VARCHAR(65535),
  description 		VARCHAR(65535),
  challengeEligibility 			VARCHAR(65535),
  cancelReason			VARCHAR(255),
  deletedAt			timestamp,
  createdAt			timestamp,
  updatedAt			timestamp,
  createdBy			BIGINT,
  updatedBy			BIGINT 
)

CREATE TABLE project_members (
  id BIGINT NOT NULL,
  role VARCHAR(255),
  userId BIGINT,
  isPrimary Boolean,
  deletedAt     timestamp,
  createdAt     timestamp,
  updatedAt     timestamp,
  createdBy     BIGINT,
  updatedBy     BIGINT 
)