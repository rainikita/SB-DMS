CREATE SCHEMA IF NOT EXISTS dmsr

------ENUMS------
CREATE TYPE dmsr.vevt AS ENUM (
  'VPA_GENERATED',
  'VPA_DEACTIVATED'
);

CREATE TYPE dmsr.mfevts AS ENUM (
  'MF_ONBOARDED',
  'MF_DEACTIVATED'
);

CREATE TYPE dmsr.devts AS ENUM (
  'DEVICE_ONBOARDED',
  'DEVICE_DEACTIVATED'
);

CREATE TYPE dmsr.mevts AS ENUM (
  'MERCHANT_ONBOARDED',
  'MERCHANT_DEACTIVATED'
);

CREATE TYPE dmsr.bevts AS ENUM (
  'BANK_ONBOARDED',
  'BANK_DEACTIVATED'
);

CREATE TYPE dmsr.brevts AS ENUM (
  'BRANCH_ONBOARDED',
  'BRANCH_DEACTIVATED'
);

CREATE TYPE dmsr.frevts AS ENUM (
  'FIRMWARE_CREATED',
  'FIRMWARE_DELETED'
);

CREATE TYPE dmsr.mdevts AS ENUM (
 'MODEL_CREATED',
  'MODEL_DELETED'
);

CREATE TYPE dmsr.sbevts AS ENUM (
  'VPA_DEVICE_BOUND',
  'VPA_DEVICE_UNBOUND',
  'ALLOCATED_TO_MERCHANT',
  'REALLOCATED_TO_MERCHANT',
  'ALLOCATED_TO_BRANCH',
  'REALLOCATED_TO_BRANCH',
  'ALLOCATED_TO_BANK',
  'REALLOCATED_TO_BANK',
  'DELIVERY_INITIATED',
  'DELIVERY_ACKNOWLEDGED',
  'DEVICE_RETURNED',
  'ISSUE_REPORTED'
);

CREATE TYPE dmsr.tevts AS ENUM (
  'CREATED',
  'UPDATED',
  'DELETED'
);


---------------Table--------------

CREATE TABLE IF NOT EXISTS dmsr.banks (
  bid SERIAL PRIMARY KEY,
  bcode VARCHAR,
  bname VARCHAR,
  bevt dmsr.bevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL
  );

CREATE TABLE IF NOT EXISTS dmsr.vpa (
  vid SERIAL PRIMARY KEY,
  vpa VARCHAR UNIQUE NOT NULL,
  bid INTEGER,
  vevt dmsr.vevt,
  eid INTEGER,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  FOREIGN KEY ("bid") REFERENCES dmsr.banks ("bid")
);

CREATE TABLE IF NOT EXISTS dmsr.mf(
  mfid SERIAL PRIMARY KEY,
  mfname VARCHAR UNIQUE,
  mfevt dmsr.mfevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL
	);


CREATE TABLE IF NOT EXISTS dmsr.firmware (
  fid SERIAL PRIMARY KEY,
  mfid INTEGER,
  fdesc JSON,
  frevt dmsr.frevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid")
);

CREATE TABLE IF NOT EXISTS dmsr.model (
  mdid SERIAL PRIMARY KEY,
  mfid INTEGER,
  fid INTEGER,
  eid INTEGER NOT NULL,
  mdesc VARCHAR,
  mevt dmsr.mdevts,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid"),
  FOREIGN KEY ("fid") REFERENCES dmsr.firmware ("fid")
);

CREATE TABLE IF NOT EXISTS dmsr.devices (
  did SERIAL PRIMARY KEY,
  dname VARCHAR UNIQUE NOT NULL,
  mfid INTEGER,
  fid INTEGER,
  mdid INTEGER,
  devt dmsr.devts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid"),
  FOREIGN KEY ("fid") REFERENCES dmsr.firmware ("fid"),
  FOREIGN KEY ("mdid") REFERENCES dmsr.model ("mdid")
);


CREATE TABLE IF NOT EXISTS dmsr.branches (
  brid SERIAL PRIMARY KEY,
  brname VARCHAR,
  braddr VARCHAR,
  bid INTEGER,
  brevt dmsr.brevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  FOREIGN KEY ("bid") REFERENCES dmsr.banks ("bid"),
  UNIQUE (bid, brid) 
);

CREATE TABLE IF NOT EXISTS dmsr.merchants (
  mpid SERIAL PRIMARY KEY,
  mid INTEGER NOT NULL,
  msid INTEGER,
  mname VARCHAR,
  minfo JSON,
  mevt dmsr.mevts,
  eid INTEGER NOT NULL,
  brid INTEGER,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  FOREIGN KEY ("brid") REFERENCES dmsr.branches ("brid")
);



CREATE TABLE IF NOT EXISTS dmsr.sb (
  sid SERIAL PRIMARY KEY,
  vid INTEGER,
  mid INTEGER,
  did INTEGER,
  bid INTEGER,
  brid INTEGER,
  sbevt dmsr.sbevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  UNIQUE (vid, did, bid, brid, mid),
  FOREIGN KEY ("vid") REFERENCES dmsr.vpa ("vid"),
  FOREIGN KEY ("mid") REFERENCES dmsr.merchants ("mpid"),
  FOREIGN KEY ("did") REFERENCES dmsr.devices ("did"),
  FOREIGN KEY ("bid") REFERENCES dmsr.banks ("bid"),
  FOREIGN KEY ("bid", "brid") REFERENCES dmsr.branches ("bid", "brid")
);


-----------Version Table-----------



CREATE TABLE IF NOT EXISTS dmsr.banks_v (
  bid INTEGER,
  bcode VARCHAR,
  bname VARCHAR,
  bevt dmsr.bevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("bid") REFERENCES dmsr.banks ("bid")
);

	

CREATE TABLE IF NOT EXISTS dmsr.vpa_v (
  vid INTEGER,
  vpa VARCHAR NOT NULL,
  vevt dmsr.vevt,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("vid") REFERENCES dmsr.vpa ("vid")
);



CREATE TABLE IF NOT EXISTS dmsr.mf_v(
  mfid SERIAL PRIMARY KEY,
  mfname VARCHAR,
  mfevt dmsr.mfevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid")
);

CREATE TABLE IF NOT EXISTS dmsr.firmware_v (
  fid SERIAL PRIMARY KEY,
  mfid INTEGER,
  fdesc JSON,
  frevt dmsr.frevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("fid") REFERENCES dmsr.firmware ("fid"),
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid")
);

CREATE TABLE IF NOT EXISTS dmsr.model_v (
  mdid SERIAL PRIMARY KEY,
  mfid INTEGER,
  fid INTEGER,
  mdevt dmsr.mdevts,
  eid INTEGER NOT NULL,
  mdesc VARCHAR,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("mdid") REFERENCES dmsr.model ("mdid"),
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid"),
  FOREIGN KEY ("fid") REFERENCES dmsr.firmware ("fid")
);

CREATE TABLE IF NOT EXISTS dmsr.devices_v (
  did INTEGER PRIMARY KEY,
  dname VARCHAR UNIQUE NOT NULL,
  mfid INTEGER,
  fid INTEGER,
  mdid INTEGER,
  devt dmsr.devts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false ,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("did") REFERENCES dmsr.devices ("did"),
  FOREIGN KEY ("mfid") REFERENCES dmsr.mf ("mfid"),
  FOREIGN KEY ("fid") REFERENCES dmsr.firmware ("fid"),
  FOREIGN KEY ("mdid") REFERENCES dmsr.model ("mdid")
);


CREATE TABLE IF NOT EXISTS dmsr.branches_v (
  brid INTEGER,
  brname VARCHAR,
  braddr VARCHAR,
  bid INTEGER,
  brevt dmsr.brevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("brid") REFERENCES dmsr.branches ("brid"),
  FOREIGN KEY ("bid") REFERENCES dmsr.banks ("bid")
);



CREATE TABLE IF NOT EXISTS dmsr.merchants_v (
  mpid INTEGER,
  mid INTEGER NOT NULL,
  msid INTEGER,
  mname VARCHAR,
  minfo JSON,
  mevt dmsr.mevts,
  eid INTEGER NOT NULL,
  brid INTEGER,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("mpid") REFERENCES dmsr.merchants ("mpid"),
  FOREIGN KEY ("brid") REFERENCES dmsr.branches ("brid")
);




CREATE TABLE IF NOT EXISTS dmsr.sb_v (
  sid INTEGER PRIMARY KEY,
  vid INTEGER,
  mid INTEGER,
  did INTEGER,
  bid INTEGER,
  brid INTEGER,
  sbevt dmsr.sbevts,
  eid INTEGER NOT NULL,
  eat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isd BOOLEAN DEFAULT false,
  eby INTEGER NOT NULL,
  op dmsr.tevts,
  FOREIGN KEY ("sid") REFERENCES dmsr.sb ("sid"),
  FOREIGN KEY ("vid") REFERENCES dmsr.vpa ("vid"),
  FOREIGN KEY ("mid") REFERENCES dmsr.merchants ("mpid"),
  FOREIGN KEY ("did") REFERENCES dmsr.devices ("did"),
  FOREIGN KEY ("bid") REFERENCES dmsr.banks ("bid"),
  FOREIGN KEY ("brid") REFERENCES dmsr.branches ("brid")
);


---------------Indexes-------------

CREATE INDEX IF NOT EXISTS idx_vpa_vid_vpa ON dmsr.vpa (vid, vpa);
CREATE INDEX IF NOT EXISTS idx_vpa_v_vid_vpa ON dmsr.vpa_v (vid, vpa);
CREATE INDEX IF NOT EXISTS idx_mf_mfid_mfname ON dmsr.mf (mfid, mfname);
CREATE INDEX IF NOT EXISTS idx_mf_v_mfid_mfname ON dmsr.mf_v (mfid, mfname);
CREATE INDEX IF NOT EXISTS idx_firmware_fid_mfid ON dmsr.firmware (fid, mfid);
CREATE INDEX IF NOT EXISTS idx_firmware_fid_v_mfid ON dmsr.firmware_v (fid, mfid);
CREATE INDEX IF NOT EXISTS idx_model_mdid ON dmsr.model (mdid);
CREATE INDEX IF NOT EXISTS idx_model_v_mdid ON dmsr.model_v (mdid);
CREATE INDEX IF NOT EXISTS idx_devices_did_dname ON dmsr.devices (did, dname);
CREATE INDEX IF NOT EXISTS idx_devices_v_did_dname ON dmsr.devices_v (did, dname);
CREATE INDEX IF NOT EXISTS idx_merchants_mid_mname ON dmsr.merchants (mpid, mname);
CREATE INDEX IF NOT EXISTS idx_merchants_v_mid_mname ON dmsr.merchants_v (mid, mname);
CREATE INDEX IF NOT EXISTS idx_banks_bid_bname ON dmsr.banks (bid, bname);
CREATE INDEX IF NOT EXISTS idx_banks_v_bid_bname ON dmsr.banks_v (bid, bname);
CREATE INDEX IF NOT EXISTS idx_branches_brid_brname ON dmsr.branches (brid, brname);
CREATE INDEX IF NOT EXISTS idx_branches_v_brid_brname ON dmsr.branches_v (brid, brname);
CREATE INDEX IF NOT EXISTS idx_sb_vid_bid_brid_mid ON dmsr.sb (vid, bid, brid, mid);


