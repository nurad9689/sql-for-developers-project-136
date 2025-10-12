--1 step
CREATE TABLE IF NOT EXISTS Lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_name VARCHAR(255),
    lesson_content VARCHAR(255),
    video_link VARCHAR(255),
    lesson_possition INTEGER,
    careated_at DATE,
    updated_at DATE,
    is_deleted INT default 0
);

CREATE TABLE IF NOT EXISTS Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES Lessons(id),
    course_name VARCHAR(255),
    course_content VARCHAR(255),
    created_at DATE,
    updated_at DATE,
    is_deleted INT default 0
);

CREATE TABLE IF NOT EXISTS Modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES Courses(id),
    modul_name VARCHAR(255),
    module_content VARCHAR(255),
    created_at DATE,
    updated_at DATE,
    is_deleted INT default 0
);

CREATE TABLE IF NOT EXISTS Programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES Modules(id),
    program_name VARCHAR(255),
    program_type VARCHAR(255),
    created_at DATE,
    updated_at DATE
);

--2 step
CREATE TYPE role AS ENUM ('student', 'teacher', 'admin');

CREATE TABLE IF NOT EXISTS TeachingGroups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    groups role,
    careated_at DATE,
    updated_at DATE    
);

CREATE TABLE IF NOT EXISTS Users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    groups_id BIGINT REFERENCES TeachingGroups(id),
    careated_at DATE,
    updated_at DATE    
);

--3 step
CREATE TYPE enrollment_status AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE IF NOT EXISTS Enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    prorgam_id BIGINT REFERENCES Programs(id),
    status enrollment_status,
    careated_at DATE,
    updated_at DATE    
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE IF NOT EXISTS Payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES Enrollments(id),
    paymant NUMERIC(255),
    status payment_status,
    payment_date DATE,
    careated_at DATE,
    updated_at DATE    
);

CREATE TYPE completions_status AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE IF NOT EXISTS ProgramCompletions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    prorgam_id BIGINT REFERENCES Programs(id),
    status completions_status,
    starting_date DATE,
    finishing_date DATE,
    careated_at DATE,
    updated_at DATE    
);

CREATE TABLE IF NOT EXISTS Certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    prorgam_id BIGINT REFERENCES Programs(id),
    certificate_url_link VARCHAR(255),
    certificate_date DATE,
    careated_at DATE,
    updated_at DATE    
);

--4 step
CREATE TABLE IF NOT EXISTS Quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES Lessons(id),
    title VARCHAR(255),
    description TEXT,
    parent_id BIGINT REFERENCES Quizzes(id),
    careated_at DATE,
    updated_at DATE
);

CREATE TABLE IF NOT EXISTS Exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES Lessons(id),
    title VARCHAR(255),
    url VARCHAR(255),
    careated_at DATE,
    updated_at DATE    
);
