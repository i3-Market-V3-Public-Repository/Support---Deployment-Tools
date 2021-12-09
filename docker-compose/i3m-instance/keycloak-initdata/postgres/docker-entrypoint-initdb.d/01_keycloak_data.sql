--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO postgres;

\connect keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
a3849dfe-b166-47d8-b7df-ec6c241a62a0	\N	auth-cookie	master	542a4980-228a-4a35-be4f-2f3fc8ebcafa	2	10	f	\N	\N
6bffff28-1c65-4da9-8095-2fa6f8305e69	\N	auth-spnego	master	542a4980-228a-4a35-be4f-2f3fc8ebcafa	3	20	f	\N	\N
b9d389fe-2f22-49ff-b4f3-0b4cafb52df8	\N	identity-provider-redirector	master	542a4980-228a-4a35-be4f-2f3fc8ebcafa	2	25	f	\N	\N
b35792ab-73d9-4b07-a973-81489e7d5c0f	\N	\N	master	542a4980-228a-4a35-be4f-2f3fc8ebcafa	2	30	t	c2be3810-6ece-491d-9d2e-15509d76caf1	\N
9949b80f-4bf5-407d-b69a-6ca548017eb9	\N	auth-username-password-form	master	c2be3810-6ece-491d-9d2e-15509d76caf1	0	10	f	\N	\N
af2867fb-7f27-4403-b137-9aabdd484dd9	\N	\N	master	c2be3810-6ece-491d-9d2e-15509d76caf1	1	20	t	a60eb85f-1c1f-49cc-8c25-64ad74e3dad8	\N
05c20b77-444f-4a8e-9a81-fcf50331e0fa	\N	conditional-user-configured	master	a60eb85f-1c1f-49cc-8c25-64ad74e3dad8	0	10	f	\N	\N
4dca6b2b-e374-4ac5-9d3e-6bc7d47dabbc	\N	auth-otp-form	master	a60eb85f-1c1f-49cc-8c25-64ad74e3dad8	0	20	f	\N	\N
d5b01043-82e7-478c-b478-17570dac4173	\N	direct-grant-validate-username	master	7a387225-fd61-4fa0-a408-0a80746e3996	0	10	f	\N	\N
a264bdf1-0c6d-40fd-8f38-366049c81cfe	\N	direct-grant-validate-password	master	7a387225-fd61-4fa0-a408-0a80746e3996	0	20	f	\N	\N
f2ceccd9-debb-42b2-be3c-0cf092eff25e	\N	\N	master	7a387225-fd61-4fa0-a408-0a80746e3996	1	30	t	35ace8ba-5091-458d-b18b-80a25598eb4e	\N
9bb71c7a-5e41-4f6d-9730-600c0e10a3c7	\N	conditional-user-configured	master	35ace8ba-5091-458d-b18b-80a25598eb4e	0	10	f	\N	\N
29b5c3d5-cdec-47d5-b788-78bc5413d4a4	\N	direct-grant-validate-otp	master	35ace8ba-5091-458d-b18b-80a25598eb4e	0	20	f	\N	\N
ce0f659c-c327-4559-b635-727a295819f2	\N	registration-page-form	master	e63cf40a-296b-4db4-9be8-f951e39ad52c	0	10	t	7bda4bf6-cbf8-4df6-a316-21e6fb6b8d9e	\N
93267b41-a506-497b-a7d3-1419adf63e6e	\N	registration-user-creation	master	7bda4bf6-cbf8-4df6-a316-21e6fb6b8d9e	0	20	f	\N	\N
3765e56e-de7e-42a6-9d6c-7b4287733fda	\N	registration-profile-action	master	7bda4bf6-cbf8-4df6-a316-21e6fb6b8d9e	0	40	f	\N	\N
cd3b3c38-0161-4c54-b3a8-592822262c5e	\N	registration-password-action	master	7bda4bf6-cbf8-4df6-a316-21e6fb6b8d9e	0	50	f	\N	\N
a5ffe576-9f80-4238-ab24-d3b6c2bff57e	\N	registration-recaptcha-action	master	7bda4bf6-cbf8-4df6-a316-21e6fb6b8d9e	3	60	f	\N	\N
56c2d533-d409-43bc-9c94-ecd61e92bb67	\N	reset-credentials-choose-user	master	52869ca9-9f49-4d15-9556-0ccaa2c7a617	0	10	f	\N	\N
9a63a568-e246-459d-bfd2-1f8eeaac60d4	\N	reset-credential-email	master	52869ca9-9f49-4d15-9556-0ccaa2c7a617	0	20	f	\N	\N
d74064a0-d635-4969-a347-8fde60db2779	\N	reset-password	master	52869ca9-9f49-4d15-9556-0ccaa2c7a617	0	30	f	\N	\N
f91c57b4-054c-4166-9a56-fa20eb4abb6e	\N	\N	master	52869ca9-9f49-4d15-9556-0ccaa2c7a617	1	40	t	c7dd48d3-02ff-459a-9f48-b89e5cc8a159	\N
8fc9514b-be8d-4d10-acfe-1400640081a2	\N	conditional-user-configured	master	c7dd48d3-02ff-459a-9f48-b89e5cc8a159	0	10	f	\N	\N
bac8ff35-fe46-4a28-bd1f-8e87d86a9540	\N	reset-otp	master	c7dd48d3-02ff-459a-9f48-b89e5cc8a159	0	20	f	\N	\N
34b7947f-afeb-4879-b003-e4a223ca9b56	\N	client-secret	master	332e8913-d6cb-4439-9a91-1c5ed24dacb1	2	10	f	\N	\N
4d054ba5-7720-49bb-a93a-59086d5e3ee2	\N	client-jwt	master	332e8913-d6cb-4439-9a91-1c5ed24dacb1	2	20	f	\N	\N
30b0a630-5de5-4aeb-814f-28eb37f3cb26	\N	client-secret-jwt	master	332e8913-d6cb-4439-9a91-1c5ed24dacb1	2	30	f	\N	\N
077d2700-2eac-4f0e-9ce8-e285b2e06b2b	\N	client-x509	master	332e8913-d6cb-4439-9a91-1c5ed24dacb1	2	40	f	\N	\N
656daa16-9c8c-4c38-a14a-cef352c06022	\N	idp-review-profile	master	dd3402ac-b72a-4c36-b426-74e888e385e7	0	10	f	\N	9d12de69-a03c-4e18-bef3-2168081ec1ef
bea13b24-fe71-439d-96a1-12b5caa81c3c	\N	\N	master	dd3402ac-b72a-4c36-b426-74e888e385e7	0	20	t	1075a120-c0cf-4cf3-8fd6-70b2f5f5813f	\N
d92c8972-c588-4339-8394-a0090d678cda	\N	idp-create-user-if-unique	master	1075a120-c0cf-4cf3-8fd6-70b2f5f5813f	2	10	f	\N	b6ec1bb8-dd51-470d-b0e0-2945cf2a9c55
4ecc3b1f-592d-4bff-9f9a-5ceed3f800d1	\N	\N	master	1075a120-c0cf-4cf3-8fd6-70b2f5f5813f	2	20	t	3860ae28-11ad-4159-8c9f-1d8e3d7681ef	\N
ef6650c9-cdcf-4673-bfaa-aa4dc123f384	\N	idp-confirm-link	master	3860ae28-11ad-4159-8c9f-1d8e3d7681ef	0	10	f	\N	\N
d358692c-2498-4c6d-aedf-e6a9a806caea	\N	\N	master	3860ae28-11ad-4159-8c9f-1d8e3d7681ef	0	20	t	f9d2baee-0efa-43c1-bd78-1cf9f5f5e288	\N
dd1f13f9-34af-44b2-aebb-0ab160515522	\N	idp-email-verification	master	f9d2baee-0efa-43c1-bd78-1cf9f5f5e288	2	10	f	\N	\N
953cfaef-c86c-4dee-b0b9-4776b1f94a18	\N	\N	master	f9d2baee-0efa-43c1-bd78-1cf9f5f5e288	2	20	t	be8673e3-efb5-4df8-b96c-fd7a4cc96302	\N
17f2de09-753f-47d7-9eda-bd98a9f6bb7f	\N	idp-username-password-form	master	be8673e3-efb5-4df8-b96c-fd7a4cc96302	0	10	f	\N	\N
5b8f70a5-34e5-411e-af8b-62e0fc0ed095	\N	\N	master	be8673e3-efb5-4df8-b96c-fd7a4cc96302	1	20	t	8ea2e80c-4dc8-4324-9a02-e6b3ff04bcd0	\N
b62d4ab0-f493-441a-8cd8-b952985b85bd	\N	conditional-user-configured	master	8ea2e80c-4dc8-4324-9a02-e6b3ff04bcd0	0	10	f	\N	\N
f9886381-9b86-4522-ab69-f3c2df4687e0	\N	auth-otp-form	master	8ea2e80c-4dc8-4324-9a02-e6b3ff04bcd0	0	20	f	\N	\N
385ff468-2aee-4440-b9e7-9daa28b8c246	\N	http-basic-authenticator	master	43ca3e51-2cd3-459e-91fe-dc3e90e27b05	0	10	f	\N	\N
de814f3c-9d11-4e58-a538-e53119467763	\N	docker-http-basic-authenticator	master	4565361c-c459-4c32-93ae-e97205465526	0	10	f	\N	\N
edcbd502-3d09-4a87-8e0e-b413ced28bf5	\N	no-cookie-redirect	master	97614f16-3ac3-4fa0-9a1e-cbb04cf93a20	0	10	f	\N	\N
7a66dfe7-654e-4497-8b67-46d7db99446a	\N	\N	master	97614f16-3ac3-4fa0-9a1e-cbb04cf93a20	0	20	t	d09ea3be-3bb2-455b-8b9a-7bc5c10219e8	\N
6710db2a-8416-4b22-8573-117798dc8a61	\N	basic-auth	master	d09ea3be-3bb2-455b-8b9a-7bc5c10219e8	0	10	f	\N	\N
30c9176f-b75b-4cce-949d-71773b6872b9	\N	basic-auth-otp	master	d09ea3be-3bb2-455b-8b9a-7bc5c10219e8	3	20	f	\N	\N
b0009c7d-bda9-427c-9cf1-8c080c6e2fd5	\N	auth-spnego	master	d09ea3be-3bb2-455b-8b9a-7bc5c10219e8	3	30	f	\N	\N
19304ba7-fb31-4f47-9d99-7888457a4160	\N	auth-cookie	Company	0a954106-c704-41dc-8485-88a2db6703f7	2	10	f	\N	\N
46fc2582-faa0-4fcb-bb43-05ad705cac07	\N	auth-spnego	Company	0a954106-c704-41dc-8485-88a2db6703f7	3	20	f	\N	\N
7dfcdbe2-00e8-42d0-90b8-7ab419e25756	\N	identity-provider-redirector	Company	0a954106-c704-41dc-8485-88a2db6703f7	2	25	f	\N	\N
e5eb1917-6c98-4c8d-b44b-576257c2bc48	\N	\N	Company	0a954106-c704-41dc-8485-88a2db6703f7	2	30	t	d8d0f6b7-0ebb-4af3-9488-95d5903f83e5	\N
306df346-f27f-43fb-86f2-f404fe605ffc	\N	auth-username-password-form	Company	d8d0f6b7-0ebb-4af3-9488-95d5903f83e5	0	10	f	\N	\N
c16feef8-bc3f-4cd2-b8e0-9d9d6bc662f2	\N	\N	Company	d8d0f6b7-0ebb-4af3-9488-95d5903f83e5	1	20	t	c974c1b8-6669-4ccf-b66c-5689452cb976	\N
64a9bcc2-dec9-4e7e-8d2d-ea0565271b9d	\N	conditional-user-configured	Company	c974c1b8-6669-4ccf-b66c-5689452cb976	0	10	f	\N	\N
0ac18080-e838-40b6-b454-60fedb3a4924	\N	auth-otp-form	Company	c974c1b8-6669-4ccf-b66c-5689452cb976	0	20	f	\N	\N
271f667b-868d-4ed5-8c05-f79a9c0112fb	\N	direct-grant-validate-username	Company	4993ce79-271a-4692-bd15-3242a339e5e2	0	10	f	\N	\N
9ec91f73-7fa8-4cc4-828c-d663c52febc3	\N	direct-grant-validate-password	Company	4993ce79-271a-4692-bd15-3242a339e5e2	0	20	f	\N	\N
a75f13c1-03ce-41d5-a934-64faeb60e714	\N	\N	Company	4993ce79-271a-4692-bd15-3242a339e5e2	1	30	t	96ffd6dd-be35-4030-9dde-1ece0c3e719c	\N
6696d394-0422-480e-928a-f856f04bf5d4	\N	conditional-user-configured	Company	96ffd6dd-be35-4030-9dde-1ece0c3e719c	0	10	f	\N	\N
46b90fe8-b21c-47af-b6f4-e88b1c26583b	\N	direct-grant-validate-otp	Company	96ffd6dd-be35-4030-9dde-1ece0c3e719c	0	20	f	\N	\N
8f9963ee-7343-408f-b573-430542c51072	\N	registration-page-form	Company	8712b41e-fbe8-4d1f-b261-026b5265b367	0	10	t	8a896197-33a1-440a-bfc2-26ad71ce19b4	\N
bed379d9-64eb-4fbe-90ae-84ab70213e28	\N	registration-user-creation	Company	8a896197-33a1-440a-bfc2-26ad71ce19b4	0	20	f	\N	\N
c54ce2c9-b5cd-4969-ae6a-e36ced283b73	\N	registration-profile-action	Company	8a896197-33a1-440a-bfc2-26ad71ce19b4	0	40	f	\N	\N
3e9cc39a-b406-443e-8c32-cb10eea2e28a	\N	registration-password-action	Company	8a896197-33a1-440a-bfc2-26ad71ce19b4	0	50	f	\N	\N
50930b1a-3442-48bc-9eed-bfd5c08eed60	\N	registration-recaptcha-action	Company	8a896197-33a1-440a-bfc2-26ad71ce19b4	3	60	f	\N	\N
f63bd9e7-666f-4e2d-99a2-66478814a2b1	\N	reset-credentials-choose-user	Company	e39168ff-829e-4fb9-83a0-0071adbfe9d6	0	10	f	\N	\N
31fb86dd-40e8-4217-aae7-4fdf48019fbf	\N	reset-credential-email	Company	e39168ff-829e-4fb9-83a0-0071adbfe9d6	0	20	f	\N	\N
aadaee62-4946-418f-9861-118644e2330b	\N	reset-password	Company	e39168ff-829e-4fb9-83a0-0071adbfe9d6	0	30	f	\N	\N
4a8375ec-886a-4326-a428-191dc558fd1a	\N	\N	Company	e39168ff-829e-4fb9-83a0-0071adbfe9d6	1	40	t	d3ce60c2-af39-49cf-888b-859b7b5138df	\N
6dfd52c6-8ad0-4e11-9d7f-a64191403ddd	\N	conditional-user-configured	Company	d3ce60c2-af39-49cf-888b-859b7b5138df	0	10	f	\N	\N
7546044a-1fc9-48f5-a6ad-4608e9b88f57	\N	reset-otp	Company	d3ce60c2-af39-49cf-888b-859b7b5138df	0	20	f	\N	\N
03fa6589-619e-4685-b212-66067e0b037f	\N	client-secret	Company	229f1d69-ae8f-4889-9f89-6d59b6ab0e05	2	10	f	\N	\N
89468ba4-96ed-4f57-8c16-4cd076d31307	\N	client-jwt	Company	229f1d69-ae8f-4889-9f89-6d59b6ab0e05	2	20	f	\N	\N
2989aa84-9d02-407f-8f98-7a79fb5bdc31	\N	client-secret-jwt	Company	229f1d69-ae8f-4889-9f89-6d59b6ab0e05	2	30	f	\N	\N
169eb79b-83e5-430d-88ca-224b6cf8a605	\N	client-x509	Company	229f1d69-ae8f-4889-9f89-6d59b6ab0e05	2	40	f	\N	\N
f30567b3-02c5-4217-8c65-3ad043ec57a2	\N	\N	Company	970b56ad-71fb-4027-920d-27866c5f53c0	0	20	t	0805c01f-7ba0-4d91-9c2b-16817921cc54	\N
dc241174-81ae-47e9-98d7-e6db453b307f	\N	idp-create-user-if-unique	Company	0805c01f-7ba0-4d91-9c2b-16817921cc54	2	10	f	\N	37888f85-3b63-4a38-8fc9-a50b4d7a643f
a8127a1c-fb2c-4008-a169-efe2e3c890c1	\N	\N	Company	0805c01f-7ba0-4d91-9c2b-16817921cc54	2	20	t	bd665cb9-1012-481e-bb82-219f8fab465e	\N
eaaac83d-e0fe-4256-975c-928c9314d13b	\N	idp-confirm-link	Company	bd665cb9-1012-481e-bb82-219f8fab465e	0	10	f	\N	\N
3801558e-00fa-4c4b-9167-051160e63dac	\N	\N	Company	bd665cb9-1012-481e-bb82-219f8fab465e	0	20	t	fb6ffbc5-5e25-4deb-9d71-8bae94932d6c	\N
ff0ff02e-70e5-44a4-9184-704320c7dfaa	\N	idp-email-verification	Company	fb6ffbc5-5e25-4deb-9d71-8bae94932d6c	2	10	f	\N	\N
5234e386-4820-4e66-86d9-a9f41a2fadea	\N	\N	Company	fb6ffbc5-5e25-4deb-9d71-8bae94932d6c	2	20	t	18911dd1-8a75-400b-b0d7-50094e72ec23	\N
6dbc43d0-ee39-40b8-915f-7dfa48ab4896	\N	idp-username-password-form	Company	18911dd1-8a75-400b-b0d7-50094e72ec23	0	10	f	\N	\N
c1f44167-4bae-4304-a297-d7e9c0869c24	\N	\N	Company	18911dd1-8a75-400b-b0d7-50094e72ec23	1	20	t	ee9d1134-178d-4553-9da0-c0609ee763b4	\N
d930abd1-07f3-467c-a727-3a7df95b3af1	\N	conditional-user-configured	Company	ee9d1134-178d-4553-9da0-c0609ee763b4	0	10	f	\N	\N
f244ebd3-5389-4a5f-a7a4-e0276b66800d	\N	auth-otp-form	Company	ee9d1134-178d-4553-9da0-c0609ee763b4	0	20	f	\N	\N
f8f5b4f6-b51b-4b0c-8955-5ceb1ca61e8a	\N	http-basic-authenticator	Company	45146e37-d316-48d3-b11d-cf05715beac3	0	10	f	\N	\N
45bdcd36-4159-405c-829c-ce209def5f75	\N	docker-http-basic-authenticator	Company	1c8aefc1-e77e-4140-95ed-17135d8b8653	0	10	f	\N	\N
89bc3867-67a0-4126-93d5-2c93962c00fe	\N	no-cookie-redirect	Company	e094dc9b-9e0c-43df-abed-97d9309ca7af	0	10	f	\N	\N
077183ff-5680-4840-ad96-e03ae36d4867	\N	\N	Company	e094dc9b-9e0c-43df-abed-97d9309ca7af	0	20	t	f0300083-4bb8-4697-8db5-ed01c25ecc93	\N
3d4568ed-ba97-4945-8f62-2b9c70bd4591	\N	basic-auth	Company	f0300083-4bb8-4697-8db5-ed01c25ecc93	0	10	f	\N	\N
024c1cb3-08b5-46dd-91a5-7b310eff783b	\N	basic-auth-otp	Company	f0300083-4bb8-4697-8db5-ed01c25ecc93	3	20	f	\N	\N
39ea6528-5c8a-40ad-ba1e-ee374f22bafc	\N	auth-spnego	Company	f0300083-4bb8-4697-8db5-ed01c25ecc93	3	30	f	\N	\N
e95be0cf-b312-4df9-9bdd-5feeae855e5f	\N	idp-review-profile	Company	970b56ad-71fb-4027-920d-27866c5f53c0	3	10	f	\N	46a386fa-a77d-4c8a-ba53-cb3235ab3b4f
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
542a4980-228a-4a35-be4f-2f3fc8ebcafa	browser	browser based authentication	master	basic-flow	t	t
c2be3810-6ece-491d-9d2e-15509d76caf1	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
a60eb85f-1c1f-49cc-8c25-64ad74e3dad8	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
7a387225-fd61-4fa0-a408-0a80746e3996	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
35ace8ba-5091-458d-b18b-80a25598eb4e	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
e63cf40a-296b-4db4-9be8-f951e39ad52c	registration	registration flow	master	basic-flow	t	t
7bda4bf6-cbf8-4df6-a316-21e6fb6b8d9e	registration form	registration form	master	form-flow	f	t
52869ca9-9f49-4d15-9556-0ccaa2c7a617	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
c7dd48d3-02ff-459a-9f48-b89e5cc8a159	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
332e8913-d6cb-4439-9a91-1c5ed24dacb1	clients	Base authentication for clients	master	client-flow	t	t
dd3402ac-b72a-4c36-b426-74e888e385e7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
1075a120-c0cf-4cf3-8fd6-70b2f5f5813f	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
3860ae28-11ad-4159-8c9f-1d8e3d7681ef	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
f9d2baee-0efa-43c1-bd78-1cf9f5f5e288	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
be8673e3-efb5-4df8-b96c-fd7a4cc96302	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
8ea2e80c-4dc8-4324-9a02-e6b3ff04bcd0	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
43ca3e51-2cd3-459e-91fe-dc3e90e27b05	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
4565361c-c459-4c32-93ae-e97205465526	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
97614f16-3ac3-4fa0-9a1e-cbb04cf93a20	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
d09ea3be-3bb2-455b-8b9a-7bc5c10219e8	Authentication Options	Authentication options.	master	basic-flow	f	t
0a954106-c704-41dc-8485-88a2db6703f7	browser	browser based authentication	Company	basic-flow	t	t
d8d0f6b7-0ebb-4af3-9488-95d5903f83e5	forms	Username, password, otp and other auth forms.	Company	basic-flow	f	t
c974c1b8-6669-4ccf-b66c-5689452cb976	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	Company	basic-flow	f	t
4993ce79-271a-4692-bd15-3242a339e5e2	direct grant	OpenID Connect Resource Owner Grant	Company	basic-flow	t	t
96ffd6dd-be35-4030-9dde-1ece0c3e719c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	Company	basic-flow	f	t
8712b41e-fbe8-4d1f-b261-026b5265b367	registration	registration flow	Company	basic-flow	t	t
8a896197-33a1-440a-bfc2-26ad71ce19b4	registration form	registration form	Company	form-flow	f	t
e39168ff-829e-4fb9-83a0-0071adbfe9d6	reset credentials	Reset credentials for a user if they forgot their password or something	Company	basic-flow	t	t
d3ce60c2-af39-49cf-888b-859b7b5138df	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	Company	basic-flow	f	t
229f1d69-ae8f-4889-9f89-6d59b6ab0e05	clients	Base authentication for clients	Company	client-flow	t	t
970b56ad-71fb-4027-920d-27866c5f53c0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	Company	basic-flow	t	t
0805c01f-7ba0-4d91-9c2b-16817921cc54	User creation or linking	Flow for the existing/non-existing user alternatives	Company	basic-flow	f	t
bd665cb9-1012-481e-bb82-219f8fab465e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	Company	basic-flow	f	t
fb6ffbc5-5e25-4deb-9d71-8bae94932d6c	Account verification options	Method with which to verity the existing account	Company	basic-flow	f	t
18911dd1-8a75-400b-b0d7-50094e72ec23	Verify Existing Account by Re-authentication	Reauthentication of existing account	Company	basic-flow	f	t
ee9d1134-178d-4553-9da0-c0609ee763b4	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	Company	basic-flow	f	t
45146e37-d316-48d3-b11d-cf05715beac3	saml ecp	SAML ECP Profile Authentication Flow	Company	basic-flow	t	t
1c8aefc1-e77e-4140-95ed-17135d8b8653	docker auth	Used by Docker clients to authenticate against the IDP	Company	basic-flow	t	t
e094dc9b-9e0c-43df-abed-97d9309ca7af	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	Company	basic-flow	t	t
f0300083-4bb8-4697-8db5-ed01c25ecc93	Authentication Options	Authentication options.	Company	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
9d12de69-a03c-4e18-bef3-2168081ec1ef	review profile config	master
b6ec1bb8-dd51-470d-b0e0-2945cf2a9c55	create unique user config	master
46a386fa-a77d-4c8a-ba53-cb3235ab3b4f	review profile config	Company
37888f85-3b63-4a38-8fc9-a50b4d7a643f	create unique user config	Company
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
9d12de69-a03c-4e18-bef3-2168081ec1ef	missing	update.profile.on.first.login
b6ec1bb8-dd51-470d-b0e0-2945cf2a9c55	false	require.password.update.after.registration
46a386fa-a77d-4c8a-ba53-cb3235ab3b4f	missing	update.profile.on.first.login
37888f85-3b63-4a38-8fc9-a50b4d7a643f	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	t	master-realm	0	f	cafa7571-4d88-479f-a953-232f88caae1f	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
4526389f-2b6f-455d-b72c-22433e78dfb2	t	f	account	0	f	fdf03afe-0751-4237-a35a-430b341e3e81	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	t	f	account-console	0	t	e247386a-5fae-4492-88c2-67755b798bd4	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5176d938-c687-4380-8d78-6e99dbc77b25	t	f	broker	0	f	b33ace4f-b8e9-436d-b56b-576744aac876	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
af9205c2-7b51-47d2-ad93-24c612401bec	t	f	security-admin-console	0	t	32a32640-2558-4cec-a3e1-fef44f3b582d	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
cf574201-6984-485a-be52-c1111a32c8dc	t	f	admin-cli	0	t	1dff182d-1f99-4663-ba89-8d82298a1a88	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	f	realm-management	0	f	5bb6bd6f-c303-4e20-9e51-93fa578ad3a5	\N	t	\N	f	Company	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
4ec4f635-04a9-4944-8d65-e6588aaa18da	t	f	account-console	0	t	7da0116d-9dff-43bb-990a-b65798a2f55e	/realms/Company/account/	f	\N	f	Company	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e86a568f-6381-4ead-93d5-8f148244a70f	t	f	broker	0	f	28e1b55a-b3e0-496a-96ad-37753c7e0feb	\N	f	\N	f	Company	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
696fe535-97a2-408e-aae3-a1e52c1697f7	t	f	admin-cli	0	t	49cbc849-004a-4a4f-a395-bdfb5cda0b8b	\N	f	\N	f	Company	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
3c03f823-8719-47bf-8648-c07fa53d06bc	t	t	service-client	0	f	e2bd18c0-f900-4a32-a63a-c9306ffabd21	\N	f	\N	f	Company	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
16475946-e318-47c7-b025-8b35702d5163	t	t	i3market-realm	0	f	0e581784-4500-4454-ae76-f10a3627c1c1	\N	t	\N	f	master	\N	0	f	f	Company Realm	f	client-secret	\N	\N	\N	t	f	f	f
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	t	f	security-admin-console	0	t	22c0c919-b197-476f-b2cf-62cf43f85098	/admin/i3market/console/	f	\N	f	Company	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	f	account	0	f	e62fdb0a-6240-4db8-ab45-de8405bfb1a6	/realms/i3market/account/	f	\N	f	Company	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f691313d-52dc-4dd4-899c-b07faf56e2c2	t	f	new-i3market-client4	0	t	ba84ac06-bade-42f5-8550-55d3100ef83e	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client4	f	client-secret	\N	new client	\N	t	f	t	f
3269b142-f564-4374-b84a-512b0f02885b	t	t	AdminClient	0	f	c3c9e734-79ae-4545-88de-5f49bd4a67fe	\N	f	\N	f	Company	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
a284c132-cb55-40c2-b25d-a3db6943a0de	t	f	new-i3market-client	0	t	3efef88f-6fba-45a2-a81f-d56294a093b6	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client	f	client-secret	\N	new client	\N	t	f	t	f
346a601f-75f5-4939-9bb8-e66f0e944e68	t	f	new-i3market-client1	0	t	0c7728c5-1d90-4946-9156-c04ab41f346e	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client1	f	client-secret	\N	new client	\N	t	f	t	f
c868ffd4-4425-4a17-b483-4a22950bd748	t	f	new-i3market-client5	0	t	364c64a1-05fd-4b56-b375-71e02484b1ae	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client5	f	client-secret	\N	new client	\N	t	f	t	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	t	t	BackplaneAPI	0	f	9cf41020-8d6a-418c-bd59-fbd513e6eae9	\N	f	\N	f	Company	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	f	f	t	f
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	t	f	new-i3market-client2	0	t	04277d5c-9f2c-4e55-a5dc-c7b9ecc26002	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client2	f	client-secret	\N	new client	\N	t	f	t	f
a2714f12-c8ff-43d4-b011-673371652f85	t	f	new-i3market-client3	0	t	094c843a-3eef-46c0-be31-7984df8cffd6	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client3	f	client-secret	\N	new client	\N	t	f	t	f
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	t	f	new-i3market-client7	0	t	e5fb9b47-738a-45b9-8258-969cd7709ab4	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client7	f	client-secret	\N	new client	\N	t	f	t	f
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	t	f	new-i3market-client8	0	t	320a1017-d925-4392-af14-494151f05a05	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client8	f	client-secret	\N	new client	\N	t	f	t	f
a9402390-c5f9-4899-8135-9e901af9710c	t	f	new-i3market-client9	0	t	db8237be-c338-442f-8aef-2d6b233d998b	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client9	f	client-secret	\N	new client	\N	t	f	t	f
b63fb8a7-600a-4fb6-bab1-3c400398b314	t	f	new-i3market-client10	0	t	1440c526-edc5-4078-8664-8a4ca5d12bf2	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client10	f	client-secret	\N	new client	\N	t	f	f	f
76757943-77e3-408d-8f41-105880b46eed	t	f	new-i3market-client11	0	t	9609dfbd-6dd6-4548-92d8-8e4260465010	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client11	f	client-secret	\N	new client	\N	t	f	t	f
a8a02f01-0c19-461d-a919-33ce6926d2fe	t	f	new-i3market-client12	0	t	09c16f1a-7dd0-4e07-9865-cadc931c48ea	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client12	f	client-secret	\N	new client	\N	t	f	t	f
fb69a878-50d1-43ed-a604-447f75565cf8	t	t	test-admin	0	f	cd3272bf-9b2e-4e0d-a6c4-f1bc97390217	\N	f	\N	f	Company	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	t	f	new-i3market-client13	0	t	f303bb98-b2d7-47fd-97f9-d3af632def99	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client13	f	client-secret	\N	new client	\N	t	f	t	f
3fe58830-bb3b-4a75-a01e-de1928321a72	t	f	new-i3market-client14	0	t	fdb5c52d-abe0-4966-ae6e-71b4ced89a35	\N	f	\N	f	Company	openid-connect	0	f	f	new-i3market-client14	f	client-secret	\N	new client	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	S256	pkce.code.challenge.method
af9205c2-7b51-47d2-ad93-24c612401bec	S256	pkce.code.challenge.method
4ec4f635-04a9-4944-8d65-e6588aaa18da	S256	pkce.code.challenge.method
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	S256	pkce.code.challenge.method
3c03f823-8719-47bf-8648-c07fa53d06bc	true	backchannel.logout.session.required
3c03f823-8719-47bf-8648-c07fa53d06bc	false	backchannel.logout.revoke.offline.tokens
3c03f823-8719-47bf-8648-c07fa53d06bc	\N	request.uris
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.server.signature
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.server.signature.keyinfo.ext
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.assertion.signature
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.client.signature
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.encrypt
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.authnstatement
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.onetimeuse.condition
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml_force_name_id_format
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.multivalued.roles
3c03f823-8719-47bf-8648-c07fa53d06bc	false	saml.force.post.binding
3c03f823-8719-47bf-8648-c07fa53d06bc	false	exclude.session.state.from.auth.response
3c03f823-8719-47bf-8648-c07fa53d06bc	false	tls.client.certificate.bound.access.tokens
3c03f823-8719-47bf-8648-c07fa53d06bc	false	client_credentials.use_refresh_token
3c03f823-8719-47bf-8648-c07fa53d06bc	false	display.on.consent.screen
3269b142-f564-4374-b84a-512b0f02885b	true	backchannel.logout.session.required
3269b142-f564-4374-b84a-512b0f02885b	false	backchannel.logout.revoke.offline.tokens
3269b142-f564-4374-b84a-512b0f02885b	\N	request.uris
3269b142-f564-4374-b84a-512b0f02885b	false	saml.server.signature
3269b142-f564-4374-b84a-512b0f02885b	false	saml.server.signature.keyinfo.ext
3269b142-f564-4374-b84a-512b0f02885b	false	saml.assertion.signature
3269b142-f564-4374-b84a-512b0f02885b	false	saml.client.signature
3269b142-f564-4374-b84a-512b0f02885b	false	saml.encrypt
3269b142-f564-4374-b84a-512b0f02885b	false	saml.authnstatement
3269b142-f564-4374-b84a-512b0f02885b	false	saml.onetimeuse.condition
3269b142-f564-4374-b84a-512b0f02885b	false	saml_force_name_id_format
3269b142-f564-4374-b84a-512b0f02885b	false	saml.multivalued.roles
3269b142-f564-4374-b84a-512b0f02885b	false	saml.force.post.binding
3269b142-f564-4374-b84a-512b0f02885b	false	exclude.session.state.from.auth.response
3269b142-f564-4374-b84a-512b0f02885b	false	tls.client.certificate.bound.access.tokens
3269b142-f564-4374-b84a-512b0f02885b	false	client_credentials.use_refresh_token
3269b142-f564-4374-b84a-512b0f02885b	false	display.on.consent.screen
a284c132-cb55-40c2-b25d-a3db6943a0de	true	backchannel.logout.session.required
a284c132-cb55-40c2-b25d-a3db6943a0de	false	backchannel.logout.revoke.offline.tokens
346a601f-75f5-4939-9bb8-e66f0e944e68	true	backchannel.logout.session.required
346a601f-75f5-4939-9bb8-e66f0e944e68	false	backchannel.logout.revoke.offline.tokens
bcb21012-4bae-4531-9f4e-c53b4205c30e	true	backchannel.logout.session.required
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	backchannel.logout.revoke.offline.tokens
bcb21012-4bae-4531-9f4e-c53b4205c30e	\N	request.uris
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.server.signature
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.server.signature.keyinfo.ext
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.assertion.signature
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.client.signature
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.encrypt
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.authnstatement
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.onetimeuse.condition
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml_force_name_id_format
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.multivalued.roles
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	saml.force.post.binding
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	exclude.session.state.from.auth.response
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	tls.client.certificate.bound.access.tokens
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	client_credentials.use_refresh_token
bcb21012-4bae-4531-9f4e-c53b4205c30e	false	display.on.consent.screen
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	true	backchannel.logout.session.required
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	false	backchannel.logout.revoke.offline.tokens
a2714f12-c8ff-43d4-b011-673371652f85	true	backchannel.logout.session.required
a2714f12-c8ff-43d4-b011-673371652f85	false	backchannel.logout.revoke.offline.tokens
f691313d-52dc-4dd4-899c-b07faf56e2c2	true	backchannel.logout.session.required
f691313d-52dc-4dd4-899c-b07faf56e2c2	false	backchannel.logout.revoke.offline.tokens
c868ffd4-4425-4a17-b483-4a22950bd748	true	backchannel.logout.session.required
c868ffd4-4425-4a17-b483-4a22950bd748	false	backchannel.logout.revoke.offline.tokens
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	true	backchannel.logout.session.required
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	false	backchannel.logout.revoke.offline.tokens
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	true	backchannel.logout.session.required
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	false	backchannel.logout.revoke.offline.tokens
a9402390-c5f9-4899-8135-9e901af9710c	true	backchannel.logout.session.required
a9402390-c5f9-4899-8135-9e901af9710c	false	backchannel.logout.revoke.offline.tokens
b63fb8a7-600a-4fb6-bab1-3c400398b314	true	backchannel.logout.session.required
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	backchannel.logout.revoke.offline.tokens
b63fb8a7-600a-4fb6-bab1-3c400398b314	\N	request.uris
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.server.signature
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.server.signature.keyinfo.ext
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.assertion.signature
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.client.signature
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.encrypt
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.authnstatement
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.onetimeuse.condition
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml_force_name_id_format
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.multivalued.roles
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	saml.force.post.binding
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	exclude.session.state.from.auth.response
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	tls.client.certificate.bound.access.tokens
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	client_credentials.use_refresh_token
b63fb8a7-600a-4fb6-bab1-3c400398b314	false	display.on.consent.screen
fb69a878-50d1-43ed-a604-447f75565cf8	true	backchannel.logout.session.required
fb69a878-50d1-43ed-a604-447f75565cf8	false	backchannel.logout.revoke.offline.tokens
fb69a878-50d1-43ed-a604-447f75565cf8	\N	request.uris
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.server.signature
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.server.signature.keyinfo.ext
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.assertion.signature
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.client.signature
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.encrypt
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.authnstatement
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.onetimeuse.condition
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml_force_name_id_format
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.multivalued.roles
fb69a878-50d1-43ed-a604-447f75565cf8	false	saml.force.post.binding
fb69a878-50d1-43ed-a604-447f75565cf8	false	exclude.session.state.from.auth.response
fb69a878-50d1-43ed-a604-447f75565cf8	false	tls.client.certificate.bound.access.tokens
fb69a878-50d1-43ed-a604-447f75565cf8	false	client_credentials.use_refresh_token
fb69a878-50d1-43ed-a604-447f75565cf8	false	display.on.consent.screen
76757943-77e3-408d-8f41-105880b46eed	true	backchannel.logout.session.required
76757943-77e3-408d-8f41-105880b46eed	false	backchannel.logout.revoke.offline.tokens
a8a02f01-0c19-461d-a919-33ce6926d2fe	true	backchannel.logout.session.required
a8a02f01-0c19-461d-a919-33ce6926d2fe	false	backchannel.logout.revoke.offline.tokens
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	true	backchannel.logout.session.required
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	backchannel.logout.revoke.offline.tokens
3fe58830-bb3b-4a75-a01e-de1928321a72	true	backchannel.logout.session.required
3fe58830-bb3b-4a75-a01e-de1928321a72	false	backchannel.logout.revoke.offline.tokens
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	\N	request.uris
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.server.signature
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.server.signature.keyinfo.ext
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.assertion.signature
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.client.signature
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.encrypt
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.authnstatement
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.onetimeuse.condition
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml_force_name_id_format
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.multivalued.roles
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	saml.force.post.binding
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	exclude.session.state.from.auth.response
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	tls.client.certificate.bound.access.tokens
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	client_credentials.use_refresh_token
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
4526389f-2b6f-455d-b72c-22433e78dfb2	2f34707b-2073-41f6-92f7-e8d191230709
4526389f-2b6f-455d-b72c-22433e78dfb2	199f30c8-bd8a-47b8-ae0c-f3dd16bba2de
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	45d7b16a-8666-4804-bc00-38fc2b33682a
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0
a284c132-cb55-40c2-b25d-a3db6943a0de	da3da7cb-e80f-4877-bf53-091868ed0370
a284c132-cb55-40c2-b25d-a3db6943a0de	186d4618-d2cd-47c8-a4dc-0f562a861898
346a601f-75f5-4939-9bb8-e66f0e944e68	8c44b1f3-186d-41e2-a8e0-85cf668366d4
346a601f-75f5-4939-9bb8-e66f0e944e68	6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	3ef0325d-0f4c-4d49-bb24-ea89f9d7e030
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	2bb46018-a878-4a07-b7a5-a7bee5d2b340
a2714f12-c8ff-43d4-b011-673371652f85	01193d9e-f6ad-4732-9ca8-2243d35a539f
a2714f12-c8ff-43d4-b011-673371652f85	62e102db-30b9-4443-9ac6-53eddd18a42a
f691313d-52dc-4dd4-899c-b07faf56e2c2	40a61e05-4540-443f-ab61-707c17ab6182
f691313d-52dc-4dd4-899c-b07faf56e2c2	bdc9ba05-31fc-419d-ba58-9dff89ba62e4
c868ffd4-4425-4a17-b483-4a22950bd748	cb9b072e-93dc-47e1-a943-47cbe9e18674
c868ffd4-4425-4a17-b483-4a22950bd748	da01fe6e-f088-4caa-a049-9e0ec22a3cec
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	853c58fb-b046-4dc3-b402-ed59d1ad4c2e
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	f40c40c8-9dc1-44be-a02d-c8b5ae9225b6
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	0532209d-ba3a-428a-b926-9fc25502613f
a9402390-c5f9-4899-8135-9e901af9710c	e9495f4b-d634-4fcd-8d74-191d285dd406
a9402390-c5f9-4899-8135-9e901af9710c	28ecaad6-3925-49eb-880f-e2a8b2c3297c
b63fb8a7-600a-4fb6-bab1-3c400398b314	add1c218-7f67-4403-a8e8-8a18c7759881
b63fb8a7-600a-4fb6-bab1-3c400398b314	de66df10-6fb6-4e4e-861c-52684d36e04b
76757943-77e3-408d-8f41-105880b46eed	f0e6b891-1300-4515-b2a7-b421ff4454bd
76757943-77e3-408d-8f41-105880b46eed	d79c84b0-b59f-4889-9e2b-c5e30a4b14b3
a8a02f01-0c19-461d-a919-33ce6926d2fe	9294a80d-452f-4c91-9c4f-a9e84005286f
a8a02f01-0c19-461d-a919-33ce6926d2fe	6ceab9c0-73d6-44a7-b20f-ba739724b3d7
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	7fcc53be-9e89-41c5-8dd0-a98f48e5e952
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	1b07e9de-2806-4f10-b706-5a679c545065
3fe58830-bb3b-4a75-a01e-de1928321a72	d3ddbd98-2b3e-400a-bccd-322c8db6203d
3fe58830-bb3b-4a75-a01e-de1928321a72	8fd263a8-8fcf-4248-b2ff-4a97119de4d0
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
a4c76b2a-f249-46e7-a004-da2daf09af48	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
60798b18-088a-45aa-acb2-07a182d7fc28	role_list	master	SAML role list	saml
12f37564-aa95-4304-a4f1-c86a95a1b43d	profile	master	OpenID Connect built-in scope: profile	openid-connect
f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	email	master	OpenID Connect built-in scope: email	openid-connect
e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	address	master	OpenID Connect built-in scope: address	openid-connect
e993c288-5b50-442f-94d1-7f7079408c6e	phone	master	OpenID Connect built-in scope: phone	openid-connect
13abfbed-bcba-491f-beae-6d1a5952db20	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
82596ad3-c5e3-436a-83f5-8fa9b592d4a1	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
ebef2001-f638-4518-98e5-05f4f76b8e6c	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
272fb0a2-efb1-4e8e-b30c-2601fc096c78	offline_access	Company	OpenID Connect built-in scope: offline_access	openid-connect
91e51416-599c-4359-bf95-4dd8fd6ad321	role_list	Company	SAML role list	saml
3abb2b3d-5894-4f43-9dbe-c722f8dad152	profile	Company	OpenID Connect built-in scope: profile	openid-connect
c535e83f-3036-42d1-8176-74b08f7595b6	email	Company	OpenID Connect built-in scope: email	openid-connect
aa6e5e60-f95e-4997-8d99-f3329331d1e4	address	Company	OpenID Connect built-in scope: address	openid-connect
8a6d0f38-b73b-488e-8819-1bbfb5f909f2	phone	Company	OpenID Connect built-in scope: phone	openid-connect
aec45149-e526-42fa-b0ef-c171a92e5365	roles	Company	OpenID Connect scope for add user roles to the access token	openid-connect
96d3c3d3-9a12-44a4-adae-0b170da5e805	web-origins	Company	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	microprofile-jwt	Company	Microprofile - JWT built-in scope	openid-connect
ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	custom-claims	Company	\N	openid-connect
02f9474c-8b44-4344-8097-ddd907607de4	vc:consumer	Company	\N	openid-connect
e7b6b38c-8241-4674-9e84-e04ad60ffd8e	vc:provider	Company	\N	openid-connect
b9884b3c-7888-41f7-98a8-9c3a044b7583	vce:consumer	Company	\N	openid-connect
42cb45fd-0613-4b6e-88c7-427b88463dc3	vce:provider	Company	\N	openid-connect
a0d4942d-eec5-442f-91ae-8807af29975e	vc:issuer	Company	\N	openid-connect
1dd17233-c710-4bd8-a7ec-eb82fcac3b2d	vc	Company	\N	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
a4c76b2a-f249-46e7-a004-da2daf09af48	true	display.on.consent.screen
a4c76b2a-f249-46e7-a004-da2daf09af48	${offlineAccessScopeConsentText}	consent.screen.text
60798b18-088a-45aa-acb2-07a182d7fc28	true	display.on.consent.screen
60798b18-088a-45aa-acb2-07a182d7fc28	${samlRoleListScopeConsentText}	consent.screen.text
12f37564-aa95-4304-a4f1-c86a95a1b43d	true	display.on.consent.screen
12f37564-aa95-4304-a4f1-c86a95a1b43d	${profileScopeConsentText}	consent.screen.text
12f37564-aa95-4304-a4f1-c86a95a1b43d	true	include.in.token.scope
f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	true	display.on.consent.screen
f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	${emailScopeConsentText}	consent.screen.text
f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	true	include.in.token.scope
e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	true	display.on.consent.screen
e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	${addressScopeConsentText}	consent.screen.text
e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	true	include.in.token.scope
e993c288-5b50-442f-94d1-7f7079408c6e	true	display.on.consent.screen
e993c288-5b50-442f-94d1-7f7079408c6e	${phoneScopeConsentText}	consent.screen.text
e993c288-5b50-442f-94d1-7f7079408c6e	true	include.in.token.scope
13abfbed-bcba-491f-beae-6d1a5952db20	true	display.on.consent.screen
13abfbed-bcba-491f-beae-6d1a5952db20	${rolesScopeConsentText}	consent.screen.text
13abfbed-bcba-491f-beae-6d1a5952db20	false	include.in.token.scope
82596ad3-c5e3-436a-83f5-8fa9b592d4a1	false	display.on.consent.screen
82596ad3-c5e3-436a-83f5-8fa9b592d4a1		consent.screen.text
82596ad3-c5e3-436a-83f5-8fa9b592d4a1	false	include.in.token.scope
ebef2001-f638-4518-98e5-05f4f76b8e6c	false	display.on.consent.screen
ebef2001-f638-4518-98e5-05f4f76b8e6c	true	include.in.token.scope
272fb0a2-efb1-4e8e-b30c-2601fc096c78	true	display.on.consent.screen
272fb0a2-efb1-4e8e-b30c-2601fc096c78	${offlineAccessScopeConsentText}	consent.screen.text
91e51416-599c-4359-bf95-4dd8fd6ad321	true	display.on.consent.screen
91e51416-599c-4359-bf95-4dd8fd6ad321	${samlRoleListScopeConsentText}	consent.screen.text
3abb2b3d-5894-4f43-9dbe-c722f8dad152	true	display.on.consent.screen
3abb2b3d-5894-4f43-9dbe-c722f8dad152	${profileScopeConsentText}	consent.screen.text
3abb2b3d-5894-4f43-9dbe-c722f8dad152	true	include.in.token.scope
c535e83f-3036-42d1-8176-74b08f7595b6	true	display.on.consent.screen
c535e83f-3036-42d1-8176-74b08f7595b6	${emailScopeConsentText}	consent.screen.text
c535e83f-3036-42d1-8176-74b08f7595b6	true	include.in.token.scope
aa6e5e60-f95e-4997-8d99-f3329331d1e4	true	display.on.consent.screen
aa6e5e60-f95e-4997-8d99-f3329331d1e4	${addressScopeConsentText}	consent.screen.text
aa6e5e60-f95e-4997-8d99-f3329331d1e4	true	include.in.token.scope
8a6d0f38-b73b-488e-8819-1bbfb5f909f2	true	display.on.consent.screen
8a6d0f38-b73b-488e-8819-1bbfb5f909f2	${phoneScopeConsentText}	consent.screen.text
8a6d0f38-b73b-488e-8819-1bbfb5f909f2	true	include.in.token.scope
aec45149-e526-42fa-b0ef-c171a92e5365	true	display.on.consent.screen
aec45149-e526-42fa-b0ef-c171a92e5365	${rolesScopeConsentText}	consent.screen.text
aec45149-e526-42fa-b0ef-c171a92e5365	false	include.in.token.scope
96d3c3d3-9a12-44a4-adae-0b170da5e805	false	display.on.consent.screen
96d3c3d3-9a12-44a4-adae-0b170da5e805		consent.screen.text
96d3c3d3-9a12-44a4-adae-0b170da5e805	false	include.in.token.scope
0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	false	display.on.consent.screen
0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	true	include.in.token.scope
ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	false	display.on.consent.screen
ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	true	include.in.token.scope
02f9474c-8b44-4344-8097-ddd907607de4	true	display.on.consent.screen
02f9474c-8b44-4344-8097-ddd907607de4	true	include.in.token.scope
e7b6b38c-8241-4674-9e84-e04ad60ffd8e	true	display.on.consent.screen
e7b6b38c-8241-4674-9e84-e04ad60ffd8e	true	include.in.token.scope
b9884b3c-7888-41f7-98a8-9c3a044b7583	true	display.on.consent.screen
b9884b3c-7888-41f7-98a8-9c3a044b7583	true	include.in.token.scope
42cb45fd-0613-4b6e-88c7-427b88463dc3	true	display.on.consent.screen
42cb45fd-0613-4b6e-88c7-427b88463dc3	true	include.in.token.scope
a0d4942d-eec5-442f-91ae-8807af29975e	true	display.on.consent.screen
a0d4942d-eec5-442f-91ae-8807af29975e	true	include.in.token.scope
1dd17233-c710-4bd8-a7ec-eb82fcac3b2d	true	display.on.consent.screen
1dd17233-c710-4bd8-a7ec-eb82fcac3b2d	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
4526389f-2b6f-455d-b72c-22433e78dfb2	60798b18-088a-45aa-acb2-07a182d7fc28	t
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	60798b18-088a-45aa-acb2-07a182d7fc28	t
cf574201-6984-485a-be52-c1111a32c8dc	60798b18-088a-45aa-acb2-07a182d7fc28	t
5176d938-c687-4380-8d78-6e99dbc77b25	60798b18-088a-45aa-acb2-07a182d7fc28	t
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	60798b18-088a-45aa-acb2-07a182d7fc28	t
af9205c2-7b51-47d2-ad93-24c612401bec	60798b18-088a-45aa-acb2-07a182d7fc28	t
4526389f-2b6f-455d-b72c-22433e78dfb2	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
4526389f-2b6f-455d-b72c-22433e78dfb2	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
4526389f-2b6f-455d-b72c-22433e78dfb2	13abfbed-bcba-491f-beae-6d1a5952db20	t
4526389f-2b6f-455d-b72c-22433e78dfb2	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
4526389f-2b6f-455d-b72c-22433e78dfb2	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
4526389f-2b6f-455d-b72c-22433e78dfb2	e993c288-5b50-442f-94d1-7f7079408c6e	f
4526389f-2b6f-455d-b72c-22433e78dfb2	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
4526389f-2b6f-455d-b72c-22433e78dfb2	a4c76b2a-f249-46e7-a004-da2daf09af48	f
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	13abfbed-bcba-491f-beae-6d1a5952db20	t
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	e993c288-5b50-442f-94d1-7f7079408c6e	f
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	a4c76b2a-f249-46e7-a004-da2daf09af48	f
cf574201-6984-485a-be52-c1111a32c8dc	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
cf574201-6984-485a-be52-c1111a32c8dc	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
cf574201-6984-485a-be52-c1111a32c8dc	13abfbed-bcba-491f-beae-6d1a5952db20	t
cf574201-6984-485a-be52-c1111a32c8dc	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
cf574201-6984-485a-be52-c1111a32c8dc	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
cf574201-6984-485a-be52-c1111a32c8dc	e993c288-5b50-442f-94d1-7f7079408c6e	f
cf574201-6984-485a-be52-c1111a32c8dc	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
cf574201-6984-485a-be52-c1111a32c8dc	a4c76b2a-f249-46e7-a004-da2daf09af48	f
5176d938-c687-4380-8d78-6e99dbc77b25	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
5176d938-c687-4380-8d78-6e99dbc77b25	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
5176d938-c687-4380-8d78-6e99dbc77b25	13abfbed-bcba-491f-beae-6d1a5952db20	t
5176d938-c687-4380-8d78-6e99dbc77b25	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
5176d938-c687-4380-8d78-6e99dbc77b25	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
5176d938-c687-4380-8d78-6e99dbc77b25	e993c288-5b50-442f-94d1-7f7079408c6e	f
5176d938-c687-4380-8d78-6e99dbc77b25	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
5176d938-c687-4380-8d78-6e99dbc77b25	a4c76b2a-f249-46e7-a004-da2daf09af48	f
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	13abfbed-bcba-491f-beae-6d1a5952db20	t
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	e993c288-5b50-442f-94d1-7f7079408c6e	f
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	a4c76b2a-f249-46e7-a004-da2daf09af48	f
af9205c2-7b51-47d2-ad93-24c612401bec	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
af9205c2-7b51-47d2-ad93-24c612401bec	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
af9205c2-7b51-47d2-ad93-24c612401bec	13abfbed-bcba-491f-beae-6d1a5952db20	t
af9205c2-7b51-47d2-ad93-24c612401bec	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
af9205c2-7b51-47d2-ad93-24c612401bec	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
af9205c2-7b51-47d2-ad93-24c612401bec	e993c288-5b50-442f-94d1-7f7079408c6e	f
af9205c2-7b51-47d2-ad93-24c612401bec	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
af9205c2-7b51-47d2-ad93-24c612401bec	a4c76b2a-f249-46e7-a004-da2daf09af48	f
16475946-e318-47c7-b025-8b35702d5163	60798b18-088a-45aa-acb2-07a182d7fc28	t
16475946-e318-47c7-b025-8b35702d5163	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
16475946-e318-47c7-b025-8b35702d5163	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
16475946-e318-47c7-b025-8b35702d5163	13abfbed-bcba-491f-beae-6d1a5952db20	t
16475946-e318-47c7-b025-8b35702d5163	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
16475946-e318-47c7-b025-8b35702d5163	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
16475946-e318-47c7-b025-8b35702d5163	e993c288-5b50-442f-94d1-7f7079408c6e	f
16475946-e318-47c7-b025-8b35702d5163	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
16475946-e318-47c7-b025-8b35702d5163	a4c76b2a-f249-46e7-a004-da2daf09af48	f
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	91e51416-599c-4359-bf95-4dd8fd6ad321	t
4ec4f635-04a9-4944-8d65-e6588aaa18da	91e51416-599c-4359-bf95-4dd8fd6ad321	t
696fe535-97a2-408e-aae3-a1e52c1697f7	91e51416-599c-4359-bf95-4dd8fd6ad321	t
e86a568f-6381-4ead-93d5-8f148244a70f	91e51416-599c-4359-bf95-4dd8fd6ad321	t
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	91e51416-599c-4359-bf95-4dd8fd6ad321	t
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	91e51416-599c-4359-bf95-4dd8fd6ad321	t
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	aec45149-e526-42fa-b0ef-c171a92e5365	t
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	c535e83f-3036-42d1-8176-74b08f7595b6	t
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
4ec4f635-04a9-4944-8d65-e6588aaa18da	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
4ec4f635-04a9-4944-8d65-e6588aaa18da	aec45149-e526-42fa-b0ef-c171a92e5365	t
4ec4f635-04a9-4944-8d65-e6588aaa18da	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
4ec4f635-04a9-4944-8d65-e6588aaa18da	c535e83f-3036-42d1-8176-74b08f7595b6	t
4ec4f635-04a9-4944-8d65-e6588aaa18da	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
4ec4f635-04a9-4944-8d65-e6588aaa18da	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
4ec4f635-04a9-4944-8d65-e6588aaa18da	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
4ec4f635-04a9-4944-8d65-e6588aaa18da	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
696fe535-97a2-408e-aae3-a1e52c1697f7	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
696fe535-97a2-408e-aae3-a1e52c1697f7	aec45149-e526-42fa-b0ef-c171a92e5365	t
696fe535-97a2-408e-aae3-a1e52c1697f7	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
696fe535-97a2-408e-aae3-a1e52c1697f7	c535e83f-3036-42d1-8176-74b08f7595b6	t
696fe535-97a2-408e-aae3-a1e52c1697f7	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
696fe535-97a2-408e-aae3-a1e52c1697f7	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
696fe535-97a2-408e-aae3-a1e52c1697f7	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
696fe535-97a2-408e-aae3-a1e52c1697f7	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
e86a568f-6381-4ead-93d5-8f148244a70f	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
e86a568f-6381-4ead-93d5-8f148244a70f	aec45149-e526-42fa-b0ef-c171a92e5365	t
e86a568f-6381-4ead-93d5-8f148244a70f	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
e86a568f-6381-4ead-93d5-8f148244a70f	c535e83f-3036-42d1-8176-74b08f7595b6	t
e86a568f-6381-4ead-93d5-8f148244a70f	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
e86a568f-6381-4ead-93d5-8f148244a70f	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
e86a568f-6381-4ead-93d5-8f148244a70f	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
e86a568f-6381-4ead-93d5-8f148244a70f	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	aec45149-e526-42fa-b0ef-c171a92e5365	t
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	c535e83f-3036-42d1-8176-74b08f7595b6	t
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
6e1e2558-506a-4fd2-a7bf-9e122d37a27a	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	aec45149-e526-42fa-b0ef-c171a92e5365	t
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	c535e83f-3036-42d1-8176-74b08f7595b6	t
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
3c03f823-8719-47bf-8648-c07fa53d06bc	91e51416-599c-4359-bf95-4dd8fd6ad321	t
3c03f823-8719-47bf-8648-c07fa53d06bc	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
3c03f823-8719-47bf-8648-c07fa53d06bc	aec45149-e526-42fa-b0ef-c171a92e5365	t
3c03f823-8719-47bf-8648-c07fa53d06bc	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
3c03f823-8719-47bf-8648-c07fa53d06bc	c535e83f-3036-42d1-8176-74b08f7595b6	t
3c03f823-8719-47bf-8648-c07fa53d06bc	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
3c03f823-8719-47bf-8648-c07fa53d06bc	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
3c03f823-8719-47bf-8648-c07fa53d06bc	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
3c03f823-8719-47bf-8648-c07fa53d06bc	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
3269b142-f564-4374-b84a-512b0f02885b	91e51416-599c-4359-bf95-4dd8fd6ad321	t
3269b142-f564-4374-b84a-512b0f02885b	ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	t
3269b142-f564-4374-b84a-512b0f02885b	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
3269b142-f564-4374-b84a-512b0f02885b	aec45149-e526-42fa-b0ef-c171a92e5365	t
3269b142-f564-4374-b84a-512b0f02885b	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
3269b142-f564-4374-b84a-512b0f02885b	c535e83f-3036-42d1-8176-74b08f7595b6	t
3269b142-f564-4374-b84a-512b0f02885b	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
3269b142-f564-4374-b84a-512b0f02885b	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
3269b142-f564-4374-b84a-512b0f02885b	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
3269b142-f564-4374-b84a-512b0f02885b	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
fb69a878-50d1-43ed-a604-447f75565cf8	91e51416-599c-4359-bf95-4dd8fd6ad321	t
fb69a878-50d1-43ed-a604-447f75565cf8	ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	t
fb69a878-50d1-43ed-a604-447f75565cf8	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
fb69a878-50d1-43ed-a604-447f75565cf8	aec45149-e526-42fa-b0ef-c171a92e5365	t
fb69a878-50d1-43ed-a604-447f75565cf8	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
fb69a878-50d1-43ed-a604-447f75565cf8	c535e83f-3036-42d1-8176-74b08f7595b6	t
fb69a878-50d1-43ed-a604-447f75565cf8	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
fb69a878-50d1-43ed-a604-447f75565cf8	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
fb69a878-50d1-43ed-a604-447f75565cf8	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
fb69a878-50d1-43ed-a604-447f75565cf8	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
a284c132-cb55-40c2-b25d-a3db6943a0de	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
a284c132-cb55-40c2-b25d-a3db6943a0de	91e51416-599c-4359-bf95-4dd8fd6ad321	t
a284c132-cb55-40c2-b25d-a3db6943a0de	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
a284c132-cb55-40c2-b25d-a3db6943a0de	aec45149-e526-42fa-b0ef-c171a92e5365	t
a284c132-cb55-40c2-b25d-a3db6943a0de	c535e83f-3036-42d1-8176-74b08f7595b6	t
fb69a878-50d1-43ed-a604-447f75565cf8	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
fb69a878-50d1-43ed-a604-447f75565cf8	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
fb69a878-50d1-43ed-a604-447f75565cf8	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
346a601f-75f5-4939-9bb8-e66f0e944e68	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
346a601f-75f5-4939-9bb8-e66f0e944e68	91e51416-599c-4359-bf95-4dd8fd6ad321	t
346a601f-75f5-4939-9bb8-e66f0e944e68	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
346a601f-75f5-4939-9bb8-e66f0e944e68	aec45149-e526-42fa-b0ef-c171a92e5365	t
346a601f-75f5-4939-9bb8-e66f0e944e68	c535e83f-3036-42d1-8176-74b08f7595b6	t
346a601f-75f5-4939-9bb8-e66f0e944e68	02f9474c-8b44-4344-8097-ddd907607de4	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	91e51416-599c-4359-bf95-4dd8fd6ad321	t
bcb21012-4bae-4531-9f4e-c53b4205c30e	ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	t
bcb21012-4bae-4531-9f4e-c53b4205c30e	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
bcb21012-4bae-4531-9f4e-c53b4205c30e	aec45149-e526-42fa-b0ef-c171a92e5365	t
bcb21012-4bae-4531-9f4e-c53b4205c30e	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
bcb21012-4bae-4531-9f4e-c53b4205c30e	c535e83f-3036-42d1-8176-74b08f7595b6	t
bcb21012-4bae-4531-9f4e-c53b4205c30e	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
bcb21012-4bae-4531-9f4e-c53b4205c30e	02f9474c-8b44-4344-8097-ddd907607de4	f
a284c132-cb55-40c2-b25d-a3db6943a0de	02f9474c-8b44-4344-8097-ddd907607de4	f
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	91e51416-599c-4359-bf95-4dd8fd6ad321	t
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	aec45149-e526-42fa-b0ef-c171a92e5365	t
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	c535e83f-3036-42d1-8176-74b08f7595b6	t
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	02f9474c-8b44-4344-8097-ddd907607de4	f
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
a2714f12-c8ff-43d4-b011-673371652f85	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
a2714f12-c8ff-43d4-b011-673371652f85	91e51416-599c-4359-bf95-4dd8fd6ad321	t
a2714f12-c8ff-43d4-b011-673371652f85	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
a2714f12-c8ff-43d4-b011-673371652f85	aec45149-e526-42fa-b0ef-c171a92e5365	t
a2714f12-c8ff-43d4-b011-673371652f85	c535e83f-3036-42d1-8176-74b08f7595b6	t
a2714f12-c8ff-43d4-b011-673371652f85	02f9474c-8b44-4344-8097-ddd907607de4	f
a2714f12-c8ff-43d4-b011-673371652f85	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
a2714f12-c8ff-43d4-b011-673371652f85	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
a2714f12-c8ff-43d4-b011-673371652f85	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
f691313d-52dc-4dd4-899c-b07faf56e2c2	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
f691313d-52dc-4dd4-899c-b07faf56e2c2	91e51416-599c-4359-bf95-4dd8fd6ad321	t
f691313d-52dc-4dd4-899c-b07faf56e2c2	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
f691313d-52dc-4dd4-899c-b07faf56e2c2	aec45149-e526-42fa-b0ef-c171a92e5365	t
f691313d-52dc-4dd4-899c-b07faf56e2c2	c535e83f-3036-42d1-8176-74b08f7595b6	t
f691313d-52dc-4dd4-899c-b07faf56e2c2	02f9474c-8b44-4344-8097-ddd907607de4	f
f691313d-52dc-4dd4-899c-b07faf56e2c2	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
f691313d-52dc-4dd4-899c-b07faf56e2c2	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
f691313d-52dc-4dd4-899c-b07faf56e2c2	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
c868ffd4-4425-4a17-b483-4a22950bd748	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
c868ffd4-4425-4a17-b483-4a22950bd748	91e51416-599c-4359-bf95-4dd8fd6ad321	t
c868ffd4-4425-4a17-b483-4a22950bd748	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
c868ffd4-4425-4a17-b483-4a22950bd748	aec45149-e526-42fa-b0ef-c171a92e5365	t
c868ffd4-4425-4a17-b483-4a22950bd748	c535e83f-3036-42d1-8176-74b08f7595b6	t
c868ffd4-4425-4a17-b483-4a22950bd748	02f9474c-8b44-4344-8097-ddd907607de4	f
c868ffd4-4425-4a17-b483-4a22950bd748	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
c868ffd4-4425-4a17-b483-4a22950bd748	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
c868ffd4-4425-4a17-b483-4a22950bd748	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
fb69a878-50d1-43ed-a604-447f75565cf8	a0d4942d-eec5-442f-91ae-8807af29975e	f
76757943-77e3-408d-8f41-105880b46eed	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
76757943-77e3-408d-8f41-105880b46eed	91e51416-599c-4359-bf95-4dd8fd6ad321	t
76757943-77e3-408d-8f41-105880b46eed	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
76757943-77e3-408d-8f41-105880b46eed	aec45149-e526-42fa-b0ef-c171a92e5365	t
76757943-77e3-408d-8f41-105880b46eed	c535e83f-3036-42d1-8176-74b08f7595b6	t
76757943-77e3-408d-8f41-105880b46eed	02f9474c-8b44-4344-8097-ddd907607de4	f
76757943-77e3-408d-8f41-105880b46eed	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
76757943-77e3-408d-8f41-105880b46eed	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
76757943-77e3-408d-8f41-105880b46eed	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	91e51416-599c-4359-bf95-4dd8fd6ad321	t
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	aec45149-e526-42fa-b0ef-c171a92e5365	t
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	c535e83f-3036-42d1-8176-74b08f7595b6	t
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	02f9474c-8b44-4344-8097-ddd907607de4	f
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	91e51416-599c-4359-bf95-4dd8fd6ad321	t
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	aec45149-e526-42fa-b0ef-c171a92e5365	t
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	c535e83f-3036-42d1-8176-74b08f7595b6	t
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	02f9474c-8b44-4344-8097-ddd907607de4	f
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
a8a02f01-0c19-461d-a919-33ce6926d2fe	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
a8a02f01-0c19-461d-a919-33ce6926d2fe	91e51416-599c-4359-bf95-4dd8fd6ad321	t
a8a02f01-0c19-461d-a919-33ce6926d2fe	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
a8a02f01-0c19-461d-a919-33ce6926d2fe	aec45149-e526-42fa-b0ef-c171a92e5365	t
a8a02f01-0c19-461d-a919-33ce6926d2fe	c535e83f-3036-42d1-8176-74b08f7595b6	t
a8a02f01-0c19-461d-a919-33ce6926d2fe	02f9474c-8b44-4344-8097-ddd907607de4	f
a8a02f01-0c19-461d-a919-33ce6926d2fe	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
a8a02f01-0c19-461d-a919-33ce6926d2fe	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
a8a02f01-0c19-461d-a919-33ce6926d2fe	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
a9402390-c5f9-4899-8135-9e901af9710c	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
a9402390-c5f9-4899-8135-9e901af9710c	91e51416-599c-4359-bf95-4dd8fd6ad321	t
a9402390-c5f9-4899-8135-9e901af9710c	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
a9402390-c5f9-4899-8135-9e901af9710c	aec45149-e526-42fa-b0ef-c171a92e5365	t
a9402390-c5f9-4899-8135-9e901af9710c	c535e83f-3036-42d1-8176-74b08f7595b6	t
a9402390-c5f9-4899-8135-9e901af9710c	02f9474c-8b44-4344-8097-ddd907607de4	f
a9402390-c5f9-4899-8135-9e901af9710c	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
a9402390-c5f9-4899-8135-9e901af9710c	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
a9402390-c5f9-4899-8135-9e901af9710c	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
b63fb8a7-600a-4fb6-bab1-3c400398b314	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
b63fb8a7-600a-4fb6-bab1-3c400398b314	91e51416-599c-4359-bf95-4dd8fd6ad321	t
b63fb8a7-600a-4fb6-bab1-3c400398b314	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
b63fb8a7-600a-4fb6-bab1-3c400398b314	aec45149-e526-42fa-b0ef-c171a92e5365	t
b63fb8a7-600a-4fb6-bab1-3c400398b314	c535e83f-3036-42d1-8176-74b08f7595b6	t
b63fb8a7-600a-4fb6-bab1-3c400398b314	02f9474c-8b44-4344-8097-ddd907607de4	f
b63fb8a7-600a-4fb6-bab1-3c400398b314	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
b63fb8a7-600a-4fb6-bab1-3c400398b314	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
b63fb8a7-600a-4fb6-bab1-3c400398b314	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	91e51416-599c-4359-bf95-4dd8fd6ad321	t
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	aec45149-e526-42fa-b0ef-c171a92e5365	t
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	c535e83f-3036-42d1-8176-74b08f7595b6	t
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	02f9474c-8b44-4344-8097-ddd907607de4	f
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
3fe58830-bb3b-4a75-a01e-de1928321a72	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
3fe58830-bb3b-4a75-a01e-de1928321a72	91e51416-599c-4359-bf95-4dd8fd6ad321	t
3fe58830-bb3b-4a75-a01e-de1928321a72	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
3fe58830-bb3b-4a75-a01e-de1928321a72	aec45149-e526-42fa-b0ef-c171a92e5365	t
3fe58830-bb3b-4a75-a01e-de1928321a72	c535e83f-3036-42d1-8176-74b08f7595b6	t
3fe58830-bb3b-4a75-a01e-de1928321a72	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
3fe58830-bb3b-4a75-a01e-de1928321a72	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
3fe58830-bb3b-4a75-a01e-de1928321a72	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	1dd17233-c710-4bd8-a7ec-eb82fcac3b2d	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
a4c76b2a-f249-46e7-a004-da2daf09af48	51c63cc5-a9f5-4215-b691-790e66be86ba
272fb0a2-efb1-4e8e-b30c-2601fc096c78	725b7f81-2afb-4a73-b6ce-56770a9f81a5
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
6babb5d7-3a46-4c68-be16-c76b9b07600d	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
59546fdd-19da-4829-83be-ce553632a806	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
59cdcfa1-5704-4f48-a197-434dc2722bab	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
71d33798-3e3f-49bb-8f53-0689e794f271	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
2cb34bf7-49df-4a18-a385-50849a92ac38	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5ccc2724-4c21-4ae5-b84e-3223770594a5	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
90dc6987-f13e-4892-a156-0882bd305e0e	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
3815c82c-d42f-49a3-84d5-b00dc096d7bd	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
8b14df0f-8410-449a-a7a7-4c9296495cad	fallback-HS256	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
779c267d-6181-4b62-8475-9d085cb7c371	fallback-RS256	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
92fa7406-086d-4269-a9ae-e0d15b25b617	rsa-generated	Company	rsa-generated	org.keycloak.keys.KeyProvider	Company	\N
81bf06d6-591c-48ee-a918-1c7f0be65cd8	hmac-generated	Company	hmac-generated	org.keycloak.keys.KeyProvider	Company	\N
97a8c3c0-5e2f-4599-a4b0-64e3d4c6db81	aes-generated	Company	aes-generated	org.keycloak.keys.KeyProvider	Company	\N
62540e90-63fe-4dbd-9407-6ce1ae16a103	Trusted Hosts	Company	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	anonymous
c5c9f4da-c039-4883-809d-9c77cea63971	Consent Required	Company	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	anonymous
09030eed-dc45-4c90-9553-626386c9959b	Full Scope Disabled	Company	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	anonymous
419aa862-e4ab-4e3a-8e7c-8650fdcc874c	Max Clients Limit	Company	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	anonymous
ebef73b4-6f4e-458b-bc20-3c4995da3ed3	Allowed Protocol Mapper Types	Company	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	anonymous
6d65988c-739c-4010-b8b8-af2ebe56731a	Allowed Client Scopes	Company	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	anonymous
c774ccbc-9639-47db-9a87-95a0941880cd	Allowed Protocol Mapper Types	Company	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	authenticated
b8061ccb-b92f-4759-8b60-cc10982afe2d	Allowed Client Scopes	Company	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Company	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
7b886ab2-3570-40e3-9f3b-0a0732de6baa	5ccc2724-4c21-4ae5-b84e-3223770594a5	allow-default-scopes	true
7a773c18-b85d-46b9-acaa-9b4b98a05da6	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a5d12603-04d3-40c1-9348-f33abaad6bcb	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	oidc-address-mapper
9f0af733-d123-48d8-a496-0619fab8a6ea	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fb584e2f-f4f6-4c39-8455-558ea11c9b70	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9a886d73-d31f-44ab-be33-3dabfb7c069b	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	oidc-full-name-mapper
d3bf71bf-52c2-40cb-8a19-2f2e5c9da68e	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	saml-user-property-mapper
e3374875-08cd-4ec5-8805-67cdd050f376	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	saml-role-list-mapper
d1e2c766-929b-4a96-9c76-d1a99d26010f	90dc6987-f13e-4892-a156-0882bd305e0e	allowed-protocol-mapper-types	saml-user-attribute-mapper
b6ca9578-9e30-4fd6-beae-22f048482946	71d33798-3e3f-49bb-8f53-0689e794f271	max-clients	200
a8ad765e-c8e1-4488-9a54-d1b43d97b7d5	6babb5d7-3a46-4c68-be16-c76b9b07600d	client-uris-must-match	true
9a3d50e6-0321-4455-b6cf-41c4403c4d9a	6babb5d7-3a46-4c68-be16-c76b9b07600d	host-sending-registration-request-must-match	true
73cc14d8-cd97-4c61-bb36-b60b8b1b0118	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	saml-user-property-mapper
63a52c8f-58c9-4339-8a90-7ca8beac67fe	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
23106c2e-17a4-48a6-b922-41ad32eb56ad	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	saml-role-list-mapper
f51ac86d-011f-41cd-af35-6eec9575fd35	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	saml-user-attribute-mapper
386c04a3-9734-4ec1-a8f6-b87df1d1c4e6	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	oidc-address-mapper
94d70968-03f2-4f63-96a5-c7b19b89e99b	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
17b77f48-4f32-4815-8dc9-ba144e7fcff5	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d305878b-30e8-4830-b2e3-adde298c2078	2cb34bf7-49df-4a18-a385-50849a92ac38	allowed-protocol-mapper-types	oidc-full-name-mapper
f5375dc1-1abd-4040-9e7e-217bbdb75ccc	3815c82c-d42f-49a3-84d5-b00dc096d7bd	allow-default-scopes	true
bb3613eb-3184-40bc-9724-1d751d6b4482	8b14df0f-8410-449a-a7a7-4c9296495cad	secret	RcjVOeHZ7Pc9NBTpFPNvXPsearWo0FLYUYGOkIQYFdQwdm-P4wbv4gGHSuS1IKWCIK8d3-vaYzEGY6PcTSU7dQ
6de68192-2366-4211-b2ac-55c89480debc	8b14df0f-8410-449a-a7a7-4c9296495cad	priority	-100
6aeb84c5-6244-4e1e-a692-9a81a35cbdd6	8b14df0f-8410-449a-a7a7-4c9296495cad	algorithm	HS256
a905f18e-cdf1-46e2-bfcc-090cde20305b	8b14df0f-8410-449a-a7a7-4c9296495cad	kid	8c8618d5-89ba-447e-8e0f-2401279fac44
d08778d3-930b-4ae6-9546-63e50996e6d0	779c267d-6181-4b62-8475-9d085cb7c371	algorithm	RS256
317df272-600f-4498-9a10-d0ea2d3f20b6	779c267d-6181-4b62-8475-9d085cb7c371	privateKey	MIIEowIBAAKCAQEAhLi35WCLEFl9aHeWTHYbyCvEiSoG/dVs7uRi/1dX6onDzYuw5eICT/qPhO1P+UIBaPG6tEg2ok8BkydVNl+MiDht4Q4+w4dG3vosnCG2wBsR8KJS6foPwGxa8EWjDjnYFgGBU4XibTf8ZwEEdIhqyXUFzVPMwh5T3SfXEvg2vRy0UJz3sAuGhBlN01XTCKfwGWdiIs6LZgele7Nya/7DWJDa9YRtiwSIB/2VCgesziupa9UseOYk260s13fJfMJV4Bg6ewZbDBIQRcRn9OAnLOyylppECcxyWG/fG8Co0ox9lMMzUGITFTaonk7rK4F/J6E/fljLeKYcmjzevaYc5wIDAQABAoIBAH5zH4JDATuKh5lIlsIypTWJva6RhCfDeA4DOu7cYL7sksj7FodvVZStvJ+BGnj5Ei7SYHfzdVoeu/lfuCgd0N7YJJgP4myYLkWzRV1cIanWILmLbkPOI8PJeLsDHd8n7WDJ/lV9ccVtWeUpav08G8Hk5KpD9QndqzlCA//mzQBPPwRNLSkHrcRyHhFq6NboZBE3iMBMsszscLEz1BvEB7zB1FHncAqgcH3NDLmwnzFsT/Jt/kDxHyge8fpG4ifyXD0pRSm33omg2NoEZR4oBisYnfP67iPZU8TTN9yNiQK4hyB/+nAkMfYsbQr/nGjM4AJx7WCd5EZYQEAZWsyo7wECgYEA0DA07VAq09SVhtssnynmQIcJ+JDKPgGGHOU31xpvsOaCW0ro9P0dfWzl1FagGiI7bYakeoJc9CH24AHCeFb32CCJ2jhVbJoiyRHFBwO3QX1BSOe6gmw8wiQZE1jLiMIwIdvaTdWgEWpwrRYXq+G5Crd4kNh1GO44Rd0VKwmwJhECgYEAozOs4XK3tByjnX8PrOSOmtX7kD3dIIQpHavRF9wi2iiL62W+60+uDlHDYdEqIsjBOgfmiGCtd1Zvk2oOi9SoyfnqqgwPMjPhbTS6/sumG6DqL85TPA+bdwJ87CsbR/Jw+0mf8DRXywvVavyzVIH+/z+TLtFmpU4gAusZwBOWu3cCgYAiDPBrLCSFFw0JzIlE0xaM0UlpNU1OzPMBgOAcN3+zIFCL2/m0MD4FiK0iiLSQ8a5koJQAUZggefml88O56QeKeu/xGCuooqEz38so9Yugk3r9EKGpuUhKvJq5Vlmb2Z8DurC+8ETI9G7PcICYpUedoBqBHlYwqK3dh2Zx7pi38QKBgQChKZCZeb2rYXS5PRZvt6yTfqhTwqOxTpGDuX5cP4kzQkMaDHnCygaqIVf+Kp2fh/w4oECpgD8M0BCS1HLU5wZfnip8DjibbNw6CY53uwen1Pouh2NutkLh/VT7q33fSK0FmakVfbsMyfzREAbPdygnS9K+sw7YQxQdjaj6It4A9QKBgElMfv7nN5ARm2oxomGjuazn6703t4pKE2MnmyKjVTtpVEZk76pAC/K26Ada2mlUwUXUnoTgw6d32ADXoY37pSFkf1SS3sDhHqxjfQ4ephkTDkAvhdS3e/7eoajlK6NXTqlpeeE6aPNyLcM0cpwfDlWaw6FDMmtDgBhBAu+3lkeN
221cf547-ccc8-4ef2-805b-e195ed88c092	779c267d-6181-4b62-8475-9d085cb7c371	certificate	MIICmzCCAYMCBgF5nfinzDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwNTI0MTA0MTI5WhcNMzEwNTI0MTA0MzA5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCEuLflYIsQWX1od5ZMdhvIK8SJKgb91Wzu5GL/V1fqicPNi7Dl4gJP+o+E7U/5QgFo8bq0SDaiTwGTJ1U2X4yIOG3hDj7Dh0be+iycIbbAGxHwolLp+g/AbFrwRaMOOdgWAYFTheJtN/xnAQR0iGrJdQXNU8zCHlPdJ9cS+Da9HLRQnPewC4aEGU3TVdMIp/AZZ2IizotmB6V7s3Jr/sNYkNr1hG2LBIgH/ZUKB6zOK6lr1Sx45iTbrSzXd8l8wlXgGDp7BlsMEhBFxGf04Ccs7LKWmkQJzHJYb98bwKjSjH2UwzNQYhMVNqieTusrgX8noT9+WMt4phyaPN69phznAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGNs5paYge7wLkG+JJH04DwAqtI8kyGR0Uuc9807pJzXHv87GaHpkLqD/ICAbpCkRlIfUmXLuceZsuTzTNrrKnwdHp8zaQ1YXZUeicGgQWlRTccW3UypZ2DYdLtYNiUHKLKGAIskAHn/S93FB/8PNTTtIfXNeAYsb0iM9eX+KBheNgd1tbjjXpjt6omL12lbOAOAjCCAJZZSuE3O1mmwKbOISiJdv255+7BfY+tSupWUtn9c694VgHLNaFSd09CefGw/TsOKNE792kNXR4nMtGRKLLtP6kJs8/PxdvZKX+C14sirLRv9wb1BKRCMfWfgM+0b0qX9rcbuGzgkW+Ad4Bc=
f61fd3c3-4dec-43d7-8f7d-c016d6a5ece3	779c267d-6181-4b62-8475-9d085cb7c371	priority	-100
cc0e9830-0d70-4e21-ae75-ab377fd10661	81bf06d6-591c-48ee-a918-1c7f0be65cd8	priority	100
d0ff5fe0-ba1b-47de-a49b-c565d7411248	81bf06d6-591c-48ee-a918-1c7f0be65cd8	kid	1a30a742-c44e-4052-892b-c13000b0b69c
844451ec-a45b-4a1c-a954-a921c09af25c	81bf06d6-591c-48ee-a918-1c7f0be65cd8	secret	5QfBEammYxqiRzgXRVbrm_VFsYFGbaLQPqg98R24PTW6M6BWSa1UpHHKHzSJx9uRTdeDIH9WM_AxoU7vRvtI_g
d69a5935-328c-4d34-a31a-a48ec3764015	81bf06d6-591c-48ee-a918-1c7f0be65cd8	algorithm	HS256
08f2548f-09d7-4541-b095-bbbc1044673e	92fa7406-086d-4269-a9ae-e0d15b25b617	certificate	MIICnTCCAYUCBgF5nfjW5DANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdDb21wYW55MB4XDTIxMDUyNDEwNDE0MVoXDTMxMDUyNDEwNDMyMVowEjEQMA4GA1UEAwwHQ29tcGFueTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIo9QFyblWoqESF/nJVkWBWMEUs2IermGJh1vur3xxyKI/Iwi9Cz9com9x0zjaaFWb+bJWYOnjQVDwKb8QlOEx3BYsFV1oKgnmwBVU5FFE/rfD/iUtdTy68n4BD/5zK5gnxUPs2unChc9A2ukQX15SkAoJxEIFXuy58gAHbCd7vOatoOeBF5Osg+H8ICsFjxshNz4SMRsqpJq5l9KOlq4xNsCiACJHQERMWxak4yuCH0JEd+azAH1wf1JQw+PWjo+egr8fScYq5xM1NENdWICgfGinhxRen/HL6NbzlFe3OPNjMUcj7DHrWD2k3c/MF3XACEVcHsUqvJfgSeCw9sxhUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEACynGUUbMmnq3nk72v+wbesVv8PoOiv7sZPXXO4FOJLSymYZyyy/yCVWHVovPZZCLFXrv2t1xBGIiedw2stftDDOQICQffRpO1hVJfnutlQ2AngNm1CzYzn/qGPPwagT3Fwme8NXB63MNLiIns02CBa14MxoLByie4dtnfd6WJjzHplM9AJQCuHWCLPgUkvJd4DyizDTYuUyxV4nXwcIiLXwbX2TB+hBigzwZw+UfUUv1dJjzA+dQLH4gLbzkAex6x2rTZH/Y1m2yQrpd4lD0XUqqA6PAqP9wwg6TruFBsFAiuCE/rno2uqoIlpy/aVRzq+DNdTmRFtPEYSBIBzfYTQ==
6af5b2ed-0c4e-4e06-810a-cf6772a106b6	92fa7406-086d-4269-a9ae-e0d15b25b617	privateKey	MIIEogIBAAKCAQEAij1AXJuVaioRIX+clWRYFYwRSzYh6uYYmHW+6vfHHIoj8jCL0LP1yib3HTONpoVZv5slZg6eNBUPApvxCU4THcFiwVXWgqCebAFVTkUUT+t8P+JS11PLryfgEP/nMrmCfFQ+za6cKFz0Da6RBfXlKQCgnEQgVe7LnyAAdsJ3u85q2g54EXk6yD4fwgKwWPGyE3PhIxGyqkmrmX0o6WrjE2wKIAIkdARExbFqTjK4IfQkR35rMAfXB/UlDD49aOj56Cvx9JxirnEzU0Q11YgKB8aKeHFF6f8cvo1vOUV7c482MxRyPsMetYPaTdz8wXdcAIRVwexSq8l+BJ4LD2zGFQIDAQABAoIBAAWO3uaaTtCc7mFlaxtKlIwRPKTEgWqbY8PFgC6cVcIc/8L+FrEGe0xscqUW7IwUcn5Us5U94zh+3EKjmHZiUDxzCRBy7hQEdzoqd46VEnMAKde7ts73jIn3VXf5ggc1FD0BeiD080xgKGPgb+5Ia7VRVCPUTWSHHGLCe6JKwVuoqttGxtrK0+93q4y4r5a2nBBpyAnOqMAI5TQIrbDpI8Otk+zsA5qNw1kRXgwcYinsSnwwtDLA0J8geZ/D9Jf0cXmCT5ZG1Kxy3iqPv8bdbKku4YwY5sM0m8yXHNkAPqCDsAeP2/+NXpGQnuCYPTH9MQjF78Ym3h8rLsz1Rx3/S0UCgYEAwPOmdl0UMGM624qBqpi0AC1t4mygljDhcbCqGlNiK6EkspQXCtD1F+S4dvx0uROIIPnUkq0/GbPJ0mM7kg6dwLRYy7NdtkAkSOWIo5LLY5j0Yc2dR1arAsCG076SPWaBJJB0d3aAgIbAbvVZF2lW65MOX07K24/27su1ceDlUxcCgYEAt2jrWIE5vIu335/r3ITcXlgYzIYvk1KtYGOjYZhh1o2kjQeZ1B3sToKp9AzRf13Zdyk2Y7AOdaKQGHEXOyYeZNQ/E+7RYWare9N1+fYQJrbCWVfpk4Bx1IIQ9dI6B9zWDjXrtIAKEA2dlWR0LWj+buBlfZT5mw1RJ1nu5/JZ27MCgYBCbqENd5aP4lpNZC6osdKnjPycTJIto767CfxG/BZ8twqPgXU9gBwikdkA/oKhhhwEXn/V0Fg9XS1LhmboLqgZxP4dhC/ro8HaZ0zYJJ5qOCtL0SMpgKl4VRkWpjJreXNVR3cR+nbbyYlPqqF18gq/KO512gb1+WcnaHOcNbY/GQKBgBOQlqJfTphlUx0AwzlH1vYdca/HlKWjiSkiF9ieV7l6bJY6vFcbRgzt9VE6WNK8YSlL9ShXLIOx7qsczTybCVz6IyxuKlm4iQxxd0FN1VU746mCLkF0zy+7HDIM1fHmxdLIP7eGfQxPV4MLLzV04MdVGp512NaIaiLHfiux95HvAoGAKeQn/5Qv0EI6jQ1PmhVNiqrHdjTrA5v3dEqP2vXivMPTdvR8QS+sqsvTlFF6rsxh63izBqdJAs85tnG/GQF/rxheHzw7h89b/TjBHHobwOntM98VzKVIhW+MsqT4pzP3fJEm0Mil68vTXmOVZGyzxQN8xvGiTCN3k2ZoCqahLSk=
e0f4405b-720a-453e-b906-fa98a9d371c2	92fa7406-086d-4269-a9ae-e0d15b25b617	priority	100
aef2d80d-98a7-40e2-be32-15d0983f2cea	97a8c3c0-5e2f-4599-a4b0-64e3d4c6db81	secret	JruGLj49AqkK1pdDOITELA
677b55a2-27cb-4185-82c0-16e499ba20cb	97a8c3c0-5e2f-4599-a4b0-64e3d4c6db81	kid	0d79f402-a44e-4a7d-bb98-bb81aa4fe274
f6749c21-55a7-4c78-b4f0-512c3da9ae21	97a8c3c0-5e2f-4599-a4b0-64e3d4c6db81	priority	100
6597fbd0-d87a-4dbe-aaf0-1fd36f75e6d3	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	oidc-full-name-mapper
e4172bdd-b1f2-46de-9a81-2d13bb6fb2c6	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	saml-role-list-mapper
fdace12c-10b6-4834-a8a5-fe42443bf405	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	saml-user-property-mapper
0b62c07f-8ea5-45c9-85bf-2f1338102eb2	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6668669f-4ccb-4580-821e-109f310a52d0	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9084a6f6-4aa7-4f3d-8aac-c000b6837ca4	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2582bfac-4f9e-45fa-ae83-9bbe785018ec	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	oidc-address-mapper
42ea6889-c596-4b82-8002-b00044e82a27	c774ccbc-9639-47db-9a87-95a0941880cd	allowed-protocol-mapper-types	saml-user-attribute-mapper
5121faef-4a77-45a2-b2e4-8904546962d2	62540e90-63fe-4dbd-9407-6ce1ae16a103	client-uris-must-match	true
be72a2aa-0676-4b1d-a192-669c29ef3f53	62540e90-63fe-4dbd-9407-6ce1ae16a103	host-sending-registration-request-must-match	true
02c72179-0e98-4168-ae8c-5a5fade060b0	b8061ccb-b92f-4759-8b60-cc10982afe2d	allow-default-scopes	true
8e6598ca-af55-47ae-ab16-7c6e7955963f	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
61bb52ae-65cb-46be-9cdb-335179a7241f	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
66d31485-aec9-4bb5-8666-ef36479c5e4b	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	oidc-full-name-mapper
a040a1f7-bf20-44ed-9508-e4e679967a02	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	saml-user-attribute-mapper
08b1c21f-6f5c-45bc-a8c8-54325efaa456	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
961290f8-93a3-4c7e-83f9-84d33c9301a2	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	saml-user-property-mapper
97855487-378c-462c-9a10-cb3117dd94a8	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	saml-role-list-mapper
aa3ec69c-8f7a-4762-9ab3-5a3d11d300a1	ebef73b4-6f4e-458b-bc20-3c4995da3ed3	allowed-protocol-mapper-types	oidc-address-mapper
3177915c-6cbb-47f4-a45b-6420ce4e203d	6d65988c-739c-4010-b8b8-af2ebe56731a	allow-default-scopes	true
2173d9cd-deb6-4a8d-a386-6aa6da0067ce	419aa862-e4ab-4e3a-8e7c-8650fdcc874c	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
bcbf15c1-8835-4706-b40b-16261f32fae6	87102381-0102-43a8-be5c-e760872bb54c
bcbf15c1-8835-4706-b40b-16261f32fae6	4c2963fe-e90f-4087-9daa-e9f10f817145
bcbf15c1-8835-4706-b40b-16261f32fae6	512cd298-c52c-4f58-a141-48aa352cfba5
bcbf15c1-8835-4706-b40b-16261f32fae6	073c38f2-b0a3-4a2c-8570-d798c24af07a
bcbf15c1-8835-4706-b40b-16261f32fae6	c49cc1a0-fcc0-4619-abc0-64f9fea17945
bcbf15c1-8835-4706-b40b-16261f32fae6	0b3a82bd-d314-4286-91fe-eed20ca808ea
bcbf15c1-8835-4706-b40b-16261f32fae6	94b11d5b-32bf-4857-9f98-d10caa9f51db
bcbf15c1-8835-4706-b40b-16261f32fae6	2d5f9548-333a-4e77-a630-e050af0df000
bcbf15c1-8835-4706-b40b-16261f32fae6	53574b20-fa19-405b-aebe-56e97557686e
bcbf15c1-8835-4706-b40b-16261f32fae6	2ea645a1-4012-4a2e-a972-5ebd35368f66
bcbf15c1-8835-4706-b40b-16261f32fae6	ce1e2bc6-b460-4bcd-9c0a-9952ea6bc52c
bcbf15c1-8835-4706-b40b-16261f32fae6	3d01e8c7-0fa2-40f8-929c-8027c2af90be
bcbf15c1-8835-4706-b40b-16261f32fae6	eab6b109-ab2c-4a8c-875f-e4cf60b5698c
bcbf15c1-8835-4706-b40b-16261f32fae6	7a13f0a1-fda2-41f9-9520-490ccdc27a69
bcbf15c1-8835-4706-b40b-16261f32fae6	fa1db38d-0e55-44a7-9d90-656dd2a3e8e6
bcbf15c1-8835-4706-b40b-16261f32fae6	cf36deb0-340a-4526-bc2f-aaded3a9459f
bcbf15c1-8835-4706-b40b-16261f32fae6	aa49a425-0109-46b4-875b-959ff6e39ce2
bcbf15c1-8835-4706-b40b-16261f32fae6	3ce8f523-3fb8-4520-82f6-f8cc446600e8
c49cc1a0-fcc0-4619-abc0-64f9fea17945	cf36deb0-340a-4526-bc2f-aaded3a9459f
073c38f2-b0a3-4a2c-8570-d798c24af07a	fa1db38d-0e55-44a7-9d90-656dd2a3e8e6
073c38f2-b0a3-4a2c-8570-d798c24af07a	3ce8f523-3fb8-4520-82f6-f8cc446600e8
199f30c8-bd8a-47b8-ae0c-f3dd16bba2de	ccc80786-e18c-4243-b582-3b0f8b1ea5a6
e150bd8d-16bb-441a-b354-7a747470e295	7e920167-5c8b-437f-9a08-996e0d525ebe
bcbf15c1-8835-4706-b40b-16261f32fae6	3fc19cff-c99b-4168-9a6e-47195249ffa4
bcbf15c1-8835-4706-b40b-16261f32fae6	7b97f716-3601-4340-aa4c-3689bcb4f9cc
bcbf15c1-8835-4706-b40b-16261f32fae6	621df8b2-5519-4359-8161-2db2c2b3fca0
bcbf15c1-8835-4706-b40b-16261f32fae6	3fabdf22-8d74-49bd-9703-400bff8979bb
bcbf15c1-8835-4706-b40b-16261f32fae6	2c175a8c-2685-4fa7-bc94-a67f12496eae
bcbf15c1-8835-4706-b40b-16261f32fae6	b6649cb0-7cf3-4c01-93f1-9f45aad54685
bcbf15c1-8835-4706-b40b-16261f32fae6	ed162276-7483-4774-9a0c-0825a45d4b1b
bcbf15c1-8835-4706-b40b-16261f32fae6	d8ac9ad6-b2b0-43e1-aff1-cb4b80230511
bcbf15c1-8835-4706-b40b-16261f32fae6	933a2908-76bd-4ee0-a8e5-8b8c01f69ebc
bcbf15c1-8835-4706-b40b-16261f32fae6	f80bd9d7-582e-41c3-a113-f7d53a2944a8
bcbf15c1-8835-4706-b40b-16261f32fae6	bbbb8fb6-00f0-4812-9291-cd187cc1d48c
bcbf15c1-8835-4706-b40b-16261f32fae6	74cd5a0c-2de5-4fcc-99d9-795ca8099bb2
bcbf15c1-8835-4706-b40b-16261f32fae6	5b2dbfea-5103-433a-9584-c4581aa6bf58
bcbf15c1-8835-4706-b40b-16261f32fae6	f5d48e28-3949-44a6-914c-d9765f72bab6
bcbf15c1-8835-4706-b40b-16261f32fae6	1c29b53a-7b4e-410a-88b1-0bc6476e02c4
bcbf15c1-8835-4706-b40b-16261f32fae6	e45dd881-76ef-420e-865e-f22730731ace
bcbf15c1-8835-4706-b40b-16261f32fae6	4ec9fd66-a729-497b-bbea-6400f74d2c9e
bcbf15c1-8835-4706-b40b-16261f32fae6	b7729ec8-cf45-484d-bb25-af9cf19f9baa
2c175a8c-2685-4fa7-bc94-a67f12496eae	e45dd881-76ef-420e-865e-f22730731ace
3fabdf22-8d74-49bd-9703-400bff8979bb	1c29b53a-7b4e-410a-88b1-0bc6476e02c4
3fabdf22-8d74-49bd-9703-400bff8979bb	b7729ec8-cf45-484d-bb25-af9cf19f9baa
0d28815b-b5fe-4348-add3-252bf3c67e4f	e3545356-874f-4ed5-b3a4-e101637b1ab4
0d28815b-b5fe-4348-add3-252bf3c67e4f	079fe8e6-2cc0-4b40-9ede-19401c5def5f
0d28815b-b5fe-4348-add3-252bf3c67e4f	c84f7d4b-aaff-4cfd-89e0-d76e47e3e82e
0d28815b-b5fe-4348-add3-252bf3c67e4f	58714751-79ef-40ab-b7f6-6fe94ad3de95
0d28815b-b5fe-4348-add3-252bf3c67e4f	56dedb1f-6b2c-43d5-a9ed-ff5e187c6069
0d28815b-b5fe-4348-add3-252bf3c67e4f	6f04b2c6-59a0-4286-8b47-0ad45ddc707b
0d28815b-b5fe-4348-add3-252bf3c67e4f	a375428f-f88d-46d7-bb13-86957f644c1d
0d28815b-b5fe-4348-add3-252bf3c67e4f	e400897c-0fd1-44d7-a2b4-65dbe3c8df78
0d28815b-b5fe-4348-add3-252bf3c67e4f	e366f778-bcfc-47dc-ab03-690f48912906
0d28815b-b5fe-4348-add3-252bf3c67e4f	8ba80c05-0322-4f5f-a7cb-e3c650478184
0d28815b-b5fe-4348-add3-252bf3c67e4f	6b813017-2343-4419-a202-5b451899a456
0d28815b-b5fe-4348-add3-252bf3c67e4f	6491e3b5-25ca-42be-b86a-4bf8e4a758b8
0d28815b-b5fe-4348-add3-252bf3c67e4f	4a9da917-8c69-47e5-becb-9075b601c523
0d28815b-b5fe-4348-add3-252bf3c67e4f	fdc5c41b-0baf-402d-aa70-dbab46dde861
0d28815b-b5fe-4348-add3-252bf3c67e4f	aba147f7-727c-4b60-91d1-40b6e785027b
0d28815b-b5fe-4348-add3-252bf3c67e4f	8d3d17a1-abfa-467e-a98d-ab8f2d978707
0d28815b-b5fe-4348-add3-252bf3c67e4f	6b77038d-3ec6-4d38-9972-140ee4f5e45a
58714751-79ef-40ab-b7f6-6fe94ad3de95	aba147f7-727c-4b60-91d1-40b6e785027b
c84f7d4b-aaff-4cfd-89e0-d76e47e3e82e	fdc5c41b-0baf-402d-aa70-dbab46dde861
c84f7d4b-aaff-4cfd-89e0-d76e47e3e82e	6b77038d-3ec6-4d38-9972-140ee4f5e45a
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	7282d066-fce8-45ac-a656-0287d96589d1
47895f3f-8bd3-4522-8085-b235a41c9838	93ccd6ae-844e-4c3a-8889-e6a7e3d4206b
bcbf15c1-8835-4706-b40b-16261f32fae6	7df652ee-17d5-4683-88db-20ad298e43f2
0d28815b-b5fe-4348-add3-252bf3c67e4f	bd9a8651-888b-4aac-9142-949c741272d4
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
13045c88-faf1-4d56-9fab-a29d8edd7f34	\N	password	c9881161-f756-4e51-8639-cddfa46174c1	1621852940474	\N	{"value":"UFE6G4WmwqVOJ2So8VBB8L61g2CSZsr6o+C1AzE8x8ZOUMC5SCm3KKxDKiqNM1BpX92cJ/tFRqGJEUSzIKv9ow==","salt":"jakrlFDdKkZ3fbbGQAki9w==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
7026c021-7723-4fd6-acba-311a974417b9	\N	password	f3b821c4-0f12-4eef-b8d6-26ecb49a8a64	1621853263873	\N	{"value":"jb/HEP/6iNdzYNkNcfBmBtzo+Fi8J8OnRNFf+yfUqjada8pEogjRIx1Ezu9J8gVob5+9cMqOuM4NZwBJDMRH2Q==","salt":"azywx7Aw47SD/N2D3v4ZHQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
b492a651-7659-4673-b7b3-7ccb7af9661a	\N	password	9cbff8fc-41a7-4b04-a8c3-682e1c25823a	1621853282323	\N	{"value":"xpCTvLAB1j+A7UspUSpAGWQpcESQBJqlNkMxrucKsculQFBqSy4rpVYNXmvVKMGo+7RXdUgm/ndhoYRk20Bjmg==","salt":"/3XGT1Pmuk9uzzk8st40IQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1e6abc70-ff51-4163-86f0-36ca33ed9293	\N	password	b32de9ba-14ee-463c-84cb-4359fb97d01c	1621853301162	\N	{"value":"neKhwroLnDJjSTd/fkdtRenrDSrYrksBir2IRB4zsUCf8IBtO5Hqhj7CwRrZK0vPAt5X6IlW6gZ2yZism+TNpA==","salt":"CNTHPHck1rZClMQjrVgatg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
19c5c2ce-310e-4b96-b1b7-d8bb9f9ef95d	\N	password	f32238b9-c0ec-4b09-a5ae-f97df023b093	1621853317035	\N	{"value":"uF2ZbY63BA4i+9pe3pcGIpKxU3FuYfc/NTrlz1Vfgaj6aBVvn46IvKcKJWakkbQ9hzhU2Zq88DDU/9UncWB+VA==","salt":"yq9Yx143JQNDfq46t6jN3Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
3d180a54-5d1b-4a99-8b0a-44ebaa1b155a	\N	password	04263061-43a5-49eb-a9bc-dac980c0e8cf	1621853330458	\N	{"value":"8TZkI+k3j+gZrS8pS1OFAPJXRdWYPHphqMypA91gDbxrkvKUDLQEFagV2LpcX5hWUEBkMooAkMYf/tFCw3FCLg==","salt":"oEqOZMYMJzgW4OZsWL3yAg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
fc8d4c68-dbe1-4162-8b39-f8dd5c47a7da	\N	password	1df78d60-40c9-4452-adc6-14664b4837e7	1621853942603	\N	{"value":"HSL1apIl9pUDSw+7UZA+dDdb5mnIJJ6DazNo6Kz7v6Z5VWOt5N0y6/DPxJAewSlhLxyumOt9TXjcg4+vVhZ21Q==","salt":"FEBpbRdloeW5GDqq+DJ2sA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
936d4d72-3b86-4250-981d-a5a24d94d89e	\N	password	28d74fb0-76fa-4994-993e-4ab4b2d0632b	1626872197500	\N	{"value":"yxeJdiEd3ycU9eDSiPtRgiI5RL/eB82HADUqr9g79lV4Qe57pz5B9FL8yHsqMUC2Yh27G/hq/+yNOE6E6WPCig==","salt":"wgw/kuv4TCkSr39u6Rb84g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
7c6136e3-76ec-4513-b5c5-0935d650603f	\N	password	ebddc15d-9ea8-42ca-85a9-9d987c1ce796	1626898832485	\N	{"value":"y3lZI77Nt0V3bYLDlCw0LaUDtbMndnst2orIYtgco2EEUepBZpWJRUBdt5rysEg7w+TK6MxmI0bRIbW2QaSCGA==","salt":"l+YX9IFnNtHIUAtgzKSGZg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
ad48796a-0691-40d3-9625-5915bc844c7b	\N	password	8fefd63e-c97b-448f-acdd-adfac0da8827	1626940163686	\N	{"value":"B/dLfs9K/2P6/ET5v4MVS4Muoa/uiQ6SHS+13apc4APUxnZoTGxi252ZkWseffyK56kaMt+UZc+zsVH6T2d0zQ==","salt":"R56aLhhPqSvKeK9dI42cpg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
cafc5f7a-63a0-4184-b75c-e0ed0cd1b6b1	\N	password	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea	1626961857810	\N	{"value":"OdOHR1A9XMP5vbiDgSqlNhjJGuBpt/xRqhxQV1aHTMwh2ExpRgdgK4nSBI+LWrpn7YS33y0CmwUXd7E01JR76w==","salt":"3vHjRppBs2U0crmAhEqSzQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
03ed0510-36ec-4999-a759-13df68fe44a9	\N	password	e8c8d2e9-52fa-4e44-8a3d-b126268fff22	1626963598296	\N	{"value":"RLvzwG6dgGilODtG2DEypWUWX4zQqULh26J8uZVpoCcs1e9r6HQnLXi92hLB0oXy2g37oeGNP7Tqct4EJVm0Mw==","salt":"odDtL6p0MtnymU3JJcNgRw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
41c471cf-4ac6-4c50-a8ca-4e7bcb4bd039	\N	password	1e279137-5e77-402e-9363-2a2934028553	1626966856264	\N	{"value":"DG4hyQ0A7QBD3f3hizGsJVtk/hmHNEVloOw6tqA/pjoFLCjcTWiBmCqbL55LvhJONFkpUuJDBnci4j3H1RcSsQ==","salt":"EC+NClW5ALh/wd6i3JFQlw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
2cf3683b-67b2-4839-b93c-16e83aec23db	\N	password	c004868e-7494-401b-b6fe-59430debe54b	1626968597777	\N	{"value":"ZBxsV1TcwpIfGULbSd13WXRB+cb773NGp9ngTKxeiINi51dLQRjSKVcEyMiBME0/o/00rrB+7MqZIxLcqc7rQA==","salt":"Oc0uDWDQlk6MpMg1uKQnXg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d43869fe-40a6-4bf5-9017-6e3742d2ee01	\N	password	26663e22-5da6-4b46-81b8-0af487d27ae8	1626969407544	\N	{"value":"kLylJZJqqdqk5cXbC4nUPhDdu1hUmW0En9TbokYr4WiR8RJC0/oguU/8TodYpaXVx3afkbHchOdXH018hpVEVg==","salt":"VKY0N88y8yW1OUN4mxQCdA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
50ec008a-d6a0-422e-a8bc-777ab4dced3e	\N	password	a6da43a4-6c98-4216-b6ee-ee815b77e0d8	1626969826538	\N	{"value":"VXCj//FK4AeizdRP0+JCnt+iYzdkBT3uWsddIkPjZaPvxQyEvhUvV6JjWTdKN/T06PA6ygR2lt2NFBTQDjGk+Q==","salt":"HWkEJuDhM/+WDxbNlZFXjg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
5476e568-0c1e-4d17-b312-235987bc29eb	\N	password	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf	1626972658178	\N	{"value":"sZdpEfOY0sJSgXxQ5HNw6G1B8ewrJHrVxzIJ0jX3AvYMPlNpwT4l5VNAR3UTQIjn2oo1GWxu0FSiOuH/LI8BoA==","salt":"WGQ3EePmj9RtSVgtRUQ+GQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
21edcdaf-21a2-4bec-8517-7617cd20088c	\N	password	670ecad2-0e81-4226-8dd3-8c12155833d5	1627401192472	\N	{"value":"bAN9dw871bWdxCxvYyrpTJh4LciXkOGD93+I3do93s8rWn+MfVIKvUYe5dORZuh7KRKdM6Y0zBP5Xkb5Dstw5w==","salt":"Z3Bl7BT8jgyU3US1/RY/yA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
4481f399-d103-48d8-a6a9-335707afcf26	\N	password	bc59a9d8-78c8-4023-9d5d-65640031d130	1631170972510	\N	{"value":"AdZY/ENzBcPbbA8WfBBsVSm+qe/4kAf5rULDPqz9oRHggPNBP7WJKjJc3uIWS+jpqAK/dknAPmMvgzz78OB2oA==","salt":"OSkV04PyihYOLF1VOp/1Rg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
18657f02-3ba3-49b4-8d09-a246547f00ab	\N	password	71ea81f8-96f1-4bcd-8878-6936ac10effd	1632404656263	\N	{"value":"D05jaBhfW2xpbP4sQFpmLi/1CreLOI3Kyn0GqgffHI2F/vMfQAsINxGzZR3xzdpgDTlZz81dWPdA7TnrGuwfUA==","salt":"hEbn+8r73hmIQuzKnIEjWg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-05-24 10:42:14.433429	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	1852934079
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-05-24 10:42:14.44598	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	1852934079
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-05-24 10:42:14.479509	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	1852934079
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-05-24 10:42:14.48244	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	1852934079
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-05-24 10:42:14.558503	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	1852934079
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-05-24 10:42:14.562387	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	1852934079
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-05-24 10:42:14.642872	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	1852934079
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-05-24 10:42:14.647508	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	1852934079
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-05-24 10:42:14.653039	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	1852934079
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-05-24 10:42:14.725787	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	1852934079
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-05-24 10:42:14.766694	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	1852934079
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-05-24 10:42:14.769412	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	1852934079
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-05-24 10:42:14.788	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	1852934079
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-24 10:42:14.807162	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	1852934079
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-24 10:42:14.809239	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	1852934079
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-24 10:42:14.811077	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	1852934079
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-24 10:42:14.812623	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	1852934079
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-05-24 10:42:14.86935	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	1852934079
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-05-24 10:42:14.914319	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	1852934079
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-05-24 10:42:14.918772	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	1852934079
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-24 10:42:15.363002	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	1852934079
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-05-24 10:42:14.921129	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	1852934079
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-05-24 10:42:14.924158	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	1852934079
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-05-24 10:42:14.944124	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	1852934079
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-05-24 10:42:14.949082	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	1852934079
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-05-24 10:42:14.950922	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	1852934079
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-05-24 10:42:14.974698	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	1852934079
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-05-24 10:42:15.109574	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	1852934079
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-05-24 10:42:15.114647	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	1852934079
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-05-24 10:42:15.175131	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	1852934079
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-05-24 10:42:15.188999	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	1852934079
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-05-24 10:42:15.208463	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	1852934079
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-05-24 10:42:15.213673	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	1852934079
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-24 10:42:15.218704	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	1852934079
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-24 10:42:15.220859	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	1852934079
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-24 10:42:15.240922	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	1852934079
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-05-24 10:42:15.245169	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	1852934079
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-24 10:42:15.249291	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1852934079
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-05-24 10:42:15.253705	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	1852934079
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-05-24 10:42:15.256575	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	1852934079
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-24 10:42:15.258157	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	1852934079
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-24 10:42:15.259842	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	1852934079
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-05-24 10:42:15.264028	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	1852934079
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-24 10:42:15.353806	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	1852934079
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-05-24 10:42:15.35909	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	1852934079
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-24 10:42:15.366997	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	1852934079
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-24 10:42:15.36946	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	1852934079
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-24 10:42:15.405375	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	1852934079
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-24 10:42:15.410243	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	1852934079
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-05-24 10:42:15.443287	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	1852934079
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-05-24 10:42:15.477077	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	1852934079
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-05-24 10:42:15.480074	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	1852934079
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-05-24 10:42:15.482419	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	1852934079
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-05-24 10:42:15.485358	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	1852934079
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-24 10:42:15.491416	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	1852934079
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-24 10:42:15.496816	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	1852934079
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-24 10:42:15.518901	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	1852934079
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-24 10:42:15.627326	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	1852934079
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-05-24 10:42:15.660069	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	1852934079
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-05-24 10:42:15.665571	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	1852934079
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-05-24 10:42:15.673269	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	1852934079
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-05-24 10:42:15.677684	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	1852934079
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-05-24 10:42:15.688999	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	1852934079
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-05-24 10:42:15.69186	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	1852934079
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-05-24 10:42:15.694092	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	1852934079
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-05-24 10:42:15.704788	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	1852934079
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-05-24 10:42:15.708824	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	1852934079
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-05-24 10:42:15.712333	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	1852934079
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-05-24 10:42:15.71991	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	1852934079
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-05-24 10:42:15.72369	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	1852934079
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-05-24 10:42:15.726487	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	1852934079
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-24 10:42:15.731896	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	1852934079
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-24 10:42:15.736997	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	1852934079
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-24 10:42:15.738706	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	1852934079
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-24 10:42:15.758242	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	1852934079
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-24 10:42:15.763826	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	1852934079
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-24 10:42:15.766694	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	1852934079
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-24 10:42:15.770113	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	1852934079
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-24 10:42:15.786077	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	1852934079
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-24 10:42:15.788187	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	1852934079
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-24 10:42:15.792311	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	1852934079
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-24 10:42:15.793893	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1852934079
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-24 10:42:15.796914	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1852934079
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-24 10:42:15.798561	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1852934079
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-24 10:42:15.802156	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	1852934079
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-05-24 10:42:15.805968	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	1852934079
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-05-24 10:42:15.811894	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	1852934079
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-05-24 10:42:15.818889	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	1852934079
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	a4c76b2a-f249-46e7-a004-da2daf09af48	f
master	60798b18-088a-45aa-acb2-07a182d7fc28	t
master	12f37564-aa95-4304-a4f1-c86a95a1b43d	t
master	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909	t
master	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea	f
master	e993c288-5b50-442f-94d1-7f7079408c6e	f
master	13abfbed-bcba-491f-beae-6d1a5952db20	t
master	82596ad3-c5e3-436a-83f5-8fa9b592d4a1	t
master	ebef2001-f638-4518-98e5-05f4f76b8e6c	f
Company	272fb0a2-efb1-4e8e-b30c-2601fc096c78	f
Company	91e51416-599c-4359-bf95-4dd8fd6ad321	t
Company	3abb2b3d-5894-4f43-9dbe-c722f8dad152	t
Company	c535e83f-3036-42d1-8176-74b08f7595b6	t
Company	aa6e5e60-f95e-4997-8d99-f3329331d1e4	f
Company	8a6d0f38-b73b-488e-8819-1bbfb5f909f2	f
Company	aec45149-e526-42fa-b0ef-c171a92e5365	t
Company	96d3c3d3-9a12-44a4-adae-0b170da5e805	t
Company	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d	f
Company	ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d	t
Company	e7b6b38c-8241-4674-9e84-e04ad60ffd8e	f
Company	b9884b3c-7888-41f7-98a8-9c3a044b7583	f
Company	02f9474c-8b44-4344-8097-ddd907607de4	f
Company	42cb45fd-0613-4b6e-88c7-427b88463dc3	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
keycloak-i3m	Company	did:ethr:0xb606e9ff3e5004144fc5d74145e825e6df9014d6	did:ethr:0xb606e9ff3e5004144fc5d74145e825e6df9014d6	\N	480b5a53-276e-474b-ab7d-02f00743b01d
keycloak-i3m	Company	did:ethr:0x1de2179e5bc13262525e3b8b2916d370b47f7820	did:ethr:0x1de2179e5bc13262525e3b8b2916d370b47f7820	\N	05046139-2f58-4a42-9988-994182312c26
keycloak-i3m-release2	Company	did:ethr:i3m:0x03285bec044fbc32bd2c03dccce6a12b3ccca5defda9c8bc717b9b16e15e583d9e	did:ethr:i3m:0x03285bec044fbc32bd2c03dccce6a12b3ccca5defda9c8bc717b9b16e15e583d9e	\N	4e457aec-fe51-4283-ad6c-14beb308e11a
keycloak-i3m-release2	Company	did:ethr:rinkeby:0x03526203383689c7482083fe5ed8c697291e78ce258b386bc914ed40fab9e13b29	did:ethr:rinkeby:0x03526203383689c7482083fe5ed8c697291e78ce258b386bc914ed40fab9e13b29	\N	b5e057d1-0ea0-460c-b85d-a055284f80b4
keycloak-i3m-release2	Company	did:ethr:rinkeby:0x02a508a8efc97a5b40c04229c21206055f70ee36f10aded6813041bc0d36afd14a	did:ethr:rinkeby:0x02a508a8efc97a5b40c04229c21206055f70ee36f10aded6813041bc0d36afd14a	\N	a2980996-e29a-413b-91db-5b7be475014f
keycloak-i3m-release2	Company	did:ethr:i3m:0x02ef12e48430fdf5143fffdecc73ca10f06f26f95e7e173e504ec17acd073d9094	did:ethr:i3m:0x02ef12e48430fdf5143fffdecc73ca10f06f26f95e7e173e504ec17acd073d9094	\N	468926e7-0094-498f-83d0-3fe03c2de18a
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	t	keycloak-i3m	keycloak-oidc	f	f	Company	f	f	970b56ad-71fb-4027-920d-27866c5f53c0	\N	I3Market	f
a5687758-ed8a-4169-a72f-28d5f98562e4	t	keycloak-i3m-release2	keycloak-oidc	f	f	Company	f	f	970b56ad-71fb-4027-920d-27866c5f53c0	\N	I3Market-release2-consumer	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	https://identity1.i3-market.eu/oidc/token	tokenUrl
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	uP9Qnzg_COkPmE5mIJvN9	clientId
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	true	useJwksUrl
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	https://identity1.i3-market.eu/oidc/auth	authorizationUrl
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	client_secret_jwt	clientAuthMethod
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	IMPORT	syncMode
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	7Uzlr2zSgqdf0RpxJW8oNSieV-w79yt4Nn5pRsYjarApdp27F_q5XAI1ouLrR_CvhT5U9SoedV0c1T3J4sb8vw	clientSecret
0f6baab3-8346-4e7e-ad49-bf25d1f530ad	openid vc:provider vc:consumer	defaultScope
a5687758-ed8a-4169-a72f-28d5f98562e4	iwYVVlZV2N0mAyvERjCc0	clientId
a5687758-ed8a-4169-a72f-28d5f98562e4	https://identity1.i3-market.eu/release2/oidc/token	tokenUrl
a5687758-ed8a-4169-a72f-28d5f98562e4	true	useJwksUrl
a5687758-ed8a-4169-a72f-28d5f98562e4	https://identity1.i3-market.eu/release2/oidc/auth	authorizationUrl
a5687758-ed8a-4169-a72f-28d5f98562e4	client_secret_jwt	clientAuthMethod
a5687758-ed8a-4169-a72f-28d5f98562e4	IMPORT	syncMode
a5687758-ed8a-4169-a72f-28d5f98562e4	gS497NLJlGto2seXZyeGrVdrwIQx4ZeXzflDD6xlGipeI7paBo-eSydyHRReua1GpQBOzE8BA48_3Boy3JrYNA	clientSecret
a5687758-ed8a-4169-a72f-28d5f98562e4	openid vce:consumer	defaultScope
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
bcbf15c1-8835-4706-b40b-16261f32fae6	master	f	${role_admin}	admin	master	\N	master
87102381-0102-43a8-be5c-e760872bb54c	master	f	${role_create-realm}	create-realm	master	\N	master
4c2963fe-e90f-4087-9daa-e9f10f817145	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_create-client}	create-client	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
512cd298-c52c-4f58-a141-48aa352cfba5	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_view-realm}	view-realm	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
073c38f2-b0a3-4a2c-8570-d798c24af07a	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_view-users}	view-users	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
c49cc1a0-fcc0-4619-abc0-64f9fea17945	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_view-clients}	view-clients	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
0b3a82bd-d314-4286-91fe-eed20ca808ea	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_view-events}	view-events	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
94b11d5b-32bf-4857-9f98-d10caa9f51db	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_view-identity-providers}	view-identity-providers	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
2d5f9548-333a-4e77-a630-e050af0df000	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_view-authorization}	view-authorization	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
53574b20-fa19-405b-aebe-56e97557686e	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_manage-realm}	manage-realm	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
2ea645a1-4012-4a2e-a972-5ebd35368f66	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_manage-users}	manage-users	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
ce1e2bc6-b460-4bcd-9c0a-9952ea6bc52c	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_manage-clients}	manage-clients	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
3d01e8c7-0fa2-40f8-929c-8027c2af90be	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_manage-events}	manage-events	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
eab6b109-ab2c-4a8c-875f-e4cf60b5698c	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_manage-identity-providers}	manage-identity-providers	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
7a13f0a1-fda2-41f9-9520-490ccdc27a69	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_manage-authorization}	manage-authorization	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
fa1db38d-0e55-44a7-9d90-656dd2a3e8e6	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_query-users}	query-users	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
cf36deb0-340a-4526-bc2f-aaded3a9459f	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_query-clients}	query-clients	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
aa49a425-0109-46b4-875b-959ff6e39ce2	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_query-realms}	query-realms	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
3ce8f523-3fb8-4520-82f6-f8cc446600e8	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_query-groups}	query-groups	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
2f34707b-2073-41f6-92f7-e8d191230709	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_view-profile}	view-profile	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
199f30c8-bd8a-47b8-ae0c-f3dd16bba2de	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_manage-account}	manage-account	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
ccc80786-e18c-4243-b582-3b0f8b1ea5a6	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_manage-account-links}	manage-account-links	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
5d78ac25-aaaa-47fe-bbb6-e85b068c4a30	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_view-applications}	view-applications	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
7e920167-5c8b-437f-9a08-996e0d525ebe	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_view-consent}	view-consent	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
e150bd8d-16bb-441a-b354-7a747470e295	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_manage-consent}	manage-consent	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
35231711-dde3-4f6a-b760-de5a70d179e9	4526389f-2b6f-455d-b72c-22433e78dfb2	t	${role_delete-account}	delete-account	master	4526389f-2b6f-455d-b72c-22433e78dfb2	\N
91095ae9-b4db-44e3-8e2a-4841881caba3	5176d938-c687-4380-8d78-6e99dbc77b25	t	${role_read-token}	read-token	master	5176d938-c687-4380-8d78-6e99dbc77b25	\N
3fc19cff-c99b-4168-9a6e-47195249ffa4	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	t	${role_impersonation}	impersonation	master	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	\N
51c63cc5-a9f5-4215-b691-790e66be86ba	master	f	${role_offline-access}	offline_access	master	\N	master
e56f2520-e787-465b-bcb7-709cf5a42a07	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
7b97f716-3601-4340-aa4c-3689bcb4f9cc	16475946-e318-47c7-b025-8b35702d5163	t	${role_create-client}	create-client	master	16475946-e318-47c7-b025-8b35702d5163	\N
621df8b2-5519-4359-8161-2db2c2b3fca0	16475946-e318-47c7-b025-8b35702d5163	t	${role_view-realm}	view-realm	master	16475946-e318-47c7-b025-8b35702d5163	\N
3fabdf22-8d74-49bd-9703-400bff8979bb	16475946-e318-47c7-b025-8b35702d5163	t	${role_view-users}	view-users	master	16475946-e318-47c7-b025-8b35702d5163	\N
2c175a8c-2685-4fa7-bc94-a67f12496eae	16475946-e318-47c7-b025-8b35702d5163	t	${role_view-clients}	view-clients	master	16475946-e318-47c7-b025-8b35702d5163	\N
b6649cb0-7cf3-4c01-93f1-9f45aad54685	16475946-e318-47c7-b025-8b35702d5163	t	${role_view-events}	view-events	master	16475946-e318-47c7-b025-8b35702d5163	\N
ed162276-7483-4774-9a0c-0825a45d4b1b	16475946-e318-47c7-b025-8b35702d5163	t	${role_view-identity-providers}	view-identity-providers	master	16475946-e318-47c7-b025-8b35702d5163	\N
d8ac9ad6-b2b0-43e1-aff1-cb4b80230511	16475946-e318-47c7-b025-8b35702d5163	t	${role_view-authorization}	view-authorization	master	16475946-e318-47c7-b025-8b35702d5163	\N
933a2908-76bd-4ee0-a8e5-8b8c01f69ebc	16475946-e318-47c7-b025-8b35702d5163	t	${role_manage-realm}	manage-realm	master	16475946-e318-47c7-b025-8b35702d5163	\N
f80bd9d7-582e-41c3-a113-f7d53a2944a8	16475946-e318-47c7-b025-8b35702d5163	t	${role_manage-users}	manage-users	master	16475946-e318-47c7-b025-8b35702d5163	\N
bbbb8fb6-00f0-4812-9291-cd187cc1d48c	16475946-e318-47c7-b025-8b35702d5163	t	${role_manage-clients}	manage-clients	master	16475946-e318-47c7-b025-8b35702d5163	\N
74cd5a0c-2de5-4fcc-99d9-795ca8099bb2	16475946-e318-47c7-b025-8b35702d5163	t	${role_manage-events}	manage-events	master	16475946-e318-47c7-b025-8b35702d5163	\N
5b2dbfea-5103-433a-9584-c4581aa6bf58	16475946-e318-47c7-b025-8b35702d5163	t	${role_manage-identity-providers}	manage-identity-providers	master	16475946-e318-47c7-b025-8b35702d5163	\N
f5d48e28-3949-44a6-914c-d9765f72bab6	16475946-e318-47c7-b025-8b35702d5163	t	${role_manage-authorization}	manage-authorization	master	16475946-e318-47c7-b025-8b35702d5163	\N
1c29b53a-7b4e-410a-88b1-0bc6476e02c4	16475946-e318-47c7-b025-8b35702d5163	t	${role_query-users}	query-users	master	16475946-e318-47c7-b025-8b35702d5163	\N
e45dd881-76ef-420e-865e-f22730731ace	16475946-e318-47c7-b025-8b35702d5163	t	${role_query-clients}	query-clients	master	16475946-e318-47c7-b025-8b35702d5163	\N
4ec9fd66-a729-497b-bbea-6400f74d2c9e	16475946-e318-47c7-b025-8b35702d5163	t	${role_query-realms}	query-realms	master	16475946-e318-47c7-b025-8b35702d5163	\N
b7729ec8-cf45-484d-bb25-af9cf19f9baa	16475946-e318-47c7-b025-8b35702d5163	t	${role_query-groups}	query-groups	master	16475946-e318-47c7-b025-8b35702d5163	\N
0d28815b-b5fe-4348-add3-252bf3c67e4f	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_realm-admin}	realm-admin	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
e3545356-874f-4ed5-b3a4-e101637b1ab4	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_create-client}	create-client	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
079fe8e6-2cc0-4b40-9ede-19401c5def5f	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_view-realm}	view-realm	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
c84f7d4b-aaff-4cfd-89e0-d76e47e3e82e	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_view-users}	view-users	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
58714751-79ef-40ab-b7f6-6fe94ad3de95	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_view-clients}	view-clients	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
56dedb1f-6b2c-43d5-a9ed-ff5e187c6069	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_view-events}	view-events	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
6f04b2c6-59a0-4286-8b47-0ad45ddc707b	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_view-identity-providers}	view-identity-providers	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
a375428f-f88d-46d7-bb13-86957f644c1d	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_view-authorization}	view-authorization	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
e400897c-0fd1-44d7-a2b4-65dbe3c8df78	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_manage-realm}	manage-realm	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
e366f778-bcfc-47dc-ab03-690f48912906	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_manage-users}	manage-users	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
8ba80c05-0322-4f5f-a7cb-e3c650478184	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_manage-clients}	manage-clients	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
6b813017-2343-4419-a202-5b451899a456	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_manage-events}	manage-events	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
6491e3b5-25ca-42be-b86a-4bf8e4a758b8	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_manage-identity-providers}	manage-identity-providers	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
4a9da917-8c69-47e5-becb-9075b601c523	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_manage-authorization}	manage-authorization	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
fdc5c41b-0baf-402d-aa70-dbab46dde861	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_query-users}	query-users	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
aba147f7-727c-4b60-91d1-40b6e785027b	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_query-clients}	query-clients	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
8d3d17a1-abfa-467e-a98d-ab8f2d978707	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_query-realms}	query-realms	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
6b77038d-3ec6-4d38-9972-140ee4f5e45a	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_query-groups}	query-groups	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
45d7b16a-8666-4804-bc00-38fc2b33682a	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_view-profile}	view-profile	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_manage-account}	manage-account	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
7282d066-fce8-45ac-a656-0287d96589d1	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_manage-account-links}	manage-account-links	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
f8d5aa36-a1f2-4505-8fb5-9bfcd9704d5f	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_view-applications}	view-applications	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
93ccd6ae-844e-4c3a-8889-e6a7e3d4206b	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_view-consent}	view-consent	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
47895f3f-8bd3-4522-8085-b235a41c9838	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_manage-consent}	manage-consent	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
f5f0b165-f7f2-4cd1-904d-7fa673dad64e	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	t	${role_delete-account}	delete-account	Company	87c9de72-44b2-4ed4-87fe-db25c8c2fbff	\N
7df652ee-17d5-4683-88db-20ad298e43f2	16475946-e318-47c7-b025-8b35702d5163	t	${role_impersonation}	impersonation	master	16475946-e318-47c7-b025-8b35702d5163	\N
bd9a8651-888b-4aac-9142-949c741272d4	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	t	${role_impersonation}	impersonation	Company	6e1e2558-506a-4fd2-a7bf-9e122d37a27a	\N
123f6a8e-cc9b-4cad-a517-95b871c14997	e86a568f-6381-4ead-93d5-8f148244a70f	t	${role_read-token}	read-token	Company	e86a568f-6381-4ead-93d5-8f148244a70f	\N
725b7f81-2afb-4a73-b6ce-56770a9f81a5	Company	f	${role_offline-access}	offline_access	Company	\N	Company
de5f45da-a4af-4e8e-b024-282008f89219	Company	f	${role_uma_authorization}	uma_authorization	Company	\N	Company
186d4618-d2cd-47c8-a4dc-0f562a861898	a284c132-cb55-40c2-b25d-a3db6943a0de	t	\N	manage-account	Company	a284c132-cb55-40c2-b25d-a3db6943a0de	\N
da3da7cb-e80f-4877-bf53-091868ed0370	a284c132-cb55-40c2-b25d-a3db6943a0de	t	\N	view-profile	Company	a284c132-cb55-40c2-b25d-a3db6943a0de	\N
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	346a601f-75f5-4939-9bb8-e66f0e944e68	t	\N	manage-account	Company	346a601f-75f5-4939-9bb8-e66f0e944e68	\N
8c44b1f3-186d-41e2-a8e0-85cf668366d4	346a601f-75f5-4939-9bb8-e66f0e944e68	t	\N	view-profile	Company	346a601f-75f5-4939-9bb8-e66f0e944e68	\N
7bd5891b-16c4-43df-a230-5d68ca681262	Company	f	\N	i3market-consumer	Company	\N	Company
cced33a2-f592-4241-ba3f-1568e6492a1b	Company	f	\N	i3market-provider	Company	\N	Company
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	t	\N	manage-account	Company	9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	\N
2bb46018-a878-4a07-b7a5-a7bee5d2b340	9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	t	\N	view-profile	Company	9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	\N
01193d9e-f6ad-4732-9ca8-2243d35a539f	a2714f12-c8ff-43d4-b011-673371652f85	t	\N	manage-account	Company	a2714f12-c8ff-43d4-b011-673371652f85	\N
62e102db-30b9-4443-9ac6-53eddd18a42a	a2714f12-c8ff-43d4-b011-673371652f85	t	\N	view-profile	Company	a2714f12-c8ff-43d4-b011-673371652f85	\N
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	f691313d-52dc-4dd4-899c-b07faf56e2c2	t	\N	manage-account	Company	f691313d-52dc-4dd4-899c-b07faf56e2c2	\N
40a61e05-4540-443f-ab61-707c17ab6182	f691313d-52dc-4dd4-899c-b07faf56e2c2	t	\N	view-profile	Company	f691313d-52dc-4dd4-899c-b07faf56e2c2	\N
da01fe6e-f088-4caa-a049-9e0ec22a3cec	c868ffd4-4425-4a17-b483-4a22950bd748	t	\N	manage-account	Company	c868ffd4-4425-4a17-b483-4a22950bd748	\N
cb9b072e-93dc-47e1-a943-47cbe9e18674	c868ffd4-4425-4a17-b483-4a22950bd748	t	\N	view-profile	Company	c868ffd4-4425-4a17-b483-4a22950bd748	\N
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	t	\N	manage-account	Company	e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	\N
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	t	\N	view-profile	Company	e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	\N
0532209d-ba3a-428a-b926-9fc25502613f	5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	t	\N	manage-account	Company	5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	\N
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	t	\N	view-profile	Company	5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	\N
28ecaad6-3925-49eb-880f-e2a8b2c3297c	a9402390-c5f9-4899-8135-9e901af9710c	t	\N	manage-account	Company	a9402390-c5f9-4899-8135-9e901af9710c	\N
e9495f4b-d634-4fcd-8d74-191d285dd406	a9402390-c5f9-4899-8135-9e901af9710c	t	\N	view-profile	Company	a9402390-c5f9-4899-8135-9e901af9710c	\N
de66df10-6fb6-4e4e-861c-52684d36e04b	b63fb8a7-600a-4fb6-bab1-3c400398b314	t	\N	manage-account	Company	b63fb8a7-600a-4fb6-bab1-3c400398b314	\N
add1c218-7f67-4403-a8e8-8a18c7759881	b63fb8a7-600a-4fb6-bab1-3c400398b314	t	\N	view-profile	Company	b63fb8a7-600a-4fb6-bab1-3c400398b314	\N
379d43b8-31bd-4d97-8e52-34648acebe92	Company	f	\N	i3market-issuer	Company	\N	Company
0232d683-f7c3-4deb-9b6a-d7a7cb626a05	fb69a878-50d1-43ed-a604-447f75565cf8	t	\N	i3market-issuer	Company	fb69a878-50d1-43ed-a604-447f75565cf8	\N
f0e6b891-1300-4515-b2a7-b421ff4454bd	76757943-77e3-408d-8f41-105880b46eed	t	\N	manage-account	Company	76757943-77e3-408d-8f41-105880b46eed	\N
d79c84b0-b59f-4889-9e2b-c5e30a4b14b3	76757943-77e3-408d-8f41-105880b46eed	t	\N	view-profile	Company	76757943-77e3-408d-8f41-105880b46eed	\N
6ceab9c0-73d6-44a7-b20f-ba739724b3d7	a8a02f01-0c19-461d-a919-33ce6926d2fe	t	\N	manage-account	Company	a8a02f01-0c19-461d-a919-33ce6926d2fe	\N
9294a80d-452f-4c91-9c4f-a9e84005286f	a8a02f01-0c19-461d-a919-33ce6926d2fe	t	\N	view-profile	Company	a8a02f01-0c19-461d-a919-33ce6926d2fe	\N
1b07e9de-2806-4f10-b706-5a679c545065	88bcd50b-f7cb-4495-854e-17b6c89d4f6e	t	\N	manage-account	Company	88bcd50b-f7cb-4495-854e-17b6c89d4f6e	\N
7fcc53be-9e89-41c5-8dd0-a98f48e5e952	88bcd50b-f7cb-4495-854e-17b6c89d4f6e	t	\N	view-profile	Company	88bcd50b-f7cb-4495-854e-17b6c89d4f6e	\N
8fd263a8-8fcf-4248-b2ff-4a97119de4d0	3fe58830-bb3b-4a75-a01e-de1928321a72	t	\N	manage-account	Company	3fe58830-bb3b-4a75-a01e-de1928321a72	\N
d3ddbd98-2b3e-400a-bccd-322c8db6203d	3fe58830-bb3b-4a75-a01e-de1928321a72	t	\N	view-profile	Company	3fe58830-bb3b-4a75-a01e-de1928321a72	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
2g3fj	12.0.4	1621852939
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
60f3edca-5d3b-4d4f-aefe-12e056030e70	audience resolve	openid-connect	oidc-audience-resolve-mapper	adb6b6f5-7b28-4e06-8fe6-012984f00dfa	\N
cd207513-67e1-4f45-a3b0-12927a52e2f4	locale	openid-connect	oidc-usermodel-attribute-mapper	af9205c2-7b51-47d2-ad93-24c612401bec	\N
1b65cd1b-5ac0-4b9d-81e6-4a90f60537b6	role list	saml	saml-role-list-mapper	\N	60798b18-088a-45aa-acb2-07a182d7fc28
257ba913-956a-4ef8-b5e0-8a11d31aeaad	full name	openid-connect	oidc-full-name-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
94f5d29a-6955-4c1d-938e-8eba1c63098a	family name	openid-connect	oidc-usermodel-property-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	given name	openid-connect	oidc-usermodel-property-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
53deccb5-5b5e-4038-8963-dbafd5976d6e	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
ee18089b-b294-441f-ba75-52c66620d4cc	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	username	openid-connect	oidc-usermodel-property-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
493552bc-e7aa-43bb-881a-33b8051a7ef7	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
1a7458ab-d131-4179-adf7-6c50f3a306a5	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	website	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
76647fc1-72d8-42ea-a934-6a0bc711761c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
9de050d1-5c1d-4145-9626-6e8dab2c379d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
6d435204-7ff4-430b-8471-94c1fd18de7d	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	12f37564-aa95-4304-a4f1-c86a95a1b43d
6d466219-9bb2-4061-889d-98e37b6aaeec	email	openid-connect	oidc-usermodel-property-mapper	\N	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909
2fc19582-3e38-4863-bb9d-6fe27585c912	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f53cb740-8ccc-4f94-9e49-dc4c8ccb9909
57e3058e-9f31-44c5-a148-856518aec08e	address	openid-connect	oidc-address-mapper	\N	e89b3348-97a9-4b4b-9a4f-f9f4c90768ea
990f0408-d5f0-4ce7-be62-c22460106410	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e993c288-5b50-442f-94d1-7f7079408c6e
48bb45ee-4250-4af3-acbc-04e656bb32c5	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e993c288-5b50-442f-94d1-7f7079408c6e
a3fb141c-0d5a-432d-814a-4fbdfc7913ae	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	13abfbed-bcba-491f-beae-6d1a5952db20
5bb8c804-81d2-4fa3-8b3d-314791041e4e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	13abfbed-bcba-491f-beae-6d1a5952db20
8c779cae-79f2-49a8-9ed0-f3b653e9ffe1	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	13abfbed-bcba-491f-beae-6d1a5952db20
e366c893-d46d-42f6-bc3e-2f41edbe8b80	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	82596ad3-c5e3-436a-83f5-8fa9b592d4a1
26caf545-ccda-496d-902a-11a33c93de24	upn	openid-connect	oidc-usermodel-property-mapper	\N	ebef2001-f638-4518-98e5-05f4f76b8e6c
a1bfb879-3904-4dc1-a624-45d7b5725789	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	ebef2001-f638-4518-98e5-05f4f76b8e6c
b30b8721-6105-4948-963c-f8ec038b0a13	audience resolve	openid-connect	oidc-audience-resolve-mapper	4ec4f635-04a9-4944-8d65-e6588aaa18da	\N
5e609bd4-1a7c-425a-953b-f985ae8b395d	role list	saml	saml-role-list-mapper	\N	91e51416-599c-4359-bf95-4dd8fd6ad321
15f87259-60a1-41dd-a9a4-9f870b612d5d	full name	openid-connect	oidc-full-name-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
78d019c2-1aea-4979-a013-6439f7a04ccc	family name	openid-connect	oidc-usermodel-property-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
8fdf3201-9a4d-436e-b913-5ce1617f6348	given name	openid-connect	oidc-usermodel-property-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
14fc0b90-13f4-4854-8900-d91eaf01b917	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
74ce96c3-6e83-4b51-a135-c514aa06bed7	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
3b2478d7-e63b-4e65-a11e-3510d9612a4d	username	openid-connect	oidc-usermodel-property-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
f60457d3-55eb-42ee-b53a-c61823073700	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
992f6122-4217-4f24-ab27-99ad19f97f9b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	website	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
aaeae43e-ccee-4033-9db6-3dee851f3ac7	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
54286bee-1718-4a1b-be1e-a3ce18d76076	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
35774838-1127-4d1c-81df-f016351e9d04	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
659fe326-0ea5-40ab-879a-5deecc078c3b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	3abb2b3d-5894-4f43-9dbe-c722f8dad152
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	email	openid-connect	oidc-usermodel-property-mapper	\N	c535e83f-3036-42d1-8176-74b08f7595b6
17a974c8-120b-40c6-8a6c-4afd39f45d17	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c535e83f-3036-42d1-8176-74b08f7595b6
7a9558af-98ac-4b2a-ae76-9223bfe20757	address	openid-connect	oidc-address-mapper	\N	aa6e5e60-f95e-4997-8d99-f3329331d1e4
2d5f0ec2-da14-443c-9e88-192bda732223	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8a6d0f38-b73b-488e-8819-1bbfb5f909f2
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8a6d0f38-b73b-488e-8819-1bbfb5f909f2
e76b6a51-d34d-4800-b3c3-40245da89a94	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	aec45149-e526-42fa-b0ef-c171a92e5365
2bebaf3d-41ab-4a29-b5c7-0ed282b02dd3	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	aec45149-e526-42fa-b0ef-c171a92e5365
a477443c-c02f-42eb-984e-6b0619ddb96b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	aec45149-e526-42fa-b0ef-c171a92e5365
4d28ba6f-7695-4bfe-848c-3c0c9a10e68c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	96d3c3d3-9a12-44a4-adae-0b170da5e805
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	upn	openid-connect	oidc-usermodel-property-mapper	\N	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d
265c68b8-b392-44d3-8d3d-a343fb689442	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0c1fe1fc-37e1-4fa4-b9b0-f7b6230f2a2d
6ce042d1-f62b-49d2-83a4-70300e86f494	locale	openid-connect	oidc-usermodel-attribute-mapper	23b56ce3-fb89-498a-8ce7-09fe5d89ab96	\N
1dcf0a65-f628-4420-a85d-0451d2bdfcb4	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	3c03f823-8719-47bf-8648-c07fa53d06bc	\N
98be05ce-4f95-466c-9902-c04ded29ef4b	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	3c03f823-8719-47bf-8648-c07fa53d06bc	\N
43b839c9-dbe8-4a98-986c-327e120cfc93	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	3c03f823-8719-47bf-8648-c07fa53d06bc	\N
25e06c0b-529b-4704-a52d-3c1a24a0b91f	walletAddress	openid-connect	oidc-usermodel-attribute-mapper	\N	ef1187ce-4bc5-466f-b8d9-ce33b8a60c5d
d934cec7-ad1c-4f53-80d6-59756518b0c5	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	3269b142-f564-4374-b84a-512b0f02885b	\N
b643c0b6-ed7d-4f34-adb4-25f77a5e02e2	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	3269b142-f564-4374-b84a-512b0f02885b	\N
28a8aab8-3a30-468e-954f-44ee7af6ad45	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	3269b142-f564-4374-b84a-512b0f02885b	\N
ec6cfd69-10be-4dbe-b534-35cbcda43247	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	bcb21012-4bae-4531-9f4e-c53b4205c30e	\N
c9110a9b-c636-4e36-8b68-faee1c476b0d	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	bcb21012-4bae-4531-9f4e-c53b4205c30e	\N
b7d33df2-69e7-4ef6-b169-ab9e96f3256e	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	bcb21012-4bae-4531-9f4e-c53b4205c30e	\N
a0cead36-f361-4861-ac6f-704aca0c7de5	ConsumerRoleMapping	openid-connect	oidc-hardcoded-role-mapper	\N	02f9474c-8b44-4344-8097-ddd907607de4
75b540ec-4d79-4fe8-98c8-e48eecf6896f	ProviderRolemapping	openid-connect	oidc-hardcoded-role-mapper	\N	e7b6b38c-8241-4674-9e84-e04ad60ffd8e
da1111e1-6bef-40c1-be64-84d1a6470fd7	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	fb69a878-50d1-43ed-a604-447f75565cf8	\N
38983e5c-85ef-4521-9e34-2e450e79e2c0	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	fb69a878-50d1-43ed-a604-447f75565cf8	\N
3a7b8393-7678-43ca-a972-79509a592c3e	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	fb69a878-50d1-43ed-a604-447f75565cf8	\N
ea41a034-2c05-49a0-9456-e2749a9e9c21	ProviderRolemapping	openid-connect	oidc-hardcoded-role-mapper	\N	a0d4942d-eec5-442f-91ae-8807af29975e
cffd0e5e-9124-4fe1-be5a-b94346dbda03	vc	openid-connect	oidc-claims-param-token-mapper	\N	1dd17233-c710-4bd8-a7ec-eb82fcac3b2d
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
cd207513-67e1-4f45-a3b0-12927a52e2f4	true	userinfo.token.claim
cd207513-67e1-4f45-a3b0-12927a52e2f4	locale	user.attribute
cd207513-67e1-4f45-a3b0-12927a52e2f4	true	id.token.claim
cd207513-67e1-4f45-a3b0-12927a52e2f4	true	access.token.claim
cd207513-67e1-4f45-a3b0-12927a52e2f4	locale	claim.name
cd207513-67e1-4f45-a3b0-12927a52e2f4	String	jsonType.label
1b65cd1b-5ac0-4b9d-81e6-4a90f60537b6	false	single
1b65cd1b-5ac0-4b9d-81e6-4a90f60537b6	Basic	attribute.nameformat
1b65cd1b-5ac0-4b9d-81e6-4a90f60537b6	Role	attribute.name
257ba913-956a-4ef8-b5e0-8a11d31aeaad	true	userinfo.token.claim
257ba913-956a-4ef8-b5e0-8a11d31aeaad	true	id.token.claim
257ba913-956a-4ef8-b5e0-8a11d31aeaad	true	access.token.claim
94f5d29a-6955-4c1d-938e-8eba1c63098a	true	userinfo.token.claim
94f5d29a-6955-4c1d-938e-8eba1c63098a	lastName	user.attribute
94f5d29a-6955-4c1d-938e-8eba1c63098a	true	id.token.claim
94f5d29a-6955-4c1d-938e-8eba1c63098a	true	access.token.claim
94f5d29a-6955-4c1d-938e-8eba1c63098a	family_name	claim.name
94f5d29a-6955-4c1d-938e-8eba1c63098a	String	jsonType.label
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	true	userinfo.token.claim
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	firstName	user.attribute
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	true	id.token.claim
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	true	access.token.claim
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	given_name	claim.name
39a9b3a6-e1fe-49c9-be28-0fe62b400ed0	String	jsonType.label
53deccb5-5b5e-4038-8963-dbafd5976d6e	true	userinfo.token.claim
53deccb5-5b5e-4038-8963-dbafd5976d6e	middleName	user.attribute
53deccb5-5b5e-4038-8963-dbafd5976d6e	true	id.token.claim
53deccb5-5b5e-4038-8963-dbafd5976d6e	true	access.token.claim
53deccb5-5b5e-4038-8963-dbafd5976d6e	middle_name	claim.name
53deccb5-5b5e-4038-8963-dbafd5976d6e	String	jsonType.label
ee18089b-b294-441f-ba75-52c66620d4cc	true	userinfo.token.claim
ee18089b-b294-441f-ba75-52c66620d4cc	nickname	user.attribute
ee18089b-b294-441f-ba75-52c66620d4cc	true	id.token.claim
ee18089b-b294-441f-ba75-52c66620d4cc	true	access.token.claim
ee18089b-b294-441f-ba75-52c66620d4cc	nickname	claim.name
ee18089b-b294-441f-ba75-52c66620d4cc	String	jsonType.label
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	true	userinfo.token.claim
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	username	user.attribute
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	true	id.token.claim
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	true	access.token.claim
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	preferred_username	claim.name
a6123954-e619-42cf-9caa-5b4a6fd3ffd3	String	jsonType.label
493552bc-e7aa-43bb-881a-33b8051a7ef7	true	userinfo.token.claim
493552bc-e7aa-43bb-881a-33b8051a7ef7	profile	user.attribute
493552bc-e7aa-43bb-881a-33b8051a7ef7	true	id.token.claim
493552bc-e7aa-43bb-881a-33b8051a7ef7	true	access.token.claim
493552bc-e7aa-43bb-881a-33b8051a7ef7	profile	claim.name
493552bc-e7aa-43bb-881a-33b8051a7ef7	String	jsonType.label
1a7458ab-d131-4179-adf7-6c50f3a306a5	true	userinfo.token.claim
1a7458ab-d131-4179-adf7-6c50f3a306a5	picture	user.attribute
1a7458ab-d131-4179-adf7-6c50f3a306a5	true	id.token.claim
1a7458ab-d131-4179-adf7-6c50f3a306a5	true	access.token.claim
1a7458ab-d131-4179-adf7-6c50f3a306a5	picture	claim.name
1a7458ab-d131-4179-adf7-6c50f3a306a5	String	jsonType.label
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	true	userinfo.token.claim
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	website	user.attribute
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	true	id.token.claim
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	true	access.token.claim
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	website	claim.name
3a8bf241-20f6-4c77-b0c0-ad2c8068bfb5	String	jsonType.label
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	true	userinfo.token.claim
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	gender	user.attribute
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	true	id.token.claim
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	true	access.token.claim
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	gender	claim.name
8e0a33e5-8cb5-4698-bcdb-a3093be457cb	String	jsonType.label
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	true	userinfo.token.claim
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	birthdate	user.attribute
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	true	id.token.claim
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	true	access.token.claim
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	birthdate	claim.name
da0ce944-a1d8-4a80-90e4-58a26f34dbe8	String	jsonType.label
76647fc1-72d8-42ea-a934-6a0bc711761c	true	userinfo.token.claim
76647fc1-72d8-42ea-a934-6a0bc711761c	zoneinfo	user.attribute
76647fc1-72d8-42ea-a934-6a0bc711761c	true	id.token.claim
76647fc1-72d8-42ea-a934-6a0bc711761c	true	access.token.claim
76647fc1-72d8-42ea-a934-6a0bc711761c	zoneinfo	claim.name
76647fc1-72d8-42ea-a934-6a0bc711761c	String	jsonType.label
9de050d1-5c1d-4145-9626-6e8dab2c379d	true	userinfo.token.claim
9de050d1-5c1d-4145-9626-6e8dab2c379d	locale	user.attribute
9de050d1-5c1d-4145-9626-6e8dab2c379d	true	id.token.claim
9de050d1-5c1d-4145-9626-6e8dab2c379d	true	access.token.claim
9de050d1-5c1d-4145-9626-6e8dab2c379d	locale	claim.name
9de050d1-5c1d-4145-9626-6e8dab2c379d	String	jsonType.label
6d435204-7ff4-430b-8471-94c1fd18de7d	true	userinfo.token.claim
6d435204-7ff4-430b-8471-94c1fd18de7d	updatedAt	user.attribute
6d435204-7ff4-430b-8471-94c1fd18de7d	true	id.token.claim
6d435204-7ff4-430b-8471-94c1fd18de7d	true	access.token.claim
6d435204-7ff4-430b-8471-94c1fd18de7d	updated_at	claim.name
6d435204-7ff4-430b-8471-94c1fd18de7d	String	jsonType.label
6d466219-9bb2-4061-889d-98e37b6aaeec	true	userinfo.token.claim
6d466219-9bb2-4061-889d-98e37b6aaeec	email	user.attribute
6d466219-9bb2-4061-889d-98e37b6aaeec	true	id.token.claim
6d466219-9bb2-4061-889d-98e37b6aaeec	true	access.token.claim
6d466219-9bb2-4061-889d-98e37b6aaeec	email	claim.name
6d466219-9bb2-4061-889d-98e37b6aaeec	String	jsonType.label
2fc19582-3e38-4863-bb9d-6fe27585c912	true	userinfo.token.claim
2fc19582-3e38-4863-bb9d-6fe27585c912	emailVerified	user.attribute
2fc19582-3e38-4863-bb9d-6fe27585c912	true	id.token.claim
2fc19582-3e38-4863-bb9d-6fe27585c912	true	access.token.claim
2fc19582-3e38-4863-bb9d-6fe27585c912	email_verified	claim.name
2fc19582-3e38-4863-bb9d-6fe27585c912	boolean	jsonType.label
57e3058e-9f31-44c5-a148-856518aec08e	formatted	user.attribute.formatted
57e3058e-9f31-44c5-a148-856518aec08e	country	user.attribute.country
57e3058e-9f31-44c5-a148-856518aec08e	postal_code	user.attribute.postal_code
57e3058e-9f31-44c5-a148-856518aec08e	true	userinfo.token.claim
57e3058e-9f31-44c5-a148-856518aec08e	street	user.attribute.street
57e3058e-9f31-44c5-a148-856518aec08e	true	id.token.claim
57e3058e-9f31-44c5-a148-856518aec08e	region	user.attribute.region
57e3058e-9f31-44c5-a148-856518aec08e	true	access.token.claim
57e3058e-9f31-44c5-a148-856518aec08e	locality	user.attribute.locality
990f0408-d5f0-4ce7-be62-c22460106410	true	userinfo.token.claim
990f0408-d5f0-4ce7-be62-c22460106410	phoneNumber	user.attribute
990f0408-d5f0-4ce7-be62-c22460106410	true	id.token.claim
990f0408-d5f0-4ce7-be62-c22460106410	true	access.token.claim
990f0408-d5f0-4ce7-be62-c22460106410	phone_number	claim.name
990f0408-d5f0-4ce7-be62-c22460106410	String	jsonType.label
48bb45ee-4250-4af3-acbc-04e656bb32c5	true	userinfo.token.claim
48bb45ee-4250-4af3-acbc-04e656bb32c5	phoneNumberVerified	user.attribute
48bb45ee-4250-4af3-acbc-04e656bb32c5	true	id.token.claim
48bb45ee-4250-4af3-acbc-04e656bb32c5	true	access.token.claim
48bb45ee-4250-4af3-acbc-04e656bb32c5	phone_number_verified	claim.name
48bb45ee-4250-4af3-acbc-04e656bb32c5	boolean	jsonType.label
a3fb141c-0d5a-432d-814a-4fbdfc7913ae	true	multivalued
a3fb141c-0d5a-432d-814a-4fbdfc7913ae	foo	user.attribute
a3fb141c-0d5a-432d-814a-4fbdfc7913ae	true	access.token.claim
a3fb141c-0d5a-432d-814a-4fbdfc7913ae	realm_access.roles	claim.name
a3fb141c-0d5a-432d-814a-4fbdfc7913ae	String	jsonType.label
5bb8c804-81d2-4fa3-8b3d-314791041e4e	true	multivalued
5bb8c804-81d2-4fa3-8b3d-314791041e4e	foo	user.attribute
5bb8c804-81d2-4fa3-8b3d-314791041e4e	true	access.token.claim
5bb8c804-81d2-4fa3-8b3d-314791041e4e	resource_access.${client_id}.roles	claim.name
5bb8c804-81d2-4fa3-8b3d-314791041e4e	String	jsonType.label
26caf545-ccda-496d-902a-11a33c93de24	true	userinfo.token.claim
26caf545-ccda-496d-902a-11a33c93de24	username	user.attribute
26caf545-ccda-496d-902a-11a33c93de24	true	id.token.claim
26caf545-ccda-496d-902a-11a33c93de24	true	access.token.claim
26caf545-ccda-496d-902a-11a33c93de24	upn	claim.name
26caf545-ccda-496d-902a-11a33c93de24	String	jsonType.label
a1bfb879-3904-4dc1-a624-45d7b5725789	true	multivalued
a1bfb879-3904-4dc1-a624-45d7b5725789	foo	user.attribute
a1bfb879-3904-4dc1-a624-45d7b5725789	true	id.token.claim
a1bfb879-3904-4dc1-a624-45d7b5725789	true	access.token.claim
a1bfb879-3904-4dc1-a624-45d7b5725789	groups	claim.name
a1bfb879-3904-4dc1-a624-45d7b5725789	String	jsonType.label
5e609bd4-1a7c-425a-953b-f985ae8b395d	false	single
5e609bd4-1a7c-425a-953b-f985ae8b395d	Basic	attribute.nameformat
5e609bd4-1a7c-425a-953b-f985ae8b395d	Role	attribute.name
15f87259-60a1-41dd-a9a4-9f870b612d5d	true	userinfo.token.claim
15f87259-60a1-41dd-a9a4-9f870b612d5d	true	id.token.claim
15f87259-60a1-41dd-a9a4-9f870b612d5d	true	access.token.claim
78d019c2-1aea-4979-a013-6439f7a04ccc	true	userinfo.token.claim
78d019c2-1aea-4979-a013-6439f7a04ccc	lastName	user.attribute
78d019c2-1aea-4979-a013-6439f7a04ccc	true	id.token.claim
78d019c2-1aea-4979-a013-6439f7a04ccc	true	access.token.claim
78d019c2-1aea-4979-a013-6439f7a04ccc	family_name	claim.name
78d019c2-1aea-4979-a013-6439f7a04ccc	String	jsonType.label
8fdf3201-9a4d-436e-b913-5ce1617f6348	true	userinfo.token.claim
8fdf3201-9a4d-436e-b913-5ce1617f6348	firstName	user.attribute
8fdf3201-9a4d-436e-b913-5ce1617f6348	true	id.token.claim
8fdf3201-9a4d-436e-b913-5ce1617f6348	true	access.token.claim
8fdf3201-9a4d-436e-b913-5ce1617f6348	given_name	claim.name
8fdf3201-9a4d-436e-b913-5ce1617f6348	String	jsonType.label
14fc0b90-13f4-4854-8900-d91eaf01b917	true	userinfo.token.claim
14fc0b90-13f4-4854-8900-d91eaf01b917	middleName	user.attribute
14fc0b90-13f4-4854-8900-d91eaf01b917	true	id.token.claim
14fc0b90-13f4-4854-8900-d91eaf01b917	true	access.token.claim
14fc0b90-13f4-4854-8900-d91eaf01b917	middle_name	claim.name
14fc0b90-13f4-4854-8900-d91eaf01b917	String	jsonType.label
74ce96c3-6e83-4b51-a135-c514aa06bed7	true	userinfo.token.claim
74ce96c3-6e83-4b51-a135-c514aa06bed7	nickname	user.attribute
74ce96c3-6e83-4b51-a135-c514aa06bed7	true	id.token.claim
74ce96c3-6e83-4b51-a135-c514aa06bed7	true	access.token.claim
74ce96c3-6e83-4b51-a135-c514aa06bed7	nickname	claim.name
74ce96c3-6e83-4b51-a135-c514aa06bed7	String	jsonType.label
3b2478d7-e63b-4e65-a11e-3510d9612a4d	true	userinfo.token.claim
3b2478d7-e63b-4e65-a11e-3510d9612a4d	username	user.attribute
3b2478d7-e63b-4e65-a11e-3510d9612a4d	true	id.token.claim
3b2478d7-e63b-4e65-a11e-3510d9612a4d	true	access.token.claim
3b2478d7-e63b-4e65-a11e-3510d9612a4d	preferred_username	claim.name
3b2478d7-e63b-4e65-a11e-3510d9612a4d	String	jsonType.label
f60457d3-55eb-42ee-b53a-c61823073700	true	userinfo.token.claim
f60457d3-55eb-42ee-b53a-c61823073700	profile	user.attribute
f60457d3-55eb-42ee-b53a-c61823073700	true	id.token.claim
f60457d3-55eb-42ee-b53a-c61823073700	true	access.token.claim
f60457d3-55eb-42ee-b53a-c61823073700	profile	claim.name
f60457d3-55eb-42ee-b53a-c61823073700	String	jsonType.label
992f6122-4217-4f24-ab27-99ad19f97f9b	true	userinfo.token.claim
992f6122-4217-4f24-ab27-99ad19f97f9b	picture	user.attribute
992f6122-4217-4f24-ab27-99ad19f97f9b	true	id.token.claim
992f6122-4217-4f24-ab27-99ad19f97f9b	true	access.token.claim
992f6122-4217-4f24-ab27-99ad19f97f9b	picture	claim.name
992f6122-4217-4f24-ab27-99ad19f97f9b	String	jsonType.label
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	true	userinfo.token.claim
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	website	user.attribute
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	true	id.token.claim
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	true	access.token.claim
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	website	claim.name
ef9ac505-c6e7-41ef-be77-66cf2d4c9036	String	jsonType.label
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	true	userinfo.token.claim
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	gender	user.attribute
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	true	id.token.claim
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	true	access.token.claim
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	gender	claim.name
ec6753eb-2fb8-438c-8cd5-dc3ba1e99c73	String	jsonType.label
aaeae43e-ccee-4033-9db6-3dee851f3ac7	true	userinfo.token.claim
aaeae43e-ccee-4033-9db6-3dee851f3ac7	birthdate	user.attribute
aaeae43e-ccee-4033-9db6-3dee851f3ac7	true	id.token.claim
aaeae43e-ccee-4033-9db6-3dee851f3ac7	true	access.token.claim
aaeae43e-ccee-4033-9db6-3dee851f3ac7	birthdate	claim.name
aaeae43e-ccee-4033-9db6-3dee851f3ac7	String	jsonType.label
54286bee-1718-4a1b-be1e-a3ce18d76076	true	userinfo.token.claim
54286bee-1718-4a1b-be1e-a3ce18d76076	zoneinfo	user.attribute
54286bee-1718-4a1b-be1e-a3ce18d76076	true	id.token.claim
54286bee-1718-4a1b-be1e-a3ce18d76076	true	access.token.claim
54286bee-1718-4a1b-be1e-a3ce18d76076	zoneinfo	claim.name
54286bee-1718-4a1b-be1e-a3ce18d76076	String	jsonType.label
35774838-1127-4d1c-81df-f016351e9d04	true	userinfo.token.claim
35774838-1127-4d1c-81df-f016351e9d04	locale	user.attribute
35774838-1127-4d1c-81df-f016351e9d04	true	id.token.claim
35774838-1127-4d1c-81df-f016351e9d04	true	access.token.claim
35774838-1127-4d1c-81df-f016351e9d04	locale	claim.name
35774838-1127-4d1c-81df-f016351e9d04	String	jsonType.label
659fe326-0ea5-40ab-879a-5deecc078c3b	true	userinfo.token.claim
659fe326-0ea5-40ab-879a-5deecc078c3b	updatedAt	user.attribute
659fe326-0ea5-40ab-879a-5deecc078c3b	true	id.token.claim
659fe326-0ea5-40ab-879a-5deecc078c3b	true	access.token.claim
659fe326-0ea5-40ab-879a-5deecc078c3b	updated_at	claim.name
659fe326-0ea5-40ab-879a-5deecc078c3b	String	jsonType.label
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	true	userinfo.token.claim
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	email	user.attribute
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	true	id.token.claim
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	true	access.token.claim
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	email	claim.name
aa1773ab-16b3-4f39-94f9-13bc1e9ae537	String	jsonType.label
17a974c8-120b-40c6-8a6c-4afd39f45d17	true	userinfo.token.claim
17a974c8-120b-40c6-8a6c-4afd39f45d17	emailVerified	user.attribute
17a974c8-120b-40c6-8a6c-4afd39f45d17	true	id.token.claim
17a974c8-120b-40c6-8a6c-4afd39f45d17	true	access.token.claim
17a974c8-120b-40c6-8a6c-4afd39f45d17	email_verified	claim.name
17a974c8-120b-40c6-8a6c-4afd39f45d17	boolean	jsonType.label
7a9558af-98ac-4b2a-ae76-9223bfe20757	formatted	user.attribute.formatted
7a9558af-98ac-4b2a-ae76-9223bfe20757	country	user.attribute.country
7a9558af-98ac-4b2a-ae76-9223bfe20757	postal_code	user.attribute.postal_code
7a9558af-98ac-4b2a-ae76-9223bfe20757	true	userinfo.token.claim
7a9558af-98ac-4b2a-ae76-9223bfe20757	street	user.attribute.street
7a9558af-98ac-4b2a-ae76-9223bfe20757	true	id.token.claim
7a9558af-98ac-4b2a-ae76-9223bfe20757	region	user.attribute.region
7a9558af-98ac-4b2a-ae76-9223bfe20757	true	access.token.claim
7a9558af-98ac-4b2a-ae76-9223bfe20757	locality	user.attribute.locality
2d5f0ec2-da14-443c-9e88-192bda732223	true	userinfo.token.claim
2d5f0ec2-da14-443c-9e88-192bda732223	phoneNumber	user.attribute
2d5f0ec2-da14-443c-9e88-192bda732223	true	id.token.claim
2d5f0ec2-da14-443c-9e88-192bda732223	true	access.token.claim
2d5f0ec2-da14-443c-9e88-192bda732223	phone_number	claim.name
2d5f0ec2-da14-443c-9e88-192bda732223	String	jsonType.label
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	true	userinfo.token.claim
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	phoneNumberVerified	user.attribute
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	true	id.token.claim
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	true	access.token.claim
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	phone_number_verified	claim.name
14ce10c7-f610-47a0-8ae1-26c47a9ac3cf	boolean	jsonType.label
e76b6a51-d34d-4800-b3c3-40245da89a94	true	multivalued
e76b6a51-d34d-4800-b3c3-40245da89a94	foo	user.attribute
e76b6a51-d34d-4800-b3c3-40245da89a94	true	access.token.claim
e76b6a51-d34d-4800-b3c3-40245da89a94	realm_access.roles	claim.name
e76b6a51-d34d-4800-b3c3-40245da89a94	String	jsonType.label
2bebaf3d-41ab-4a29-b5c7-0ed282b02dd3	true	multivalued
2bebaf3d-41ab-4a29-b5c7-0ed282b02dd3	foo	user.attribute
2bebaf3d-41ab-4a29-b5c7-0ed282b02dd3	true	access.token.claim
2bebaf3d-41ab-4a29-b5c7-0ed282b02dd3	resource_access.${client_id}.roles	claim.name
2bebaf3d-41ab-4a29-b5c7-0ed282b02dd3	String	jsonType.label
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	true	userinfo.token.claim
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	username	user.attribute
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	true	id.token.claim
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	true	access.token.claim
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	upn	claim.name
a4b54a60-abd0-4e47-a3fa-a2c541cc17d6	String	jsonType.label
265c68b8-b392-44d3-8d3d-a343fb689442	true	multivalued
265c68b8-b392-44d3-8d3d-a343fb689442	foo	user.attribute
265c68b8-b392-44d3-8d3d-a343fb689442	true	id.token.claim
265c68b8-b392-44d3-8d3d-a343fb689442	true	access.token.claim
265c68b8-b392-44d3-8d3d-a343fb689442	groups	claim.name
265c68b8-b392-44d3-8d3d-a343fb689442	String	jsonType.label
6ce042d1-f62b-49d2-83a4-70300e86f494	true	userinfo.token.claim
6ce042d1-f62b-49d2-83a4-70300e86f494	locale	user.attribute
6ce042d1-f62b-49d2-83a4-70300e86f494	true	id.token.claim
6ce042d1-f62b-49d2-83a4-70300e86f494	true	access.token.claim
6ce042d1-f62b-49d2-83a4-70300e86f494	locale	claim.name
6ce042d1-f62b-49d2-83a4-70300e86f494	String	jsonType.label
1dcf0a65-f628-4420-a85d-0451d2bdfcb4	clientId	user.session.note
1dcf0a65-f628-4420-a85d-0451d2bdfcb4	true	id.token.claim
1dcf0a65-f628-4420-a85d-0451d2bdfcb4	true	access.token.claim
1dcf0a65-f628-4420-a85d-0451d2bdfcb4	clientId	claim.name
1dcf0a65-f628-4420-a85d-0451d2bdfcb4	String	jsonType.label
98be05ce-4f95-466c-9902-c04ded29ef4b	clientHost	user.session.note
98be05ce-4f95-466c-9902-c04ded29ef4b	true	id.token.claim
98be05ce-4f95-466c-9902-c04ded29ef4b	true	access.token.claim
98be05ce-4f95-466c-9902-c04ded29ef4b	clientHost	claim.name
98be05ce-4f95-466c-9902-c04ded29ef4b	String	jsonType.label
43b839c9-dbe8-4a98-986c-327e120cfc93	clientAddress	user.session.note
43b839c9-dbe8-4a98-986c-327e120cfc93	true	id.token.claim
43b839c9-dbe8-4a98-986c-327e120cfc93	true	access.token.claim
43b839c9-dbe8-4a98-986c-327e120cfc93	clientAddress	claim.name
43b839c9-dbe8-4a98-986c-327e120cfc93	String	jsonType.label
25e06c0b-529b-4704-a52d-3c1a24a0b91f	true	userinfo.token.claim
25e06c0b-529b-4704-a52d-3c1a24a0b91f	walletAddress	user.attribute
25e06c0b-529b-4704-a52d-3c1a24a0b91f	true	id.token.claim
25e06c0b-529b-4704-a52d-3c1a24a0b91f	true	access.token.claim
25e06c0b-529b-4704-a52d-3c1a24a0b91f	walletAddress	claim.name
25e06c0b-529b-4704-a52d-3c1a24a0b91f	String	jsonType.label
d934cec7-ad1c-4f53-80d6-59756518b0c5	clientId	user.session.note
d934cec7-ad1c-4f53-80d6-59756518b0c5	true	id.token.claim
d934cec7-ad1c-4f53-80d6-59756518b0c5	true	access.token.claim
d934cec7-ad1c-4f53-80d6-59756518b0c5	clientId	claim.name
d934cec7-ad1c-4f53-80d6-59756518b0c5	String	jsonType.label
b643c0b6-ed7d-4f34-adb4-25f77a5e02e2	clientHost	user.session.note
b643c0b6-ed7d-4f34-adb4-25f77a5e02e2	true	id.token.claim
b643c0b6-ed7d-4f34-adb4-25f77a5e02e2	true	access.token.claim
b643c0b6-ed7d-4f34-adb4-25f77a5e02e2	clientHost	claim.name
b643c0b6-ed7d-4f34-adb4-25f77a5e02e2	String	jsonType.label
28a8aab8-3a30-468e-954f-44ee7af6ad45	clientAddress	user.session.note
28a8aab8-3a30-468e-954f-44ee7af6ad45	true	id.token.claim
28a8aab8-3a30-468e-954f-44ee7af6ad45	true	access.token.claim
28a8aab8-3a30-468e-954f-44ee7af6ad45	clientAddress	claim.name
28a8aab8-3a30-468e-954f-44ee7af6ad45	String	jsonType.label
ec6cfd69-10be-4dbe-b534-35cbcda43247	clientId	user.session.note
ec6cfd69-10be-4dbe-b534-35cbcda43247	true	id.token.claim
ec6cfd69-10be-4dbe-b534-35cbcda43247	true	access.token.claim
ec6cfd69-10be-4dbe-b534-35cbcda43247	clientId	claim.name
ec6cfd69-10be-4dbe-b534-35cbcda43247	String	jsonType.label
c9110a9b-c636-4e36-8b68-faee1c476b0d	clientHost	user.session.note
c9110a9b-c636-4e36-8b68-faee1c476b0d	true	id.token.claim
c9110a9b-c636-4e36-8b68-faee1c476b0d	true	access.token.claim
c9110a9b-c636-4e36-8b68-faee1c476b0d	clientHost	claim.name
c9110a9b-c636-4e36-8b68-faee1c476b0d	String	jsonType.label
b7d33df2-69e7-4ef6-b169-ab9e96f3256e	clientAddress	user.session.note
b7d33df2-69e7-4ef6-b169-ab9e96f3256e	true	id.token.claim
b7d33df2-69e7-4ef6-b169-ab9e96f3256e	true	access.token.claim
b7d33df2-69e7-4ef6-b169-ab9e96f3256e	clientAddress	claim.name
b7d33df2-69e7-4ef6-b169-ab9e96f3256e	String	jsonType.label
a0cead36-f361-4861-ac6f-704aca0c7de5	i3market-consumer	role
75b540ec-4d79-4fe8-98c8-e48eecf6896f	i3market-provider	role
da1111e1-6bef-40c1-be64-84d1a6470fd7	clientId	user.session.note
da1111e1-6bef-40c1-be64-84d1a6470fd7	true	id.token.claim
da1111e1-6bef-40c1-be64-84d1a6470fd7	true	access.token.claim
da1111e1-6bef-40c1-be64-84d1a6470fd7	clientId	claim.name
da1111e1-6bef-40c1-be64-84d1a6470fd7	String	jsonType.label
38983e5c-85ef-4521-9e34-2e450e79e2c0	clientHost	user.session.note
38983e5c-85ef-4521-9e34-2e450e79e2c0	true	id.token.claim
38983e5c-85ef-4521-9e34-2e450e79e2c0	true	access.token.claim
38983e5c-85ef-4521-9e34-2e450e79e2c0	clientHost	claim.name
38983e5c-85ef-4521-9e34-2e450e79e2c0	String	jsonType.label
3a7b8393-7678-43ca-a972-79509a592c3e	clientAddress	user.session.note
3a7b8393-7678-43ca-a972-79509a592c3e	true	id.token.claim
3a7b8393-7678-43ca-a972-79509a592c3e	true	access.token.claim
3a7b8393-7678-43ca-a972-79509a592c3e	clientAddress	claim.name
3a7b8393-7678-43ca-a972-79509a592c3e	String	jsonType.label
ea41a034-2c05-49a0-9456-e2749a9e9c21	i3market-issuer	role
cffd0e5e-9124-4fe1-be5a-b94346dbda03	true	id.token.claim
cffd0e5e-9124-4fe1-be5a-b94346dbda03	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d3e5a09d-1a9e-461f-82e5-a39b06a70ffc	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	542a4980-228a-4a35-be4f-2f3fc8ebcafa	e63cf40a-296b-4db4-9be8-f951e39ad52c	7a387225-fd61-4fa0-a408-0a80746e3996	52869ca9-9f49-4d15-9556-0ccaa2c7a617	332e8913-d6cb-4439-9a91-1c5ed24dacb1	2592000	f	900	t	f	4565361c-c459-4c32-93ae-e97205465526	0	f	0	0
Company	60	300	300	\N	\N	\N	t	f	0	\N	i3market	1632472618	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	16475946-e318-47c7-b025-8b35702d5163	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	0a954106-c704-41dc-8485-88a2db6703f7	8712b41e-fbe8-4d1f-b261-026b5265b367	4993ce79-271a-4692-bd15-3242a339e5e2	e39168ff-829e-4fb9-83a0-0071adbfe9d6	229f1d69-ae8f-4889-9f89-6d59b6ab0e05	2592000	f	900	t	f	1c8aefc1-e77e-4140-95ed-17135d8b8653	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
clientSessionIdleTimeout	0	Company
clientSessionMaxLifespan	0	Company
clientOfflineSessionIdleTimeout	0	Company
clientOfflineSessionMaxLifespan	0	Company
bruteForceProtected	false	Company
permanentLockout	false	Company
maxFailureWaitSeconds	900	Company
minimumQuickLoginWaitSeconds	60	Company
waitIncrementSeconds	60	Company
quickLoginCheckMilliSeconds	1000	Company
maxDeltaTimeSeconds	43200	Company
failureFactor	30	Company
actionTokenGeneratedByAdminLifespan	43200	Company
actionTokenGeneratedByUserLifespan	300	Company
offlineSessionMaxLifespanEnabled	false	Company
offlineSessionMaxLifespan	5184000	Company
webAuthnPolicyRpEntityName	keycloak	Company
webAuthnPolicySignatureAlgorithms	ES256	Company
webAuthnPolicyRpId		Company
webAuthnPolicyAttestationConveyancePreference	not specified	Company
webAuthnPolicyAuthenticatorAttachment	not specified	Company
webAuthnPolicyRequireResidentKey	not specified	Company
webAuthnPolicyUserVerificationRequirement	not specified	Company
webAuthnPolicyCreateTimeout	0	Company
webAuthnPolicyAvoidSameAuthenticatorRegister	false	Company
webAuthnPolicyRpEntityNamePasswordless	keycloak	Company
webAuthnPolicySignatureAlgorithmsPasswordless	ES256	Company
webAuthnPolicyRpIdPasswordless		Company
webAuthnPolicyAttestationConveyancePreferencePasswordless	not specified	Company
webAuthnPolicyAuthenticatorAttachmentPasswordless	not specified	Company
webAuthnPolicyRequireResidentKeyPasswordless	not specified	Company
webAuthnPolicyUserVerificationRequirementPasswordless	not specified	Company
webAuthnPolicyCreateTimeoutPasswordless	0	Company
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	false	Company
_browser_header.contentSecurityPolicyReportOnly		Company
_browser_header.xContentTypeOptions	nosniff	Company
_browser_header.xRobotsTag	none	Company
_browser_header.xFrameOptions	SAMEORIGIN	Company
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	Company
_browser_header.xXSSProtection	1; mode=block	Company
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	Company
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	51c63cc5-a9f5-4215-b691-790e66be86ba
master	e56f2520-e787-465b-bcb7-709cf5a42a07
Company	725b7f81-2afb-4a73-b6ce-56770a9f81a5
Company	de5f45da-a4af-4e8e-b024-282008f89219
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
Company	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	Company
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
Company		starttls
Company	1025	port
Company		auth
Company	mailhog	host
Company	noreply@keycloak	from
Company		ssl
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
4526389f-2b6f-455d-b72c-22433e78dfb2	/realms/master/account/*
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	/realms/master/account/*
af9205c2-7b51-47d2-ad93-24c612401bec	/admin/master/console/*
4ec4f635-04a9-4944-8d65-e6588aaa18da	/realms/Company/account/*
3c03f823-8719-47bf-8648-c07fa53d06bc	*
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	/admin/i3market/console/*
87c9de72-44b2-4ed4-87fe-db25c8c2fbff	/realms/i3market/account/*
3269b142-f564-4374-b84a-512b0f02885b	www.google.it
a284c132-cb55-40c2-b25d-a3db6943a0de	https://oauthdebugger.com/debug
346a601f-75f5-4939-9bb8-e66f0e944e68	https://oauthdebugger.com/debug
bcb21012-4bae-4531-9f4e-c53b4205c30e	www.google.it
9b8823a7-3a8b-45cb-b9c0-5c5f286731fc	https://oauthdebugger.com/debug
a2714f12-c8ff-43d4-b011-673371652f85	https://oauthdebugger.com/debug
f691313d-52dc-4dd4-899c-b07faf56e2c2	https://oauthdebugger.com/debug
c868ffd4-4425-4a17-b483-4a22950bd748	https://oauthdebugger.com/debug
e4a0c7e3-9086-4185-a6bd-caa9c0a09b5d	https://oauthdebugger.com/debug
5abff2bf-fef2-4b07-8ea6-1f1c95207dcc	https://oauthdebugger.com/debug
a9402390-c5f9-4899-8135-9e901af9710c	https://oauthdebugger.com/debug
b63fb8a7-600a-4fb6-bab1-3c400398b314	https://oauthdebugger.com/debug
fb69a878-50d1-43ed-a604-447f75565cf8	https://oauthdebugger.com/debug
76757943-77e3-408d-8f41-105880b46eed	https://oauthdebugger.com/debug
a8a02f01-0c19-461d-a919-33ce6926d2fe	http://localhost:4200/credential
a8a02f01-0c19-461d-a919-33ce6926d2fe	https://oauthdebugger.com/debug
3fe58830-bb3b-4a75-a01e-de1928321a72	http://localhost:4200/credential
3fe58830-bb3b-4a75-a01e-de1928321a72	https://oauthdebugger.com/debug
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	http://localhost:4200/credential
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	https://oauthdebugger.com/debug
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
245ae9ce-9a98-4c8d-b314-844de27ae6ed	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
faa9b71b-897c-4b1b-a5d4-43c6b3410b62	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
b94b2d2a-e052-4137-a091-10ca39fc01ea	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
827cf361-6e05-4765-ac0b-485dcb0f08eb	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
a0433ecc-03bf-4025-9aff-fa6ca7690eeb	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
a23d6477-88c0-42b0-ba53-329fb09c425b	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
a4c57f14-391d-4008-817d-3db17eddc1b7	delete_account	Delete Account	master	f	f	delete_account	60
b1a11373-39a4-4981-b838-b647bf41eaa7	VERIFY_EMAIL	Verify Email	Company	t	f	VERIFY_EMAIL	50
865bea19-5112-48b9-a7da-6d59443e458c	UPDATE_PROFILE	Update Profile	Company	t	f	UPDATE_PROFILE	40
691cdb34-fe35-4d71-b331-6d15e959fcf3	CONFIGURE_TOTP	Configure OTP	Company	t	f	CONFIGURE_TOTP	10
edb82840-d494-4d48-97f9-0709d597c8a8	UPDATE_PASSWORD	Update Password	Company	t	f	UPDATE_PASSWORD	30
787b3765-77f4-4869-b88c-f6fb46ba7bbc	terms_and_conditions	Terms and Conditions	Company	f	f	terms_and_conditions	20
0f7df41f-4d5b-4690-8b7e-cdfc691deb9a	update_user_locale	Update User Locale	Company	t	f	update_user_locale	1000
e9de7e93-57d7-4dc1-99ac-5a70657592b7	delete_account	Delete Account	Company	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
adb6b6f5-7b28-4e06-8fe6-012984f00dfa	199f30c8-bd8a-47b8-ae0c-f3dd16bba2de
4ec4f635-04a9-4944-8d65-e6588aaa18da	29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0
a284c132-cb55-40c2-b25d-a3db6943a0de	7bd5891b-16c4-43df-a230-5d68ca681262
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
locale	en	c9881161-f756-4e51-8639-cddfa46174c1	ef73f40d-06f8-42ad-b4c6-509d7ef1582e
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
825d15bb-3dbe-4987-b70e-c5993cea44fc	\N	d2b8ca3d-4dae-4983-9c30-83f461a429da	f	t	\N	\N	\N	Company	service-account-service-client	1621853115423	3c03f823-8719-47bf-8648-c07fa53d06bc	0
9cbff8fc-41a7-4b04-a8c3-682e1c25823a	\N	15e86e4c-8e46-4f55-9e28-8e7ba5d30342	t	t	\N	\N	\N	Company	user1	1621853189377	\N	0
b32de9ba-14ee-463c-84cb-4359fb97d01c	\N	4195c714-df7c-4f48-85d0-195a54026a1e	t	t	\N	\N	\N	Company	user2	1621853200057	\N	0
f32238b9-c0ec-4b09-a5ae-f97df023b093	\N	f0473cd6-f85b-4536-ba4b-26fa28305d0e	t	t	\N	\N	\N	Company	user3	1621853208720	\N	0
04263061-43a5-49eb-a9bc-dac980c0e8cf	\N	db665582-2772-4cfe-9e6b-3fc6058dd0d5	t	t	\N	\N	\N	Company	user4	1621853215288	\N	0
f3b821c4-0f12-4eef-b8d6-26ecb49a8a64	\N	3d693051-2293-4567-82b3-7afe3aceae5e	t	t	\N	\N	\N	Company	user5	1621853222451	\N	0
c9881161-f756-4e51-8639-cddfa46174c1	admin@keycloak	admin@keycloak	f	t	\N	admin	admin	master	admin	1621852940306	\N	0
1df78d60-40c9-4452-adc6-14664b4837e7	\N	c4c84dbd-0b47-4010-9419-96b92361e51d	t	t	\N	\N	\N	Company	admin	1621853930531	\N	0
8a75a8e8-9761-4373-b713-cbad641f5b7d	\N	e625e131-364c-478f-9f5b-60c612578ccc	f	t	\N	\N	\N	Company	service-account-adminclient	1625814608578	3269b142-f564-4374-b84a-512b0f02885b	0
5ddbd744-3393-45a7-809f-77899baff289	\N	d5c6d681-74ee-49d7-968e-6c0fc5006197	f	t	\N	\N	\N	Company	service-account-backplaneapi	1626036267527	bcb21012-4bae-4531-9f4e-c53b4205c30e	0
480b5a53-276e-474b-ab7d-02f00743b01d	\N	77448d72-5d7d-4322-a761-1183230cd337	f	t	\N	\N	\N	Company	did:ethr:0xb606e9ff3e5004144fc5d74145e825e6df9014d6	1626847858441	\N	0
28d74fb0-76fa-4994-993e-4ab4b2d0632b	newuser2@mail.it	newuser2@mail.it	t	t	\N	Nuovo	Utente2	Company	newuser2	1626872197444	\N	0
ebddc15d-9ea8-42ca-85a9-9d987c1ce796	newuser3@mail.it	newuser3@mail.it	t	t	\N	Nuovo	Utente3	Company	newuser3	1626898832415	\N	0
8fefd63e-c97b-448f-acdd-adfac0da8827	newuser4@mail.it	newuser4@mail.it	t	t	\N	Nuovo	Utente4	Company	newuser4	1626940163620	\N	0
f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea	newuser6@mail.it	newuser6@mail.it	t	t	\N	Nuovo	Utente6	Company	newuser6	1626961857732	\N	0
e8c8d2e9-52fa-4e44-8a3d-b126268fff22	newuser7@mail.it	newuser7@mail.it	t	t	\N	Nuovo	Utente7	Company	newuser7	1626963598229	\N	0
1e279137-5e77-402e-9363-2a2934028553	newuser8@mail.it	newuser8@mail.it	t	t	\N	Nuovo	Utente8	Company	newuser8	1626966856189	\N	0
c004868e-7494-401b-b6fe-59430debe54b	newuser9@mail.it	newuser9@mail.it	t	t	\N	Nuovo	Utente9	Company	newuser9	1626968597698	\N	0
26663e22-5da6-4b46-81b8-0af487d27ae8	newuser11@mail.it	newuser11@mail.it	t	t	\N	Nuovo	Utente11	Company	newuser11	1626969407478	\N	0
a6da43a4-6c98-4216-b6ee-ee815b77e0d8	newuser12@mail.it	newuser12@mail.it	t	t	\N	Nuovo	Utente12	Company	newuser12	1626969826466	\N	0
05046139-2f58-4a42-9988-994182312c26	\N	51e45700-1718-4666-a23a-d98b58731b16	f	t	\N	\N	\N	Company	did:ethr:0x1de2179e5bc13262525e3b8b2916d370b47f7820	1626971195350	\N	0
914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf	newuser10@mail.it	newuser10@mail.it	t	t	\N	Nuovo	Utente10	Company	newuser10	1626972658089	\N	0
670ecad2-0e81-4226-8dd3-8c12155833d5	newuser21@mail.it	newuser21@mail.it	t	t	\N	Nuovo	Utente21	Company	newuser21	1627401192386	\N	0
bc59a9d8-78c8-4023-9d5d-65640031d130	user7@mail.it	user7@mail.it	t	t	\N	Nuovo	Utente6	Company	user7	1631170972450	\N	0
d5651d30-c8fb-43c4-af4e-9247bc4cbc3d	\N	d1db63a9-27f2-4b4d-b6d3-214db18b5ce8	f	t	\N	\N	\N	Company	service-account-test-admin	1631189866017	fb69a878-50d1-43ed-a604-447f75565cf8	0
71ea81f8-96f1-4bcd-8878-6936ac10effd	ruèert@mail.it	ruèert@mail.it	t	t	\N	Nuovo	Utente	Company	rupert	1632404656156	\N	0
4e457aec-fe51-4283-ad6c-14beb308e11a	\N	4455db7b-24c3-46af-9a31-424d1a384ffc	f	t	\N	\N	\N	Company	did:ethr:i3m:0x03285bec044fbc32bd2c03dccce6a12b3ccca5defda9c8bc717b9b16e15e583d9e	1632407566202	\N	0
b5e057d1-0ea0-460c-b85d-a055284f80b4	\N	28d76f9d-6560-46e0-a5c2-e749f9049f70	f	t	\N	\N	\N	Company	did:ethr:rinkeby:0x03526203383689c7482083fe5ed8c697291e78ce258b386bc914ed40fab9e13b29	1632407716872	\N	0
a2980996-e29a-413b-91db-5b7be475014f	\N	711737ab-16a7-4e3e-8ea2-a432a78f52e3	f	t	\N	\N	\N	Company	did:ethr:rinkeby:0x02a508a8efc97a5b40c04229c21206055f70ee36f10aded6813041bc0d36afd14a	1632408200216	\N	0
468926e7-0094-498f-83d0-3fe03c2de18a	\N	be9170b2-9705-4417-9aaa-0c611371f7ba	f	t	\N	\N	\N	Company	did:ethr:i3m:0x02ef12e48430fdf5143fffdecc73ca10f06f26f95e7e173e504ec17acd073d9094	1632759665209	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
9cbff8fc-41a7-4b04-a8c3-682e1c25823a	UPDATE_PASSWORD
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
51c63cc5-a9f5-4215-b691-790e66be86ba	c9881161-f756-4e51-8639-cddfa46174c1
e56f2520-e787-465b-bcb7-709cf5a42a07	c9881161-f756-4e51-8639-cddfa46174c1
199f30c8-bd8a-47b8-ae0c-f3dd16bba2de	c9881161-f756-4e51-8639-cddfa46174c1
2f34707b-2073-41f6-92f7-e8d191230709	c9881161-f756-4e51-8639-cddfa46174c1
bcbf15c1-8835-4706-b40b-16261f32fae6	c9881161-f756-4e51-8639-cddfa46174c1
de5f45da-a4af-4e8e-b024-282008f89219	825d15bb-3dbe-4987-b70e-c5993cea44fc
725b7f81-2afb-4a73-b6ce-56770a9f81a5	825d15bb-3dbe-4987-b70e-c5993cea44fc
45d7b16a-8666-4804-bc00-38fc2b33682a	825d15bb-3dbe-4987-b70e-c5993cea44fc
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	825d15bb-3dbe-4987-b70e-c5993cea44fc
e3545356-874f-4ed5-b3a4-e101637b1ab4	825d15bb-3dbe-4987-b70e-c5993cea44fc
bd9a8651-888b-4aac-9142-949c741272d4	825d15bb-3dbe-4987-b70e-c5993cea44fc
4a9da917-8c69-47e5-becb-9075b601c523	825d15bb-3dbe-4987-b70e-c5993cea44fc
8ba80c05-0322-4f5f-a7cb-e3c650478184	825d15bb-3dbe-4987-b70e-c5993cea44fc
6b813017-2343-4419-a202-5b451899a456	825d15bb-3dbe-4987-b70e-c5993cea44fc
6491e3b5-25ca-42be-b86a-4bf8e4a758b8	825d15bb-3dbe-4987-b70e-c5993cea44fc
e400897c-0fd1-44d7-a2b4-65dbe3c8df78	825d15bb-3dbe-4987-b70e-c5993cea44fc
e366f778-bcfc-47dc-ab03-690f48912906	825d15bb-3dbe-4987-b70e-c5993cea44fc
aba147f7-727c-4b60-91d1-40b6e785027b	825d15bb-3dbe-4987-b70e-c5993cea44fc
6b77038d-3ec6-4d38-9972-140ee4f5e45a	825d15bb-3dbe-4987-b70e-c5993cea44fc
8d3d17a1-abfa-467e-a98d-ab8f2d978707	825d15bb-3dbe-4987-b70e-c5993cea44fc
fdc5c41b-0baf-402d-aa70-dbab46dde861	825d15bb-3dbe-4987-b70e-c5993cea44fc
0d28815b-b5fe-4348-add3-252bf3c67e4f	825d15bb-3dbe-4987-b70e-c5993cea44fc
de5f45da-a4af-4e8e-b024-282008f89219	9cbff8fc-41a7-4b04-a8c3-682e1c25823a
725b7f81-2afb-4a73-b6ce-56770a9f81a5	9cbff8fc-41a7-4b04-a8c3-682e1c25823a
45d7b16a-8666-4804-bc00-38fc2b33682a	9cbff8fc-41a7-4b04-a8c3-682e1c25823a
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	9cbff8fc-41a7-4b04-a8c3-682e1c25823a
de5f45da-a4af-4e8e-b024-282008f89219	b32de9ba-14ee-463c-84cb-4359fb97d01c
725b7f81-2afb-4a73-b6ce-56770a9f81a5	b32de9ba-14ee-463c-84cb-4359fb97d01c
45d7b16a-8666-4804-bc00-38fc2b33682a	b32de9ba-14ee-463c-84cb-4359fb97d01c
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	b32de9ba-14ee-463c-84cb-4359fb97d01c
de5f45da-a4af-4e8e-b024-282008f89219	f32238b9-c0ec-4b09-a5ae-f97df023b093
725b7f81-2afb-4a73-b6ce-56770a9f81a5	f32238b9-c0ec-4b09-a5ae-f97df023b093
45d7b16a-8666-4804-bc00-38fc2b33682a	f32238b9-c0ec-4b09-a5ae-f97df023b093
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	f32238b9-c0ec-4b09-a5ae-f97df023b093
de5f45da-a4af-4e8e-b024-282008f89219	04263061-43a5-49eb-a9bc-dac980c0e8cf
725b7f81-2afb-4a73-b6ce-56770a9f81a5	04263061-43a5-49eb-a9bc-dac980c0e8cf
45d7b16a-8666-4804-bc00-38fc2b33682a	04263061-43a5-49eb-a9bc-dac980c0e8cf
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	04263061-43a5-49eb-a9bc-dac980c0e8cf
de5f45da-a4af-4e8e-b024-282008f89219	f3b821c4-0f12-4eef-b8d6-26ecb49a8a64
725b7f81-2afb-4a73-b6ce-56770a9f81a5	f3b821c4-0f12-4eef-b8d6-26ecb49a8a64
45d7b16a-8666-4804-bc00-38fc2b33682a	f3b821c4-0f12-4eef-b8d6-26ecb49a8a64
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	f3b821c4-0f12-4eef-b8d6-26ecb49a8a64
de5f45da-a4af-4e8e-b024-282008f89219	1df78d60-40c9-4452-adc6-14664b4837e7
725b7f81-2afb-4a73-b6ce-56770a9f81a5	1df78d60-40c9-4452-adc6-14664b4837e7
45d7b16a-8666-4804-bc00-38fc2b33682a	1df78d60-40c9-4452-adc6-14664b4837e7
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	1df78d60-40c9-4452-adc6-14664b4837e7
de5f45da-a4af-4e8e-b024-282008f89219	8a75a8e8-9761-4373-b713-cbad641f5b7d
725b7f81-2afb-4a73-b6ce-56770a9f81a5	8a75a8e8-9761-4373-b713-cbad641f5b7d
45d7b16a-8666-4804-bc00-38fc2b33682a	8a75a8e8-9761-4373-b713-cbad641f5b7d
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	8a75a8e8-9761-4373-b713-cbad641f5b7d
e3545356-874f-4ed5-b3a4-e101637b1ab4	8a75a8e8-9761-4373-b713-cbad641f5b7d
bd9a8651-888b-4aac-9142-949c741272d4	8a75a8e8-9761-4373-b713-cbad641f5b7d
4a9da917-8c69-47e5-becb-9075b601c523	8a75a8e8-9761-4373-b713-cbad641f5b7d
8ba80c05-0322-4f5f-a7cb-e3c650478184	8a75a8e8-9761-4373-b713-cbad641f5b7d
6b813017-2343-4419-a202-5b451899a456	8a75a8e8-9761-4373-b713-cbad641f5b7d
6491e3b5-25ca-42be-b86a-4bf8e4a758b8	8a75a8e8-9761-4373-b713-cbad641f5b7d
e400897c-0fd1-44d7-a2b4-65dbe3c8df78	8a75a8e8-9761-4373-b713-cbad641f5b7d
e366f778-bcfc-47dc-ab03-690f48912906	8a75a8e8-9761-4373-b713-cbad641f5b7d
aba147f7-727c-4b60-91d1-40b6e785027b	8a75a8e8-9761-4373-b713-cbad641f5b7d
6b77038d-3ec6-4d38-9972-140ee4f5e45a	8a75a8e8-9761-4373-b713-cbad641f5b7d
8d3d17a1-abfa-467e-a98d-ab8f2d978707	8a75a8e8-9761-4373-b713-cbad641f5b7d
fdc5c41b-0baf-402d-aa70-dbab46dde861	8a75a8e8-9761-4373-b713-cbad641f5b7d
0d28815b-b5fe-4348-add3-252bf3c67e4f	8a75a8e8-9761-4373-b713-cbad641f5b7d
de5f45da-a4af-4e8e-b024-282008f89219	5ddbd744-3393-45a7-809f-77899baff289
725b7f81-2afb-4a73-b6ce-56770a9f81a5	5ddbd744-3393-45a7-809f-77899baff289
45d7b16a-8666-4804-bc00-38fc2b33682a	5ddbd744-3393-45a7-809f-77899baff289
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	5ddbd744-3393-45a7-809f-77899baff289
da3da7cb-e80f-4877-bf53-091868ed0370	5ddbd744-3393-45a7-809f-77899baff289
186d4618-d2cd-47c8-a4dc-0f562a861898	5ddbd744-3393-45a7-809f-77899baff289
8c44b1f3-186d-41e2-a8e0-85cf668366d4	5ddbd744-3393-45a7-809f-77899baff289
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	5ddbd744-3393-45a7-809f-77899baff289
de5f45da-a4af-4e8e-b024-282008f89219	480b5a53-276e-474b-ab7d-02f00743b01d
725b7f81-2afb-4a73-b6ce-56770a9f81a5	480b5a53-276e-474b-ab7d-02f00743b01d
45d7b16a-8666-4804-bc00-38fc2b33682a	480b5a53-276e-474b-ab7d-02f00743b01d
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	480b5a53-276e-474b-ab7d-02f00743b01d
da3da7cb-e80f-4877-bf53-091868ed0370	480b5a53-276e-474b-ab7d-02f00743b01d
186d4618-d2cd-47c8-a4dc-0f562a861898	480b5a53-276e-474b-ab7d-02f00743b01d
8c44b1f3-186d-41e2-a8e0-85cf668366d4	480b5a53-276e-474b-ab7d-02f00743b01d
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	480b5a53-276e-474b-ab7d-02f00743b01d
de5f45da-a4af-4e8e-b024-282008f89219	28d74fb0-76fa-4994-993e-4ab4b2d0632b
725b7f81-2afb-4a73-b6ce-56770a9f81a5	28d74fb0-76fa-4994-993e-4ab4b2d0632b
45d7b16a-8666-4804-bc00-38fc2b33682a	28d74fb0-76fa-4994-993e-4ab4b2d0632b
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	28d74fb0-76fa-4994-993e-4ab4b2d0632b
da3da7cb-e80f-4877-bf53-091868ed0370	28d74fb0-76fa-4994-993e-4ab4b2d0632b
186d4618-d2cd-47c8-a4dc-0f562a861898	28d74fb0-76fa-4994-993e-4ab4b2d0632b
8c44b1f3-186d-41e2-a8e0-85cf668366d4	28d74fb0-76fa-4994-993e-4ab4b2d0632b
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	28d74fb0-76fa-4994-993e-4ab4b2d0632b
de5f45da-a4af-4e8e-b024-282008f89219	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
725b7f81-2afb-4a73-b6ce-56770a9f81a5	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
45d7b16a-8666-4804-bc00-38fc2b33682a	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
da3da7cb-e80f-4877-bf53-091868ed0370	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
186d4618-d2cd-47c8-a4dc-0f562a861898	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
8c44b1f3-186d-41e2-a8e0-85cf668366d4	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
2bb46018-a878-4a07-b7a5-a7bee5d2b340	ebddc15d-9ea8-42ca-85a9-9d987c1ce796
de5f45da-a4af-4e8e-b024-282008f89219	8fefd63e-c97b-448f-acdd-adfac0da8827
725b7f81-2afb-4a73-b6ce-56770a9f81a5	8fefd63e-c97b-448f-acdd-adfac0da8827
45d7b16a-8666-4804-bc00-38fc2b33682a	8fefd63e-c97b-448f-acdd-adfac0da8827
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	8fefd63e-c97b-448f-acdd-adfac0da8827
da3da7cb-e80f-4877-bf53-091868ed0370	8fefd63e-c97b-448f-acdd-adfac0da8827
186d4618-d2cd-47c8-a4dc-0f562a861898	8fefd63e-c97b-448f-acdd-adfac0da8827
8c44b1f3-186d-41e2-a8e0-85cf668366d4	8fefd63e-c97b-448f-acdd-adfac0da8827
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	8fefd63e-c97b-448f-acdd-adfac0da8827
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	8fefd63e-c97b-448f-acdd-adfac0da8827
2bb46018-a878-4a07-b7a5-a7bee5d2b340	8fefd63e-c97b-448f-acdd-adfac0da8827
01193d9e-f6ad-4732-9ca8-2243d35a539f	8fefd63e-c97b-448f-acdd-adfac0da8827
62e102db-30b9-4443-9ac6-53eddd18a42a	8fefd63e-c97b-448f-acdd-adfac0da8827
de5f45da-a4af-4e8e-b024-282008f89219	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
725b7f81-2afb-4a73-b6ce-56770a9f81a5	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
45d7b16a-8666-4804-bc00-38fc2b33682a	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
da3da7cb-e80f-4877-bf53-091868ed0370	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
186d4618-d2cd-47c8-a4dc-0f562a861898	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
8c44b1f3-186d-41e2-a8e0-85cf668366d4	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
2bb46018-a878-4a07-b7a5-a7bee5d2b340	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
01193d9e-f6ad-4732-9ca8-2243d35a539f	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
62e102db-30b9-4443-9ac6-53eddd18a42a	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
40a61e05-4540-443f-ab61-707c17ab6182	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	f68cf0d9-d134-4bf1-b4e0-ebbf73a544ea
de5f45da-a4af-4e8e-b024-282008f89219	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
725b7f81-2afb-4a73-b6ce-56770a9f81a5	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
45d7b16a-8666-4804-bc00-38fc2b33682a	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
da3da7cb-e80f-4877-bf53-091868ed0370	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
186d4618-d2cd-47c8-a4dc-0f562a861898	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
8c44b1f3-186d-41e2-a8e0-85cf668366d4	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
2bb46018-a878-4a07-b7a5-a7bee5d2b340	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
01193d9e-f6ad-4732-9ca8-2243d35a539f	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
62e102db-30b9-4443-9ac6-53eddd18a42a	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
40a61e05-4540-443f-ab61-707c17ab6182	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	e8c8d2e9-52fa-4e44-8a3d-b126268fff22
de5f45da-a4af-4e8e-b024-282008f89219	1e279137-5e77-402e-9363-2a2934028553
725b7f81-2afb-4a73-b6ce-56770a9f81a5	1e279137-5e77-402e-9363-2a2934028553
45d7b16a-8666-4804-bc00-38fc2b33682a	1e279137-5e77-402e-9363-2a2934028553
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	1e279137-5e77-402e-9363-2a2934028553
da3da7cb-e80f-4877-bf53-091868ed0370	1e279137-5e77-402e-9363-2a2934028553
186d4618-d2cd-47c8-a4dc-0f562a861898	1e279137-5e77-402e-9363-2a2934028553
8c44b1f3-186d-41e2-a8e0-85cf668366d4	1e279137-5e77-402e-9363-2a2934028553
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	1e279137-5e77-402e-9363-2a2934028553
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	1e279137-5e77-402e-9363-2a2934028553
2bb46018-a878-4a07-b7a5-a7bee5d2b340	1e279137-5e77-402e-9363-2a2934028553
01193d9e-f6ad-4732-9ca8-2243d35a539f	1e279137-5e77-402e-9363-2a2934028553
62e102db-30b9-4443-9ac6-53eddd18a42a	1e279137-5e77-402e-9363-2a2934028553
40a61e05-4540-443f-ab61-707c17ab6182	1e279137-5e77-402e-9363-2a2934028553
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	1e279137-5e77-402e-9363-2a2934028553
de5f45da-a4af-4e8e-b024-282008f89219	c004868e-7494-401b-b6fe-59430debe54b
725b7f81-2afb-4a73-b6ce-56770a9f81a5	c004868e-7494-401b-b6fe-59430debe54b
45d7b16a-8666-4804-bc00-38fc2b33682a	c004868e-7494-401b-b6fe-59430debe54b
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	c004868e-7494-401b-b6fe-59430debe54b
da3da7cb-e80f-4877-bf53-091868ed0370	c004868e-7494-401b-b6fe-59430debe54b
186d4618-d2cd-47c8-a4dc-0f562a861898	c004868e-7494-401b-b6fe-59430debe54b
8c44b1f3-186d-41e2-a8e0-85cf668366d4	c004868e-7494-401b-b6fe-59430debe54b
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	c004868e-7494-401b-b6fe-59430debe54b
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	c004868e-7494-401b-b6fe-59430debe54b
2bb46018-a878-4a07-b7a5-a7bee5d2b340	c004868e-7494-401b-b6fe-59430debe54b
01193d9e-f6ad-4732-9ca8-2243d35a539f	c004868e-7494-401b-b6fe-59430debe54b
62e102db-30b9-4443-9ac6-53eddd18a42a	c004868e-7494-401b-b6fe-59430debe54b
40a61e05-4540-443f-ab61-707c17ab6182	c004868e-7494-401b-b6fe-59430debe54b
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	c004868e-7494-401b-b6fe-59430debe54b
cb9b072e-93dc-47e1-a943-47cbe9e18674	c004868e-7494-401b-b6fe-59430debe54b
da01fe6e-f088-4caa-a049-9e0ec22a3cec	c004868e-7494-401b-b6fe-59430debe54b
de5f45da-a4af-4e8e-b024-282008f89219	26663e22-5da6-4b46-81b8-0af487d27ae8
725b7f81-2afb-4a73-b6ce-56770a9f81a5	26663e22-5da6-4b46-81b8-0af487d27ae8
45d7b16a-8666-4804-bc00-38fc2b33682a	26663e22-5da6-4b46-81b8-0af487d27ae8
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	26663e22-5da6-4b46-81b8-0af487d27ae8
da3da7cb-e80f-4877-bf53-091868ed0370	26663e22-5da6-4b46-81b8-0af487d27ae8
186d4618-d2cd-47c8-a4dc-0f562a861898	26663e22-5da6-4b46-81b8-0af487d27ae8
8c44b1f3-186d-41e2-a8e0-85cf668366d4	26663e22-5da6-4b46-81b8-0af487d27ae8
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	26663e22-5da6-4b46-81b8-0af487d27ae8
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	26663e22-5da6-4b46-81b8-0af487d27ae8
2bb46018-a878-4a07-b7a5-a7bee5d2b340	26663e22-5da6-4b46-81b8-0af487d27ae8
01193d9e-f6ad-4732-9ca8-2243d35a539f	26663e22-5da6-4b46-81b8-0af487d27ae8
62e102db-30b9-4443-9ac6-53eddd18a42a	26663e22-5da6-4b46-81b8-0af487d27ae8
40a61e05-4540-443f-ab61-707c17ab6182	26663e22-5da6-4b46-81b8-0af487d27ae8
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	26663e22-5da6-4b46-81b8-0af487d27ae8
cb9b072e-93dc-47e1-a943-47cbe9e18674	26663e22-5da6-4b46-81b8-0af487d27ae8
da01fe6e-f088-4caa-a049-9e0ec22a3cec	26663e22-5da6-4b46-81b8-0af487d27ae8
de5f45da-a4af-4e8e-b024-282008f89219	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
725b7f81-2afb-4a73-b6ce-56770a9f81a5	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
45d7b16a-8666-4804-bc00-38fc2b33682a	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
da3da7cb-e80f-4877-bf53-091868ed0370	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
186d4618-d2cd-47c8-a4dc-0f562a861898	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
8c44b1f3-186d-41e2-a8e0-85cf668366d4	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
2bb46018-a878-4a07-b7a5-a7bee5d2b340	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
01193d9e-f6ad-4732-9ca8-2243d35a539f	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
62e102db-30b9-4443-9ac6-53eddd18a42a	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
40a61e05-4540-443f-ab61-707c17ab6182	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
cb9b072e-93dc-47e1-a943-47cbe9e18674	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
da01fe6e-f088-4caa-a049-9e0ec22a3cec	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	a6da43a4-6c98-4216-b6ee-ee815b77e0d8
de5f45da-a4af-4e8e-b024-282008f89219	05046139-2f58-4a42-9988-994182312c26
725b7f81-2afb-4a73-b6ce-56770a9f81a5	05046139-2f58-4a42-9988-994182312c26
45d7b16a-8666-4804-bc00-38fc2b33682a	05046139-2f58-4a42-9988-994182312c26
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	05046139-2f58-4a42-9988-994182312c26
da3da7cb-e80f-4877-bf53-091868ed0370	05046139-2f58-4a42-9988-994182312c26
186d4618-d2cd-47c8-a4dc-0f562a861898	05046139-2f58-4a42-9988-994182312c26
8c44b1f3-186d-41e2-a8e0-85cf668366d4	05046139-2f58-4a42-9988-994182312c26
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	05046139-2f58-4a42-9988-994182312c26
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	05046139-2f58-4a42-9988-994182312c26
2bb46018-a878-4a07-b7a5-a7bee5d2b340	05046139-2f58-4a42-9988-994182312c26
01193d9e-f6ad-4732-9ca8-2243d35a539f	05046139-2f58-4a42-9988-994182312c26
62e102db-30b9-4443-9ac6-53eddd18a42a	05046139-2f58-4a42-9988-994182312c26
40a61e05-4540-443f-ab61-707c17ab6182	05046139-2f58-4a42-9988-994182312c26
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	05046139-2f58-4a42-9988-994182312c26
cb9b072e-93dc-47e1-a943-47cbe9e18674	05046139-2f58-4a42-9988-994182312c26
da01fe6e-f088-4caa-a049-9e0ec22a3cec	05046139-2f58-4a42-9988-994182312c26
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	05046139-2f58-4a42-9988-994182312c26
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	05046139-2f58-4a42-9988-994182312c26
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	05046139-2f58-4a42-9988-994182312c26
0532209d-ba3a-428a-b926-9fc25502613f	05046139-2f58-4a42-9988-994182312c26
e9495f4b-d634-4fcd-8d74-191d285dd406	05046139-2f58-4a42-9988-994182312c26
28ecaad6-3925-49eb-880f-e2a8b2c3297c	05046139-2f58-4a42-9988-994182312c26
de5f45da-a4af-4e8e-b024-282008f89219	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
725b7f81-2afb-4a73-b6ce-56770a9f81a5	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
45d7b16a-8666-4804-bc00-38fc2b33682a	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
da3da7cb-e80f-4877-bf53-091868ed0370	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
186d4618-d2cd-47c8-a4dc-0f562a861898	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
8c44b1f3-186d-41e2-a8e0-85cf668366d4	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
2bb46018-a878-4a07-b7a5-a7bee5d2b340	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
01193d9e-f6ad-4732-9ca8-2243d35a539f	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
62e102db-30b9-4443-9ac6-53eddd18a42a	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
40a61e05-4540-443f-ab61-707c17ab6182	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
cb9b072e-93dc-47e1-a943-47cbe9e18674	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
da01fe6e-f088-4caa-a049-9e0ec22a3cec	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
0532209d-ba3a-428a-b926-9fc25502613f	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
e9495f4b-d634-4fcd-8d74-191d285dd406	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
28ecaad6-3925-49eb-880f-e2a8b2c3297c	914d6f49-9bd7-4ee4-b5c0-f5f54e1976cf
de5f45da-a4af-4e8e-b024-282008f89219	670ecad2-0e81-4226-8dd3-8c12155833d5
725b7f81-2afb-4a73-b6ce-56770a9f81a5	670ecad2-0e81-4226-8dd3-8c12155833d5
45d7b16a-8666-4804-bc00-38fc2b33682a	670ecad2-0e81-4226-8dd3-8c12155833d5
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	670ecad2-0e81-4226-8dd3-8c12155833d5
da3da7cb-e80f-4877-bf53-091868ed0370	670ecad2-0e81-4226-8dd3-8c12155833d5
186d4618-d2cd-47c8-a4dc-0f562a861898	670ecad2-0e81-4226-8dd3-8c12155833d5
8c44b1f3-186d-41e2-a8e0-85cf668366d4	670ecad2-0e81-4226-8dd3-8c12155833d5
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	670ecad2-0e81-4226-8dd3-8c12155833d5
add1c218-7f67-4403-a8e8-8a18c7759881	670ecad2-0e81-4226-8dd3-8c12155833d5
de66df10-6fb6-4e4e-861c-52684d36e04b	670ecad2-0e81-4226-8dd3-8c12155833d5
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	670ecad2-0e81-4226-8dd3-8c12155833d5
2bb46018-a878-4a07-b7a5-a7bee5d2b340	670ecad2-0e81-4226-8dd3-8c12155833d5
01193d9e-f6ad-4732-9ca8-2243d35a539f	670ecad2-0e81-4226-8dd3-8c12155833d5
62e102db-30b9-4443-9ac6-53eddd18a42a	670ecad2-0e81-4226-8dd3-8c12155833d5
40a61e05-4540-443f-ab61-707c17ab6182	670ecad2-0e81-4226-8dd3-8c12155833d5
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	670ecad2-0e81-4226-8dd3-8c12155833d5
cb9b072e-93dc-47e1-a943-47cbe9e18674	670ecad2-0e81-4226-8dd3-8c12155833d5
da01fe6e-f088-4caa-a049-9e0ec22a3cec	670ecad2-0e81-4226-8dd3-8c12155833d5
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	670ecad2-0e81-4226-8dd3-8c12155833d5
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	670ecad2-0e81-4226-8dd3-8c12155833d5
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	670ecad2-0e81-4226-8dd3-8c12155833d5
0532209d-ba3a-428a-b926-9fc25502613f	670ecad2-0e81-4226-8dd3-8c12155833d5
e9495f4b-d634-4fcd-8d74-191d285dd406	670ecad2-0e81-4226-8dd3-8c12155833d5
28ecaad6-3925-49eb-880f-e2a8b2c3297c	670ecad2-0e81-4226-8dd3-8c12155833d5
de5f45da-a4af-4e8e-b024-282008f89219	bc59a9d8-78c8-4023-9d5d-65640031d130
725b7f81-2afb-4a73-b6ce-56770a9f81a5	bc59a9d8-78c8-4023-9d5d-65640031d130
45d7b16a-8666-4804-bc00-38fc2b33682a	bc59a9d8-78c8-4023-9d5d-65640031d130
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	bc59a9d8-78c8-4023-9d5d-65640031d130
da3da7cb-e80f-4877-bf53-091868ed0370	bc59a9d8-78c8-4023-9d5d-65640031d130
186d4618-d2cd-47c8-a4dc-0f562a861898	bc59a9d8-78c8-4023-9d5d-65640031d130
8c44b1f3-186d-41e2-a8e0-85cf668366d4	bc59a9d8-78c8-4023-9d5d-65640031d130
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	bc59a9d8-78c8-4023-9d5d-65640031d130
add1c218-7f67-4403-a8e8-8a18c7759881	bc59a9d8-78c8-4023-9d5d-65640031d130
de66df10-6fb6-4e4e-861c-52684d36e04b	bc59a9d8-78c8-4023-9d5d-65640031d130
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	bc59a9d8-78c8-4023-9d5d-65640031d130
2bb46018-a878-4a07-b7a5-a7bee5d2b340	bc59a9d8-78c8-4023-9d5d-65640031d130
01193d9e-f6ad-4732-9ca8-2243d35a539f	bc59a9d8-78c8-4023-9d5d-65640031d130
62e102db-30b9-4443-9ac6-53eddd18a42a	bc59a9d8-78c8-4023-9d5d-65640031d130
40a61e05-4540-443f-ab61-707c17ab6182	bc59a9d8-78c8-4023-9d5d-65640031d130
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	bc59a9d8-78c8-4023-9d5d-65640031d130
cb9b072e-93dc-47e1-a943-47cbe9e18674	bc59a9d8-78c8-4023-9d5d-65640031d130
da01fe6e-f088-4caa-a049-9e0ec22a3cec	bc59a9d8-78c8-4023-9d5d-65640031d130
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	bc59a9d8-78c8-4023-9d5d-65640031d130
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	bc59a9d8-78c8-4023-9d5d-65640031d130
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	bc59a9d8-78c8-4023-9d5d-65640031d130
0532209d-ba3a-428a-b926-9fc25502613f	bc59a9d8-78c8-4023-9d5d-65640031d130
e9495f4b-d634-4fcd-8d74-191d285dd406	bc59a9d8-78c8-4023-9d5d-65640031d130
28ecaad6-3925-49eb-880f-e2a8b2c3297c	bc59a9d8-78c8-4023-9d5d-65640031d130
de5f45da-a4af-4e8e-b024-282008f89219	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
725b7f81-2afb-4a73-b6ce-56770a9f81a5	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
45d7b16a-8666-4804-bc00-38fc2b33682a	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
da3da7cb-e80f-4877-bf53-091868ed0370	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
186d4618-d2cd-47c8-a4dc-0f562a861898	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
8c44b1f3-186d-41e2-a8e0-85cf668366d4	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
add1c218-7f67-4403-a8e8-8a18c7759881	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
de66df10-6fb6-4e4e-861c-52684d36e04b	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
2bb46018-a878-4a07-b7a5-a7bee5d2b340	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
01193d9e-f6ad-4732-9ca8-2243d35a539f	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
62e102db-30b9-4443-9ac6-53eddd18a42a	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
40a61e05-4540-443f-ab61-707c17ab6182	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
cb9b072e-93dc-47e1-a943-47cbe9e18674	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
da01fe6e-f088-4caa-a049-9e0ec22a3cec	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
0532209d-ba3a-428a-b926-9fc25502613f	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
e9495f4b-d634-4fcd-8d74-191d285dd406	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
28ecaad6-3925-49eb-880f-e2a8b2c3297c	d5651d30-c8fb-43c4-af4e-9247bc4cbc3d
de5f45da-a4af-4e8e-b024-282008f89219	71ea81f8-96f1-4bcd-8878-6936ac10effd
725b7f81-2afb-4a73-b6ce-56770a9f81a5	71ea81f8-96f1-4bcd-8878-6936ac10effd
45d7b16a-8666-4804-bc00-38fc2b33682a	71ea81f8-96f1-4bcd-8878-6936ac10effd
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	71ea81f8-96f1-4bcd-8878-6936ac10effd
da3da7cb-e80f-4877-bf53-091868ed0370	71ea81f8-96f1-4bcd-8878-6936ac10effd
186d4618-d2cd-47c8-a4dc-0f562a861898	71ea81f8-96f1-4bcd-8878-6936ac10effd
8c44b1f3-186d-41e2-a8e0-85cf668366d4	71ea81f8-96f1-4bcd-8878-6936ac10effd
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	71ea81f8-96f1-4bcd-8878-6936ac10effd
add1c218-7f67-4403-a8e8-8a18c7759881	71ea81f8-96f1-4bcd-8878-6936ac10effd
de66df10-6fb6-4e4e-861c-52684d36e04b	71ea81f8-96f1-4bcd-8878-6936ac10effd
f0e6b891-1300-4515-b2a7-b421ff4454bd	71ea81f8-96f1-4bcd-8878-6936ac10effd
d79c84b0-b59f-4889-9e2b-c5e30a4b14b3	71ea81f8-96f1-4bcd-8878-6936ac10effd
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	71ea81f8-96f1-4bcd-8878-6936ac10effd
2bb46018-a878-4a07-b7a5-a7bee5d2b340	71ea81f8-96f1-4bcd-8878-6936ac10effd
01193d9e-f6ad-4732-9ca8-2243d35a539f	71ea81f8-96f1-4bcd-8878-6936ac10effd
62e102db-30b9-4443-9ac6-53eddd18a42a	71ea81f8-96f1-4bcd-8878-6936ac10effd
40a61e05-4540-443f-ab61-707c17ab6182	71ea81f8-96f1-4bcd-8878-6936ac10effd
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	71ea81f8-96f1-4bcd-8878-6936ac10effd
cb9b072e-93dc-47e1-a943-47cbe9e18674	71ea81f8-96f1-4bcd-8878-6936ac10effd
da01fe6e-f088-4caa-a049-9e0ec22a3cec	71ea81f8-96f1-4bcd-8878-6936ac10effd
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	71ea81f8-96f1-4bcd-8878-6936ac10effd
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	71ea81f8-96f1-4bcd-8878-6936ac10effd
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	71ea81f8-96f1-4bcd-8878-6936ac10effd
0532209d-ba3a-428a-b926-9fc25502613f	71ea81f8-96f1-4bcd-8878-6936ac10effd
e9495f4b-d634-4fcd-8d74-191d285dd406	71ea81f8-96f1-4bcd-8878-6936ac10effd
28ecaad6-3925-49eb-880f-e2a8b2c3297c	71ea81f8-96f1-4bcd-8878-6936ac10effd
de5f45da-a4af-4e8e-b024-282008f89219	4e457aec-fe51-4283-ad6c-14beb308e11a
725b7f81-2afb-4a73-b6ce-56770a9f81a5	4e457aec-fe51-4283-ad6c-14beb308e11a
45d7b16a-8666-4804-bc00-38fc2b33682a	4e457aec-fe51-4283-ad6c-14beb308e11a
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	4e457aec-fe51-4283-ad6c-14beb308e11a
da3da7cb-e80f-4877-bf53-091868ed0370	4e457aec-fe51-4283-ad6c-14beb308e11a
186d4618-d2cd-47c8-a4dc-0f562a861898	4e457aec-fe51-4283-ad6c-14beb308e11a
8c44b1f3-186d-41e2-a8e0-85cf668366d4	4e457aec-fe51-4283-ad6c-14beb308e11a
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	4e457aec-fe51-4283-ad6c-14beb308e11a
add1c218-7f67-4403-a8e8-8a18c7759881	4e457aec-fe51-4283-ad6c-14beb308e11a
de66df10-6fb6-4e4e-861c-52684d36e04b	4e457aec-fe51-4283-ad6c-14beb308e11a
f0e6b891-1300-4515-b2a7-b421ff4454bd	4e457aec-fe51-4283-ad6c-14beb308e11a
d79c84b0-b59f-4889-9e2b-c5e30a4b14b3	4e457aec-fe51-4283-ad6c-14beb308e11a
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	4e457aec-fe51-4283-ad6c-14beb308e11a
2bb46018-a878-4a07-b7a5-a7bee5d2b340	4e457aec-fe51-4283-ad6c-14beb308e11a
01193d9e-f6ad-4732-9ca8-2243d35a539f	4e457aec-fe51-4283-ad6c-14beb308e11a
62e102db-30b9-4443-9ac6-53eddd18a42a	4e457aec-fe51-4283-ad6c-14beb308e11a
40a61e05-4540-443f-ab61-707c17ab6182	4e457aec-fe51-4283-ad6c-14beb308e11a
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	4e457aec-fe51-4283-ad6c-14beb308e11a
cb9b072e-93dc-47e1-a943-47cbe9e18674	4e457aec-fe51-4283-ad6c-14beb308e11a
da01fe6e-f088-4caa-a049-9e0ec22a3cec	4e457aec-fe51-4283-ad6c-14beb308e11a
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	4e457aec-fe51-4283-ad6c-14beb308e11a
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	4e457aec-fe51-4283-ad6c-14beb308e11a
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	4e457aec-fe51-4283-ad6c-14beb308e11a
0532209d-ba3a-428a-b926-9fc25502613f	4e457aec-fe51-4283-ad6c-14beb308e11a
e9495f4b-d634-4fcd-8d74-191d285dd406	4e457aec-fe51-4283-ad6c-14beb308e11a
28ecaad6-3925-49eb-880f-e2a8b2c3297c	4e457aec-fe51-4283-ad6c-14beb308e11a
de5f45da-a4af-4e8e-b024-282008f89219	b5e057d1-0ea0-460c-b85d-a055284f80b4
725b7f81-2afb-4a73-b6ce-56770a9f81a5	b5e057d1-0ea0-460c-b85d-a055284f80b4
45d7b16a-8666-4804-bc00-38fc2b33682a	b5e057d1-0ea0-460c-b85d-a055284f80b4
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	b5e057d1-0ea0-460c-b85d-a055284f80b4
da3da7cb-e80f-4877-bf53-091868ed0370	b5e057d1-0ea0-460c-b85d-a055284f80b4
186d4618-d2cd-47c8-a4dc-0f562a861898	b5e057d1-0ea0-460c-b85d-a055284f80b4
8c44b1f3-186d-41e2-a8e0-85cf668366d4	b5e057d1-0ea0-460c-b85d-a055284f80b4
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	b5e057d1-0ea0-460c-b85d-a055284f80b4
add1c218-7f67-4403-a8e8-8a18c7759881	b5e057d1-0ea0-460c-b85d-a055284f80b4
de66df10-6fb6-4e4e-861c-52684d36e04b	b5e057d1-0ea0-460c-b85d-a055284f80b4
f0e6b891-1300-4515-b2a7-b421ff4454bd	b5e057d1-0ea0-460c-b85d-a055284f80b4
d79c84b0-b59f-4889-9e2b-c5e30a4b14b3	b5e057d1-0ea0-460c-b85d-a055284f80b4
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	b5e057d1-0ea0-460c-b85d-a055284f80b4
2bb46018-a878-4a07-b7a5-a7bee5d2b340	b5e057d1-0ea0-460c-b85d-a055284f80b4
01193d9e-f6ad-4732-9ca8-2243d35a539f	b5e057d1-0ea0-460c-b85d-a055284f80b4
62e102db-30b9-4443-9ac6-53eddd18a42a	b5e057d1-0ea0-460c-b85d-a055284f80b4
40a61e05-4540-443f-ab61-707c17ab6182	b5e057d1-0ea0-460c-b85d-a055284f80b4
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	b5e057d1-0ea0-460c-b85d-a055284f80b4
cb9b072e-93dc-47e1-a943-47cbe9e18674	b5e057d1-0ea0-460c-b85d-a055284f80b4
da01fe6e-f088-4caa-a049-9e0ec22a3cec	b5e057d1-0ea0-460c-b85d-a055284f80b4
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	b5e057d1-0ea0-460c-b85d-a055284f80b4
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	b5e057d1-0ea0-460c-b85d-a055284f80b4
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	b5e057d1-0ea0-460c-b85d-a055284f80b4
0532209d-ba3a-428a-b926-9fc25502613f	b5e057d1-0ea0-460c-b85d-a055284f80b4
e9495f4b-d634-4fcd-8d74-191d285dd406	b5e057d1-0ea0-460c-b85d-a055284f80b4
28ecaad6-3925-49eb-880f-e2a8b2c3297c	b5e057d1-0ea0-460c-b85d-a055284f80b4
de5f45da-a4af-4e8e-b024-282008f89219	a2980996-e29a-413b-91db-5b7be475014f
725b7f81-2afb-4a73-b6ce-56770a9f81a5	a2980996-e29a-413b-91db-5b7be475014f
45d7b16a-8666-4804-bc00-38fc2b33682a	a2980996-e29a-413b-91db-5b7be475014f
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	a2980996-e29a-413b-91db-5b7be475014f
da3da7cb-e80f-4877-bf53-091868ed0370	a2980996-e29a-413b-91db-5b7be475014f
186d4618-d2cd-47c8-a4dc-0f562a861898	a2980996-e29a-413b-91db-5b7be475014f
8c44b1f3-186d-41e2-a8e0-85cf668366d4	a2980996-e29a-413b-91db-5b7be475014f
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	a2980996-e29a-413b-91db-5b7be475014f
add1c218-7f67-4403-a8e8-8a18c7759881	a2980996-e29a-413b-91db-5b7be475014f
de66df10-6fb6-4e4e-861c-52684d36e04b	a2980996-e29a-413b-91db-5b7be475014f
f0e6b891-1300-4515-b2a7-b421ff4454bd	a2980996-e29a-413b-91db-5b7be475014f
d79c84b0-b59f-4889-9e2b-c5e30a4b14b3	a2980996-e29a-413b-91db-5b7be475014f
9294a80d-452f-4c91-9c4f-a9e84005286f	a2980996-e29a-413b-91db-5b7be475014f
6ceab9c0-73d6-44a7-b20f-ba739724b3d7	a2980996-e29a-413b-91db-5b7be475014f
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	a2980996-e29a-413b-91db-5b7be475014f
2bb46018-a878-4a07-b7a5-a7bee5d2b340	a2980996-e29a-413b-91db-5b7be475014f
01193d9e-f6ad-4732-9ca8-2243d35a539f	a2980996-e29a-413b-91db-5b7be475014f
62e102db-30b9-4443-9ac6-53eddd18a42a	a2980996-e29a-413b-91db-5b7be475014f
40a61e05-4540-443f-ab61-707c17ab6182	a2980996-e29a-413b-91db-5b7be475014f
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	a2980996-e29a-413b-91db-5b7be475014f
cb9b072e-93dc-47e1-a943-47cbe9e18674	a2980996-e29a-413b-91db-5b7be475014f
da01fe6e-f088-4caa-a049-9e0ec22a3cec	a2980996-e29a-413b-91db-5b7be475014f
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	a2980996-e29a-413b-91db-5b7be475014f
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	a2980996-e29a-413b-91db-5b7be475014f
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	a2980996-e29a-413b-91db-5b7be475014f
0532209d-ba3a-428a-b926-9fc25502613f	a2980996-e29a-413b-91db-5b7be475014f
e9495f4b-d634-4fcd-8d74-191d285dd406	a2980996-e29a-413b-91db-5b7be475014f
28ecaad6-3925-49eb-880f-e2a8b2c3297c	a2980996-e29a-413b-91db-5b7be475014f
de5f45da-a4af-4e8e-b024-282008f89219	468926e7-0094-498f-83d0-3fe03c2de18a
725b7f81-2afb-4a73-b6ce-56770a9f81a5	468926e7-0094-498f-83d0-3fe03c2de18a
45d7b16a-8666-4804-bc00-38fc2b33682a	468926e7-0094-498f-83d0-3fe03c2de18a
29b4fe07-a3bc-4b6d-9e46-1c2d49f980e0	468926e7-0094-498f-83d0-3fe03c2de18a
da3da7cb-e80f-4877-bf53-091868ed0370	468926e7-0094-498f-83d0-3fe03c2de18a
186d4618-d2cd-47c8-a4dc-0f562a861898	468926e7-0094-498f-83d0-3fe03c2de18a
8c44b1f3-186d-41e2-a8e0-85cf668366d4	468926e7-0094-498f-83d0-3fe03c2de18a
6a98c15c-ef6b-4f1a-8b59-8dd20bc28fc1	468926e7-0094-498f-83d0-3fe03c2de18a
add1c218-7f67-4403-a8e8-8a18c7759881	468926e7-0094-498f-83d0-3fe03c2de18a
de66df10-6fb6-4e4e-861c-52684d36e04b	468926e7-0094-498f-83d0-3fe03c2de18a
f0e6b891-1300-4515-b2a7-b421ff4454bd	468926e7-0094-498f-83d0-3fe03c2de18a
d79c84b0-b59f-4889-9e2b-c5e30a4b14b3	468926e7-0094-498f-83d0-3fe03c2de18a
9294a80d-452f-4c91-9c4f-a9e84005286f	468926e7-0094-498f-83d0-3fe03c2de18a
6ceab9c0-73d6-44a7-b20f-ba739724b3d7	468926e7-0094-498f-83d0-3fe03c2de18a
7fcc53be-9e89-41c5-8dd0-a98f48e5e952	468926e7-0094-498f-83d0-3fe03c2de18a
1b07e9de-2806-4f10-b706-5a679c545065	468926e7-0094-498f-83d0-3fe03c2de18a
d3ddbd98-2b3e-400a-bccd-322c8db6203d	468926e7-0094-498f-83d0-3fe03c2de18a
8fd263a8-8fcf-4248-b2ff-4a97119de4d0	468926e7-0094-498f-83d0-3fe03c2de18a
3ef0325d-0f4c-4d49-bb24-ea89f9d7e030	468926e7-0094-498f-83d0-3fe03c2de18a
2bb46018-a878-4a07-b7a5-a7bee5d2b340	468926e7-0094-498f-83d0-3fe03c2de18a
01193d9e-f6ad-4732-9ca8-2243d35a539f	468926e7-0094-498f-83d0-3fe03c2de18a
62e102db-30b9-4443-9ac6-53eddd18a42a	468926e7-0094-498f-83d0-3fe03c2de18a
40a61e05-4540-443f-ab61-707c17ab6182	468926e7-0094-498f-83d0-3fe03c2de18a
bdc9ba05-31fc-419d-ba58-9dff89ba62e4	468926e7-0094-498f-83d0-3fe03c2de18a
cb9b072e-93dc-47e1-a943-47cbe9e18674	468926e7-0094-498f-83d0-3fe03c2de18a
da01fe6e-f088-4caa-a049-9e0ec22a3cec	468926e7-0094-498f-83d0-3fe03c2de18a
13b5afc9-4f4f-4e25-ad9f-8fc8a08e6eb4	468926e7-0094-498f-83d0-3fe03c2de18a
853c58fb-b046-4dc3-b402-ed59d1ad4c2e	468926e7-0094-498f-83d0-3fe03c2de18a
f40c40c8-9dc1-44be-a02d-c8b5ae9225b6	468926e7-0094-498f-83d0-3fe03c2de18a
0532209d-ba3a-428a-b926-9fc25502613f	468926e7-0094-498f-83d0-3fe03c2de18a
e9495f4b-d634-4fcd-8d74-191d285dd406	468926e7-0094-498f-83d0-3fe03c2de18a
28ecaad6-3925-49eb-880f-e2a8b2c3297c	468926e7-0094-498f-83d0-3fe03c2de18a
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
af9205c2-7b51-47d2-ad93-24c612401bec	+
23b56ce3-fb89-498a-8ce7-09fe5d89ab96	+
88bcd50b-f7cb-4495-854e-17b6c89d4f6e	*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

