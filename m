From: <jackie.huang@windriver.com>
Subject: [PATCH RT-TESTS] rt-tests Makefile: Added missing dependencies
Date: Thu, 6 Dec 2012 18:10:56 +0800
Message-ID: <1354788656-26552-1-git-send-email-jackie.huang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <Jackie.Huang@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44445 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab2LFKK7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Dec 2012 05:10:59 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qB6AAwhF027148
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Thu, 6 Dec 2012 02:10:59 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Jackie Huang <jackie.huang@windriver.com>

Hi,

When I make with -j 4 option, I got the following error sometimes:

cc -Wall -Wno-nonnull -O2 -DNUMA  -o pi_stress pi_stress.o -lrt -lpthread -lrttest -L.
cc -Wall -Wno-nonnull -O2 -DNUMA  -o rt-migrate-test rt-migrate-test.o -lrt -lpthread -lrttest -L.
cc -Wall -Wno-nonnull -O2 -DNUMA  -o hackbench hackbench.o -lrt -lpthread -lrttest -L.
//usrusr/bin/ld: cannot find /-bin/ldlrttest:
 cannot find -collect2: lrttest
collect2: ld returned 1 exit status
ld returned 1 exit status
/usr/bin/ld: cannot find -lrttest
collect2: ld returned 1 exit status

which indecates that the following targets missed dependency on librttest.a:
pi_stress
rt-migrate-test
hackbench

so this patch add these missing dependencies.

Signed-off-by: Jackie Huang <jackie.huang@windriver.com>
---
 Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index fd3cdb3..60707a7 100644
--- a/Makefile
+++ b/Makefile
@@ -68,14 +68,14 @@ cyclictest: cyclictest.o librttest.a
 signaltest: signaltest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
-pi_stress: pi_stress.o
+pi_stress: pi_stress.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
-rt-migrate-test: rt-migrate-test.o
+rt-migrate-test: rt-migrate-test.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 ptsematest: ptsematest.o librttest.a
@@ -96,7 +96,7 @@ sendme: sendme.o librttest.a
 pip_stress: pip_stress.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
-hackbench: hackbench.o
+hackbench: hackbench.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 librttest.a: rt-utils.o error.o rt-get_cpu.o
-- 
1.7.9.5

