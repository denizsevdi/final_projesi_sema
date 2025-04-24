DROP TABLE IF EXISTS blog_posts, certificate_assignments, certificates, enrollments, course_categories, categories, courses, members CASCADE;

-- MEMBERS TABLE
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- COURSES TABLE
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    instructor VARCHAR(100)
);

-- CATEGORIES TABLE
CREATE TABLE categories (
    category_id SMALLINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- RELATION BETWEEN COURSES AND CATEGORIES
CREATE TABLE course_categories (
    course_id INTEGER REFERENCES courses(course_id) ON DELETE CASCADE,
    category_id SMALLINT REFERENCES categories(category_id) ON DELETE CASCADE,
    PRIMARY KEY (course_id, category_id)
);

-- ENROLLMENTS TABLE
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    member_id INTEGER REFERENCES members(member_id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES courses(course_id) ON DELETE CASCADE,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CERTIFICATES TABLE
CREATE TABLE certificates (
    certificate_id SERIAL PRIMARY KEY,
    code VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE
);

-- CERTIFICATE ASSIGNMENTS TABLE
CREATE TABLE certificate_assignments (
    assignment_id SERIAL PRIMARY KEY,
    member_id INTEGER REFERENCES members(member_id) ON DELETE CASCADE,
    certificate_id INTEGER REFERENCES certificates(certificate_id) ON DELETE CASCADE,
    received_date DATE
);

-- BLOG POSTS TABLE
CREATE TABLE blog_posts (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    publish_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER REFERENCES members(member_id) ON DELETE CASCADE
);
