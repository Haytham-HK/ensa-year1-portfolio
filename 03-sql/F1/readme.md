# F1 Database Project (PL/SQL)

This is a project I worked on for my Database course at ENSA. I used Oracle PL/SQL to create a relational database for managing a Formula 1 Championship.

The main idea was to practice connecting tables using foreign keys and writing stored procedures and functions to handle data automatically.

## Database Structure

The image below shows how the tables (Constructors, Drivers, and Races) are related to each other.

![Database Structure](diagram.png)

## Files

* `f1.sql` - The script with the table creation, sample data, and the PL/SQL code.
* `diagram.png` - The image showing the database schema.

## Table Overview

I organized the data into four main tables:

1.  **Constructors**: Stores team information.
2.  **Drivers**: Stores driver details.
3.  **Races**: The list of Grand Prix events.
4.  **Race_Results**: This links drivers to races to store the position and points for each event.

## PL/SQL Features

1.  **Procedure (`transfer_driver`)**: Moves a driver to a new team.
2.  **Function (`get_driver_points`)**: Calculates the total points for a specific driver.

### Usage Examples

**1. Transfer a driver:**
Instead of manually looking up a team ID and writing an `UPDATE` query, just run this:

```sql
-- Example: Move Carlos Sainz (55) to Williams
BEGIN
    transfer_driver(55, 'Williams');
END;
/
```

**2. Get drivers points :**

```sql
DECLARE
    v_score NUMBER;
BEGIN
    v_score := get_driver_points(1); -- Get points for verstappen
    DBMS_OUTPUT.PUT_LINE('Score: ' || v_score);
END;
/
```