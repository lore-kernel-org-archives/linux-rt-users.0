From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rt-tests: Add cyclicdeadline and deadline_test to the Make system
Date: Thu, 23 Jun 2016 14:11:51 +0200
Message-ID: <1466683911-10994-4-git-send-email-jkacur@redhat.com>
References: <1466683911-10994-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466683911-10994-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

- Add cyclicdeadline and deadline_test to the Makefile
- Conditionally define _GNU_SOURCE in the new programs
- Add the new programs to the .gitignore file

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore                          |  2 ++
 Makefile                            | 11 ++++++++++-
 src/sched_deadline/cyclicdeadline.c |  2 ++
 src/sched_deadline/deadline_test.c  |  2 ++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index ceee8bfb6e9a..b8884d547940 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,8 @@ SRPMS
 /pip_stress
 /hackbench
 /pmqtest
+/cyclicdeadline
+/deadline_test
 
 rt-tests.spec
 tags
diff --git a/Makefile b/Makefile
index d60282e05931..8c0294d197e4 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,9 @@ sources = cyclictest.c \
 	  sendme.c \
 	  signaltest.c \
 	  sigwaittest.c \
-	  svsematest.c
+	  svsematest.c  \
+	  cyclicdeadline.c \
+	  deadline_test.c
 
 TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
@@ -83,6 +85,7 @@ VPATH	+= src/pmqtest:
 VPATH	+= src/backfire:
 VPATH	+= src/lib:
 VPATH	+= src/hackbench:
+VPATH	+= src/sched_deadline:
 
 $(OBJDIR)/%.o: %.c | $(OBJDIR)
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
@@ -103,6 +106,12 @@ $(OBJDIR):
 cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
 
+cyclicdeadline: $(OBJDIR)/cyclicdeadline.o $(OBJDIR)/librttest.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
+
+deadline_test: $(OBJDIR)/deadline_test.o $(OBJDIR)/librttest.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
+
 signaltest: $(OBJDIR)/signaltest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 9c50456f7419..f530488545e0 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1,4 +1,6 @@
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <pthread.h>
 #include <stdarg.h>
 #include <stdlib.h>
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 8a813c494520..2794730febc4 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -29,7 +29,9 @@
  *    Look for "simple_test"
  *
  */
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <pthread.h>
 #include <stdarg.h>
 #include <stdlib.h>
-- 
2.4.11
