CREATE TABLE day_entries(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  date DATE,
  start TIME,
  end TIME,
  description VARCHAR(255)
);

CREATE OR REPLACE VIEW day_overview AS SELECT date, SEC_TO_TIME(SUM(TIME_TO_SEC(SUBTIME(end, start)))) AS time FROM day_entries GROUP BY date;
CREATE OR REPLACE VIEW month_overview AS SELECT YEAR(date) AS year, MONTH(date) AS month, SEC_TO_TIME(SUM(TIME_TO_SEC(time))) AS time FROM day_overview GROUP BY month, year;
CREATE OR REPLACE VIEW year_overview AS SELECT year, SEC_TO_TIME(SUM(TIME_TO_SEC(time))) AS time FROM month_overview GROUP BY year;
