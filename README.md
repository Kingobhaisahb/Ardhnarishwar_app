# Ardhnarishwar App

**A Full-Stack Job Portal | Flutter • Spring Boot • MySQL**

Ardhnarishwar is a full-stack job portal designed to connect candidates and employers through a centralized recruitment platform. It includes ATS-based resume scoring, role-based authentication, and dedicated dashboards for candidates, employers, and administrators.

**The Android application is live on Google Play Store.**

## 🚀 Live Application

(https://play.google.com/store/apps/details?id=com.recruweb.ardhnarishwar)

## 💡 Project Overview

The goal of Ardhnarishwar is to simplify recruitment by bringing job seekers, employers, and administrators into one platform. Candidates can explore opportunities, employers can manage recruitment activities, and administrators can oversee the platform.

The project combines a Flutter mobile application with a Spring Boot backend and a MySQL database.

## ✨ Key Features

- **ATS Resume Scoring** — Resume scoring to help assess how well a candidate's profile matches recruitment requirements.
- **Role-Based Authentication** — Access and functionality based on user roles.
- **Candidate Dashboard** — A dedicated interface for job seekers.
- **Employer Dashboard** — Tools for employers to manage recruitment activities.
- **Admin Dashboard** — Administrative access and platform management.
- **Full-Stack Architecture** — Mobile frontend, backend APIs, and relational database integration.
- **Live Android Deployment** — Published on Google Play Store.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile application |
| Spring Boot | Backend services and REST APIs |
| MySQL | Relational database |
| Java | Backend application development |

## 🏗️ Architecture

```text
Flutter Mobile App
        |
        | HTTPS / REST API
        v
Spring Boot Backend
        |
        | Database Queries
        v
     MySQL Database
```

The Flutter application communicates with the backend through APIs. Spring Boot handles application logic, authentication, and data operations, while MySQL stores the application's persistent data.

## ☁️ Deployment & Traffic Handling

Ardhnarishwar is distributed through Google Play Store, making the Android application available to users through its published listing.

The app's ability to handle concurrent users depends primarily on the backend hosting environment, API performance, database capacity, and infrastructure configuration.

The architecture can be scaled using the following approaches:

- **Stateless Backend Services:** Keep request processing stateless where possible so additional Spring Boot instances can serve incoming requests.
- **Load Balancing:** Distribute API traffic across multiple backend instances when traffic increases.
- **Database Indexing:** Add indexes to frequently queried columns to improve lookup performance.
- **Connection Pooling:** Reuse database connections instead of opening a new connection for every request.
- **Pagination:** Return large datasets, such as job listings, in manageable pages rather than loading everything at once.
- **Caching:** Cache suitable frequently accessed data to reduce repeated database queries.
- **Performance Monitoring:** Monitor API latency, error rates, CPU and memory usage, and database performance to identify bottlenecks.

These are scalability techniques that can be applied as demand grows. Actual traffic capacity depends on the deployed infrastructure and should be established through load testing.

## ⚡ Optimization Strategy

To maintain responsive performance as usage grows:

1. Optimize database queries and index frequently filtered or searched fields.
2. Keep API responses lightweight and avoid unnecessary database calls.
3. Use pagination for job listings, candidate records, and other large result sets.
4. Configure appropriate backend and database connection pool limits.
5. Validate scalability with concurrent-request and load tests.
6. Monitor production errors and resource usage to guide further optimization.

## 🎯 What Has Been Achieved

- Developed a full-stack job portal using Flutter, Spring Boot, and MySQL.
- Implemented ATS-based resume scoring functionality.
- Built role-specific experiences for candidates, employers, and administrators.
- Integrated a mobile frontend with backend services and persistent data storage.
- Published the Android application on Google Play Store.

## 📲 Try the App

Experience the live application here:

**[Ardhnarishwar — Google Play Store](https://play.google.com/store/apps/details?id=com.recruweb.ardhnarishwar)**


---

**Built with Flutter, Spring Boot, and MySQL.**
