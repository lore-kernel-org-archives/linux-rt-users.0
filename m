Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA27F7CC
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037496; cv=none; b=Ibt5dYRuqWTrFHxKfSC9/VfuD/pWZz7gNNVvtR763ogi/RaKbbJO6Z+9Qn2HEeyBi1S3NawkNRvBWzJ+0/UH5/Fx4NrRJJCrT0AxKUKDhzv6ryx5FrdyDCgi984/sOsoyycsqUv430xK7dzGrgUyBH4CP84+BhRdP5553zgtURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037496; c=relaxed/simple;
	bh=caWAmsm1LpkxrcdNhNArbqT66ZC/Tu73R4Vfm6dq2JQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IPfZTC6tSyXCKOj1+wLZ8OWZ7bX0YdYf3SUvmzDhI9NTYioqE+S5KEDznxJe/0DmYKW3W55FMO00fRRYmGvhQtSOW4EbSghlA59x8Ky8OzPP52nK4qMd52upNJd6taHiWN52cYnHRDK7aaZaAtg5+fqaRaOwfCkkK+IFCbEOL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+ZO9SBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+ZO9SBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706037493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jzZPR7wsPJW7ENJj46f4c4J9EVFW+C9wfJcRLpR0sYE=;
	b=a+ZO9SBfSIKhI7ozasWuxFKZWcveGdKpXbuC+5maMJ/fh2yxBu1WTHkC8L19hkBay15kbd
	5EFajJUdpHS+p5VL8lfe9h/oHIiiNnHpJ5QpDFikLIHq0BGA8ZQ7fbxAFV7YQSae7p/nJN
	h1KYB76EyBipm6CPy48m5z8h4lGaYkA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-mWm_Q79gNtGhlJ7gFtshlA-1; Tue, 23 Jan 2024 14:18:11 -0500
X-MC-Unique: mWm_Q79gNtGhlJ7gFtshlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8B2080007C
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 19:18:10 +0000 (UTC)
Received: from 418390da0609.redhat.com (unknown [10.2.16.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A52E740D1B60
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 19:18:10 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH] rteval: Add Dockerfile README
Date: Tue, 23 Jan 2024 19:18:10 +0000
Message-Id: <20240123191810.107-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add README.md for Docker setup, covering build and test instructions
in a containerized environment.

Signed-off-by: Chris White <chwhite@redhat.com>
---
 README-Dockerfile | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 README-Dockerfile

diff --git a/README-Dockerfile b/README-Dockerfile
new file mode 100644
index 0000000..95da6d8
--- /dev/null
+++ b/README-Dockerfile
@@ -0,0 +1,49 @@
+
+# README-Dockerfile-rteval
+
+## Introduction
+This README provides detailed instructions for setting up an rteval container using Docker or Podman. This Dockerfile is designed to pull the latest local copy of your code, along with any modifications you've made, and compile it into a container image for testing purposes. This approach offers an OS-agnostic method for testing your changes, suitable for semi-modern host operating systems. The containerized environment of rteval ensures consistent and reproducible test results across different systems.
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
+  - For Podman: `sudo podman build -t rteval-upstream .`
+  - For Docker: `sudo docker build -t rteval-upstream .`
+
+## Usage
+### Run the Container
+- Start the container in privileged mode. This container will drop you directly into an interactive shell. Run the following command to start the container and drop into an interactive shell:
+  - For Podman: `sudo podman run -it --privileged rteval-upstream`
+  - For Docker: `sudo docker run -it --privileged rteval-upstream`
+- This will create a long lasting container. In order to use it again (say after a reboot), you need to start and exec into the container to get yourself back into the shell:
+  - For Podman: 
+    - `sudo podman start rteval-upstream`
+    - `sudo podman exec -it rteval-upstream /bin/bash`
+  - For Docker: 
+    - `sudo docker start rteval-upstream`
+    - `sudo docker exec -it rteval-upstream /bin/bash`
+- And to clean up and remove your container so you can test a new one:
+  - For Podman: `sudo podman rm -f rteval-upstream`
+  - For Docker: `sudo docker rm -f rteval-upstream`
+- Please note that the above command does not cleanup the container when you are done. It can be useful to run a single use container when trying to only test a quick change and remove the container afterwards. To run a a single use container that removes itself immediately after you exit the shell, run the following commands with the `--rm` option:
+  - For Podman: `sudo podman run -it --rm --privileged rteval-upstream`
+  - For Docker: `sudo docker run -it --rm --privileged rteval-upstream`
+  
+
+### Test rteval Build
+- Inside the container, test the 'rteval' build:
+  - Command: `rteval -d 1s`
+
+## Conclusion
+Follow these detailed steps for a successful rteval container setup using Docker or Podman.
-- 
2.31.1

