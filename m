Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMBdDQxg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC9A0
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Dec 2023 14:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701730722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fn7hIcNVODpCVAOf4Y1IYAu2GI16mYd2UUlXIeGIi+A=;
	b=YMBdDQxgfFC06I742GFFXTRa8o+sAsoE/LXqgNPDqAPRK1VmgH+/ZCVJI7Y1qjxg75o/4h
	Bd2e94EoNogjicLc6JQwAnur+JUfbGCfsDnIMEzUnQwqVMcBhrf379CkGSc/aPHW3MHPgK
	eLALcFrDCWPmE+lpZ0F9QVO1sbACrmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-5gCUwClYMeCFJmV68EtXLA-1; Mon, 04 Dec 2023 17:58:41 -0500
X-MC-Unique: 5gCUwClYMeCFJmV68EtXLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D27C7101A53B
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Dec 2023 22:58:40 +0000 (UTC)
Received: from 418390da0609.redhat.com (unknown [10.2.16.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89B8A5028;
	Mon,  4 Dec 2023 22:58:40 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH] rt-tests: Add interactive source-to-image Dockerfile
Date: Mon,  4 Dec 2023 22:58:40 +0000
Message-Id: <20231204225840.17042-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This Dockerfile sets up a base image for rt-tests, copies the code,
and installs it, providing an interactive container for testing the
various applications packaged.

Signed-off-by: Chris White <chwhite@redhat.com>
---
 Dockerfile | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Dockerfile

diff --git a/Dockerfile b/Dockerfile
new file mode 100644
index 0000000..92f680e
--- /dev/null
+++ b/Dockerfile
@@ -0,0 +1,26 @@
+# Use CentOS Stream 9 as base image
+FROM centos:stream9
+
+# Install required packages for RT-Tests
+RUN dnf -y update && \
+    dnf install -y \
+        gcc \
+        make \
+        numactl-devel \
+        util-linux \
+        git && \
+    git clone https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git /opt/rt-tests && \
+    cd /opt/rt-tests && \
+    make && \
+    make install && \
+    dnf remove -y \
+        git \
+        make && \
+    dnf clean all
+
+
+# Set the working directory to the RT-Tests directory
+WORKDIR /opt/rt-tests
+
+# Set the entrypoint to a shell
+ENTRYPOINT ["/bin/bash"]
-- 
2.31.1

