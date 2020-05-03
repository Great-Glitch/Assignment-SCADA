
CREATE TABLE [ALARM]
( 
	[TagId]              integer  NOT NULL ,
	[AlarmId]            integer  NOT NULL ,
	[ActivationTime]     datetime  NOT NULL ,
	[AcknowledgeTime]    datetime  NULL ,
	[AcknowledgedBy]     integer  NULL 
)
go

CREATE TABLE [ALARMCONFIGURATION]
( 
	[TagId]              integer  NOT NULL ,
	[AlarmId]            integer  NOT NULL ,
	[AlarmLimit]         float  NULL ,
	[PriorityLevel]      char(20)  NULL 
)
go

CREATE TABLE [ALARMLIST]
( 
	[AlarmId]            integer  IDENTITY  NOT NULL ,
	[AlarmName]          char(50)  NULL ,
	[AlarmType]          char(50)  NULL ,
	[AlarmDescription]   char(100)  NULL 
)
go

CREATE TABLE [ALARMTYPE]
( 
	[AlarmType]          char(50)  NOT NULL 
)
go

CREATE TABLE [MEASUREMENT]
( 
	[TagId]              integer  NOT NULL ,
	[MeasurementTimestamp] datetime  NOT NULL ,
	[Measurement]        float  NULL ,
	[Quality]            char(18)  NULL ,
	[Status]             char(18)  NULL 
)
go

CREATE TABLE [MEASUREMENTSTATISTIC]
( 
	[TagId]              integer  NOT NULL ,
	[MeasurementTimestamp] datetime  NOT NULL ,
	[MeanVal]            float  NULL ,
	[MinVal]             float  NULL ,
	[MaxVal]             float  NULL 
)
go

CREATE TABLE [OPERATOR]
( 
	[OperatorId]         integer  IDENTITY  NOT NULL ,
	[FirstName]          char(40)  NULL ,
	[LastName]           char(40)  NULL ,
	[PhoneNr]            char(18)  NULL ,
	[Email]              char(50)  NULL ,
	[UserName]           char(50)  NULL 
)
go

CREATE TABLE [PRIORITYLIST]
( 
	[PriorityLevel]      char(20)  NOT NULL 
)
go

CREATE TABLE [TAG]
( 
	[TagId]              integer  IDENTITY  NOT NULL ,
	[TagName]            char(20)  NULL ,
	[MeasurementInterval] integer  NULL ,
	[TagUnit]            char(15)  NULL ,
	[ItemId]             char(50)  NULL ,
	[ItemUrl]            char(100)  NULL ,
	[TagDescription]     char(100)  NULL 
)
go

CREATE TABLE [UNIT]
( 
	[TagUnit]            char(15)  NOT NULL 
)
go


ALTER TABLE [ALARM]
	ADD CONSTRAINT [XPKALARM] PRIMARY KEY  CLUSTERED ([TagId] ASC,[AlarmId] ASC,[ActivationTime] ASC)
go

ALTER TABLE [ALARMCONFIGURATION]
	ADD CONSTRAINT [XPKTAG_ALARMLIST] PRIMARY KEY  CLUSTERED ([TagId] ASC,[AlarmId] ASC)
go

ALTER TABLE [ALARMLIST]
	ADD CONSTRAINT [XPKALARMLIST] PRIMARY KEY  CLUSTERED ([AlarmId] ASC)
go

ALTER TABLE [ALARMTYPE]
	ADD CONSTRAINT [XPKALARMTYPE] PRIMARY KEY  CLUSTERED ([AlarmType] ASC)
go

ALTER TABLE [MEASUREMENT]
	ADD CONSTRAINT [XPKMEASUREMENT] PRIMARY KEY  CLUSTERED ([TagId] ASC,[MeasurementTimestamp] ASC)
go

ALTER TABLE [MEASUREMENTSTATISTIC]
	ADD CONSTRAINT [XPKSTATISTIC] PRIMARY KEY  CLUSTERED ([TagId] ASC,[MeasurementTimestamp] ASC)
go

ALTER TABLE [OPERATOR]
	ADD CONSTRAINT [XPKUSER] PRIMARY KEY  CLUSTERED ([OperatorId] ASC)
go

ALTER TABLE [PRIORITYLIST]
	ADD CONSTRAINT [XPKPriority] PRIMARY KEY  CLUSTERED ([PriorityLevel] ASC)
go

ALTER TABLE [TAG]
	ADD CONSTRAINT [XPKTAG] PRIMARY KEY  CLUSTERED ([TagId] ASC)
go

ALTER TABLE [UNIT]
	ADD CONSTRAINT [XPKUNIT] PRIMARY KEY  CLUSTERED ([TagUnit] ASC)
go

ALTER TABLE [UNIT]
	ADD CONSTRAINT [XPKUNIT] PRIMARY KEY  CLUSTERED ([TagUnit] ASC)
go

CREATE VIEW [viewAlarmList]([AlarmName],[AlarmType],[AlarmId],[AlarmDescription],[TagName],[AlarmLimit],[ActivationTime])
AS
SELECT [ALARMLIST].[AlarmName],[ALARMLIST].[AlarmType],[ALARMLIST].[AlarmId],[ALARMLIST].[AlarmDescription],[TAG].[TagName],[ALARMCONFIGURATION].[AlarmLimit],[ALARM].[ActivationTime]
	FROM [ALARMLIST],[TAG],[ALARMCONFIGURATION],[ALARM]
		WHERE ALARM.TagId = ALARMCONFIGURATION.TagId and
ALARM.AlarmId = ALARMCONFIGURATION.AlarmId
go


ALTER TABLE [ALARM]
	ADD CONSTRAINT [R_9] FOREIGN KEY ([TagId],[AlarmId]) REFERENCES [ALARMCONFIGURATION]([TagId],[AlarmId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ALARM]
	ADD CONSTRAINT [R_11] FOREIGN KEY ([AcknowledgedBy]) REFERENCES [OPERATOR]([OperatorId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ALARMCONFIGURATION]
	ADD CONSTRAINT [R_7] FOREIGN KEY ([TagId]) REFERENCES [TAG]([TagId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ALARMCONFIGURATION]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([AlarmId]) REFERENCES [ALARMLIST]([AlarmId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ALARMCONFIGURATION]
	ADD CONSTRAINT [R_17] FOREIGN KEY ([PriorityLevel]) REFERENCES [PRIORITYLIST]([PriorityLevel])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ALARMLIST]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([AlarmType]) REFERENCES [ALARMTYPE]([AlarmType])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [MEASUREMENT]
	ADD CONSTRAINT [R_4] FOREIGN KEY ([TagId]) REFERENCES [TAG]([TagId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [MEASUREMENTSTATISTIC]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([TagId]) REFERENCES [TAG]([TagId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [TAG]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([TagUnit]) REFERENCES [UNIT]([TagUnit])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

CREATE PROCEDURE [AcknowledgeAlarm]   
   
 AS 
go
