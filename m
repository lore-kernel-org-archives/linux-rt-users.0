Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C13716D
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Oct 2023 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOqkCbRO"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B53B0
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Oct 2023 12:02:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d17fd450aso29179906d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Oct 2023 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433361; x=1699038161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XSTTOwEdarGzMDFbf1NouhjqW6O2mqZ1GMfcm/Cj5GI=;
        b=DOqkCbROo3eUQhBOUSaT6U3pkyJfPuwPY/mUZQGbkIjGZt9M9gGWkEiTputN6Dht2G
         YVlG/X+kDbVpuUChJTgg4agoivNhaBgWFDoYumHzA8eiCMnhjlY1ZfeLPNLlaxBfpJdJ
         IFDfHgrGUVhwtNRCYU73yyphNrfCtjN1hV+cY9tzVMB6d4oJxVXcLtD/JIHjV+VxJ9dp
         xIWaqppkueu6C/WDXS946i4H7PUK4dM8bdIh9E0SbGNmg9goyYdQM04NMXH+opMDhxgN
         amsq9ii6Xf888BBexcvGoWQu4VFFNWU+nfEFMGCA4sXIQMK7eQhEg8R1/wz/5wXl/m7A
         8X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433361; x=1699038161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSTTOwEdarGzMDFbf1NouhjqW6O2mqZ1GMfcm/Cj5GI=;
        b=HVxAlxhLrme8yAmEqVQ7rGwUsFWLq7AamzIjURtmuZO/u027h8N8PJQlapwqyA6XuV
         hRJ/X5MGen6EZd69w3c7JyiTCifdAMEdWEV/qnfRBPLuCFZR56lpp8MInqdGhReQcKbF
         wDYswjRdqY5wFVJRshWnnwlffjMHs/5Fo4j43QdZ4wuCGmkAuLlr181cHm+sDFlMMpqT
         6w8XO7yn/hdyoKQE6e+7WTAqPsz66SRv7u2t7qXP1G2zQPmnP5daeYX4WbwSFHAWwP3E
         xYzT3E3MG5lTRgjC8dF6P1SRL68oh+qwVCx8QMqBr8yME+QUPItL7/ixp7deSswqMmjd
         lYwA==
X-Gm-Message-State: AOJu0YyLwKqfwEo5gu2iml1VV/C+MtccOOabPP5wUfmpabROobE/FeSy
	IYgwqBR2S3kQU9ZM4Vds+na4sFDyrfEWnA==
X-Google-Smtp-Source: AGHT+IESGn7cwYVp3xboekiEY5fuRikYWmLJxT9QMJcWKkqJB0uevVrOgiRIzOcTFI527rPQiy48Bg==
X-Received: by 2002:a0c:f84a:0:b0:66c:edf4:b955 with SMTP id g10-20020a0cf84a000000b0066cedf4b955mr7631517qvo.21.1698433360807;
        Fri, 27 Oct 2023 12:02:40 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id x21-20020ac86b55000000b004166ab2e509sm812611qts.92.2023.10.27.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:02:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Add missing SPDX licenses
Date: Fri, 27 Oct 2023 15:02:09 -0400
Message-ID: <20231027190209.40105-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add missing SPDX licenses

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore                               |  1 +
 Makefile                                 |  1 +
 src/backfire/backfire.4                  |  1 +
 src/backfire/sendme.8                    |  1 +
 src/backfire/sendme.c                    | 15 +--------------
 src/cyclictest/cyclictest.8              |  1 +
 src/cyclictest/get_cyclictest_snapshot.8 |  1 +
 src/hackbench/hackbench.8                |  1 +
 src/hwlatdetect/hwlatdetect.8            |  1 +
 src/oslat/oslat.8                        |  1 +
 src/pi_tests/pi_stress.8                 |  1 +
 src/pi_tests/pip_stress.8                |  1 +
 src/pmqtest/pmqtest.8                    |  1 +
 src/ptsematest/ptsematest.8              |  1 +
 src/queuelat/determine_maximum_mpps.8    |  1 +
 src/queuelat/queuelat.8                  |  1 +
 src/queuelat/targeted-ipi/Kbuild         |  1 +
 src/queuelat/targeted-ipi/Makefile       |  1 +
 src/rt-migrate-test/rt-migrate-test.8    |  1 +
 src/sched_deadline/cyclicdeadline.8      |  1 +
 src/sched_deadline/deadline_test.8       |  1 +
 src/signaltest/signaltest.8              |  1 +
 src/sigwaittest/sigwaittest.8            |  1 +
 src/ssdd/ssdd.8                          |  1 +
 src/svsematest/svsematest.8              |  1 +
 25 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7fef7de0438c..9d308785a740 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 *~
 .*
 *.o
diff --git a/Makefile b/Makefile
index 8d3268d19901..2808c212058a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 VERSION =3D 2.6
 CC =3D $(CROSS_COMPILE)gcc
 AR =3D $(CROSS_COMPILE)ar
diff --git a/src/backfire/backfire.4 b/src/backfire/backfire.4
index 66dccd1dd1f0..1057a432eefb 100644
--- a/src/backfire/backfire.4
+++ b/src/backfire/backfire.4
@@ -1,4 +1,5 @@
 .TH "backfire" "4" "0.1" "" "Driver"=0D
+# SPDX-License-Identifier: GPL-2.0-or-later=0D
 .SH "NAME"=0D
 .LP=0D
 backfire \- send a signal from driver to user=0D
diff --git a/src/backfire/sendme.8 b/src/backfire/sendme.8
index 05f3a1c14d8b..9c973607f859 100644
--- a/src/backfire/sendme.8
+++ b/src/backfire/sendme.8
@@ -1,4 +1,5 @@
 .TH "sendme" "8" "0.2" "" ""=0D
+# SPDX-License-Identifier: GPL-2.0-only=0D
 .SH "NAME"=0D
 .LP=0D
 \fBsendme\fR \- Send a signal from driver to user and measure time interva=
ls=0D
diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index d963723b1c93..da10397846f7 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * sendme.c
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
 #include <stdlib.h>
diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 1cc72e64effc..2ccdfc1ff5fa 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH CYCLICTEST 8 "April 22, 2016"
+# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/cyclictest/get_cyclictest_snapshot.8 b/src/cyclictest/get_=
cyclictest_snapshot.8
index e9251a8e821f..45eb90da070c 100644
--- a/src/cyclictest/get_cyclictest_snapshot.8
+++ b/src/cyclictest/get_cyclictest_snapshot.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH GET_CYCLICTEST_SNAPSHOT 8 "July 6, 2020"
+# SPDX-License-Identifier: GPL-2.0-or-later
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/hackbench/hackbench.8 b/src/hackbench/hackbench.8
index 4c2c8ad9cb1a..1f3ecd51cc07 100644
--- a/src/hackbench/hackbench.8
+++ b/src/hackbench/hackbench.8
@@ -1,4 +1,5 @@
 .TH "hackbench" "8" "September  19, 2020" "" ""
+# SPDX-License-Identifier: GPL-2.0-or-later
 .SH "NAME"
 hackbench \- scheduler benchmark/stress test
 .SH "SYNOPSIS"
diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index 21d0fe4aaca2..560ff7cc0cc9 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH HWLATDETECT 8 "May  12, 2009"
+# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
index eb96448bfff1..fba10ab4944d 100644
--- a/src/oslat/oslat.8
+++ b/src/oslat/oslat.8
@@ -1,4 +1,5 @@
 .TH OSLAT 8 "August 17, 2020"
+# SPDX-License-Identifier: GPL-3.0-only
 .\" for manpage-specific macros, see man(7)
 .SH NAME
 oslat \- OS Latency Detector
diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index 8c43a1ccf676..6ae28c178d75 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -4,6 +4,7 @@
 .\"{{{}}}
 .\"{{{  Title
 .TH pi_stress 8 "Nov 27, 2006" "" "Linux System Administrator's Manual"
+# SPDX-License-Identifier: GPL-2.0-or-later
 .\"}}}
 .\"{{{ Name
 .SH NAME
diff --git a/src/pi_tests/pip_stress.8 b/src/pi_tests/pip_stress.8
index 1808330b2e17..0d06dd2215f8 100644
--- a/src/pi_tests/pip_stress.8
+++ b/src/pi_tests/pip_stress.8
@@ -1,5 +1,6 @@
 .\"
 .TH PIP\ STRESS 8 "September 17, 2018"
+# SPDX-License-Identifier: GPL-2.0-or-later
 .SH NAME
 .B pip_stress \- Priority Inheritance with processes
 .SH SYNOPSIS
diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 4fbcc5c27ce2..cce43d9b5ee5 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -1,4 +1,5 @@
 .TH "pmqtest" "8" "0.1" "" ""
+# SPDX-License-Identifier: GPL-2.0-or-later
 .SH "NAME"
 .LP
 \fBpmqtest\fR \- Start pairs of threads and measure the latency of interpr=
ocess communication with POSIX messages queues
diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 57e1658612c0..5e944d353ec0 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -1,4 +1,5 @@
 .TH "ptsematest" "8" "0.1" "" ""
+# SPDX-License-Identifier: GPL-2.0-or-later
 .SH "NAME"
 .LP
 \fBptsematest\fR \- Start two threads and measure the latency of interproc=
ess communication with POSIX mutex.
diff --git a/src/queuelat/determine_maximum_mpps.8 b/src/queuelat/determine=
_maximum_mpps.8
index c48a651160d3..ba2cc2ad9c2a 100644
--- a/src/queuelat/determine_maximum_mpps.8
+++ b/src/queuelat/determine_maximum_mpps.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH DETERMINE_MAXIMUM_MPPS 8 "Dec 4, 2020"
+# SPDX-License-Identifier: GPL-2.0-or-later
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/queuelat/queuelat.8 b/src/queuelat/queuelat.8
index 2f99e703c990..aa497e93f738 100644
--- a/src/queuelat/queuelat.8
+++ b/src/queuelat/queuelat.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH QUEUELAT 8 "Sept 3, 2018"
+# SPDX-License-Identifier: GPL-2.0-or-later
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/queuelat/targeted-ipi/Kbuild b/src/queuelat/targeted-ipi/K=
build
index 9bdd5c63a00a..6d569c38aab8 100644
--- a/src/queuelat/targeted-ipi/Kbuild
+++ b/src/queuelat/targeted-ipi/Kbuild
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 obj-m :=3D targeted-ipi.o
=20
diff --git a/src/queuelat/targeted-ipi/Makefile b/src/queuelat/targeted-ipi=
/Makefile
index ee5591fe45c0..9dabd7c22fe0 100644
--- a/src/queuelat/targeted-ipi/Makefile
+++ b/src/queuelat/targeted-ipi/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 obj-$(CONFIG_TARGETED_IPI) +=3D targeted-ipi.o
diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt=
-migrate-test.8
index 53670e3757fa..88daec50138c 100644
--- a/src/rt-migrate-test/rt-migrate-test.8
+++ b/src/rt-migrate-test/rt-migrate-test.8
@@ -1,5 +1,6 @@
 .\"
 .TH RT-MIGRATE-TEST 8 "September 18, 2020"
+# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever editing this manpage
 .SH NAME
 rt-migrate-test \- real-time task migration program
diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cycli=
cdeadline.8
index fab301edc86a..bfc6327c51da 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH CYCLICDEADLINE 8 "January 16, 2020"
+# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/sched_deadline/deadline_test.8 b/src/sched_deadline/deadli=
ne_test.8
index 8f32c5b6feb6..0d7932250e23 100644
--- a/src/sched_deadline/deadline_test.8
+++ b/src/sched_deadline/deadline_test.8
@@ -1,5 +1,6 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH DEADLINE_TEST 8 "November 1, 2018"
+# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
index da818ecdef67..a8c9a6e91c68 100644
--- a/src/signaltest/signaltest.8
+++ b/src/signaltest/signaltest.8
@@ -1,5 +1,6 @@
 .\"
 .TH SIGNALTEST 8 "November 15, 2020"
+# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever updating this manpage
 .SH NAME
 signaltest \- signal roundtrip test software
diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
index 26ad333e2841..f0ecbb6448b1 100644
--- a/src/sigwaittest/sigwaittest.8
+++ b/src/sigwaittest/sigwaittest.8
@@ -1,4 +1,5 @@
 .TH "sigwaittest" "8" "0.1" "" ""
+# SPDX-License-Identifier: GPL-2.0-only
 .SH "NAME"
 .LP
 \fBsigwaittest\fR \- Start two threads or fork two processes and measure t=
he latency between sending and receiving a signal
diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
index a3b9d790dec4..e6be5ef6a27d 100644
--- a/src/ssdd/ssdd.8
+++ b/src/ssdd/ssdd.8
@@ -1,4 +1,5 @@
 .TH SSDD 8 "September 19, 2020"
+# SPDX-License-Identifier: GPL-2.0-or-later
 .SH NAME
 ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
 .SH SYNOPSIS
diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
index 93abf55f3d4d..7865ed0550e9 100644
--- a/src/svsematest/svsematest.8
+++ b/src/svsematest/svsematest.8
@@ -1,4 +1,5 @@
 .TH "svsematest" "8" "0.1" "" ""
+# SPDX-License-Identifier: GPL-2.0-or-later
 .SH "NAME"
 .LP
 \fBsvsematest\fR \- Start two threads or fork two processes and measure th=
e latency of SYSV semaphores
--=20
2.41.0

