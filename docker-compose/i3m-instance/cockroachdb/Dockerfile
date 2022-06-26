ARG COCKROACHDB_VERSION

FROM cockroachdb/cockroach:${COCKROACHDB_VERSION}

# Use a modified version of the startup script that creates
# default user certificates if these do not exist yet.
COPY resources/cockroach.sh /cockroach/

# Include latest software updates from the distribution as a best practise and
# to satisfy automated vulnerability scanners (trivy).
RUN microdnf upgrade -y
