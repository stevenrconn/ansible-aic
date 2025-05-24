FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

ARG PYTHON_PYZ_RELEASE="1.7.1"
ARG ANSIBLE_RELEASE

ENV PIPX_PYZ_URL="https://github.com/pypa/pipx/releases/download/${PYTHON_PYZ_RELEASE}/pipx.pyz"

ENV PIPX_HOME="/opt/pipx"
ENV PIPX_BIN_DIR="/opt/pipx/bin"
ENV PIPX_MAN_DIR="/opt/pipx/man"
ENV PATH="${PIPX_BIN_DIR}:${PATH}"

RUN set -o xtrace -o errexit -o nounset && \
    microdnf upgrade --assumeyes && \
    microdnf install --assumeyes python3.12 openssh-clients && \
    microdnf clean all

RUN set -o xtrace -o errexit -o nounset && \
    mkdir --parents /opt/pipx && \
    curl --silent --location --output /opt/pipx/pipx.pyz ${PIPX_PYZ_URL} && \
    python3.12 /opt/pipx/pipx.pyz install --include-deps ansible${ANSIBLE_RELEASE:+"==${ANSIBLE_RELEASE}"}

COPY --chmod=0775 entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]