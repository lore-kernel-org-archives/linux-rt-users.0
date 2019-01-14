From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Makefile: ssdd: Incoroporate ssdd into the rt-tests Makefile
Date: Mon, 14 Jan 2019 21:43:58 +0100
Message-ID: <20190114204358.15550-1-jkacur@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "julia @ ni . com" <julia@ni.com>,
        "tglx @ linutronix . de" <tglx@linutronix.de>,
        "oleg @ redhat . com" <oleg@redhat.com>,
        "linux-rt-users @ vger . kernel . org"
        <linux-rt-users@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
To: Joe Korty <Joe.Korty@concurrent-rt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Incoroporate ssdd into the rt-tests build

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 06f399cc629d..16cd2f9bdd03 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,8 @@ sources = cyclictest.c \
 	  svsematest.c  \
 	  cyclicdeadline.c \
 	  deadline_test.c \
-	  queuelat.c 
+	  queuelat.c \
+	  ssdd.c
 
 TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
@@ -86,6 +87,7 @@ VPATH	+= src/lib:
 VPATH	+= src/hackbench:
 VPATH	+= src/sched_deadline:
 VPATH	+= src/queuelat:	
+VPATH	+= src/ssdd:
 
 $(OBJDIR)/%.o: %.c | $(OBJDIR)
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
@@ -146,6 +148,9 @@ hackbench: $(OBJDIR)/hackbench.o
 queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
+ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
+
 LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
-- 
2.20.1
