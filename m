Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FCC432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 22:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BB320740
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 22:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPMXoH4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKYWia (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:38:30 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34768 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWia (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 17:38:30 -0500
Received: by mail-wr1-f47.google.com with SMTP id t2so20145979wrr.1
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQ5Elk7c2ecslq20u0ZkvFsCITy72e8RX8gl0LIo2FY=;
        b=DPMXoH4ynG7hTnl+Cb1JoSiwDwH/w/yO5DMGfFwrXQEP2AZ7G00pRK9tmNfvD1wEZP
         g96QTHWIN6YTMQi6gYRu+WU9AiE8N1/HnadTNrsFWq2L3FBPTFZCZcmlN45rLzHJU8vf
         y4zHnbHNRhdsP+/ygIAlq9Lt2IlKub6jXkiTJ5eR02ZcRLLkh+70GhZrzoeK7CL0Pm2O
         tL40GhAI7OMV49ibt7WHPQnrN7vuZZMyGjREIfSXLk8tBK3y3HEiDXXhUmuEZlYV7qdU
         w885XZnI0OGofsFlf8IuddH3In+y0YRAcpME8m+PL74ZK3tpPyq9TqoHENoW6s2W1MPd
         h4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OQ5Elk7c2ecslq20u0ZkvFsCITy72e8RX8gl0LIo2FY=;
        b=rf2l0A/hfmEb8ZK9THCDKaFE32iEkP7acJb6JTm+DUPsd5WXtRin0rhbvjv/pevno8
         JVEjlnAL9OGnwg4+En/mPhG9vzgj/bUaJmUCLa4wvJNpiFm7+6A77U1ig2LV/kvanU/G
         O+jbFHTL6NKFoNelgF3rlfsmx36Ey8fOsM99WJ+V1s9KyQoJJPHXtVY9Mt+THK9o9PQ9
         OLVMPAFgEZzYRwlSkz3WDv3zi2dTr1fyVUlVqBeHMNG1QR5tqQNLYzWEMBqzK/ljS70R
         trL0d4fZ62QD9rmchdNuPtk0KxrNP2rCRiOM6C3/FF4/bm50LujC27GM1AHuFEONj9/S
         x30A==
X-Gm-Message-State: APjAAAWH/t5QJDTzW1+bMLDAwwK1hOvvtNs8HI6s2CvQM5dAFTcivBkE
        36oUYgv+65xiOmhxeuHEtp9iFYQpWPs=
X-Google-Smtp-Source: APXvYqzh/7GbGIs3slXi4YcHAODLUGxIV+WKJLPk8HMP3kpRrjQwUM8r/sweUoRqxXgxOCKW3bpI9A==
X-Received: by 2002:a5d:5050:: with SMTP id h16mr36431086wrt.380.1574721503606;
        Mon, 25 Nov 2019 14:38:23 -0800 (PST)
Received: from planxty.redhat.com ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id 91sm12769422wrm.42.2019.11.25.14.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:38:22 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: Add SPDX tags V3
Date:   Mon, 25 Nov 2019 23:38:09 +0100
Message-Id: <20191125223810.16643-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add SPDX tags instead of having out-of-date and incomplete licences at
the top of files

Audited again to make sure that GPL-2.0-only is used where appropriate
and not GPL-2.0-or-later (and the other way around)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/backfire/backfire.c                  | 17 +--------------
 src/cyclictest/cyclictest.c              |  5 +----
 src/cyclictest/rt_numa.h                 |  1 +
 src/hwlatdetect/hwlatdetect.py           |  8 ++-----
 src/include/bionic.h                     |  1 +
 src/include/error.h                      |  1 +
 src/include/pip_stress.h                 |  1 +
 src/include/rt-get_cpu.h                 |  1 +
 src/include/rt-sched.h                   | 24 +++++----------------
 src/include/rt-utils.h                   |  1 +
 src/lib/error.c                          |  1 +
 src/lib/rt-get_cpu.c                     |  1 +
 src/lib/rt-sched.c                       | 25 ++++++----------------
 src/lib/rt-utils.c                       |  1 +
 src/pi_tests/classic_pi.c                | 22 ++++---------------
 src/pi_tests/pi_stress.c                 | 22 ++++---------------
 src/pi_tests/pip_stress.c                | 14 +-----------
 src/pi_tests/sigtest.c                   | 22 ++++---------------
 src/pi_tests/tst-mutexpi10.c             | 27 ++++++------------------
 src/pmqtest/pmqtest.c                    | 16 +-------------
 src/ptsematest/ptsematest.c              | 17 +--------------
 src/queuelat/determine_maximum_mpps.sh   |  3 +++
 src/queuelat/get_cpuinfo_mhz.sh          |  3 +++
 src/queuelat/queuelat.c                  |  8 +++++++
 src/queuelat/targeted-ipi/targeted-ipi.c |  7 ++++++
 src/rt-migrate-test/rt-migrate-test.c    | 19 +----------------
 src/sched_deadline/cyclicdeadline.c      |  8 +++++++
 src/sched_deadline/deadline_test.c       | 24 ++++++---------------
 src/signaltest/signaltest.c              |  2 ++
 src/sigwaittest/sigwaittest.c            |  2 ++
 src/ssdd/ssdd.c                          | 12 +++++------
 src/svsematest/svsematest.c              | 16 ++------------
 32 files changed, 94 insertions(+), 238 deletions(-)

diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
index a8ac9f5e2b28..81a31d49f47b 100644
--- a/src/backfire/backfire.c
+++ b/src/backfire/backfire.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * backfire - send signal back to caller
- *
  * Copyright (C) 2007  Carsten Emde <C.Emde@osadl.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <linux/module.h>
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1c515ae1354c..beac9a3ce946 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * High resolution timer test software
  *
@@ -6,10 +7,6 @@
  * (C) 2008-2012 Clark Williams <williams@redhat.com>
  * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License Version
- * 2 as published by the Free Software Foundation.
- *
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 983502d34c94..1f7c5a482150 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * A numa library for cyclictest.
  * The functions here are designed to work whether cyclictest has been
diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index c11a6f8ea5b1..12228f45f852 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -1,14 +1,10 @@
 #!/usr/bin/python3
 
+# SPDX-License-Identifier: GPL-2.0-only
+
 # (C) 2018,2019 Clark Williams <williams@redhat.com>
 # (C) 2015,2016 Clark Williams <williams@redhat.com>
 # (C) 2009 Clark Williams <williams@redhat.com>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License Version 2
-# as published by the Free Software Foundation.
-
-
 
 import sys
 import os
diff --git a/src/include/bionic.h b/src/include/bionic.h
index 54f9c54b0824..e0433437f5d2 100644
--- a/src/include/bionic.h
+++ b/src/include/bionic.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #ifndef BIONIC_H
 #define BIONIC_H
 
diff --git a/src/include/error.h b/src/include/error.h
index 4acff4952dd6..d205e49ff041 100644
--- a/src/include/error.h
+++ b/src/include/error.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #ifndef __ERROR_H
 #define __ERROR_H
 
diff --git a/src/include/pip_stress.h b/src/include/pip_stress.h
index 8ed24522851c..ee8b545ab117 100644
--- a/src/include/pip_stress.h
+++ b/src/include/pip_stress.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #ifndef __PIP_STRESS_H
 #define __PIP_STRESS_H
 
diff --git a/src/include/rt-get_cpu.h b/src/include/rt-get_cpu.h
index 15d05fcb15fa..74bf8f0fac25 100644
--- a/src/include/rt-get_cpu.h
+++ b/src/include/rt-get_cpu.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #ifndef __RT_GET_CPU_H
 #define __RT_GET_CPU_H
 #include <stdio.h>
diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index 679c4bd10ae2..80171c76e0ee 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-   rt-sched.h - sched_setattr() and sched_getattr() API
-
-   (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
-   Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
-   USA */
+ * rt-sched.h - sched_setattr() and sched_getattr() API
+ * (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
+ * Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
+ */
 
 /* This file is based on Dario Faggioli's libdl. Eventually it will be
    replaced by a proper implemenation of this API. */
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 405fa7855346..6ec2b2011959 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #ifndef __RT_UTILS_H
 #define __RT_UTILS_H
 
diff --git a/src/lib/error.c b/src/lib/error.c
index b32aa0270780..4434a842da17 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2009 John Kacur <jkacur@redhat.com>
  *
diff --git a/src/lib/rt-get_cpu.c b/src/lib/rt-get_cpu.c
index 83430dd4d068..608cd9bb76e0 100644
--- a/src/lib/rt-get_cpu.c
+++ b/src/lib/rt-get_cpu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2009 John Kacur <jkacur@redhat.com>
  */
diff --git a/src/lib/rt-sched.c b/src/lib/rt-sched.c
index 4a8e3c42b49f..2aaf02d42aee 100644
--- a/src/lib/rt-sched.c
+++ b/src/lib/rt-sched.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-   rt-sched.h - sched_setattr() and sched_getattr() API
-
-   (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
-   Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
-   USA */
+ * rt-sched.h - sched_setattr() and sched_getattr() API
+ *
+ * (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
+ * Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
+ */
 
 /* This file is based on Dario Faggioli's libdl. Eventually it will be
    replaced by a proper implemenation of this API. */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index e1b166afcd6c..1998a327d036 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2009 Carsten Emde <carsten.emde@osadl.org>
  * Copyright (C) 2010 Clark Williams <williams@redhat.com>
diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
index 695ee4c4bd03..64af8890276f 100644
--- a/src/pi_tests/classic_pi.c
+++ b/src/pi_tests/classic_pi.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-  classic_pi - Classic Priority Inversion deadlock test case
-  
-   Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
-  
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
-   USA */
+ * classic_pi - Classic Priority Inversion deadlock test case
+ * Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
+ */
 
 /* This program tests Priority Inheritance mutexes and their ability
    to avoid Priority Inversion deadlocks
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 1286370c474b..7fa98dfb9ad4 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-   pi_stress - Priority Inheritance stress test
-
-   Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
-   USA */
+ * pi_stress - Priority Inheritance stress test
+ * Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
+ */
 
 /* This program stress tests pthreads priority inheritance mutexes
 
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index e6cf0ce940ca..c9dbd992e15d 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 	Pip stress - Priority Inheritance with processes
 
     Copyright (C) 2009, John Kacur <jkacur@redhat.com>
-
-    This program is free software: you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation, either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 
 /*
diff --git a/src/pi_tests/sigtest.c b/src/pi_tests/sigtest.c
index 0cf520c01335..17dd0d43bdc6 100644
--- a/src/pi_tests/sigtest.c
+++ b/src/pi_tests/sigtest.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-  sigtest - simple little program to verify signal behavior
-  
-   Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
-  
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
-   USA */
+ * sigtest - simple little program to verify signal behavior
+ * Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
+*/
 
 #include <stdio.h>
 #include <signal.h>
diff --git a/src/pi_tests/tst-mutexpi10.c b/src/pi_tests/tst-mutexpi10.c
index a63ea23ba621..97a345edd26e 100644
--- a/src/pi_tests/tst-mutexpi10.c
+++ b/src/pi_tests/tst-mutexpi10.c
@@ -1,25 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
-   Classic Priority Inversion deadlock test case
-  
-   Copyright (C) 2006 Free Software Foundation, Inc.
-   This file is part of the GNU C Library.
-     Contributed by Clark Williams<williams@redhat.com>, 2006
-  
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public License as
-   published by the Free Software Foundation; either version 2.1 of the
-   License, or (at your option) any later version.
-  
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-  
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
-
+ * Classic Priority Inversion deadlock test case
+ * Copyright (C) 2006 Free Software Foundation, Inc.
+ * This file is part of the GNU C Library.
+ * Contributed by Clark Williams<williams@redhat.com>, 2006
+ */ 
 
 /* This program tests Priority Inheritance mutexes and their ability
    to avoid Priority Inversion deadlocks
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 3ce799bd6319..3ce29252b9a2 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * pmqtest.c
  *
  * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 553759212ac9..78fa444c5578 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * ptsematest.c
- *
  * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index 3acd6ba2e362..52d54c0f9065 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -1,5 +1,8 @@
 #!/bin/bash
 
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2018 Marcelo Tosatti <mtosatti@redhat.com>
+
 #  A script to determine the maximum mpps. Logic:
 #  Increase mpps in 0.5 units 
 # 
diff --git a/src/queuelat/get_cpuinfo_mhz.sh b/src/queuelat/get_cpuinfo_mhz.sh
index fb5158f31040..eafdd9577424 100755
--- a/src/queuelat/get_cpuinfo_mhz.sh
+++ b/src/queuelat/get_cpuinfo_mhz.sh
@@ -1,5 +1,8 @@
 #!/bin/bash
 
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2018 Marcelo Tosatti <mtosatti@redhat.com>
+
 mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " "`
 echo $mhz
 
diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index a5525e41776a..cccb50ef0cc4 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -1,3 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2018 Marcelo Tosatti <mtosatti@redhat.com>
+ * Copyright (C) 2019 John Kacur <jkacur@redhat.com>
+ * Copyright (C) 2019 Clark Williams <williams@redhat.com>
+ */
+
 #include <string.h>
 #include <stdlib.h>
 #include <sys/types.h>
diff --git a/src/queuelat/targeted-ipi/targeted-ipi.c b/src/queuelat/targeted-ipi/targeted-ipi.c
index 4a10e0b24ecb..be2b153260c5 100644
--- a/src/queuelat/targeted-ipi/targeted-ipi.c
+++ b/src/queuelat/targeted-ipi/targeted-ipi.c
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2018 Marcelo Tosatti <mtosatti@redhat.com>
+ * Copyright (C) 2019 John Kacur <jkacur@redhat.com>
+ * Copyright (C) 2019 Clark Williams <williams@redhat.com>
+ */
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index f0a285d1d45f..4863238edeb4 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -1,24 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * rt-migrate-test.c
- *
  * Copyright (C) 2007-2009 Steven Rostedt <srostedt@redhat.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <stdio.h>
 #ifndef __USE_XOPEN2K
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 7b5e8b36c4ea..a08e28e73c42 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1,3 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2016 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
+ * Copyright (C) 2019 John Kacur <jkacur@redhat.com>
+ * Copyright (C) 2019 Clark Williams <williams@redhat.com>
+ */
+
 #include <pthread.h>
 #include <stdarg.h>
 #include <stdlib.h>
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 5b5f40dbb74d..4cef2609912e 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1,22 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 /*
  * Copyright (C) 2016 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not,  see <http://www.gnu.org/licenses>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
+ * Copyright (C) 2019 John Kacur <jkacur@redhat.com>
+ * Copyright (C) 2019 Clark Williams <williams@redhat.com>
+ */
+
+/*
  * deadline_test.c
  *
  * This program is used to test the deadline scheduler (SCHED_DEADLINE tasks).
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 4c952561d7f2..b5c86c5635cb 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 /*
  * RT signal roundtrip test software
  *
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 2d0c04132fa7..4678b68675b2 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
  * sigwaittest.c
  *
diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 080ed17107a8..f165da96e23a 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -1,3 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2019 Joe Korty <joe.korty@concurrent-rt.com>
+ */
+
 /*
  * Have a tracer do a bunch of PTRACE_SINGLESTEPs against
  * a tracee as fast as possible.  Create several of these
@@ -16,12 +22,6 @@
  * The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
  * and checks that waitpid's return values for correctness.
  *
- * This program was originally written by
- * Joe Korty <joe.korty@concurrent-rt.com>
- * This program is free software; you can redistribute it and / or modify
- * it under the terms of the GNU General Public License Version 2
- * of the licence, or (at your option) any later version
- * see COPYING for more information
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 15e36af76288..7c15393fe1be 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
  * svsematest.c
  *
  * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
-- 
2.20.1

