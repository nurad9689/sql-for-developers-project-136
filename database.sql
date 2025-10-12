--1 step
CREATE TABLE IF NOT EXISTS Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description VARCHAR(255),
    created_at DATE,
    updated_at DATE,
    deleted_at SMALLINT default 0
);

CREATE TABLE IF NOT EXISTS Modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description VARCHAR(255),
    created_at DATE,
    updated_at DATE,
    deleted_at SMALLINT default 0
);

CREATE TABLE IF NOT EXISTS Course_modules (
    course_id BIGINT,
    module_id BIGINT,
    PRIMARY KEY (course_id, module_id),
	FOREIGN KEY (course_id) REFERENCES Courses(id),
	FOREIGN KEY (module_id) REFERENCES Modules(id)
);

CREATE TABLE IF NOT EXISTS Programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price NUMERIC,
    program_type VARCHAR(255),
    created_at DATE,
    updated_at DATE
);

CREATE TABLE IF NOT EXISTS Program_modules (
    program_id BIGINT,
    module_id BIGINT,
    PRIMARY KEY (program_id, module_id),
	FOREIGN KEY (program_id) REFERENCES Programs(id),
	FOREIGN KEY (module_id) REFERENCES Modules(id)
);

CREATE TABLE IF NOT EXISTS Lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES Courses(id),
    name VARCHAR(255),
    content VARCHAR(255),
    video_url VARCHAR(255),
    position INTEGER,
    created_at DATE,
    updated_at DATE,
    deleted_at SMALLINT default 0
);

--2 step
CREATE TYPE role_status AS ENUM ('student', 'teacher', 'admin');

CREATE TABLE IF NOT EXISTS Teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(255),
    created_at DATE,
    updated_at DATE    
);

CREATE TABLE IF NOT EXISTS Users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    email VARCHAR(255),
    password_hash VARCHAR(255),
    teaching_group_id BIGINT REFERENCES Teaching_groups(id),
    role role_status,
    created_at DATE,
    updated_at DATE,
    deleted_at SMALLINT default 0
);

--3 step
CREATE TYPE enrollment_status AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE IF NOT EXISTS Enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    status enrollment_status,
    created_at DATE,
    updated_at DATE    
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE IF NOT EXISTS Payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES Enrollments(id),
    amount NUMERIC(255),
    status payment_status,
    paid_at DATE,
    created_at DATE,
    updated_at DATE    
);

CREATE TYPE completions_status AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE IF NOT EXISTS Program_completions  (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    status completions_status,
    started_at DATE,
    completed_at DATE,
    created_at DATE,
    updated_at DATE    
);

CREATE TABLE IF NOT EXISTS Certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    url VARCHAR(255),
    issued_at DATE,
    created_at DATE,
    updated_at DATE    
);

--4 step
CREATE TABLE IF NOT EXISTS Quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES Lessons(id),
    name VARCHAR(255),
    content TEXT,
    created_at DATE,
    updated_at DATE
);

CREATE TABLE IF NOT EXISTS Exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES Lessons(id),
    name VARCHAR(255),
    url VARCHAR(255),
    created_at DATE,
    updated_at DATE    
);

--5 step
CREATE TABLE IF NOT EXISTS Discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES Lessons(id),
    user_id BIGINT REFERENCES Users(id),
    text TEXT,
    created_at DATE,
    updated_at DATE    
);

CREATE TYPE blog_status AS ENUM ('created', 'in moderation', 'published', 'archived');

CREATE TABLE IF NOT EXISTS Blogs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    name VARCHAR(255),
    content TEXT,
    status blog_status,
    created_at DATE,
    updated_at DATE    
);
