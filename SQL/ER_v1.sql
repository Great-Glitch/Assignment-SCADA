
CREATE TABLE [ALARM]
( 
	[TagId]              integer  NOT NULL ,
	[AlarmId]            char(18)  NOT NULL ,
	[ActivationTime]     char(18)  NULL ,
	[AcknowledgeTime]    char(18)  NULL ,
	[AcknowledgedBy]     char(18)  NULL 
)
go

CREATE TABLE [ALARMCONFIGURATION]
( 
	[TagId]              integer  NOT NULL ,
	[AlarmId]            char(18)  NOT NULL ,
	[AlarmLimit]         char(18)  NULL 
)
go

CREATE TABLE [ALARMLIST]
( 
	[AlarmId]            char(18)  NOT NULL ,
	[AlarmName]          char(18)  NULL ,
	[AlarmType]          char(18)  NULL ,
	[AlarmDescription]   char(18)  NULL 
)
go

CREATE TABLE [ALARMTYPE]
( 
	[AlarmType]          char(18)  NOT NULL 
)
go

CREATE TABLE [MEASUREMENT]
( 
	[TagId]              integer  NOT NULL ,
	[MeasurementTimestamp] datetime  NOT NULL ,
	[Measurement]        float  NULL 
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

CREATE TABLE [TAG]
( 
	[TagId]              integer  NOT NULL ,
	[TagName]            char(15)  NULL ,
	[MeasurementInterval] integer  NULL ,
	[TagUnit]            char(15)  NULL ,
	[ItemId]             char(18)  NULL ,
	[ItemUrl]            char(18)  NULL 
)
go

CREATE TABLE [UNIT]
( 
	[TagUnit]            char(15)  NOT NULL 
)
go

CREATE TABLE [UNIT]
( 
	[TagUnit]            char(15)  NOT NULL 
)
go

CREATE TABLE [USER]
( 
	[UserId]             char(18)  NOT NULL ,
	[FirstName]          char(18)  NULL ,
	[LastName]           char(18)  NULL ,
	[PhoneNr]            char(18)  NULL ,
	[Email]              char(18)  NULL ,
	[UserName]           char(18)  NULL 
)
go

ALTER TABLE [ALARM]
	ADD CONSTRAINT [XPKALARM] PRIMARY KEY  CLUSTERED ([TagId] ASC,[AlarmId] ASC)
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

ALTER TABLE [TAG]
	ADD CONSTRAINT [XPKTAG] PRIMARY KEY  CLUSTERED ([TagId] ASC)
go

ALTER TABLE [UNIT]
	ADD CONSTRAINT [XPKUNIT] PRIMARY KEY  CLUSTERED ([TagUnit] ASC)
go

ALTER TABLE [UNIT]
	ADD CONSTRAINT [XPKUNIT] PRIMARY KEY  CLUSTERED ([TagUnit] ASC)
go

ALTER TABLE [USER]
	ADD CONSTRAINT [XPKUSER] PRIMARY KEY  CLUSTERED ([UserId] ASC)
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
	ADD CONSTRAINT [R_11] FOREIGN KEY ([AcknowledgedBy]) REFERENCES [USER]([UserId])
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


CREATE TRIGGER tD_ALARM ON ALARM FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ALARM */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* USER  ALARM on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00029d4f", PARENT_OWNER="", PARENT_TABLE="USER"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="AcknowledgedBy" */
    IF EXISTS (SELECT * FROM deleted,USER
      WHERE
        /* %JoinFKPK(deleted,USER," = "," AND") */
        deleted.AcknowledgedBy = USER.UserId AND
        NOT EXISTS (
          SELECT * FROM ALARM
          WHERE
            /* %JoinFKPK(ALARM,USER," = "," AND") */
            ALARM.AcknowledgedBy = USER.UserId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ALARM because USER exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ALARMCONFIGURATION  ALARM on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ALARMCONFIGURATION"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="TagId""AlarmId" */
    IF EXISTS (SELECT * FROM deleted,ALARMCONFIGURATION
      WHERE
        /* %JoinFKPK(deleted,ALARMCONFIGURATION," = "," AND") */
        deleted.TagId = ALARMCONFIGURATION.TagId AND
        deleted.AlarmId = ALARMCONFIGURATION.AlarmId AND
        NOT EXISTS (
          SELECT * FROM ALARM
          WHERE
            /* %JoinFKPK(ALARM,ALARMCONFIGURATION," = "," AND") */
            ALARM.TagId = ALARMCONFIGURATION.TagId AND
            ALARM.AlarmId = ALARMCONFIGURATION.AlarmId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ALARM because ALARMCONFIGURATION exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ALARM ON ALARM FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ALARM */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTagId integer, 
           @insAlarmId char(18),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* USER  ALARM on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000306c1", PARENT_OWNER="", PARENT_TABLE="USER"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="AcknowledgedBy" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(AcknowledgedBy)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,USER
        WHERE
          /* %JoinFKPK(inserted,USER) */
          inserted.AcknowledgedBy = USER.UserId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.AcknowledgedBy IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ALARM because USER does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ALARMCONFIGURATION  ALARM on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ALARMCONFIGURATION"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="TagId""AlarmId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TagId) OR
    UPDATE(AlarmId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,ALARMCONFIGURATION
        WHERE
          /* %JoinFKPK(inserted,ALARMCONFIGURATION) */
          inserted.TagId = ALARMCONFIGURATION.TagId and
          inserted.AlarmId = ALARMCONFIGURATION.AlarmId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ALARM because ALARMCONFIGURATION does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ALARMCONFIGURATION ON ALARMCONFIGURATION FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ALARMCONFIGURATION */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ALARMCONFIGURATION  ALARM on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000382a9", PARENT_OWNER="", PARENT_TABLE="ALARMCONFIGURATION"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="TagId""AlarmId" */
    IF EXISTS (
      SELECT * FROM deleted,ALARM
      WHERE
        /*  %JoinFKPK(ALARM,deleted," = "," AND") */
        ALARM.TagId = deleted.TagId AND
        ALARM.AlarmId = deleted.AlarmId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ALARMCONFIGURATION because ALARM exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ALARMLIST  ALARMCONFIGURATION on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ALARMLIST"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="AlarmId" */
    IF EXISTS (SELECT * FROM deleted,ALARMLIST
      WHERE
        /* %JoinFKPK(deleted,ALARMLIST," = "," AND") */
        deleted.AlarmId = ALARMLIST.AlarmId AND
        NOT EXISTS (
          SELECT * FROM ALARMCONFIGURATION
          WHERE
            /* %JoinFKPK(ALARMCONFIGURATION,ALARMLIST," = "," AND") */
            ALARMCONFIGURATION.AlarmId = ALARMLIST.AlarmId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ALARMCONFIGURATION because ALARMLIST exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* TAG  ALARMCONFIGURATION on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="TagId" */
    IF EXISTS (SELECT * FROM deleted,TAG
      WHERE
        /* %JoinFKPK(deleted,TAG," = "," AND") */
        deleted.TagId = TAG.TagId AND
        NOT EXISTS (
          SELECT * FROM ALARMCONFIGURATION
          WHERE
            /* %JoinFKPK(ALARMCONFIGURATION,TAG," = "," AND") */
            ALARMCONFIGURATION.TagId = TAG.TagId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ALARMCONFIGURATION because TAG exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ALARMCONFIGURATION ON ALARMCONFIGURATION FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ALARMCONFIGURATION */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTagId integer, 
           @insAlarmId char(18),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ALARMCONFIGURATION  ALARM on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003c491", PARENT_OWNER="", PARENT_TABLE="ALARMCONFIGURATION"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="TagId""AlarmId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TagId) OR
    UPDATE(AlarmId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ALARM
      WHERE
        /*  %JoinFKPK(ALARM,deleted," = "," AND") */
        ALARM.TagId = deleted.TagId AND
        ALARM.AlarmId = deleted.AlarmId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ALARMCONFIGURATION because ALARM exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ALARMLIST  ALARMCONFIGURATION on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ALARMLIST"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="AlarmId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(AlarmId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,ALARMLIST
        WHERE
          /* %JoinFKPK(inserted,ALARMLIST) */
          inserted.AlarmId = ALARMLIST.AlarmId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ALARMCONFIGURATION because ALARMLIST does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* TAG  ALARMCONFIGURATION on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="TagId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TagId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,TAG
        WHERE
          /* %JoinFKPK(inserted,TAG) */
          inserted.TagId = TAG.TagId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ALARMCONFIGURATION because TAG does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ALARMLIST ON ALARMLIST FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ALARMLIST */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ALARMLIST  ALARMCONFIGURATION on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024d40", PARENT_OWNER="", PARENT_TABLE="ALARMLIST"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="AlarmId" */
    IF EXISTS (
      SELECT * FROM deleted,ALARMCONFIGURATION
      WHERE
        /*  %JoinFKPK(ALARMCONFIGURATION,deleted," = "," AND") */
        ALARMCONFIGURATION.AlarmId = deleted.AlarmId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ALARMLIST because ALARMCONFIGURATION exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* ALARMTYPE  ALARMLIST on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ALARMTYPE"
    CHILD_OWNER="", CHILD_TABLE="ALARMLIST"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="AlarmType" */
    IF EXISTS (SELECT * FROM deleted,ALARMTYPE
      WHERE
        /* %JoinFKPK(deleted,ALARMTYPE," = "," AND") */
        deleted.AlarmType = ALARMTYPE.AlarmType AND
        NOT EXISTS (
          SELECT * FROM ALARMLIST
          WHERE
            /* %JoinFKPK(ALARMLIST,ALARMTYPE," = "," AND") */
            ALARMLIST.AlarmType = ALARMTYPE.AlarmType
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ALARMLIST because ALARMTYPE exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ALARMLIST ON ALARMLIST FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ALARMLIST */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAlarmId char(18),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ALARMLIST  ALARMCONFIGURATION on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002ba04", PARENT_OWNER="", PARENT_TABLE="ALARMLIST"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="AlarmId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(AlarmId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ALARMCONFIGURATION
      WHERE
        /*  %JoinFKPK(ALARMCONFIGURATION,deleted," = "," AND") */
        ALARMCONFIGURATION.AlarmId = deleted.AlarmId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ALARMLIST because ALARMCONFIGURATION exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ALARMTYPE  ALARMLIST on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ALARMTYPE"
    CHILD_OWNER="", CHILD_TABLE="ALARMLIST"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="AlarmType" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(AlarmType)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,ALARMTYPE
        WHERE
          /* %JoinFKPK(inserted,ALARMTYPE) */
          inserted.AlarmType = ALARMTYPE.AlarmType
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.AlarmType IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ALARMLIST because ALARMTYPE does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ALARMTYPE ON ALARMTYPE FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ALARMTYPE */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ALARMTYPE  ALARMLIST on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000113bd", PARENT_OWNER="", PARENT_TABLE="ALARMTYPE"
    CHILD_OWNER="", CHILD_TABLE="ALARMLIST"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="AlarmType" */
    IF EXISTS (
      SELECT * FROM deleted,ALARMLIST
      WHERE
        /*  %JoinFKPK(ALARMLIST,deleted," = "," AND") */
        ALARMLIST.AlarmType = deleted.AlarmType
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ALARMTYPE because ALARMLIST exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ALARMTYPE ON ALARMTYPE FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ALARMTYPE */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAlarmType char(18),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ALARMTYPE  ALARMLIST on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001324c", PARENT_OWNER="", PARENT_TABLE="ALARMTYPE"
    CHILD_OWNER="", CHILD_TABLE="ALARMLIST"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="AlarmType" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(AlarmType)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ALARMLIST
      WHERE
        /*  %JoinFKPK(ALARMLIST,deleted," = "," AND") */
        ALARMLIST.AlarmType = deleted.AlarmType
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ALARMTYPE because ALARMLIST exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_MEASUREMENT ON MEASUREMENT FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on MEASUREMENT */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* TAG  MEASUREMENT on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001380d", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="TagId" */
    IF EXISTS (SELECT * FROM deleted,TAG
      WHERE
        /* %JoinFKPK(deleted,TAG," = "," AND") */
        deleted.TagId = TAG.TagId AND
        NOT EXISTS (
          SELECT * FROM MEASUREMENT
          WHERE
            /* %JoinFKPK(MEASUREMENT,TAG," = "," AND") */
            MEASUREMENT.TagId = TAG.TagId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last MEASUREMENT because TAG exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_MEASUREMENT ON MEASUREMENT FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on MEASUREMENT */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTagId integer, 
           @insMeasurementTimestamp datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* TAG  MEASUREMENT on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015225", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="TagId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TagId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,TAG
        WHERE
          /* %JoinFKPK(inserted,TAG) */
          inserted.TagId = TAG.TagId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update MEASUREMENT because TAG does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_MEASUREMENTSTATISTIC ON MEASUREMENTSTATISTIC FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on MEASUREMENTSTATISTIC */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* TAG  MEASUREMENTSTATISTIC on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00014f0e", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENTSTATISTIC"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="TagId" */
    IF EXISTS (SELECT * FROM deleted,TAG
      WHERE
        /* %JoinFKPK(deleted,TAG," = "," AND") */
        deleted.TagId = TAG.TagId AND
        NOT EXISTS (
          SELECT * FROM MEASUREMENTSTATISTIC
          WHERE
            /* %JoinFKPK(MEASUREMENTSTATISTIC,TAG," = "," AND") */
            MEASUREMENTSTATISTIC.TagId = TAG.TagId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last MEASUREMENTSTATISTIC because TAG exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_MEASUREMENTSTATISTIC ON MEASUREMENTSTATISTIC FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on MEASUREMENTSTATISTIC */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTagId integer, 
           @insMeasurementTimestamp datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* TAG  MEASUREMENTSTATISTIC on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00016e53", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENTSTATISTIC"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="TagId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TagId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,TAG
        WHERE
          /* %JoinFKPK(inserted,TAG) */
          inserted.TagId = TAG.TagId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update MEASUREMENTSTATISTIC because TAG does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_TAG ON TAG FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on TAG */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* TAG  ALARMCONFIGURATION on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00040c9c", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="TagId" */
    IF EXISTS (
      SELECT * FROM deleted,ALARMCONFIGURATION
      WHERE
        /*  %JoinFKPK(ALARMCONFIGURATION,deleted," = "," AND") */
        ALARMCONFIGURATION.TagId = deleted.TagId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete TAG because ALARMCONFIGURATION exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* TAG  MEASUREMENTSTATISTIC on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENTSTATISTIC"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="TagId" */
    IF EXISTS (
      SELECT * FROM deleted,MEASUREMENTSTATISTIC
      WHERE
        /*  %JoinFKPK(MEASUREMENTSTATISTIC,deleted," = "," AND") */
        MEASUREMENTSTATISTIC.TagId = deleted.TagId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete TAG because MEASUREMENTSTATISTIC exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* TAG  MEASUREMENT on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="TagId" */
    IF EXISTS (
      SELECT * FROM deleted,MEASUREMENT
      WHERE
        /*  %JoinFKPK(MEASUREMENT,deleted," = "," AND") */
        MEASUREMENT.TagId = deleted.TagId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete TAG because MEASUREMENT exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* UNIT  TAG on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="UNIT"
    CHILD_OWNER="", CHILD_TABLE="TAG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="TagUnit" */
    IF EXISTS (SELECT * FROM deleted,UNIT
      WHERE
        /* %JoinFKPK(deleted,UNIT," = "," AND") */
        deleted.TagUnit = UNIT.TagUnit AND
        NOT EXISTS (
          SELECT * FROM TAG
          WHERE
            /* %JoinFKPK(TAG,UNIT," = "," AND") */
            TAG.TagUnit = UNIT.TagUnit
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last TAG because UNIT exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_TAG ON TAG FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on TAG */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTagId integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* TAG  ALARMCONFIGURATION on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004a0b8", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="ALARMCONFIGURATION"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="TagId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TagId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ALARMCONFIGURATION
      WHERE
        /*  %JoinFKPK(ALARMCONFIGURATION,deleted," = "," AND") */
        ALARMCONFIGURATION.TagId = deleted.TagId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update TAG because ALARMCONFIGURATION exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* TAG  MEASUREMENTSTATISTIC on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENTSTATISTIC"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="TagId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TagId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,MEASUREMENTSTATISTIC
      WHERE
        /*  %JoinFKPK(MEASUREMENTSTATISTIC,deleted," = "," AND") */
        MEASUREMENTSTATISTIC.TagId = deleted.TagId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update TAG because MEASUREMENTSTATISTIC exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* TAG  MEASUREMENT on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="TAG"
    CHILD_OWNER="", CHILD_TABLE="MEASUREMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="TagId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TagId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,MEASUREMENT
      WHERE
        /*  %JoinFKPK(MEASUREMENT,deleted," = "," AND") */
        MEASUREMENT.TagId = deleted.TagId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update TAG because MEASUREMENT exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* UNIT  TAG on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="UNIT"
    CHILD_OWNER="", CHILD_TABLE="TAG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="TagUnit" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TagUnit)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,UNIT
        WHERE
          /* %JoinFKPK(inserted,UNIT) */
          inserted.TagUnit = UNIT.TagUnit
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.TagUnit IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update TAG because UNIT does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_UNIT ON UNIT FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on UNIT */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* UNIT  TAG on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f1be", PARENT_OWNER="", PARENT_TABLE="UNIT"
    CHILD_OWNER="", CHILD_TABLE="TAG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="TagUnit" */
    IF EXISTS (
      SELECT * FROM deleted,TAG
      WHERE
        /*  %JoinFKPK(TAG,deleted," = "," AND") */
        TAG.TagUnit = deleted.TagUnit
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete UNIT because TAG exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_UNIT ON UNIT FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on UNIT */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTagUnit char(15),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* UNIT  TAG on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00011233", PARENT_OWNER="", PARENT_TABLE="UNIT"
    CHILD_OWNER="", CHILD_TABLE="TAG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="TagUnit" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TagUnit)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,TAG
      WHERE
        /*  %JoinFKPK(TAG,deleted," = "," AND") */
        TAG.TagUnit = deleted.TagUnit
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update UNIT because TAG exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_USER ON USER FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on USER */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* USER  ALARM on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010139", PARENT_OWNER="", PARENT_TABLE="USER"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="AcknowledgedBy" */
    IF EXISTS (
      SELECT * FROM deleted,ALARM
      WHERE
        /*  %JoinFKPK(ALARM,deleted," = "," AND") */
        ALARM.AcknowledgedBy = deleted.UserId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete USER because ALARM exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_USER ON USER FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on USER */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insUserId char(18),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* USER  ALARM on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000119ff", PARENT_OWNER="", PARENT_TABLE="USER"
    CHILD_OWNER="", CHILD_TABLE="ALARM"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="AcknowledgedBy" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UserId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ALARM
      WHERE
        /*  %JoinFKPK(ALARM,deleted," = "," AND") */
        ALARM.AcknowledgedBy = deleted.UserId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update USER because ALARM exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


