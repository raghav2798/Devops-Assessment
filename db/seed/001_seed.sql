-- 200 bookings, 5 orgs, 6 cities, 4 statuses, created_at spread over the last 90 days.
INSERT INTO hotel_bookings
    (id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
SELECT
    md5('booking-' || g)::uuid,
    md5('org-' || (g % 5))::uuid,
    'hotel-' || lpad(((g % 12) + 1)::text, 3, '0'),
    (ARRAY['delhi','delhi','mumbai','bengaluru','chennai','hyderabad','pune'])[(g % 7) + 1],
    (ts + ((g % 30) + 1) * INTERVAL '1 day')::date,
    (ts + (((g % 30) + 1) + ((g % 5) + 1)) * INTERVAL '1 day')::date,
    round((2500 + ((g * 797) % 18000))::numeric, 2),
    (ARRAY['confirmed','pending','cancelled','completed'])[(g % 4) + 1],
    ts
FROM (
    SELECT g, (NOW() - ((g * 13) % 90) * INTERVAL '1 day')::timestamp AS ts
    FROM generate_series(1, 200) AS g
) s;

INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT id, 'booking_created', jsonb_build_object('amount', amount), created_at
FROM hotel_bookings;

INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT id, 'payment_captured', jsonb_build_object('method', 'card'), created_at + INTERVAL '5 minutes'
FROM hotel_bookings WHERE status IN ('confirmed', 'completed');

INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT id, 'booking_cancelled', jsonb_build_object('reason', 'guest_request'), created_at + INTERVAL '2 hours'
FROM hotel_bookings WHERE status = 'cancelled';
