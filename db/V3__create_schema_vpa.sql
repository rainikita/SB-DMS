ALTER TYPE dmsr.vevt RENAME TO vevts;

ALTER TABLE dmsr.vpa
ALTER COLUMN vevt TYPE dmsr.vevts USING vevt::dmsr.vevts;


ALTER TABLE dmsr.vpa_v
ALTER COLUMN vevt TYPE dmsr.vevts USING vevt::dmsr.vevts;

