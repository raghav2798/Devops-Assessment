-- city = equality, created_at = range, INCLUDE = columns needed for GROUP BY/SUM (index-only scan)
CREATE INDEX idx_hotel_bookings_city_created_at
    ON hotel_bookings (city, created_at)
    INCLUDE (org_id, status, amount);
