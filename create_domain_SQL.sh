# -------------------------------------------------------------------
# Usage:
#   * Run this script to generate SQL command used to create new domain.
#
#       bash create_domain_SQL.sh <domain> <description> <max-mailboxes> <max-aliases>
#
#     For example:
#
#       bash create_domain_SQL.sh domain.ltd "My Domain" 100 100
#
#     It will print SQL commands on console directly, you can redirect the
#     output to a file for further use like this:
#
#       bash create_domain_SQL.sh domain.ltd "My Domain" 100 100 > output.sql
#
#   * Import output.sql into SQL database like below:
#
#       # mysql -uroot -p
#       mysql> USE vmail;
#       mysql> SOURCE /path/to/output.sql;

if [ X"$#" != X'4' ]; then
    echo "Invalid command arguments. Usage:"
    echo "bash create_domain_SQL.sh domain.ltd description max_mailboxes max_aliases"
    exit 255
fi

# Read input.
domain="$1"
description="$2"
max_mailboxes="$3"
max_aliases="$4"

cat <<EOF
INSERT INTO domain (domain, description, transport, backupmx, settings, maxquota,
                    quota, aliases, mailboxes, active, created)
             VALUES ('${domain}', '${description}', 'virtual', 0, '', 0,
                     0, ${max_aliases}, ${max_mailboxes}, 1, NOW());
EOF


