CREATE TABLE "User_Settings"(
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "language" VARCHAR(255) NOT NULL,
    "theme" BOOLEAN NOT NULL,
    "communication" BOOLEAN NOT NULL,
    "marketing" BOOLEAN NOT NULL,
    "security" BOOLEAN NOT NULL
);
ALTER TABLE
    "User_Settings" ADD PRIMARY KEY("id");
CREATE TABLE "Users"(
    "id" BIGINT NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "dob" DATE NOT NULL
);
ALTER TABLE
    "Users" ADD PRIMARY KEY("id");
ALTER TABLE
    "Users" ADD CONSTRAINT "users_username_unique" UNIQUE("username");
CREATE TABLE "UserQuotas"(
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "dataset_count" BIGINT NOT NULL,
    "agents_count" BIGINT NOT NULL,
    "kendra_indexes" BIGINT NOT NULL
);
ALTER TABLE
    "UserQuotas" ADD PRIMARY KEY("id");
CREATE TABLE "Datasets"(
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NULL,
    "capacity" BIGINT NOT NULL,
    "source" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Datasets" ADD PRIMARY KEY("id");
CREATE TABLE "Agents"(
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "tokens" BIGINT NOT NULL,
    "gift_tokens" BIGINT NOT NULL,
    "url" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Agents" ADD PRIMARY KEY("id");
CREATE TABLE "AgentDatasets"(
    "id" UUID NOT NULL,
    "agent_id" UUID NOT NULL,
    "dataset_id" UUID NOT NULL
);
ALTER TABLE
    "AgentDatasets" ADD PRIMARY KEY("id");
CREATE TABLE "Developer"(
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "api_key" VARCHAR(255) NOT NULL,
    "webhook_url" VARCHAR(255) NOT NULL,
    "realtime_update" BOOLEAN NOT NULL
);
ALTER TABLE
    "Developer" ADD PRIMARY KEY("id");
CREATE TABLE "KIndexes"(
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "sources" BIGINT NOT NULL
);
ALTER TABLE
    "KIndexes" ADD PRIMARY KEY("id");
CREATE TABLE "KConnectors"(
    "id" UUID NOT NULL,
    "kindex_id" UUID NOT NULL,
    "dataset_id" UUID NULL,
    "secretsID" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "KConnectors" ADD PRIMARY KEY("id");
ALTER TABLE
    "Datasets" ADD CONSTRAINT "datasets_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("id");
ALTER TABLE
    "User_Settings" ADD CONSTRAINT "user_settings_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("id");
ALTER TABLE
    "Agents" ADD CONSTRAINT "agents_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("id");
ALTER TABLE
    "Developer" ADD CONSTRAINT "developer_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("id");
ALTER TABLE
    "KConnectors" ADD CONSTRAINT "kconnectors_dataset_id_foreign" FOREIGN KEY("dataset_id") REFERENCES "Datasets"("id");
ALTER TABLE
    "UserQuotas" ADD CONSTRAINT "userquotas_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("id");
ALTER TABLE
    "AgentDatasets" ADD CONSTRAINT "agentdatasets_agent_id_foreign" FOREIGN KEY("agent_id") REFERENCES "Agents"("id");
ALTER TABLE
    "AgentDatasets" ADD CONSTRAINT "agentdatasets_dataset_id_foreign" FOREIGN KEY("dataset_id") REFERENCES "Datasets"("id");
ALTER TABLE
    "KIndexes" ADD CONSTRAINT "kindexes_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("id");
ALTER TABLE
    "KConnectors" ADD CONSTRAINT "kconnectors_kindex_id_foreign" FOREIGN KEY("kindex_id") REFERENCES "KIndexes"("id");