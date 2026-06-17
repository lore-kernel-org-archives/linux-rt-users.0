Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C733B71BC
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727678; cv=none; b=JWWVBfb1hLv2gBcPj+jMV9xtqreqp7MZ4nsFdBzWyyEnBGTuPF6pou25TeBXBIB4db2u9Ghf2sENR0Mx2bHbJ4ev4NooNegzLARzVtbAIqYg3UFCXQpbtzxGsA6sHXJ/fXArBwKo3bzBDk/0S90i1KqqAWj5IylGulqAA2dpqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727678; c=relaxed/simple;
	bh=/s7QsZDEr5pkWWPW+cMycqnVuTmLuMYrS6m3gIOJofM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPVTXmjAh3Hga0FY2YKWemy+JJp714pAcf7l1/6jr9cVxQ2T5No8r2swNznqcVAlg7q8sTHF+xOaQo+9dxcVFl+V2AoMcEw+LFGYm2WfsyUb4IUZy5iPYP2lhLCTnTLUCVTsPjFfXKiKi/E0T2yPK0yjr2oFxvNdTMS5oh/WAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtyYgExY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtyYgExY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so1565106d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781727676; x=1782332476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7hEiQ81+z1rzylXNSZj5CkrDIzP8QYsJbG5OcdCX6Y=;
        b=OtyYgExYXBXEuVqkCjqwHfGGUrKadudaUOo2wUwrJKuL7lvHnbdeYynjS09UXiScDd
         mQKsRcmgHBr5y0ZP8QI0NQyJf7EX7SJye5vUqwwMxmrrtO2nLm5FSwtZGK2Hism4l9qq
         xcILTh1o4dSf92HK/EtGnWEYyADvU9N+kwQct8WGn0k+LnV9iew79OlYvGSVokAycZqe
         8uquAojLHR0JDWVFWRzXgs96doMWIgTP5CC1yFy4asusZKF8WWH4POZbTgOq/JaHb8z8
         US9QDeoo6k/eBtLQaacJcPzqKXa5tEfUIpdnwA5sFLCWkKwKXYAkYD9CFkh2Xgzy7bXs
         Ku+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781727676; x=1782332476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7hEiQ81+z1rzylXNSZj5CkrDIzP8QYsJbG5OcdCX6Y=;
        b=eIrD2tMPs+LFWzAkbK1R9A6U1TV3nmXQwPWpELXDLnd9k5Et0Klze7UD7Y76dacse/
         cvLjojYqGFGSmPUHDEx8HdHzFVLhXojIAsIf9Y3BIGOMsnc6Q829wdts5U+ITDN0qmbC
         1nNYuW6Jx2KnBvc87ZUI8ew0awh9M8/euCfOGWxfzU2ERSM4uv1dsYW7O08/KHuiDjnx
         ZkjGQpdAIuXrnJ1RpPfpT9LQCsqLVdKMWp+dJhyfdv4cHyObrD2g8MSwGbJ+zG+jG4b2
         lWwot5qsPXhFHQJBe1T8m1RvLLLaMV+GoMHyi7g8pgvIOV0tAsiefForUNnftbU3dbA/
         IulA==
X-Gm-Message-State: AOJu0YwJMA8ABEET0FoM/DRVW3gy9NyY8ycF4516paLK2MIPCQZEgP1J
	WYac2x176M+ez6i+8nKKWSieiH382/jwB8M5TeeCI4mqqZBj1k1BnK9n0/mSxw==
X-Gm-Gg: AfdE7cl35QEAY9Bk4dVaQCNXKz+SIKwu+8Wb2HJjPSyBJ1FjtezJavRsW4MUxr5bsur
	hFfl385CQy3iO6DjoZqqzqDYH8+tJAG3EtdhZ+5eMKp6gHqSmC1mNoRBDbmSXkye6uQSHGgZm2A
	PIyfSKwcc9Edy545d442YUNFTGz1M/SzLqEK4ZlLYgxr2AG/dTiPG667N64aomAO3kFloe7O7+b
	DRTDnytXX/j1SusADGtbZ7WUMNvLrreqeJOU5GURXYB0nPHqAE0xcXAwe6VVD6F2FbN3Swu5nJY
	YCsVgxs6eKChzbQAgmTQVTB2LdhyPihiZ1FdeWamNYwPO1PLvUm6WaiJ1zBTEhNkl7jisV0p1gE
	UNjvpfHzV/U6Uz0P7L5I4tbtW0KdzZfQCt4rbf8GdZxmnn4J00/IAnBuhORrpyLSGr3esZmevNk
	MgLbYgqrQNcdfKW52vNO36s2HGmtEHpkECG9pDORNQv4PMymKbxT5ADF6vSAsyWZOs+bA6oJFX9
	qD9vrVp
X-Received: by 2002:a05:6214:808b:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-8dce27fdc12mr10779466d6.30.1781727675459;
        Wed, 17 Jun 2026 13:21:15 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f1dc7432sm71969046d6.19.2026.06.17.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 13:21:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 2/3] rt-tests: Add SPDX identifiers and fix documentation issues
Date: Wed, 17 Jun 2026 16:20:55 -0400
Message-ID: <20260617202059.217693-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617202059.217693-1-jkacur@redhat.com>
References: <20260617202059.217693-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add SPDX-License-Identifier: GPL-2.0-or-later to the following files
that were missing license identifiers:
- get_pylib.py
- Dockerfile
- MAINTAINERS
- README-Dockerfile
- src/pi_tests/README
- src/queuelat/README
- src/queuelat/targeted-ipi/README

Additionally, fix documentation issues:

In README-Dockerfile:
- Fix spelling: "imbiguous" → "unambiguous"
- Correct project references: "rteval" → "rt-tests" in directory name,
  container image name, and section heading to accurately reflect that
  this is rt-tests documentation

In src/pi_tests/README:
- Fix spelling: "inheritence" → "inheritance"
- Fix typo: "one one processor" → "on one processor"
- Fix spacing: "fetchthe" → "fetch the"
- Fix option: "--duraton" → "--duration"

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Dockerfile                       |  1 +
 MAINTAINERS                      |  2 ++
 README-Dockerfile                | 11 ++++++-----
 get_pylib.py                     |  1 +
 src/pi_tests/README              | 10 ++++++----
 src/queuelat/README              |  3 ++-
 src/queuelat/targeted-ipi/README |  1 +
 7 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index 92f680e708d6..b66875277304 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Use CentOS Stream 9 as base image
 FROM centos:stream9
 
diff --git a/MAINTAINERS b/MAINTAINERS
index da5ad3a80768..fc69a0f2c4a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1,3 +1,5 @@
+SPDX-License-Identifier: GPL-2.0-or-later
+
 Please send your patches to
 
 Clark Williams <williams@redhat.com>
diff --git a/README-Dockerfile b/README-Dockerfile
index fc6ec85feac7..bff3b7dcd958 100644
--- a/README-Dockerfile
+++ b/README-Dockerfile
@@ -1,8 +1,9 @@
-1
+SPDX-License-Identifier: GPL-2.0-or-later
+
 # README-Dockerfile-rt-tests
 
 ## Introduction
-This README provides detailed instructions for setting up an rt-tests container using Docker or Podman. This Dockerfile will pull a current copy of your code (plus all of your changes) and compile it into a container image for you to test with. This will give you an imbiguous way to test your changes, assuming you are running on a semi-modern host OS. The rt-tests container can be used to test any of the subpackages found under the rt-tests project, but is mainly intended for hwlatdetect and cyclictest.
+This README provides detailed instructions for setting up an rt-tests container using Docker or Podman. This Dockerfile will pull a current copy of your code (plus all of your changes) and compile it into a container image for you to test with. This will give you an unambiguous way to test your changes, assuming you are running on a semi-modern host OS. The rt-tests container can be used to test any of the subpackages found under the rt-tests project, but is mainly intended for hwlatdetect and cyclictest.
 
 ## Prerequisites
 - Docker or Podman installed on your system.
@@ -16,8 +17,8 @@ This README provides detailed instructions for setting up an rt-tests container
   - Alternatively, install Podman: `sudo apt-get update && sudo apt-get install podman -y`
 
 ### Build the Container
-- Navigate to the root directory of the 'rteval'
-- Build the container image named 'rteval-upstream':
+- Navigate to the root directory of 'rt-tests'
+- Build the container image named 'rt-tests-upstream':
   - For Podman: `sudo podman build -t rt-tests-upstream .`
   - For Docker: `sudo docker build -t rt-tests-upstream .`
 
@@ -40,7 +41,7 @@ This README provides detailed instructions for setting up an rt-tests container
   - For Podman: `sudo podman run -it --rm --privileged rt-tests-upstream`
   - For Docker: `sudo docker run -it --rm --privileged rt-tests-upstream`  
 
-### Test rteval Build
+### Test rt-tests Build
 - Inside the container, test one of the rt-tests packages you just built: 
   - Command: `cyclictest -D 1s`
   - Command: `hwlatdetect --duration 1`
diff --git a/get_pylib.py b/get_pylib.py
index 56253d589fe4..5ecf6e23475b 100755
--- a/get_pylib.py
+++ b/get_pylib.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 # This file is used during the make process
 
diff --git a/src/pi_tests/README b/src/pi_tests/README
index 6b2850d6b970..3313355f06f9 100644
--- a/src/pi_tests/README
+++ b/src/pi_tests/README
@@ -1,3 +1,5 @@
+SPDX-License-Identifier: GPL-2.0-or-later
+
 DESCRIPTION
 
 The pi_stress program is a stress test that is intended to exercise
@@ -22,20 +24,20 @@ The threads run through a state machine designed to guarantee that a
 low-priority thread holds a mutex while a medium priority thread runs
 (keeping the low-priority thread from releasing the mutex). The
 high-priority thread attempts to acquire the mutex and is blocked
-because of the low-priority thread holding it. If priority inheritence
+because of the low-priority thread holding it. If priority inheritance
 is working, the low-priority thread will receive a priority boost
 (will inherit the high-priority thread's priority) and will then run
 and release the mutex, averting a deadlock.
 
 On a multi-processor system, the admin and reporter threads are run
-one one processor while the inversion groups are run on another
+on one processor while the inversion groups are run on another
 processor. 
 
 
 STEPS TO RUN
 
 Install the pi_tests rpm. If you are running Fedora Core, the simplest
-way do to that is to fetchthe rt-userspace.repo file from:
+way do to that is to fetch the rt-userspace.repo file from:
 
 http://people.redhat.com/~williams/rt-userspace.repo
 
@@ -74,7 +76,7 @@ that have been performed. To stop the test, press any key and a
 summary will be printed to show how many inversions were performed and
 how long the test ran.
 
-To run the test for a specifed time, use the --duraton=<seconds>
+To run the test for a specifed time, use the --duration=<seconds>
 option.
 
 
diff --git a/src/queuelat/README b/src/queuelat/README
index 4ffdb3753bbd..10c7fbb9eea9 100644
--- a/src/queuelat/README
+++ b/src/queuelat/README
@@ -1,5 +1,6 @@
+SPDX-License-Identifier: GPL-2.0-or-later
 
-cyclictest does not catch all cases where packet forwarding 
+cyclictest does not catch all cases where packet forwarding
 latency can exceed a given threshold.
 
 Example: 
diff --git a/src/queuelat/targeted-ipi/README b/src/queuelat/targeted-ipi/README
index f36711c239b4..15dc2acb8418 100644
--- a/src/queuelat/targeted-ipi/README
+++ b/src/queuelat/targeted-ipi/README
@@ -1,3 +1,4 @@
+SPDX-License-Identifier: GPL-2.0-or-later
 
 To build:
 
-- 
2.54.0

