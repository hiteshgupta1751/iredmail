DELETE FROM mailbox WHERE username = 'eva.goldstein@example.com';
DELETE FROM forwardings WHERE address = 'eva.goldstein@example.com' OR forwarding = 'eva.goldstein@example.com';
DELETE FROM mailbox WHERE username = 'edith.erickson@example.com';
DELETE FROM forwardings WHERE address = 'edith.erickson@example.com' OR forwarding = 'edith.erickson@example.com';
