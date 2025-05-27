# PostgreSQL Database Schema for User and Order Management

This project implements a robust PostgreSQL database designed for use in enterprise-grade applications with Spring Boot and Thymeleaf. It includes full normalization, professional database modeling practices, and support for application-level and database-level security features.

## Features Overview

| Feature                    | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| 6 Normal Forms             | All database tables are normalized up to the sixth normal form              |
| ACID Compliance            | Full support for atomicity, consistency, isolation, and durability          |
| Constraints                | Use of primary keys, foreign keys, unique constraints, and not-null checks  |
| Primary and Foreign Keys   | Established on all appropriate tables to ensure referential integrity       |
| Indexes                    | Indexed critical foreign key columns to improve query performance           |
| Many-to-Many Relations     | Implemented via junction tables such as plan_user and role_permissions      |
| Views                      | Logical views can be added for abstraction and query reuse                  |
| Stored Procedures          | Placeholder-ready for server-side business logic with PostgreSQL functions  |
| Transactions               | Full support for transactional control in procedures and application logic  |
| Isolation Levels           | Ready for configuration in application to handle concurrency                |
| Application Permissions    | Custom roles and permission system designed for Spring Security             |
| UUID Support               | UUID fields are used for enhanced security and global ID uniqueness         |
| Timestamps                 | Includes created_at and updated_at for auditability                         |
| Role-Based Access Control  | Application roles such as ADMIN and USER with permission mappings           |
| PostgreSQL GRANT Support   | Optionally restrict access using GRANT commands at the database level       |

## Tables and Relationships

### Core Entities

| Table    | Purpose                      |
|----------|------------------------------|
| users    | Stores account information including name, email, and password |
| roles    | Defines access roles for the application (e.g. ADMIN, USER)    |
| orders   | Tracks user orders and relevant timestamps                     |
| plans    | Educational or subscription plans                              |
| courses  | Courses belonging to a specific plan                           |
| tasks    | Tasks assigned under courses                                   |
| progress | Tracks task completion progress per user                       |

### Relationship Tables

| Table         | Description                                                |
|---------------|------------------------------------------------------------|
| plan_user     | Many-to-many relation between users and plans              |
| role_permissions | Links roles to specific permissions                     |
| user_permissions | Optional user-specific overrides for permission control |

### Permissions System

| Table       | Purpose                             |
|-------------|-------------------------------------|
| permissions | Defines granular rights such as READ_USERS or EDIT_ORDERS |
| role_permissions | Assigns permissions to roles    |
| user_permissions | Assigns permissions directly to users (optional) |

## Integration with Spring Boot and Thymeleaf

- The `roles` and `permissions` tables are structured for direct integration with Spring Security.
- Roles can be assigned per user for coarse-grained access control.
- Permissions allow fine-grained access for specific features or actions in the application.
- UUIDs and timestamps make the schema future-proof and auditable.

## Optional: PostgreSQL Access Management

For production use, PostgreSQL GRANT statements can be used to secure access for app users, admins, and read-only connections.

| Role Name     | Permissions Granted                      |
|---------------|-------------------------------------------|
| app_user      | SELECT, INSERT, UPDATE, DELETE            |
| read_only     | SELECT only                               |
| db_admin      | Full schema and table management rights   |

## Summary

This PostgreSQL schema is highly extensible, secure, and optimized for real-world applications requiring both flexibility and structure. It is designed for integration into a modern Java application stack using Spring Boot, Hibernate, and Thymeleaf.

