--
-- Class Domain as table domain
--

CREATE TABLE "domain" (
  "id" serial,
  "name" text NOT NULL,
  "description" text NOT NULL
);

ALTER TABLE ONLY "domain"
  ADD CONSTRAINT domain_pkey PRIMARY KEY (id);


--
-- Class Candidate as table candidate
--

CREATE TABLE "candidate" (
  "id" serial,
  "first_name" text NOT NULL,
  "last_name" text NOT NULL,
  "email" text NOT NULL,
  "dob" timestamp without time zone,
  "domain_id" integer NOT NULL,
  "experience" integer NOT NULL,
  "password" text NOT NULL,
  "access_token" text,
  "phone" text
);

ALTER TABLE ONLY "candidate"
  ADD CONSTRAINT candidate_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "candidate"
  ADD CONSTRAINT candidate_fk_0
    FOREIGN KEY("domain_id")
      REFERENCES domain(id)
        ON DELETE CASCADE;

--
-- Class Level as table level
--

CREATE TABLE "level" (
  "id" serial,
  "number" integer NOT NULL
);

ALTER TABLE ONLY "level"
  ADD CONSTRAINT level_pkey PRIMARY KEY (id);


--
-- Class Exam as table exams
--

CREATE TABLE "exams" (
  "id" serial,
  "name" text NOT NULL,
  "description" text,
  "domain_id" integer NOT NULL,
  "no_of_questions" integer NOT NULL,
  "level" integer NOT NULL,
  "question_ids" json,
  "passing_score" integer NOT NULL
);

ALTER TABLE ONLY "exams"
  ADD CONSTRAINT exams_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "exams"
  ADD CONSTRAINT exams_fk_0
    FOREIGN KEY("domain_id")
      REFERENCES domain(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "exams"
  ADD CONSTRAINT exams_fk_1
    FOREIGN KEY("level")
      REFERENCES level(id)
        ON DELETE CASCADE;

--
-- Class QuestionCategory as table questioncategory
--

CREATE TABLE "questioncategory" (
  "id" serial,
  "domain_id" integer NOT NULL,
  "name" text NOT NULL,
  "description" text
);

ALTER TABLE ONLY "questioncategory"
  ADD CONSTRAINT questioncategory_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "questioncategory"
  ADD CONSTRAINT questioncategory_fk_0
    FOREIGN KEY("domain_id")
      REFERENCES domain(id)
        ON DELETE CASCADE;

--
-- Class Question as table question
--

CREATE TABLE "question" (
  "id" serial,
  "domain_id" integer NOT NULL,
  "level_id" integer NOT NULL,
  "question" text NOT NULL,
  "question_category_id" integer NOT NULL,
  "op1" text NOT NULL,
  "op2" text NOT NULL,
  "op3" text NOT NULL,
  "op4" text NOT NULL,
  "correct_op" text NOT NULL
);

ALTER TABLE ONLY "question"
  ADD CONSTRAINT question_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "question"
  ADD CONSTRAINT question_fk_0
    FOREIGN KEY("domain_id")
      REFERENCES domain(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "question"
  ADD CONSTRAINT question_fk_1
    FOREIGN KEY("level_id")
      REFERENCES level(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "question"
  ADD CONSTRAINT question_fk_2
    FOREIGN KEY("question_category_id")
      REFERENCES questioncategory(id)
        ON DELETE CASCADE;

--
-- Class Role as table role
--

CREATE TABLE "role" (
  "id" serial,
  "name" text NOT NULL
);

ALTER TABLE ONLY "role"
  ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Class Status as table status
--

CREATE TABLE "status" (
  "id" serial,
  "name" text NOT NULL
);

ALTER TABLE ONLY "status"
  ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Class User as table users
--

CREATE TABLE "users" (
  "id" serial,
  "first_name" text NOT NULL,
  "last_name" text NOT NULL,
  "email" text NOT NULL,
  "phone" text NOT NULL,
  "dob" timestamp without time zone NOT NULL,
  "domain_id" integer NOT NULL,
  "role_id" integer NOT NULL,
  "experience" integer NOT NULL,
  "password" text NOT NULL,
  "access_token" text
);

ALTER TABLE ONLY "users"
  ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "users"
  ADD CONSTRAINT users_fk_0
    FOREIGN KEY("domain_id")
      REFERENCES domain(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "users"
  ADD CONSTRAINT users_fk_1
    FOREIGN KEY("role_id")
      REFERENCES role(id)
        ON DELETE CASCADE;

--
-- Class Response as table responses
--

CREATE TABLE "responses" (
  "id" serial,
  "candidate_id" integer NOT NULL,
  "exam_id" integer NOT NULL,
  "score" integer,
  "assign_by" integer,
  "reviewed_by" integer,
  "q_ids" json NOT NULL,
  "response" json NOT NULL,
  "status" integer
);

ALTER TABLE ONLY "responses"
  ADD CONSTRAINT responses_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "responses"
  ADD CONSTRAINT responses_fk_0
    FOREIGN KEY("candidate_id")
      REFERENCES candidate(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "responses"
  ADD CONSTRAINT responses_fk_1
    FOREIGN KEY("exam_id")
      REFERENCES exams(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "responses"
  ADD CONSTRAINT responses_fk_2
    FOREIGN KEY("assign_by")
      REFERENCES users(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "responses"
  ADD CONSTRAINT responses_fk_3
    FOREIGN KEY("reviewed_by")
      REFERENCES users(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "responses"
  ADD CONSTRAINT responses_fk_4
    FOREIGN KEY("status")
      REFERENCES status(id)
        ON DELETE CASCADE;

