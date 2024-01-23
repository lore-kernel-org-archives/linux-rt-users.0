Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71C823D4
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039622; cv=none; b=Rqg7d/fmh+3AGMtQwlx0+W8OS2LiY1+7pXMiWWhx8u8iQjKlTJSDNhBTbssMPv+9uTWcbF2D3tyGjjOQhf6g/WEmiyiiwO0NHg9Wxu5p1TIaZwdtTdzco1u9OBMyD7Hj96uginfVL9dvX5RF2kKJKTUzeISv3NakENGMjQxUtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039622; c=relaxed/simple;
	bh=4i9Z6GHTXiBnvIq2kMe/TFPqv/j/q3Z9qIiYrU2hpGE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=p4QdR/+Ulf5RRbBY96MKo98GdpP7IGbZ6UVBzl0TjcVBtmQ20Cj0zsn4EsEfMOBf+wNTePphpWNDzg+6eGDgBXKF6wSoG5IprzOb6MhU/jJVNTiFcGn9/gGzJ6gmLCK9Zuj9vKsXuiSL5ys9J2qgKuldiAbebJm+k1qy46WgSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iua1tXiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iua1tXiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706039619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lppP3uu6bJoJYGJtF7E4EnX36APv4bnDd83FEUWaue4=;
	b=Iua1tXiRBUCQODHu+okqtXNjGaZFu3yvZjs4ojKK0nnUr1+G4v7zvP/CrcjjZ/RTyeQ7g7
	cOlxCEGx1mGGuOeYamC1XdDgCx8c8uN6BvGjNC6MHGoTW6hfo7JXIOuSmD5AJ8UXa1JbqX
	ki+0Py12eckboGyAUTC/r35lIlL0ww8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-q4Q9LiA3MumPcp0dORzXOA-1; Tue, 23 Jan 2024 14:53:37 -0500
X-MC-Unique: q4Q9LiA3MumPcp0dORzXOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E53285A589
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 19:53:37 +0000 (UTC)
Received: from 418390da0609.redhat.com (unknown [10.2.16.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E22451D5
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 19:53:37 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH] rt-tests: Add Dockerfile README
Date: Tue, 23 Jan 2024 19:53:36 +0000
Message-Id: <20240123195336.167-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add README detailing Docker setup for building and testing
rt-tests in a containerized environment.

Signed-off-by: Chris White <chwhite@redhat.com>
---
 README-Dockerfile | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 README-Dockerfile

diff --git a/README-Dockerfile b/README-Dockerfile
new file mode 100644
index 0000000..fc6ec85
--- /dev/null
+++ b/README-Dockerfile
@@ -0,0 +1,49 @@
+1
+# README-Dockerfile-rt-tests
+
+## Introduction
+This README provides detailed instructions for setting up an rt-tests container using Docker or Podman. This Dockerfile will pull a current copy of your code (plus all of your changes) and compile it into a container image for you to test with. This will give you an imbiguous way to test your changes, assuming you are running on a semi-modern host OS. The rt-tests container can be used to test any of the subpackages found under the rt-tests project, but is mainly intended for hwlatdetect and cyclictest.
+
+## Prerequisites
+- Docker or Podman installed on your system.
+
+## Installation
+### Prepare Your Environment
+- For EPEL systems (Fedora, CentOS, RHEL):
+  - Install Podman: `sudo dnf install podman -y`
+- For Debian-based systems (Ubuntu):
+  - Install Docker: `sudo apt-get update && sudo apt-get install docker.io -y`
+  - Alternatively, install Podman: `sudo apt-get update && sudo apt-get install podman -y`
+
+### Build the Container
+- Navigate to the root directory of the 'rteval'
+- Build the container image named 'rteval-upstream':
+  - For Podman: `sudo podman build -t rt-tests-upstream .`
+  - For Docker: `sudo docker build -t rt-tests-upstream .`
+
+## Usage
+### Run the Container
+- Start the container in privileged mode:
+  - For Podman: `sudo podman run -it --privileged rt-tests-upstream`
+  - For Docker: `sudo docker run -it --privileged rt-tests-upstream`
+- This will create a long lasting container. In order to use it again (say after a reboot), you need to start and exec into the container to get yourself back into the shell:
+  - For Podman: 
+    - `sudo podman start rt-tests-upstream`
+    - `sudo podman exec -it rt-tests-upstream /bin/bash`
+  - For Docker: 
+    - `sudo docker start rt-tests-upstream`
+    - `sudo docker exec -it rt-tests-upstream /bin/bash`
+- And to clean up and remove your container so you can test a new one:
+  - For Podman: `sudo podman rm -f rt-tests-upstream`
+  - For Docker: `sudo docker rm -f rt-tests-upstream`
+- Please note that the above command does not cleanup the container when you are done. It can be useful to run a single use container when trying to only test a quick change and remove the container afterwards. To run a a single use container that removes itself immediately after you exit the shell, run the following commands with the `--rm` option:
+  - For Podman: `sudo podman run -it --rm --privileged rt-tests-upstream`
+  - For Docker: `sudo docker run -it --rm --privileged rt-tests-upstream`  
+
+### Test rteval Build
+- Inside the container, test one of the rt-tests packages you just built: 
+  - Command: `cyclictest -D 1s`
+  - Command: `hwlatdetect --duration 1`
+
+## Conclusion
+Follow these detailed steps for a successful rt-tests container setup using Docker or Podman.
-- 
2.31.1

