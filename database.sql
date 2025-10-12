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
