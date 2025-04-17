#!/bin/bash
# This script checks the syntax of Falco rules using yamllint and falco.

echo "Checking Falco rules syntax..."

yamllint rules/

docker run -it \
           --rm \
           --volume="./rules/:/etc/falco/rules.d:ro" \
           --entrypoint=falco \
           falcosecurity/falco:latest \
           -V \
           /etc/falco/falco_rules.yaml \
           -V \
           /etc/falco/rules.d/access_rules.yaml;

# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
    echo "Falco rules syntax check failed."
    exit 1
fi
echo "Falco rules syntax check passed."
