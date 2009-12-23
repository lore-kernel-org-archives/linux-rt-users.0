From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/5] rt-tests: pip - Use check_privs() from the rt-utils library.
Date: Wed, 23 Dec 2009 17:02:59 +0100
Message-ID: <1261584180-13922-5-git-send-email-jkacur@redhat.com>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
 <1261584180-13922-2-git-send-email-jkacur@redhat.com>
 <1261584180-13922-3-git-send-email-jkacur@redhat.com>
 <1261584180-13922-4-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:4950 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbZLWQDN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 11:03:13 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3180927fgg.1
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 08:03:12 -0800 (PST)
In-Reply-To: <1261584180-13922-4-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Use check_privs() from the rt-utils library to make sure that the user is
running with real-time privileges for the pip test program.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile           |    2 +-
 src/include/pip.h  |    1 +
 src/pi_tests/pip.c |    3 +++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b30a139..3339556 100644
--- a/Makefile
+++ b/Makefile
@@ -63,7 +63,7 @@ svsematest: svsematest.o rt-utils.o rt-get_cpu.o
 sendme: sendme.o rt-utils.o rt-get_cpu.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-pip: pip.o error.o
+pip: pip.o error.o rt-utils.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
diff --git a/src/include/pip.h b/src/include/pip.h
index 01a31c3..b2068be 100644
--- a/src/include/pip.h
+++ b/src/include/pip.h
@@ -13,6 +13,7 @@
 #include <sys/wait.h>
 #include <signal.h>
 #include <sched.h>
+#include <rt-utils.h>
 #include "error.h"
 
 void low(pid_t pid);	/* low priority process */
diff --git a/src/pi_tests/pip.c b/src/pi_tests/pip.c
index ce3f5d9..085908b 100644
--- a/src/pi_tests/pip.c
+++ b/src/pi_tests/pip.c
@@ -83,6 +83,9 @@ int main(void)
 
 	*minimum_priority = sched_get_priority_min(policy);
 
+	if (check_privs())
+		exit(-1);
+
 	mptr = mmap_page();	/* Get a page of shared memory */
 	resource = (pthread_mutex_t*)mptr;	/* point our lock to it */
 	mptr += sizeof(pthread_mutex_t);	/* advance the memory pointer */
-- 
1.6.5.2

