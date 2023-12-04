Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLkypozv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7B1FEB
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Dec 2023 12:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701722059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YWen9QaG4+Q9PXy1sVnWpXyX5yJD5FVhAPfXXPFSlIg=;
	b=WLkypozvM67taJLk5B4V7G3PfCwrpA0swUGiE+zvFsioEaB40yBZXeOreQCDIGRadiBxVR
	S3ffjM+MuT8KXLA+22cEz6jjBSs6WqQJLjd4wl0uz4kC04O61+bN3BWK9yixSzOYrN1qom
	nJeTb+AjP84ZzbsxtChgTEuLtFSncQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-nf6IPevtOf2CHToriC3tHw-1; Mon, 04 Dec 2023 15:34:17 -0500
X-MC-Unique: nf6IPevtOf2CHToriC3tHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D6EB185A784
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Dec 2023 20:34:17 +0000 (UTC)
Received: from 418390da0609.redhat.com (unknown [10.2.16.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DABAF2026D68;
	Mon,  4 Dec 2023 20:34:16 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH] rteval: Add interactive source-to-image Dockerfile
Date: Mon,  4 Dec 2023 20:34:16 +0000
Message-Id: <20231204203416.16713-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

This Dockerfile sets up a base image for rteval, copies the code,
and installs it, providing an interactive container for testing
rteval directly.

Signed-off-by: Chris White <chwhite@redhat.com>
---
 .dockerignore |  1 +
 Dockerfile    | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 .dockerignore
 create mode 100644 Dockerfile

diff --git a/.dockerignore b/.dockerignore
new file mode 100644
index 0000000..2d2ecd6
--- /dev/null
+++ b/.dockerignore
@@ -0,0 +1 @@
+.git/
diff --git a/Dockerfile b/Dockerfile
new file mode 100644
index 0000000..45f6434
--- /dev/null
+++ b/Dockerfile
@@ -0,0 +1,69 @@
+# Use CentOS Stream 9 as base image
+FROM centos:stream9
+
+ARG KERNEL_VERSION=linux-6.6.1.tar.xz
+
+
+# Copy current directory to /opt/rteval/
+COPY . /opt/rteval/
+
+# Install everything in one layer to shrink the image size
+# 1: Install needed dependencies and pull kernel source
+# 2: install rteval and fix bad symlink
+# 3: Remove uneeded packages and shrink the image
+RUN dnf -y update && \
+    dnf install -y \
+        python3-devel \
+        python3-lxml \
+        python3-libxml2 \
+        python3-dmidecode \
+        python3-requests \
+        realtime-tests \
+        sysstat \
+        xz \
+        bzip2 \
+        tar \
+        gzip \
+        m4 \
+        make \
+        gawk \
+        kernel-headers \
+        sos \
+        numactl \
+        gcc \
+        binutils \
+        gcc-c++ \
+        flex \
+        bison \
+        bc \
+        elfutils \
+        elfutils-libelf-devel \
+        openssl \
+        openssl-devel \
+        stress-ng \
+        perl-interpreter \
+        perl-devel \
+        perl-generators \
+        libmpc \
+        libmpc-devel \
+        dwarves \
+        wget \
+        procps-ng && \
+    cd /opt/rteval && \
+    wget -P loadsource https://www.kernel.org/pub/linux/kernel/v6.x/${KERNEL_VERSION} && \
+    make install && \
+    make clean && \
+    rm -f /usr/local/bin/rteval && \
+    ln -s /opt/rteval/rteval-cmd /usr/bin/rteval && \
+    dnf remove -y \
+        gcc-c++ \
+        python3-devel \
+        perl-devel && \
+    dnf clean all
+
+
+# Set the working directory to /root
+WORKDIR /root
+
+# Set the entrypoint to a shell
+ENTRYPOINT ["/bin/bash"]
-- 
2.31.1

