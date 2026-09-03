# 🌳 Public Tree Infrastructure Management Database

A Relational Database and Data Visualization project aimed at managing urban green infrastructure, tracking tree health, and optimizing maintenance task assignments.

## 🎯 Project Overview
This project simulates the database architecture for the Department of Parks and Recreation of Rosario. The goal is to provide a structured data environment to register public trees (species, locations, health status), coordinate maintenance squads, and track the resolution time of public claims.

## 🛠️ Tech Stack
* **Database:** SQL Server (T-SQL, SSMS)
* **Architecture:** Third Normal Form (3NF) Relational Data Modeling

## 🚀 Key Features & Technical Highlights

* **Relational Data Modeling:** Designed a highly normalized 3NF database architecture resolving complex N:M relationships through associative tables (e.g., matching maintenance tasks with specific trees and public claims).
* **Spatial & Health Tracking:** Implemented precise decimal coordinate tracking (`DECIMAL(9,6)`) for tree locations and maintained historical logs of tree health indicators over time.
* **Advanced SQL Views:** Programmed dynamic views (e.g., `vw_ReclamosConTiempos`) using `DATEDIFF` and `ISNULL` to automatically calculate response times—measuring the days elapsed between a public claim, task assignment, and final resolution.
* **Stored Procedures:** Developed parameterized stored procedures (e.g., `usp_TareasPendientes`) to query pending maintenance tasks for specific trees and output the next scheduled intervention date.
* **Interactive Dashboard:** Built a Power BI dashboard (`consultas tp final.pbix`) connected to the database to visualize workload distribution among squads and monitor claim resolution efficiency.

## 📂 Repository Structure
* `/database`: Contains the SQL scripts to recreate the environment (`DDL` for schema creation, `DML` for mock data insertion, and scripts for Views/Stored Procedures).
* `/docs`: Includes the Entity-Relationship Diagram (ERD) detailing the 3NF schema, Primary Keys, and Foreign Key constraints.
* `/dashboard`: Contains the Power BI file with the visual reports.
