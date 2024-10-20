CREATE OR REPLACE FUNCTION dmsr.banks_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.banks_v (bid, bcode, bname, bevt, eid, eat, isd, eby, op)
    VALUES (NEW.bid, NEW.bcode, NEW.bname, NEW.bevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.banks_v (bid, bcode, bname, bevt, eid, eat, isd, eby, op)
      VALUES (NEW.bid, NEW.bcode, NEW.bname, NEW.bevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.banks_v (bid, bcode, bname, bevt, eid, eat, isd, eby, op)
      VALUES (NEW.bid, NEW.bcode, NEW.bname, NEW.bevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER banks_trigger
AFTER INSERT OR UPDATE ON dmsr.banks
FOR EACH ROW
EXECUTE FUNCTION dmsr.banks_trigger_function();



-----branches-------------
CREATE OR REPLACE FUNCTION dmsr.branches_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.branches_v (brid, brname, braddr, bid, brevt, eid, eat, isd, eby, op)
    VALUES (NEW.brid, NEW.brname, NEW.braddr, NEW.bid, NEW.brevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.branches_v (brid, brname, braddr, bid, brevt, eid, eat, isd, eby, op)
      VALUES (NEW.brid, NEW.brname, NEW.braddr, NEW.bid, NEW.brevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.branches_v (brid, brname, braddr, bid, brevt, eid, eat, isd, eby, op)
      VALUES (NEW.brid, NEW.brname, NEW.braddr, NEW.bid, NEW.brevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER branches_trigger
AFTER INSERT OR UPDATE ON dmsr.branches
FOR EACH ROW
EXECUTE FUNCTION dmsr.branches_trigger_function();



---------------devices-----------
CREATE OR REPLACE FUNCTION dmsr.devices_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.devices_v (did, dname, mfid, fid, mdid, devt, eid, eat, isd, eby, op)
    VALUES (NEW.did, NEW.dname, NEW.mfid, NEW.fid, NEW.mdid, NEW.devt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.devices_v (did, dname, mfid, fid, mdid, devt, eid, eat, isd, eby, op)
      VALUES (NEW.did, NEW.dname, NEW.mfid, NEW.fid, NEW.mdid, NEW.devt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.devices_v (did, dname, mfid, fid, mdid, devt, eid, eat, isd, eby, op)
      VALUES (NEW.did, NEW.dname, NEW.mfid, NEW.fid, NEW.mdid, NEW.devt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER devices_trigger
AFTER INSERT OR UPDATE ON dmsr.devices
FOR EACH ROW
EXECUTE FUNCTION dmsr.devices_trigger_function();




-----firmware-----------

CREATE OR REPLACE FUNCTION dmsr.firmware_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.firmware_v (fid, mfid, fdesc, frevt, eid, eat, isd, eby, op)
    VALUES (NEW.fid, NEW.mfid, NEW.fdesc, NEW.frevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.firmware_v (fid, mfid, fdesc, frevt, eid, eat, isd, eby, op)
      VALUES (NEW.fid, NEW.mfid, NEW.fdesc, NEW.frevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'DELETED');
    ELSE
      INSERT INTO dmsr.firmware_v (fid, mfid, fdesc, frevt, eid, eat, isd, eby, op)
      VALUES (NEW.fid, NEW.mfid, NEW.fdesc, NEW.frevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER firmware_trigger
AFTER INSERT OR UPDATE ON dmsr.firmware
FOR EACH ROW
EXECUTE FUNCTION dmsr.firmware_trigger_function();


------merchants---------------

CREATE OR REPLACE FUNCTION dmsr.merchants_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.merchants_v (mpid, mid, msid, mname, minfo, mevt, eid, brid, eat, isd, eby, op)
    VALUES (NEW.mpid, NEW.mid, NEW.msid, NEW.mname, NEW.minfo, NEW.mevt, NEW.eid, NEW.brid, NEW.eat, NEW.isd, NEW.eby, 'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.merchants_v (mpid, mid, msid, mname, minfo, mevt, eid, brid, eat, isd, eby, op)
      VALUES (NEW.mpid, NEW.mid, NEW.msid, NEW.mname, NEW.minfo, NEW.mevt, NEW.eid, NEW.brid, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.merchants_v (mpid, mid, msid, mname, minfo, mevt, eid, brid, eat, isd, eby, op)
      VALUES (NEW.mpid, NEW.mid, NEW.msid, NEW.mname, NEW.minfo, NEW.mevt, NEW.eid, NEW.brid, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER merchants_trigger
AFTER INSERT OR UPDATE ON dmsr.merchants
FOR EACH ROW
EXECUTE FUNCTION dmsr.merchants_trigger_function();




---------------------mf----------------------------

CREATE OR REPLACE FUNCTION dmsr.mf_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.mf_v (mfid, mfname, mfevt, eid, eat, isd, eby, op)
    VALUES (NEW.mfid, NEW.mfname, NEW.mfevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.mf_v (mfid, mfname, mfevt, eid, eat, isd, eby, op)
      VALUES (NEW.mfid, NEW.mfname, NEW.mfevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.mf_v (mfid, mfname, mfevt, eid, eat, isd, eby, op)
      VALUES (NEW.mfid, NEW.mfname, NEW.mfevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER mf_trigger
AFTER INSERT OR UPDATE ON dmsr.mf
FOR EACH ROW
EXECUTE FUNCTION dmsr.mf_trigger_function();




---------------Model---------------

CREATE OR REPLACE FUNCTION dmsr.model_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.model_v (mdid, mfid, fid, mdevt, eid, mdesc, eat, isd, eby, op)
    VALUES (NEW.mdid, NEW.mfid, NEW.fid, NEW.mdevt, NEW.eid, NEW.mdesc, NEW.eat, NEW.isd,NEW.eby,'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.model_v (mdid, mfid, fid, mdevt, eid, mdesc, eat, isd, eby, op)
      VALUES (NEW.mdid, NEW.mfid, NEW.fid, NEW.mdevt, NEW.eid, NEW.mdesc, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.model_v (mdid, mfid, fid, mdevt, eid, mdesc, eat, isd, eby, op)
      VALUES (NEW.mdid, NEW.mfid, NEW.fid, NEW.mdevt, NEW.eid, NEW.mdesc, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER model_trigger
AFTER INSERT OR UPDATE ON dmsr.model
FOR EACH ROW
EXECUTE FUNCTION dmsr.model_trigger_function();




---------------sb----------
CREATE OR REPLACE FUNCTION dmsr.sb_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.sb_v (	sid, vid, mid, did, bid, brid, sbevt, eid, eat, isd, eby, op)
    VALUES (NEW.sid, NEW.vid, NEW.mid, NEW.did, NEW.bid, NEW.brid, NEW.sbevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.sb_v (sid, vid, mid, did, bid, brid, sbevt, eid, eat, isd, eby, op)
      VALUES (NEW.sid, NEW.vid, NEW.mid, NEW.did, NEW.bid, NEW.brid, NEW.sbevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'DELETED');
    ELSE
      INSERT INTO dmsr.sb_v (	sid, vid, mid, did, bid, brid, sbevt, eid, eat, isd, eby, op)
      VALUES (NEW.sid, NEW.vid, NEW.mid, NEW.did, NEW.bid, NEW.brid, NEW.sbevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby,'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sb_trigger
AFTER INSERT OR UPDATE ON dmsr.sb
FOR EACH ROW
EXECUTE FUNCTION dmsr.sb_trigger_function();


--------VPA----------

CREATE OR REPLACE FUNCTION dmsr.vpa_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO dmsr.vpa_v (vid, vpa, vevt, eid, eat, isd, eby, op)
    VALUES (NEW.vid, NEW.vpa, NEW.vevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'CREATED');
  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.isd = true AND OLD.isd = false THEN
      INSERT INTO dmsr.vpa_v (vid, vpa, vevt, eid, eat, isd, eby, op)
      VALUES (NEW.vid, NEW.vpa, NEW.vevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'DELETED');
    ELSE
      INSERT INTO dmsr.vpa_v (vid, vpa, vevt, eid, eat, isd, eby, op)
      VALUES (NEW.vid, NEW.vpa, NEW.vevt, NEW.eid, NEW.eat, NEW.isd, NEW.eby, 'UPDATED');
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER vpa_trigger
AFTER INSERT OR UPDATE ON dmsr.vpa
FOR EACH ROW
EXECUTE FUNCTION dmsr.vpa_trigger_function();
































