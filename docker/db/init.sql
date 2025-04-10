CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    role ENUM('admin', 'user') NOT NULL,
    UNIQUE (email)
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    UNIQUE (name)
);

CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    location_id INTEGER NOT NULL REFERENCES locations(location_id) ON DELETE RESTRICT,
    sport_name VARCHAR(255) NOT NULL,
    description TEXT,
    duration_minutes INTEGER NOT NULL,
    capacity INTEGER
);

CREATE TABLE schedule (
    id SERIAL PRIMARY KEY,
    class_id INTEGER NOT NULL REFERENCES classes(class_id) ON DELETE CASCADE,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_recurring BOOLEAN DEFAULT TRUE
);

CREATE TABLE schedule_exceptions (
    id SERIAL PRIMARY KEY,
    schedule_id INTEGER NOT NULL REFERENCES schedule(schedule_id) ON DELETE CASCADE,
    exception_date DATE NOT NULL,
    override_start_time TIME,
    override_duration_minutes INTEGER,
    is_cancelled BOOLEAN DEFAULT FALSE,
);

CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT,
    class_id INTEGER NOT NULL REFERENCES classes(class_id) ON DELETE RESTRICT,
    enrollment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    termination_date TIMESTAMP WITH TIME ZONE
    UNIQUE (user_id, class_id)
);
