
-- i3-MARKET instance CockroachDB database initialization script

-- We will create databases for auditable accounting, cloud wallet, and conflict
-- resolution components.  Each component gets its own role so that privileges
-- can be assigned to the role.
-- Each component instance should get its own host specific user that is
-- assigned corresponding role.  This way users and their keys can be managed
-- sparately from privileges of roles.

CREATE ROLE auditable_accounting;
CREATE USER auditable_accounting_node1;
GRANT auditable_accounting TO auditable_accounting_node1;
CREATE DATABASE auditable_accounting;
ALTER DATABASE auditable_accounting OWNER TO auditable_accounting;

CREATE ROLE cloud_wallet;
CREATE USER cloud_wallet_node1;
GRANT cloud_wallet TO cloud_wallet_node1;
CREATE DATABASE cloud_wallet;
ALTER DATABASE cloud_wallet OWNER TO cloud_wallet;

CREATE ROLE conflict_resolution;
CREATE USER conflict_resolution_node1;
GRANT conflict_resolution TO conflict_resolution_node1;
CREATE DATABASE conflict_resolution;
ALTER DATABASE conflict_resolution OWNER TO conflict_resolution;

