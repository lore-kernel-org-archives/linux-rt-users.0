From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/7] Add the following new tests - ptsematest - sigwaittest - svsematest - sendme
Date: Mon, 14 Dec 2009 16:58:53 +0100
Message-ID: <1260806336-4691-5-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
 <1260806336-4691-2-git-send-email-jkacur@redhat.com>
 <1260806336-4691-3-git-send-email-jkacur@redhat.com>
 <1260806336-4691-4-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <carsten.emde@osadl.org>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:17516 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558AbZLNP71 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:27 -0500
Received: by gv-out-0910.google.com with SMTP id r4so33107gve.37
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:25 -0800 (PST)
In-Reply-To: <1260806336-4691-4-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Carsten Emde <carsten.emde@osadl.org>

Signed-off-by: Carsten Emde <carsten.emde@osadl.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                      |   35 ++-
 src/backfire/Makefile         |   14 +
 src/backfire/backfire.4       |   36 ++
 src/backfire/backfire.c       |  150 +++++++++
 src/backfire/sendme.8         |   42 +++
 src/backfire/sendme.c         |  291 +++++++++++++++++
 src/backfire/version.h        |    1 +
 src/ptsematest/Makefile       |   16 +
 src/ptsematest/ptsematest.8   |   54 ++++
 src/ptsematest/ptsematest.c   |  439 +++++++++++++++++++++++++
 src/sigwaittest/Makefile      |   17 +
 src/sigwaittest/sigwaittest.8 |   57 ++++
 src/sigwaittest/sigwaittest.c |  634 +++++++++++++++++++++++++++++++++++++
 src/svsematest/Makefile       |   16 +
 src/svsematest/svsematest.8   |   57 ++++
 src/svsematest/svsematest.c   |  704 +++++++++++++++++++++++++++++++++++++++++
 16 files changed, 2557 insertions(+), 6 deletions(-)
 create mode 100644 src/backfire/Makefile
 create mode 100644 src/backfire/backfire.4
 create mode 100644 src/backfire/backfire.c
 create mode 100644 src/backfire/sendme.8
 create mode 100644 src/backfire/sendme.c
 create mode 100644 src/backfire/version.h
 create mode 100644 src/ptsematest/Makefile
 create mode 100644 src/ptsematest/ptsematest.8
 create mode 100644 src/ptsematest/ptsematest.c
 create mode 100644 src/sigwaittest/Makefile
 create mode 100644 src/sigwaittest/sigwaittest.8
 create mode 100644 src/sigwaittest/sigwaittest.c
 create mode 100644 src/svsematest/Makefile
 create mode 100644 src/svsematest/svsematest.8
 create mode 100644 src/svsematest/svsematest.c

diff --git a/Makefile b/Makefile
index 2507a1f..3a85336 100644
--- a/Makefile
+++ b/Makefile
@@ -1,12 +1,14 @@
 VERSION_STRING = 0.56
 
 TARGETS	= cyclictest signaltest classic_pi pi_stress \
-	  hwlatdetect rt-migrate-test
+	  hwlatdetect rt-migrate-test ptsematest sigwaittest svsematest \
+	  sendme
 LIBS 	= -lpthread -lrt
 DESTDIR	?=
 prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
-mandir	?= $(prefix)/share/man/man8
+mandir	?= $(prefix)/share/man
+srcdir	?= $(prefix)/src
 
 CFLAGS = -Wall -Wno-nonnull -Isrc/lib
 ifndef DEBUG
@@ -39,6 +41,18 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 rt-migrate-test: src/rt-migrate-test/rt-migrate-test.c
 	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
 
+ptsematest: src/ptsematest/ptsematest.c $(UTILS)
+	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+
+sigwaittest: src/sigwaittest/sigwaittest.c $(UTILS)
+	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+
+svsematest: src/svsematest/svsematest.c $(UTILS)
+	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+
+sendme: src/backfire/sendme.c $(UTILS)
+	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
@@ -57,11 +71,20 @@ changelog:
 
 .PHONY: all
 install: all
-	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)"
+	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
+	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
-	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/cyclictest.8.gz"
-	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/pi_stress.8.gz"
-	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/hwlatdetect.8.gz"
+	mkdir -p "$(DESTDIR)$(srcdir)/backfire"
+	sed s/__VERSION_STRING__/$(VERSION_STRING)/ <src/backfire/backfire.c >"$(DESTDIR)$(srcdir)/backfire/backfire.c"
+	cp src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire"
+	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz
+	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
+	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
+	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz"
+	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
+	gzip src/sigwaittest/sigwaittest.8 -c >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
+	gzip src/svsematest/svsematest.8 -c >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
+	gzip src/backfire/sendme.8 -c >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
 
 .PHONY: release
 release: clean changelog
diff --git a/src/backfire/Makefile b/src/backfire/Makefile
new file mode 100644
index 0000000..33a0e02
--- /dev/null
+++ b/src/backfire/Makefile
@@ -0,0 +1,14 @@
+obj-m := backfire.o
+
+all:	modules modules_install
+	@echo Done
+
+modules:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
+
+modules_install:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules_install
+
+clean:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
+	@rm -f *.o Module.markers modules.order
diff --git a/src/backfire/backfire.4 b/src/backfire/backfire.4
new file mode 100644
index 0000000..66dccd1
--- /dev/null
+++ b/src/backfire/backfire.4
@@ -0,0 +1,36 @@
+.TH "backfire" "4" "0.1" "" "Driver"
+.SH "NAME"
+.LP
+backfire \- send a signal from driver to user
+.SH "DESCRIPTION"
+.LP
+The \fBbackfire\fR driver reads a numerical string that is sent to the
+\fB/dev/backfire\fR device and sends the corresponding signal to the calling
+user program. Reading from \fB/dev/backfire\fR returns the time of the day
+when the most recent sent request was serviced or 0, if a sent request was
+not yet received. The time of the day is displayed in seconds since
+1970-01-01 00:00:00 UTC followed by the fraction of the second in
+microseconds separated by a comma.
+.SH "PURPOSE"
+.LP
+The \fBbackfire\fR driver is normally used in combination with the program
+\fBsendme\fR to benchmark the performance of the kernel's signal sending
+capabilities.
+.SH "EXAMPLES"
+.LP
+.nf
+head -1 /dev/backfire
+0,0
+trap "echo Got signal 7" 7
+echo 7 >/dev/backfire
+Got signal 7
+head -1 /dev/backfire
+1234567890,123456
+.fi
+.LP
+.SH "AUTHORS"
+.LP
+Carsten Emde <C.Emde@osadl.org>
+.SH "SEE ALSO"
+.LP
+sendme(8)
diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
new file mode 100644
index 0000000..699031a
--- /dev/null
+++ b/src/backfire/backfire.c
@@ -0,0 +1,150 @@
+/*
+ * backfire - send signal back to caller
+ *
+ * Copyright (C) 2007  Carsten Emde <C.Emde@osadl.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
+ * USA.
+ */
+
+#include <linux/module.h>
+
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/time.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define BACKFIRE_MINOR MISC_DYNAMIC_MINOR
+
+static spinlock_t backfire_state_lock = SPIN_LOCK_UNLOCKED;
+static int backfire_open_cnt; /* #times opened */
+static int backfire_open_mode; /* special open modes */
+static struct timeval sendtime; /* when the most recent signal was sent */
+#define BACKFIRE_WRITE 1 /* opened for writing (exclusive) */
+#define BACKFIRE_EXCL 2 /* opened with O_EXCL */
+
+/*
+ * These are the file operation function for user access to /dev/backfire
+ */
+static ssize_t
+backfire_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	return snprintf(buf, count, "%d,%d\n", (int) sendtime.tv_sec,
+		(int) sendtime.tv_usec);
+}
+
+static ssize_t
+backfire_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	int signo;
+	struct pid *pid;
+
+	if (sscanf(buf, "%d", &signo) >= 1) {
+		if (signo > 0 && signo < 32) {
+			pid = get_pid(task_pid(current));
+			do_gettimeofday(&sendtime);
+			kill_pid(pid, signo, 1);
+		} else
+			printk(KERN_ERR "Invalid signal no. %d\n", signo);
+	}
+	return strlen(buf);
+}
+
+static int
+backfire_open(struct inode *inode, struct file *file)
+{
+	spin_lock(&backfire_state_lock);
+
+	if ((backfire_open_cnt && (file->f_flags & O_EXCL)) ||
+	    (backfire_open_mode & BACKFIRE_EXCL)) {
+		spin_unlock(&backfire_state_lock);
+		return -EBUSY;
+	}
+
+	if (file->f_flags & O_EXCL)
+		backfire_open_mode |= BACKFIRE_EXCL;
+	if (file->f_mode & 2)
+		backfire_open_mode |= BACKFIRE_WRITE;
+	backfire_open_cnt++;
+
+	spin_unlock(&backfire_state_lock);
+
+	return 0;
+}
+
+static int
+backfire_release(struct inode *inode, struct file *file)
+{
+	spin_lock(&backfire_state_lock);
+
+	backfire_open_cnt--;
+
+	if (backfire_open_cnt == 1 && backfire_open_mode & BACKFIRE_EXCL)
+		backfire_open_mode &= ~BACKFIRE_EXCL;
+	if (file->f_mode & 2)
+		backfire_open_mode &= ~BACKFIRE_WRITE;
+
+	spin_unlock(&backfire_state_lock);
+
+	return 0;
+}
+
+static struct file_operations backfire_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= backfire_open,
+	.read		= backfire_read,
+	.write		= backfire_write,
+	.release	= backfire_release,
+};
+
+static struct miscdevice backfire_dev = {
+	BACKFIRE_MINOR,
+	"backfire",
+	&backfire_fops
+};
+
+static int __init backfire_init(void)
+{
+	int ret;
+
+	ret = misc_register(&backfire_dev);
+	if (ret)
+		printk(KERN_ERR "backfire: can't register dynamic misc device\n");
+	else
+		printk(KERN_INFO "backfire driver v__VERSION_STRING__ misc device %d\n",
+			backfire_dev.minor);
+	return ret;
+}
+
+static void __exit backfire_exit(void)
+{
+	misc_deregister(&backfire_dev);
+}
+
+module_init(backfire_init);
+module_exit(backfire_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Carsten Emde <C.Emde@osadl.org>");
+MODULE_DESCRIPTION("Send signal back to caller");
diff --git a/src/backfire/sendme.8 b/src/backfire/sendme.8
new file mode 100644
index 0000000..b9857ab
--- /dev/null
+++ b/src/backfire/sendme.8
@@ -0,0 +1,42 @@
+.TH "sendme" "8" "0.2" "" ""
+.SH "NAME"
+.LP
+\fBsendme\fR \- Send a signal from driver to user and measure time intervals
+.SH "SYNTAX"
+.LP
+sendme [-a|-a PROC] [-b USEC] [-l loops] [-p PRIO]
+.br
+.SH "DESCRIPTION"
+.LP
+The program \fBsendme\fR uses the \fBbackfire\fR driver to send a signal from driver to user. It then reads the timestamp from the driver and calculates the time intervals to call the driver and to receive the signal from the driver.
+.SH "OPTIONS"
+.TP
+.B \-a, \-\-affinity[=PROC]
+Run on procesor number PROC. If PROC is not specified, run on current processor.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
+It is useful to track down unexpected large latencies on a system.
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Sendme is stopped once the number of timer intervals has been reached.
+.TP
+.B \-p, \-\-prio=PRIO
+Set the priority of the process.
+.SH "FILES"
+backfire.ko
+.SH "EXAMPLES"
+.LP
+.nf
+# modprobe backfire
+# sendme -a -p99 -l1000000
+Samples:  1000000
+To:   Min    0, Cur    0, Avg    1, Max   11
+From: Min    2, Cur    3, Avg    3, Max   43
+.fi
+.SH "AUTHORS"
+.LP
+Carsten Emde <C.Emde@osadl.org>
+.SH "SEE ALSO"
+.LP
+backfire(4)
diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
new file mode 100644
index 0000000..190dbf5
--- /dev/null
+++ b/src/backfire/sendme.c
@@ -0,0 +1,291 @@
+/*
+ * sendme.c
+ *
+ * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
+ * USA.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#define __USE_GNU
+#include <fcntl.h>
+#include <getopt.h>
+#include <signal.h>
+#include <sched.h>
+#include <string.h>
+#include <time.h>
+#include "rt-utils.h"
+
+#define _GNU_SOURCE
+#include <utmpx.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+
+#define USEC_PER_SEC		1000000
+#define NSEC_PER_SEC		1000000000
+
+#define SIGTEST SIGHUP
+
+enum {
+	AFFINITY_UNSPECIFIED,
+	AFFINITY_SPECIFIED,
+	AFFINITY_USECURRENT
+};
+static int setaffinity = AFFINITY_UNSPECIFIED;
+
+static int affinity;
+static int tracelimit;
+static int priority;
+static int shutdown;
+static int max_cycles;
+static volatile struct timeval after;
+static int interval = 1000;
+
+static int kernvar(int mode, const char *name, char *value, size_t sizeofvalue)
+{
+	char filename[128];
+	char *fileprefix = get_debugfileprefix();
+	int retval = 1;
+	int path;
+
+	strncpy(filename, fileprefix, sizeof(filename));
+	strncat(filename, name, sizeof(filename) - strlen(fileprefix));
+	path = open(filename, mode);
+	if (path >= 0) {
+		if (mode == O_RDONLY) {
+			int got;
+			if ((got = read(path, value, sizeofvalue)) > 0) {
+				retval = 0;
+				value[got-1] = '\0';
+			}
+		} else if (mode == O_WRONLY) {
+			if (write(path, value, sizeofvalue) == sizeofvalue)
+				retval = 0;
+		}
+		close(path);
+	}
+	return retval;
+}
+
+void signalhandler(int signo)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	after = tv;
+	if (signo == SIGINT || signo == SIGTERM)
+		shutdown = 1;
+}
+
+void stop_tracing(void)
+{
+	kernvar(O_WRONLY, "tracing_enabled", "0", 1);
+}
+
+static void display_help(void)
+{
+	printf("sendme V %1.2f\n", VERSION_STRING);
+	puts("Usage: sendme <options>");
+	puts("Function: send a signal from driver to userspace");
+	puts(
+	"Options:\n"
+	"-a [NUM] --affinity        pin to current processor\n"
+	"                           with NUM pin to processor NUM\n"
+	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-p PRIO  --prio=PRIO       priority\n");
+	exit(1);
+}
+
+static void process_options (int argc, char *argv[])
+{
+	int error = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (;;) {
+		int option_index = 0;
+		/** Options for getopt */
+		static struct option long_options[] = {
+			{"affinity", optional_argument, NULL, 'a'},
+			{"breaktrace", required_argument, NULL, 'b'},
+			{"interval", required_argument, NULL, 'i'},
+			{"loops", required_argument, NULL, 'l'},
+			{"priority", required_argument, NULL, 'p'},
+			{"help", no_argument, NULL, '?'},
+			{NULL, 0, NULL, 0}
+		};
+		int c = getopt_long (argc, argv, "a::b:i:l:p:",
+			long_options, &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'a':
+			if (optarg != NULL) {
+				affinity = atoi(optarg);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind < argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else
+				setaffinity = AFFINITY_USECURRENT;
+			break;
+		case 'b': tracelimit = atoi(optarg); break;
+		case 'i': interval = atoi(optarg); break;
+		case 'l': max_cycles = atoi(optarg); break;
+		case 'p': priority = atoi(optarg); break;
+		case '?': error = 1; break;
+		}
+	}
+
+	if (setaffinity == AFFINITY_SPECIFIED) {
+		if (affinity < 0)
+			error = 1;
+		if (affinity >= max_cpus) {
+			fprintf(stderr, "ERROR: CPU #%d not found, only %d CPUs available\n",
+			    affinity, max_cpus);
+			error = 1;
+		}
+	}
+
+	if (priority < 0 || priority > 99)
+		error = 1;
+
+	if (error)
+		display_help ();
+}
+
+int main(int argc, char *argv[])
+{
+	int path;
+	cpu_set_t mask;
+	int policy = SCHED_FIFO;
+	struct sched_param schedp;
+	struct flock fl;
+	int retval = 0;
+
+	process_options(argc, argv);
+
+	if (check_privs())
+		return 1;
+
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+		perror("mlockall");
+		return 1;
+	}
+
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = priority;
+	sched_setscheduler(0, policy, &schedp);
+
+	if (setaffinity != AFFINITY_UNSPECIFIED) {
+		CPU_ZERO(&mask);
+		if (setaffinity == AFFINITY_USECURRENT)
+			affinity = sched_getcpu();
+		CPU_SET(affinity, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			fprintf(stderr,	"WARNING: Could not set CPU affinity "
+				"to CPU #%d\n", affinity);
+	}
+
+	path = open("/dev/backfire", O_RDWR);
+	if (path < 0) {
+		fprintf(stderr, "ERROR: Could not access backfire device, "
+				"try 'modprobe backfire'\n");
+		return 1;
+	}
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+	if (fcntl(path, F_SETLK, &fl) == -1) {
+		fprintf(stderr, "ERRROR: backfire device locked\n");
+		retval = 1;
+	} else {
+		char sigtest[8];
+		char timestamp[32];
+		struct timeval before, sendtime, diff;
+		unsigned int diffno = 0;
+		unsigned int mindiff1 = UINT_MAX, maxdiff1 = 0;
+		unsigned int mindiff2 = UINT_MAX, maxdiff2 = 0;
+		double sumdiff1 = 0.0, sumdiff2 = 0.0;
+
+		if (tracelimit)
+			kernvar(O_WRONLY, "tracing_enabled", "1", 1);
+
+		sprintf(sigtest, "%d", SIGTEST);
+		signal(SIGTEST, signalhandler);
+		signal(SIGINT, signalhandler);
+		signal(SIGTERM, signalhandler);
+
+		while (1) {
+			struct timespec ts;
+
+			ts.tv_sec = interval / USEC_PER_SEC;
+			ts.tv_nsec = (interval % USEC_PER_SEC) * 1000;
+
+			gettimeofday(&before, NULL);
+			write(path, sigtest, strlen(sigtest));
+			while (after.tv_sec == 0);
+			read(path, timestamp, sizeof(timestamp));
+			if (sscanf(timestamp, "%lu,%lu\n", &sendtime.tv_sec,
+			    &sendtime.tv_usec) != 2)
+				break;
+			diffno++;
+			if(max_cycles && diffno >= max_cycles)
+				shutdown = 1;
+
+			printf("Samples: %8d\n", diffno);
+			timersub(&sendtime, &before, &diff);
+			if (diff.tv_usec < mindiff1)
+				mindiff1 = diff.tv_usec;
+			if (diff.tv_usec > maxdiff1)
+				maxdiff1 = diff.tv_usec;
+			sumdiff1 += (double) diff.tv_usec;
+			printf("To:   Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+				mindiff1, (int) diff.tv_usec,
+				(int) ((sumdiff1 / diffno) + 0.5),
+				maxdiff1);
+
+			timersub(&after, &sendtime, &diff);
+			if (diff.tv_usec < mindiff2)
+				mindiff2 = diff.tv_usec;
+			if (diff.tv_usec > maxdiff2)
+				maxdiff2 = diff.tv_usec;
+			sumdiff2 += (double) diff.tv_usec;
+			printf("From: Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+				mindiff2, (int) diff.tv_usec,
+				(int) ((sumdiff2 / diffno) + 0.5),
+				maxdiff2);
+			after.tv_sec = 0;
+			if ((tracelimit && diff.tv_usec > tracelimit) ||
+			    shutdown) {
+				if (tracelimit)
+					stop_tracing();
+				break;
+			}
+			nanosleep(&ts, NULL);
+			printf("\033[3A");
+		}
+	}
+
+	close(path);
+	return retval;
+}
diff --git a/src/backfire/version.h b/src/backfire/version.h
new file mode 100644
index 0000000..cbe3858
--- /dev/null
+++ b/src/backfire/version.h
@@ -0,0 +1 @@
+#define VERSION "0.5"
diff --git a/src/ptsematest/Makefile b/src/ptsematest/Makefile
new file mode 100644
index 0000000..c0bfa7c
--- /dev/null
+++ b/src/ptsematest/Makefile
@@ -0,0 +1,16 @@
+CFLAGS += -Wall -O2
+LDFLAGS += -lpthread
+
+all:	ptsematest
+	@echo Done
+
+ptsematest.o: ptsematest.c
+
+ptsematest:
+
+clean:
+	@rm -f *.o
+
+tar:	clean
+	@rm -f ptsematest
+	$(shell bn=`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
new file mode 100644
index 0000000..001e809
--- /dev/null
+++ b/src/ptsematest/ptsematest.8
@@ -0,0 +1,54 @@
+.TH "ptsematest" "8" "0.1" "" ""
+.SH "NAME"
+.LP
+\fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
+.SH "SYNTAX"
+.LP
+ptsematest [-a|-a PROC] [-b USEC] [-d DIST] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
+.br
+.SH "DESCRIPTION"
+.LP
+The program \fBptsematest\fR starts two threads that are synchronized via pthread_mutex_unlock()/pthread_mutex_lock() and measures the latency between releasing and getting the lock.
+.SH "OPTIONS"
+.TP
+.B \-a, \-\-affinity[=PROC]
+Run on procesor number PROC. If PROC is not specified, run on current processor.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
+It is useful to track down unexpected large latencies of a system.
+.TP
+.B \-d, \-\-distance=DIST
+Set the distance of thread intervals in microseconds (default is 500 us). When  cylictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
+.TP
+.B \-i, \-\-interval=INTV
+Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. ptsematest is stopped once the number of timer intervals has been reached.
+.TP
+.B \-p, \-\-prio=PRIO
+Set the priority of the process.
+.TP
+.B \-t, \-\-threads[=NUM]
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+.SH "EXAMPLES"
+The following example was running on a 4-way processor:
+.LP
+.nf
+# ptsematest -a -t -p99 -i100 -d25 -l1000000
+#0: ID8672, P99, CPU0, I100; #1: ID8673, P99, CPU0, Cycles 1000000
+#2: ID8674, P98, CPU1, I125; #3: ID8675, P98, CPU1, Cycles 811035
+#4: ID8676, P97, CPU2, I150; #5: ID8677, P97, CPU2, Cycles 668130
+#6: ID8678, P96, CPU3, I175; #7: ID8679, P96, CPU3, Cycles 589423
+#1 -> #0, Min    1, Cur    1, Avg    2, Max   11
+#3 -> #2, Min    1, Cur    2, Avg    2, Max   13
+#5 -> #4, Min    1, Cur    4, Avg    3, Max   12
+#7 -> #6, Min    1, Cur    4, Avg    2, Max   12
+.fi
+.SH "AUTHORS"
+.LP
+Carsten Emde <C.Emde@osadl.org>
+.SH "SEE ALSO"
+.LP
+pthread_mutex_lock(3p), pthread_mutex_unlock(3p)
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
new file mode 100644
index 0000000..e040417
--- /dev/null
+++ b/src/ptsematest/ptsematest.c
@@ -0,0 +1,439 @@
+/*
+ * ptsematest.c
+ *
+ * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
+ * USA.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <signal.h>
+#include <string.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+#include <linux/unistd.h>
+#include "rt-utils.h"
+
+#define __USE_GNU
+#include <pthread.h>
+
+#undef HAS_SCHED_GETCPU
+
+#define gettid() syscall(__NR_gettid)
+#ifndef HAS_SCHED_GETCPU
+#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
+#endif
+
+#define USEC_PER_SEC 1000000
+
+enum {
+	AFFINITY_UNSPECIFIED,
+	AFFINITY_SPECIFIED,
+	AFFINITY_USEALL
+};
+
+static pthread_mutex_t *testmutex;
+static pthread_mutex_t *syncmutex;
+
+struct params {
+	int num;
+	int cpu;
+	int priority;
+	int affinity;
+	int sender;
+	int samples;
+	int max_cycles;
+	int tracelimit;
+	int tid;
+	int shutdown;
+	int stopped;
+	struct timespec delay;
+	unsigned int mindiff, maxdiff;
+	double sumdiff;
+	struct timeval unblocked, received, diff;
+	pthread_t threadid;
+	struct params *neighbor;
+	char error[MAX_PATH * 2];
+};
+
+void *semathread(void *param)
+{
+	int mustgetcpu = 0;
+	int first = 1;
+	struct params *par = param;
+	cpu_set_t mask;
+	int policy = SCHED_FIFO;
+	struct sched_param schedp;
+
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = par->priority;
+	sched_setscheduler(0, policy, &schedp);
+
+	if (par->cpu != -1) {
+		CPU_ZERO(&mask);
+		CPU_SET(par->cpu, &mask);
+		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			fprintf(stderr,	"WARNING: Could not set CPU affinity "
+				"to CPU #%d\n", par->cpu);
+	} else
+		mustgetcpu = 1;
+
+	par->tid = gettid();
+
+	while (!par->shutdown) {
+		if (par->sender) {
+			pthread_mutex_lock(&syncmutex[par->num]);
+
+			/* Release lock: Start of latency measurement ... */
+			gettimeofday(&par->unblocked, NULL);
+			pthread_mutex_unlock(&testmutex[par->num]);
+			par->samples++;
+			if(par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
+				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
+			}
+		} else {
+			/* Receiver */
+			if (!first) {
+				pthread_mutex_lock(&syncmutex[par->num]);
+				first = 1;
+			}
+			pthread_mutex_lock(&testmutex[par->num]);
+
+			/* ... Got the lock: End of latency measurement */
+			gettimeofday(&par->received, NULL);
+			par->samples++;
+			timersub(&par->received, &par->neighbor->unblocked,
+			    &par->diff);
+
+			if (par->diff.tv_usec < par->mindiff)
+				par->mindiff = par->diff.tv_usec;
+			if (par->diff.tv_usec > par->maxdiff)
+				par->maxdiff = par->diff.tv_usec;
+			par->sumdiff += (double) par->diff.tv_usec;
+			if (par->tracelimit && par->maxdiff > par->tracelimit) {
+				char tracing_enabled_file[MAX_PATH];
+
+				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcat(tracing_enabled_file, "tracing_enabled");
+				int tracing_enabled =
+				    open(tracing_enabled_file, O_WRONLY);
+				if (tracing_enabled >= 0) {
+					write(tracing_enabled, "0", 1);
+					close(tracing_enabled);
+				} else
+					snprintf(par->error, sizeof(par->error),
+					    "Could not access %s\n",
+					    tracing_enabled_file);
+				par->shutdown = 1;
+				par->neighbor->shutdown = 1;
+			}
+
+			if (par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
+				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
+		        }
+			nanosleep(&par->delay, NULL);
+			pthread_mutex_unlock(&syncmutex[par->num]);
+		}
+	}
+	par->stopped = 1;
+	return NULL;
+}
+
+
+static void display_help(void)
+{
+	printf("ptsematest V %1.2f\n", VERSION_STRING);
+	puts("Usage: ptsematest <options>");
+	puts("Function: test POSIX threads mutex latency");
+	puts(
+	"Options:\n"
+	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	"                           with NUM pin all threads to the processor NUM\n"
+	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-p PRIO  --prio=PRIO       priority\n"
+	"-t       --threads         one thread per available processor\n"
+	"-t [NUM] --threads=NUM     number of threads:\n"
+	"                           without NUM, threads = max_cpus\n"
+	"                           without -t default = 1\n");
+	exit(1);
+}
+
+
+static int setaffinity = AFFINITY_UNSPECIFIED;
+static int affinity;
+static int tracelimit;
+static int priority;
+static int num_threads = 1;
+static int max_cycles;
+static int interval = 1000;
+static int distance = 500;
+
+static void process_options (int argc, char *argv[])
+{
+	int error = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (;;) {
+		int option_index = 0;
+		/** Options for getopt */
+		static struct option long_options[] = {
+			{"affinity", optional_argument, NULL, 'a'},
+			{"breaktrace", required_argument, NULL, 'b'},
+			{"distance", required_argument, NULL, 'd'},
+			{"interval", required_argument, NULL, 'i'},
+			{"loops", required_argument, NULL, 'l'},
+			{"priority", required_argument, NULL, 'p'},
+			{"threads", optional_argument, NULL, 't'},
+			{"help", no_argument, NULL, '?'},
+			{NULL, 0, NULL, 0}
+		};
+		int c = getopt_long (argc, argv, "a::b:d:i:l:p:t::",
+			long_options, &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'a':
+			if (optarg != NULL) {
+				affinity = atoi(optarg);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind<argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
+				setaffinity = AFFINITY_USEALL;
+			}
+			break;
+		case 'b': tracelimit = atoi(optarg); break;
+		case 'd': distance = atoi(optarg); break;
+		case 'i': interval = atoi(optarg); break;
+		case 'l': max_cycles = atoi(optarg); break;
+		case 'p': priority = atoi(optarg); break;
+		case 't':
+			if (optarg != NULL)
+				num_threads = atoi(optarg);
+			else if (optind<argc && atoi(argv[optind]))
+				num_threads = atoi(argv[optind]);
+			else
+				num_threads = max_cpus;
+			break;
+		case '?': error = 1; break;
+		}
+	}
+
+	if (setaffinity == AFFINITY_SPECIFIED) {
+		if (affinity < 0)
+			error = 1;
+		if (affinity >= max_cpus) {
+			fprintf(stderr, "ERROR: CPU #%d not found, only %d CPUs available\n",
+			    affinity, max_cpus);
+			error = 1;
+		}
+	}
+
+	if (num_threads < 0 || num_threads > 255)
+		error = 1;
+
+	if (priority < 0 || priority > 99)
+		error = 1;
+
+	if (num_threads < 1)
+		error = 1;
+
+	if (error)
+		display_help ();
+}
+
+
+static int volatile shutdown;
+
+static void sighand(int sig)
+{
+	shutdown = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int oldsamples = 1;
+	struct params *receiver = NULL;
+	struct params *sender = NULL;
+	sigset_t sigset;
+	struct timespec maindelay;
+
+	process_options(argc, argv);
+
+	if (check_privs())
+		return 1;
+
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+		perror("mlockall");
+		return 1;
+	}
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+
+	receiver = calloc(num_threads, sizeof(struct params));
+	sender = calloc(num_threads, sizeof(struct params));
+	if (receiver == NULL || sender == NULL)
+		goto nomem;
+
+	testmutex = (pthread_mutex_t *) calloc(num_threads, sizeof(pthread_mutex_t));
+	syncmutex = (pthread_mutex_t *) calloc(num_threads, sizeof(pthread_mutex_t));
+	if (testmutex == NULL || syncmutex == NULL)
+		goto nomem;
+
+	for (i = 0; i < num_threads; i++) {
+		receiver[i].mindiff = UINT_MAX;
+		receiver[i].maxdiff = 0;
+		receiver[i].sumdiff = 0.0;
+
+
+		pthread_mutex_init(&testmutex[i], NULL);
+		pthread_mutex_init(&syncmutex[i], NULL);
+
+		/* Wait on first attempt */
+		pthread_mutex_lock(&testmutex[i]);
+
+		receiver[i].num = i;
+		receiver[i].cpu = i;
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: receiver[i].cpu = -1; break;
+		case AFFINITY_SPECIFIED: receiver[i].cpu = affinity; break;
+		case AFFINITY_USEALL: receiver[i].cpu = i % max_cpus; break;
+		}
+		receiver[i].priority = priority;
+		receiver[i].tracelimit = tracelimit;
+		if (priority > 0)
+			priority--;
+		receiver[i].delay.tv_sec = interval / USEC_PER_SEC;
+		receiver[i].delay.tv_nsec = (interval % USEC_PER_SEC) * 1000;
+		interval += distance;
+		receiver[i].max_cycles = max_cycles;
+		receiver[i].sender = 0;
+		receiver[i].neighbor = &sender[i];
+		pthread_create(&receiver[i].threadid, NULL, semathread, &receiver[i]);
+		memcpy(&sender[i], &receiver[i], sizeof(receiver[0]));
+		sender[i].sender = 1;
+		sender[i].neighbor = &receiver[i];
+		pthread_create(&sender[i].threadid, NULL, semathread, &sender[i]);
+	}
+
+	maindelay.tv_sec = 0;
+	maindelay.tv_nsec = 50000000; /* 50 ms */
+
+	while (!shutdown) {
+		int printed;
+		int errorlines = 0;
+
+		for (i = 0; i < num_threads; i++)
+			shutdown |= receiver[i].shutdown | sender[i].shutdown;
+
+		if (receiver[0].samples > oldsamples || shutdown) {
+			for (i = 0; i < num_threads; i++) {
+				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
+				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
+				    receiver[i].delay.tv_nsec / 1000,
+				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
+				    sender[i].samples);
+			}
+			for (i = 0; i < num_threads; i++) {
+				printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+					i*2+1, i*2,
+					receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
+					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
+					receiver[i].maxdiff);
+				if (receiver[i].error[0] != '\0') {
+					printf(receiver[i].error);
+					errorlines++;
+					receiver[i].error[0] = '\0';
+				}
+				if (sender[i].error[0] != '\0') {
+					printf(sender[i].error);
+					errorlines++;
+					receiver[i].error[0] = '\0';
+				}
+			}
+			printed = 1;
+		} else
+			printed = 0;
+
+		sigemptyset(&sigset);
+		sigaddset(&sigset, SIGTERM);
+		sigaddset(&sigset, SIGINT);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		nanosleep(&maindelay, NULL);
+
+		sigemptyset(&sigset);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		if (printed && !shutdown)
+			printf("\033[%dA", num_threads*2 + errorlines);
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		receiver[i].shutdown = 1;
+		sender[i].shutdown = 1;
+		pthread_mutex_unlock(&testmutex[i]);
+		pthread_mutex_unlock(&syncmutex[i]);
+	}
+	nanosleep(&receiver[0].delay, NULL);
+
+	for (i = 0; i < num_threads; i++) {
+		if (!receiver[i].stopped)
+			pthread_kill(receiver[i].threadid, SIGTERM);
+		if (!sender[i].stopped)
+			pthread_kill(sender[i].threadid, SIGTERM);
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		pthread_mutex_destroy(&testmutex[i]);
+		pthread_mutex_destroy(&syncmutex[i]);
+	}
+
+ 	nomem:
+
+	return 0;
+}
diff --git a/src/sigwaittest/Makefile b/src/sigwaittest/Makefile
new file mode 100644
index 0000000..521daeb
--- /dev/null
+++ b/src/sigwaittest/Makefile
@@ -0,0 +1,17 @@
+CFLAGS += -Wall -O2
+LDFLAGS += -lpthread -lrt
+
+all:	sigwaittest
+	@echo Done
+
+sigwaittest.o: sigwaittest.c
+
+sigwaittest:
+
+clean:
+	@rm -f *.o
+
+tar:	clean
+	@rm -f sigwaittest
+	$(shell bn=`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
+
diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
new file mode 100644
index 0000000..89a97f1
--- /dev/null
+++ b/src/sigwaittest/sigwaittest.8
@@ -0,0 +1,57 @@
+.TH "sigwaittest" "8" "0.1" "" ""
+.SH "NAME"
+.LP
+\fBsigwaittest\fR \- Start two threads or fork two processes and measure the latency between sending and receiving a signal
+.SH "SYNTAX"
+.LP
+sigwaittest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
+.br
+.SH "DESCRIPTION"
+.LP
+The program \fBsigwaittest\fR starts two threads or, optionally, forks two processes that are synchonized via signals and measures the latency between sending a signal and returning from sigwait().
+.SH "OPTIONS"
+.TP
+.B \-a, \-\-affinity[=PROC]
+Run on procesor number PROC. If PROC is not specified, run on current processor.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
+It is useful to track down unexpected large latencies of a system.
+.TP
+.B \-d, \-\-distance=DIST
+Set the distance of thread intervals in microseconds (default is 500 us). When  cylictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
+.TP
+.B \-f, \-\-fork
+Instead of creating threads (which is the default), fork new processes
+.TP
+.B \-i, \-\-interval=INTV
+Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. sigwaittest is stopped once the number of timer intervals has been reached.
+.TP
+.B \-p, \-\-prio=PRIO
+Set the priority of the process.
+.TP
+.B \-t, \-\-threads[=NUM]
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+.SH "EXAMPLES"
+The following example was running on a 4-way CPU:
+.LP
+.nf
+# sigwaittest -a -t -p99 -i100 -d25 -l1000000
+#0: ID11510, P99, CPU0, I100; #1: ID11511, P99, CPU0, Cycles 1000000
+#2: ID11512, P98, CPU1, I125; #3: ID11513, P98, CPU1, Cycles 817484
+#4: ID11514, P97, CPU2, I150; #5: ID11515, P97, CPU2, Cycles 668213
+#6: ID11516, P96, CPU3, I175; #7: ID11517, P96, CPU3, Cycles 597344
+#1 -> #0, Min    1, Cur    2, Avg    3, Max   30
+#3 -> #2, Min    1, Cur   26, Avg    3, Max   42
+#5 -> #4, Min    1, Cur   46, Avg    4, Max   67
+#7 -> #6, Min    1, Cur    2, Avg    3, Max   74
+.fi
+.SH "AUTHORS"
+.LP
+Carsten Emde <C.Emde@osadl.org>
+.SH "SEE ALSO"
+.LP
+kill(2), sigwait(3)
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
new file mode 100644
index 0000000..a3bbebc
--- /dev/null
+++ b/src/sigwaittest/sigwaittest.c
@@ -0,0 +1,634 @@
+/*
+ * sigwaittest.c
+ *
+ * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
+ * USA.
+ */
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <limits.h>
+#include <getopt.h>
+#include <signal.h>
+#include <string.h>
+#include <time.h>
+#include <utmpx.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <linux/unistd.h>
+#include "rt-utils.h"
+
+#define __USE_GNU
+#include <pthread.h>
+
+#undef HAS_SCHED_GETCPU
+
+#define gettid() syscall(__NR_gettid)
+#ifndef HAS_SCHED_GETCPU
+#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
+#endif
+
+#define USEC_PER_SEC 1000000
+
+enum {
+	AFFINITY_UNSPECIFIED,
+	AFFINITY_SPECIFIED,
+	AFFINITY_USEALL
+};
+
+struct params {
+	int num;
+	int num_threads;
+	int cpu;
+	int priority;
+	int affinity;
+	int sender;
+	int samples;
+	int max_cycles;
+	int tracelimit;
+	int tid;
+	pid_t pid;
+	int shutdown;
+	int stopped;
+	struct timespec delay;
+	unsigned int mindiff, maxdiff;
+	double sumdiff;
+	struct timeval unblocked, received, diff;
+	pthread_t threadid;
+	struct params *neighbor;
+	char error[MAX_PATH * 2];
+};
+
+static int mustfork;
+static int wasforked;
+static int wasforked_sender = -1;
+static int wasforked_threadno = -1;
+static int tracelimit;
+
+void *semathread(void *param)
+{
+	int mustgetcpu = 0;
+	struct params *par = param;
+	cpu_set_t mask;
+	int policy = SCHED_FIFO;
+	struct sched_param schedp;
+
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = par->priority;
+	sched_setscheduler(0, policy, &schedp);
+
+	if (par->cpu != -1) {
+		CPU_ZERO(&mask);
+		CPU_SET(par->cpu, &mask);
+		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			fprintf(stderr,	"WARNING: Could not set CPU affinity "
+				"to CPU #%d\n", par->cpu);
+	} else {
+        	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+        	if (max_cpus > 1)
+		        mustgetcpu = 1;
+	        else
+			par->cpu = 0;
+	}
+
+	if (!wasforked)
+		par->tid = gettid();
+
+	while (!par->shutdown) {
+		int sig;
+		int first = 1;
+		sigset_t sigset;
+		struct params *neighbor = NULL;
+
+		if (par->sender) {
+			if (wasforked)
+				neighbor = par - par->num_threads;
+			else
+				neighbor = par->neighbor;
+			if (first) {
+				sigemptyset(&sigset);
+				sigaddset(&sigset, SIGUSR1);
+				pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+				first = 0;
+			}
+
+			/* Sending signal: Start of latency measurement ... */
+			gettimeofday(&par->unblocked, NULL);
+			if (wasforked)
+				kill(neighbor->pid, SIGUSR2);
+			else
+				pthread_kill(neighbor->threadid, SIGUSR2);
+			par->samples++;
+			if(par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+
+			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
+				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
+			}
+			sigwait(&sigset, &sig);
+		} else {
+			/* Receiver */
+			if (wasforked)
+				neighbor = par + par->num_threads;
+			else
+				neighbor = par->neighbor;
+			if (first) {
+				sigemptyset(&sigset);
+				sigaddset(&sigset, SIGUSR2);
+				pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+				first = 0;
+			}
+			sigwait(&sigset, &sig);
+
+			/* ... Signal received: End of latency measurement */
+			gettimeofday(&par->received, NULL);
+			par->samples++;
+			if (par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+
+			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
+				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
+		        }
+			/*
+			 * Latency is the time spent between sending and
+			 * receiving the signal.
+			 */
+			timersub(&par->received, &neighbor->unblocked,
+			    &par->diff);
+
+			if (par->diff.tv_usec < par->mindiff)
+				par->mindiff = par->diff.tv_usec;
+			if (par->diff.tv_usec > par->maxdiff)
+				par->maxdiff = par->diff.tv_usec;
+			par->sumdiff += (double) par->diff.tv_usec;
+			if (par->tracelimit && par->maxdiff > par->tracelimit) {
+				char tracing_enabled_file[MAX_PATH];
+
+				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcat(tracing_enabled_file, "tracing_enabled");
+				int tracing_enabled =
+				    open(tracing_enabled_file, O_WRONLY);
+				if (tracing_enabled >= 0) {
+					write(tracing_enabled, "0", 1);
+					close(tracing_enabled);
+				} else
+					snprintf(par->error, sizeof(par->error),
+					    "Could not access %s\n",
+					    tracing_enabled_file);
+				par->shutdown = 1;
+				neighbor->shutdown = 1;
+			}
+
+			nanosleep(&par->delay, NULL);
+
+			if (wasforked)
+				kill(neighbor->pid, SIGUSR1);
+			else
+				pthread_kill(neighbor->threadid, SIGUSR1);
+		}
+	}
+	par->stopped = 1;
+	return NULL;
+}
+
+
+static void display_help(void)
+{
+	printf("sigwaittest V %1.2f\n", VERSION_STRING);
+	puts("Usage: sigwaittest <options>");
+	puts("Function: test sigwait() latency");
+	puts(
+	"Options:\n"
+	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	"                           with NUM pin all threads to the processor NUM\n"
+	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	"-f       --fork            fork new processes instead of creating threads\n"
+	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-p PRIO  --prio=PRIO       priority\n"
+	"-t       --threads         one thread per available processor\n"
+	"-t [NUM] --threads=NUM     number of threads:\n"
+	"                           without NUM, threads = max_cpus\n"
+	"                           without -t default = 1\n");
+	exit(1);
+}
+
+
+static int setaffinity = AFFINITY_UNSPECIFIED;
+static int affinity;
+static int priority;
+static int num_threads = 1;
+static int max_cycles;
+static int interval = 1000;
+static int distance = 500;
+
+static void process_options (int argc, char *argv[])
+{
+	int error = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int thistracelimit = 0;
+
+	for (;;) {
+		int option_index = 0;
+		/** Options for getopt */
+		static struct option long_options[] = {
+			{"affinity", optional_argument, NULL, 'a'},
+			{"breaktrace", required_argument, NULL, 'b'},
+			{"distance", required_argument, NULL, 'd'},
+			{"fork", optional_argument, NULL, 'f'},
+			{"interval", required_argument, NULL, 'i'},
+			{"loops", required_argument, NULL, 'l'},
+			{"priority", required_argument, NULL, 'p'},
+			{"threads", optional_argument, NULL, 't'},
+			{"help", no_argument, NULL, '?'},
+			{NULL, 0, NULL, 0}
+		};
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:t::",
+			long_options, &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'a':
+			if (optarg != NULL) {
+				affinity = atoi(optarg);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind<argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
+				setaffinity = AFFINITY_USEALL;
+			}
+			break;
+		case 'b': thistracelimit = atoi(optarg); break;
+		case 'd': distance = atoi(optarg); break;
+		case 'f':
+			if (optarg != NULL) {
+				wasforked = 1;
+				if (optarg[0] == 's')
+					wasforked_sender = 1;
+				else if (optarg[0] == 'r')
+					wasforked_sender = 0;
+				wasforked_threadno = atoi(optarg+1);
+			} else
+				mustfork = 1;
+			break;
+		case 'i': interval = atoi(optarg); break;
+		case 'l': max_cycles = atoi(optarg); break;
+		case 'p': priority = atoi(optarg); break;
+		case 't':
+			if (optarg != NULL)
+				num_threads = atoi(optarg);
+			else if (optind<argc && atoi(argv[optind]))
+				num_threads = atoi(argv[optind]);
+			else
+				num_threads = max_cpus;
+			break;
+		case '?': error = 1; break;
+		}
+	}
+
+	if (!wasforked) {
+		if (setaffinity == AFFINITY_SPECIFIED) {
+			if (affinity < 0)
+				error = 1;
+			if (affinity >= max_cpus) {
+				fprintf(stderr, "ERROR: CPU #%d not found, "
+				    "only %d CPUs available\n",
+				    affinity, max_cpus);
+				error = 1;
+			}
+		}
+
+		if (num_threads < 1 || num_threads > 255)
+			error = 1;
+
+		if (priority < 0 || priority > 99)
+			error = 1;
+
+		tracelimit = thistracelimit;
+	}
+	if (error)
+		display_help ();
+}
+
+
+static int volatile mustshutdown;
+
+static void sighand(int sig)
+{
+	mustshutdown = 1;
+}
+
+
+int main(int argc, char *argv[])
+{
+	int i, totalsize = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int oldsamples = 1;
+	struct params *receiver = NULL;
+	struct params *sender = NULL;
+	sigset_t sigset;
+	void *param = NULL;
+	char f_opt[8];
+	struct timespec launchdelay, maindelay;
+
+	process_options(argc, argv);
+
+	if (check_privs())
+		return 1;
+
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+		perror("mlockall");
+		return 1;
+	}
+
+	if (mustfork) {
+		int shmem;
+
+		/*
+		 * In fork mode (-f), the shared memory contains two
+		 * subsequent arrays, receiver[num_threads] and
+		 * sender[num_threads].
+		 */
+		totalsize = num_threads * sizeof(struct params) * 2;
+
+		shm_unlink("/sigwaittest");
+  		shmem = shm_open("/sigwaittest", O_CREAT|O_EXCL|O_RDWR,
+		    S_IRUSR|S_IWUSR);
+		if (shmem < 0) {
+			fprintf(stderr, "Could not create shared memory\n");
+			return 1;
+		}
+		ftruncate(shmem, totalsize);
+		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
+		    shmem, 0);
+		if (param == MAP_FAILED) {
+			fprintf(stderr, "Could not map shared memory\n");
+			close(shmem);
+			return 1;
+		}
+
+		receiver = (struct params *) param;
+		sender = receiver + num_threads;
+	} else if (wasforked) {
+		struct stat buf;
+		int shmem, totalsize, expect_totalsize;
+
+		if (wasforked_threadno == -1 || wasforked_sender == -1) {
+			fprintf(stderr, "Invalid fork option\n");
+			return 1;
+		}
+		shmem = shm_open("/sigwaittest", O_RDWR, S_IRUSR|S_IWUSR);
+		if (fstat(shmem, &buf)) {
+			fprintf(stderr,
+			    "Could not determine shared memory size\n");
+			close(shmem);
+			return 1;
+		}
+		totalsize = buf.st_size;
+		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
+		    shmem, 0);
+		close(shmem);
+		if (param == MAP_FAILED) {
+			fprintf(stderr, "Could not map shared memory\n");
+			return 1;
+		}
+
+		receiver = (struct params *) param;
+		expect_totalsize = receiver->num_threads *
+		    sizeof(struct params) * 2;
+		if (totalsize != expect_totalsize) {
+			fprintf(stderr, "Memory size problem (expected %d, "
+			    "found %d\n", expect_totalsize, totalsize);
+			munmap(param, totalsize);
+			return 1;
+		}
+		sender = receiver + receiver->num_threads;
+		if (wasforked_sender)
+			semathread(sender + wasforked_threadno);
+		else
+			semathread(receiver + wasforked_threadno);
+		munmap(param, totalsize);
+		return 0;
+	}
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+	sigemptyset(&sigset);
+	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+	if (!mustfork && !wasforked) {
+		receiver = calloc(num_threads, sizeof(struct params));
+		sender = calloc(num_threads, sizeof(struct params));
+		if (receiver == NULL || sender == NULL)
+			goto nomem;
+	}
+
+	launchdelay.tv_sec = 0;
+	launchdelay.tv_nsec = 10000000; /* 10 ms */
+
+	maindelay.tv_sec = 0;
+	maindelay.tv_nsec = 50000000; /* 50 ms */
+
+	for (i = 0; i < num_threads; i++) {
+		receiver[i].mindiff = UINT_MAX;
+		receiver[i].maxdiff = 0;
+		receiver[i].sumdiff = 0.0;
+
+		receiver[i].num = i;
+		receiver[i].cpu = i;
+		receiver[i].priority = priority;
+		receiver[i].tracelimit = tracelimit;
+		if (priority > 0)
+			priority--;
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: receiver[i].cpu = -1; break;
+		case AFFINITY_SPECIFIED: receiver[i].cpu = affinity; break;
+		case AFFINITY_USEALL: receiver[i].cpu = i % max_cpus; break;
+		}
+		receiver[i].delay.tv_sec = interval / USEC_PER_SEC;
+		receiver[i].delay.tv_nsec = (interval % USEC_PER_SEC) * 1000;
+		interval += distance;
+		receiver[i].max_cycles = max_cycles;
+		receiver[i].sender = 0;
+		receiver[i].neighbor = &sender[i];
+		if (mustfork) {
+			pid_t pid = fork();
+			if (pid == -1) {
+				fprintf(stderr, "Could not fork\n");
+				return 1;
+			} else if (pid == 0) {
+				char *args[3];
+
+				receiver[i].num_threads = num_threads;
+				receiver[i].pid = getpid();
+				sprintf(f_opt, "-fr%d", i);
+				args[0] = argv[0];
+				args[1] = f_opt;
+				args[2] = NULL;
+				execvp(args[0], args);
+				fprintf(stderr,
+				    "Could not execute receiver child process "
+				    "#%d\n", i);
+			}
+		} else
+			pthread_create(&receiver[i].threadid, NULL,
+			    semathread, &receiver[i]);
+
+		nanosleep(&launchdelay, NULL);
+
+		memcpy(&sender[i], &receiver[i], sizeof(receiver[0]));
+		sender[i].sender = 1;
+		sender[i].neighbor = &receiver[i];
+		if (mustfork) {
+			pid_t pid = fork();
+			if (pid == -1) {
+				fprintf(stderr, "Could not fork\n");
+				return 1;
+			} else if (pid == 0) {
+				char *args[3];
+
+				sender[i].num_threads = num_threads;
+				sender[i].pid = getpid();
+				sprintf(f_opt, "-fs%d", i);
+				args[0] = argv[0];
+				args[1] = f_opt;
+				args[2] = NULL;
+				execvp(args[0], args);
+				fprintf(stderr,
+				    "Could not execute sender child process "
+				    "#%d\n", i);
+			}
+		} else
+			pthread_create(&sender[i].threadid, NULL, semathread,
+			    &sender[i]);
+	}
+
+	while (!mustshutdown) {
+		int printed;
+		int errorlines = 0;
+
+		for (i = 0; i < num_threads; i++)
+			mustshutdown |= receiver[i].shutdown |
+			    sender[i].shutdown;
+
+		if (receiver[0].samples > oldsamples || mustshutdown) {
+			for (i = 0; i < num_threads; i++) {
+				int receiver_pid, sender_pid;
+				if (mustfork) {
+					receiver_pid = receiver[i].pid;
+					sender_pid = sender[i].pid;
+				} else {
+					receiver_pid = receiver[i].tid;
+					sender_pid = sender[i].tid;
+				}
+				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: "
+				    "ID%d, P%d, CPU%d, Cycles %d\n",
+				    i*2, receiver_pid, receiver[i].priority,
+				    receiver[i].cpu, receiver[i].delay.tv_nsec /
+				    1000, i*2+1, sender_pid, sender[i].priority,
+				    sender[i].cpu, sender[i].samples);
+			}
+			for (i = 0; i < num_threads; i++) {
+				if (receiver[i].mindiff == -1)
+					printf("#%d -> #%d (not yet ready)\n",
+					    i*2+1, i*2);
+				else
+					printf("#%d -> #%d, Min %4d, Cur %4d, "
+					    "Avg %4d, Max %4d\n",
+					    i*2+1, i*2,	receiver[i].mindiff,
+					    (int) receiver[i].diff.tv_usec,
+					    (int) ((receiver[i].sumdiff /
+					    receiver[i].samples) + 0.5),
+					    receiver[i].maxdiff);
+				if (receiver[i].error[0] != '\0') {
+					printf(receiver[i].error);
+					receiver[i].error[0] = '\0';
+					errorlines++;
+				}
+				if (sender[i].error[0] != '\0') {
+					printf(sender[i].error);
+					sender[i].error[0] = '\0';
+					errorlines++;
+				}
+			}
+			printed = 1;
+		} else
+			printed = 0;
+
+		sigemptyset(&sigset);
+		sigaddset(&sigset, SIGTERM);
+		sigaddset(&sigset, SIGINT);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		nanosleep(&maindelay, NULL);
+
+		sigemptyset(&sigset);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		if (printed && !mustshutdown)
+			printf("\033[%dA", num_threads*2 + errorlines);
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		receiver[i].shutdown = 1;
+		sender[i].shutdown = 1;
+	}
+	nanosleep(&receiver[0].delay, NULL);
+
+	for (i = 0; i < num_threads; i++) {
+		if (!receiver[i].stopped) {
+			if (mustfork)
+				kill(receiver[i].pid, SIGTERM);
+			else
+				pthread_kill(receiver[i].threadid, SIGTERM);
+		}
+		if (!sender[i].stopped) {
+			if (mustfork)
+				kill(sender[i].pid, SIGTERM);
+			else
+				pthread_kill(sender[i].threadid, SIGTERM);
+		}
+	}
+
+ 	nomem:
+	if (mustfork) {
+		munmap(param, totalsize);
+		shm_unlink("/sigwaittest");
+	}
+
+	return 0;
+}
diff --git a/src/svsematest/Makefile b/src/svsematest/Makefile
new file mode 100644
index 0000000..aab2da0
--- /dev/null
+++ b/src/svsematest/Makefile
@@ -0,0 +1,16 @@
+CFLAGS += -Wall -O2
+LDFLAGS += -lpthread -lrt
+
+all:	svsematest
+	@echo Done
+
+svsematest.o: svsematest.c
+
+svsematest:
+
+clean:
+	@rm -f *.o
+
+tar:	clean
+	@rm -f svsematest
+	$(shell bn=`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
new file mode 100644
index 0000000..93b163e
--- /dev/null
+++ b/src/svsematest/svsematest.8
@@ -0,0 +1,57 @@
+.TH "svsematest" "8" "0.1" "" ""
+.SH "NAME"
+.LP
+\fBsvsematest\fR \- Start two threads or fork two processes and measure the latency of SYSV semaphores
+.SH "SYNTAX"
+.LP
+svsematest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
+.br
+.SH "DESCRIPTION"
+.LP
+The program \fBsvsematest\fR starts two threads or, optionally, forks two processes that are synchronized via SYSV semaphores and measures the latency between releasing a semaphore on one side and getting it on the other side.
+.SH "OPTIONS"
+.TP
+.B \-a, \-\-affinity[=PROC]
+Run on procesor number PROC. If PROC is not specified, run on current processor.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
+It is useful to track down unexpected large latencies of a system.
+.TP
+.B \-d, \-\-distance=DIST
+Set the distance of thread intervals in microseconds (default is 500 us). When  cylictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
+.TP
+.B \-f, \-\-fork
+Instead of creating threads (which is the default), fork new processes
+.TP
+.B \-i, \-\-interval=INTV
+Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. svsematest is stopped once the number of timer intervals has been reached.
+.TP
+.B \-p, \-\-prio=PRIO
+Set the priority of the process.
+.TP
+.B \-t, \-\-threads[=NUM]
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+.SH "EXAMPLES"
+The following example was running on a 4-way CPU:
+.LP
+.nf
+# svsematest -a -t -p99 -i100 -d25 -l1000000
+#0: ID13110, P99, CPU0, I100; #1: ID13111, P99, CPU0, Cycles 1000000
+#2: ID13112, P98, CPU1, I125; #3: ID13113, P98, CPU1, Cycles 813573
+#4: ID13114, P97, CPU2, I150; #5: ID13115, P97, CPU2, Cycles 667285
+#6: ID13116, P96, CPU3, I175; #7: ID13117, P96, CPU3, Cycles 591403
+#1 -> #0, Min    1, Cur    2, Avg    2, Max   12
+#3 -> #2, Min    1, Cur    3, Avg    2, Max   12
+#5 -> #4, Min    1, Cur    3, Avg    3, Max   12
+#7 -> #6, Min    1, Cur    2, Avg    3, Max   11
+.fi
+.SH "AUTHORS"
+.LP
+Carsten Emde <C.Emde@osadl.org>
+.SH "SEE ALSO"
+semop(2)
+.LP
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
new file mode 100644
index 0000000..3f1ea48
--- /dev/null
+++ b/src/svsematest/svsematest.c
@@ -0,0 +1,704 @@
+/*
+ * svsematest.c
+ *
+ * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
+ * USA.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#define __USE_GNU
+#include <fcntl.h>
+#include <getopt.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sched.h>
+#include <string.h>
+#include <time.h>
+#include <utmpx.h>
+
+#include <linux/unistd.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sem.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+#include "rt-utils.h"
+
+#define HAS_SCHED_GETCPU
+
+#define gettid() syscall(__NR_gettid)
+#ifndef HAS_SCHED_GETCPU
+#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
+#endif
+
+#define USEC_PER_SEC 1000000
+
+#define SEM_WAIT_FOR_RECEIVER 0
+#define SEM_WAIT_FOR_SENDER 1
+
+#define SEM_LOCK -1
+#define SEM_UNLOCK 1
+
+enum {
+	AFFINITY_UNSPECIFIED,
+	AFFINITY_SPECIFIED,
+	AFFINITY_USEALL
+};
+
+struct params {
+	int num;
+	int num_threads;
+	int cpu;
+	int priority;
+	int affinity;
+	int semid;
+	int sender;
+	int samples;
+	int max_cycles;
+	int tracelimit;
+	int tid;
+	pid_t pid;
+	int shutdown;
+	int stopped;
+	struct timespec delay;
+	unsigned int mindiff, maxdiff;
+	double sumdiff;
+	struct timeval unblocked, received, diff;
+	pthread_t threadid;
+	struct params *neighbor;
+	char error[MAX_PATH * 2];
+};
+
+static int mustfork;
+static int wasforked;
+static int wasforked_sender = -1;
+static int wasforked_threadno = -1;
+static int tracelimit;
+
+void *semathread(void *param)
+{
+	int mustgetcpu = 0;
+	struct params *par = param;
+	cpu_set_t mask;
+	int policy = SCHED_FIFO;
+	struct sched_param schedp;
+	struct sembuf sb = { 0, 0, 0};
+	sigset_t sigset;
+
+	sigemptyset(&sigset);
+	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = par->priority;
+	sched_setscheduler(0, policy, &schedp);
+
+	if (par->cpu != -1) {
+		CPU_ZERO(&mask);
+		CPU_SET(par->cpu, &mask);
+		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			snprintf(par->error, sizeof(par->error),
+			    "WARNING: Could not set CPU affinity "
+			    "to CPU #%d\n", par->cpu);
+	} else {
+        	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+        	if (max_cpus > 1)
+		        mustgetcpu = 1;
+	        else
+			par->cpu = 0;
+	}
+
+	if (!wasforked)
+		par->tid = gettid();
+
+	while (!par->shutdown) {
+		if (par->sender) {
+ 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+ 			sb.sem_op = SEM_UNLOCK;
+			/*
+			 * Unlocking the semaphore:
+			 *   Start of latency measurement ...
+			 */
+			gettimeofday(&par->unblocked, NULL);
+			semop(par->semid, &sb, 1);
+			par->samples++;
+			if(par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+
+			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
+				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
+			}
+
+ 			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
+ 			sb.sem_op = SEM_LOCK;
+			semop(par->semid, &sb, 1);
+
+ 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_op = SEM_LOCK;
+			semop(par->semid, &sb, 1);
+		} else {
+			/* Receiver */
+			struct params *neighbor;
+
+ 			if (wasforked)
+				neighbor = par + par->num_threads;
+			else
+				neighbor = par->neighbor;
+
+ 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_op = SEM_LOCK;
+			semop(par->semid, &sb, 1);
+
+			/*
+			 * ... We got the lock:
+			 * End of latency measurement
+			 */
+			gettimeofday(&par->received, NULL);
+			par->samples++;
+			if (par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+
+			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
+				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
+			}
+
+			timersub(&par->received, &neighbor->unblocked,
+			    &par->diff);
+
+			if (par->diff.tv_usec < par->mindiff)
+				par->mindiff = par->diff.tv_usec;
+			if (par->diff.tv_usec > par->maxdiff)
+				par->maxdiff = par->diff.tv_usec;
+			par->sumdiff += (double) par->diff.tv_usec;
+			if (par->tracelimit && par->maxdiff > par->tracelimit) {
+				char tracing_enabled_file[MAX_PATH];
+
+				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcat(tracing_enabled_file, "tracing_enabled");
+				int tracing_enabled =
+				    open(tracing_enabled_file, O_WRONLY);
+				if (tracing_enabled >= 0) {
+					write(tracing_enabled, "0", 1);
+					close(tracing_enabled);
+				} else
+					snprintf(par->error, sizeof(par->error),
+					    "Could not access %s\n",
+					    tracing_enabled_file);
+				par->shutdown = 1;
+				neighbor->shutdown = 1;
+			}
+
+ 			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
+			sb.sem_op = SEM_UNLOCK;
+			semop(par->semid, &sb, 1);
+
+			nanosleep(&par->delay, NULL);
+
+ 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_op = SEM_UNLOCK;
+			semop(par->semid, &sb, 1);
+		}
+	}
+	if (par->sender) {
+		sb.sem_num = SEM_WAIT_FOR_SENDER;
+		sb.sem_op = SEM_UNLOCK;
+		semop(par->semid, &sb, 1);
+
+		sb.sem_num = SEM_WAIT_FOR_RECEIVER;
+		sb.sem_op = SEM_UNLOCK;
+		semop(par->semid, &sb, 1);
+	}
+	par->stopped = 1;
+	return NULL;
+}
+
+
+union semun {
+       int		val;	/* Value for SETVAL */
+       struct semid_ds *buf;	/* Buffer for IPC_STAT, IPC_SET */
+       unsigned short  *array;	/* Array for GETALL, SETALL */
+       struct seminfo  *__buf;	/* Buffer for IPC_INFO (Linux-specific) */
+};
+
+
+static void display_help(void)
+{
+	printf("svsematest V %1.2f\n", VERSION_STRING);
+	puts("Usage: svsematest <options>");
+	puts("Function: test SYSV semaphore latency");
+	puts(
+	"Options:\n"
+	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	"                           with NUM pin all threads to the processor NUM\n"
+	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	"-f       --fork            fork new processes instead of creating threads\n"
+	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-p PRIO  --prio=PRIO       priority\n"
+	"-t       --threads         one thread per available processor\n"
+	"-t [NUM] --threads=NUM     number of threads:\n"
+	"                           without NUM, threads = max_cpus\n"
+	"                           without -t default = 1\n");
+	exit(1);
+}
+
+
+static int setaffinity = AFFINITY_UNSPECIFIED;
+static int affinity;
+static int priority;
+static int num_threads = 1;
+static int max_cycles;
+static int interval = 1000;
+static int distance = 500;
+
+static void process_options (int argc, char *argv[])
+{
+	int error = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int thistracelimit = 0;
+
+	for (;;) {
+		int option_index = 0;
+		/** Options for getopt */
+		static struct option long_options[] = {
+			{"affinity", optional_argument, NULL, 'a'},
+			{"breaktrace", required_argument, NULL, 'b'},
+			{"distance", required_argument, NULL, 'd'},
+			{"fork", optional_argument, NULL, 'f'},
+			{"interval", required_argument, NULL, 'i'},
+			{"loops", required_argument, NULL, 'l'},
+			{"priority", required_argument, NULL, 'p'},
+			{"threads", optional_argument, NULL, 't'},
+			{"help", no_argument, NULL, '?'},
+			{NULL, 0, NULL, 0}
+		};
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:t::",
+			long_options, &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'a':
+			if (optarg != NULL) {
+				affinity = atoi(optarg);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind<argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
+				setaffinity = AFFINITY_USEALL;
+			}
+			break;
+		case 'b': thistracelimit = atoi(optarg); break;
+		case 'd': distance = atoi(optarg); break;
+		case 'f':
+			if (optarg != NULL) {
+				wasforked = 1;
+				if (optarg[0] == 's')
+					wasforked_sender = 1;
+				else if (optarg[0] == 'r')
+					wasforked_sender = 0;
+				wasforked_threadno = atoi(optarg+1);
+			} else
+				mustfork = 1;
+			break;
+		case 'i': interval = atoi(optarg); break;
+		case 'l': max_cycles = atoi(optarg); break;
+		case 'p': priority = atoi(optarg); break;
+		case 't':
+			if (optarg != NULL)
+				num_threads = atoi(optarg);
+			else if (optind<argc && atoi(argv[optind]))
+				num_threads = atoi(argv[optind]);
+			else
+				num_threads = max_cpus;
+			break;
+		case '?': error = 1; break;
+		}
+	}
+
+	if (!wasforked) {
+		if (setaffinity == AFFINITY_SPECIFIED) {
+			if (affinity < 0)
+				error = 1;
+			if (affinity >= max_cpus) {
+				fprintf(stderr, "ERROR: CPU #%d not found, "
+				    "only %d CPUs available\n",
+				    affinity, max_cpus);
+				error = 1;
+			}
+		}
+
+		if (num_threads < 1 || num_threads > 255)
+			error = 1;
+
+		if (priority < 0 || priority > 99)
+			error = 1;
+
+		tracelimit = thistracelimit;
+	}
+	if (error)
+		display_help ();
+}
+
+
+static int volatile mustshutdown;
+
+static void sighand(int sig)
+{
+	mustshutdown = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	char *myfile;
+	int i, totalsize = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int oldsamples = 1;
+	key_t key;
+        union semun args;
+	struct params *receiver = NULL;
+	struct params *sender = NULL;
+	sigset_t sigset;
+	void *param = NULL;
+	char f_opt[8];
+	struct timespec launchdelay, maindelay;
+
+	myfile = getenv("_");
+	if (myfile == NULL)
+		myfile = argv[0];
+
+	process_options(argc, argv);
+
+	if (check_privs())
+		return 1;
+
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+		perror("mlockall");
+		return 1;
+	}
+
+	if (mustfork) {
+		int shmem;
+
+		/*
+		 * In fork mode (-f), the shared memory contains two
+		 * subsequent arrays, receiver[num_threads] and
+		 * sender[num_threads].
+		 */
+		totalsize = num_threads * sizeof(struct params) * 2;
+
+		shm_unlink("/sigwaittest");
+  		shmem = shm_open("/sigwaittest", O_CREAT|O_EXCL|O_RDWR,
+		    S_IRUSR|S_IWUSR);
+		if (shmem < 0) {
+			fprintf(stderr, "Could not create shared memory\n");
+			return 1;
+		}
+		ftruncate(shmem, totalsize);
+		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
+		    shmem, 0);
+		if (param == MAP_FAILED) {
+			fprintf(stderr, "Could not map shared memory\n");
+			close(shmem);
+			return 1;
+		}
+
+		receiver = (struct params *) param;
+		sender = receiver + num_threads;
+	} else if (wasforked) {
+		struct stat buf;
+		int shmem, totalsize, expect_totalsize;
+
+		if (wasforked_threadno == -1 || wasforked_sender == -1) {
+			fprintf(stderr, "Invalid fork option\n");
+			return 1;
+		}
+		shmem = shm_open("/sigwaittest", O_RDWR, S_IRUSR|S_IWUSR);
+		if (fstat(shmem, &buf)) {
+			fprintf(stderr,
+			    "Could not determine shared memory size\n");
+			close(shmem);
+			return 1;
+		}
+		totalsize = buf.st_size;
+		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
+		    shmem, 0);
+		close(shmem);
+		if (param == MAP_FAILED) {
+			fprintf(stderr, "Could not map shared memory\n");
+			return 1;
+		}
+
+		receiver = (struct params *) param;
+		expect_totalsize = receiver->num_threads *
+		    sizeof(struct params) * 2;
+		if (totalsize != expect_totalsize) {
+			fprintf(stderr, "Memory size problem (expected %d, "
+			    "found %d\n", expect_totalsize, totalsize);
+			munmap(param, totalsize);
+			return 1;
+		}
+		sender = receiver + receiver->num_threads;
+		if (wasforked_sender)
+			semathread(sender + wasforked_threadno);
+		else
+			semathread(receiver + wasforked_threadno);
+		munmap(param, totalsize);
+		return 0;
+	}
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+
+	sigemptyset(&sigset);
+	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+	if (!mustfork && !wasforked) {
+		receiver = calloc(num_threads, sizeof(struct params));
+		sender = calloc(num_threads, sizeof(struct params));
+		if (receiver == NULL || sender == NULL)
+			goto nomem;
+	}
+
+	launchdelay.tv_sec = 0;
+	launchdelay.tv_nsec = 10000000; /* 10 ms */
+
+	maindelay.tv_sec = 0;
+	maindelay.tv_nsec = 50000000; /* 50 ms */
+
+	for (i = 0; i < num_threads; i++) {
+		struct sembuf sb = { 0, 0, 0};
+
+		receiver[i].mindiff = UINT_MAX;
+		receiver[i].maxdiff = 0;
+		receiver[i].sumdiff = 0.0;
+
+		if ((key = ftok(myfile, i)) == -1) {
+			perror("ftok");
+			goto nosem;
+		}
+
+		if ((receiver[i].semid = semget(key, 2, 0666 | IPC_CREAT)) == -1) {
+			perror("semget");
+			goto nosem;
+		}
+
+		args.val = 1;
+		if (semctl(receiver[i].semid, SEM_WAIT_FOR_RECEIVER, SETVAL, args) == -1) {
+			perror("semctl sema #0");
+			goto nosem;
+		}
+
+		if (semctl(receiver[i].semid, SEM_WAIT_FOR_SENDER, SETVAL, args) == -1) {
+			perror("semctl sema #1");
+			goto nosem;
+		}
+
+		sb.sem_num = SEM_WAIT_FOR_RECEIVER;
+		sb.sem_op = SEM_LOCK;
+		semop(receiver[i].semid, &sb, 1);
+
+		sb.sem_num = SEM_WAIT_FOR_SENDER;
+		sb.sem_op = SEM_LOCK;
+		semop(receiver[i].semid, &sb, 1);
+
+		receiver[i].cpu = i;
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: receiver[i].cpu = -1; break;
+		case AFFINITY_SPECIFIED: receiver[i].cpu = affinity; break;
+		case AFFINITY_USEALL: receiver[i].cpu = i % max_cpus; break;
+		}
+		receiver[i].priority = priority;
+		receiver[i].tracelimit = tracelimit;
+		if (priority > 0)
+			priority--;
+		receiver[i].delay.tv_sec = interval / USEC_PER_SEC;
+		receiver[i].delay.tv_nsec = (interval % USEC_PER_SEC) * 1000;
+		interval += distance;
+		receiver[i].max_cycles = max_cycles;
+		receiver[i].sender = 0;
+		receiver[i].neighbor = &sender[i];
+		if (mustfork) {
+			pid_t pid = fork();
+			if (pid == -1) {
+				fprintf(stderr, "Could not fork\n");
+				return 1;
+			} else if (pid == 0) {
+				char *args[3];
+
+				receiver[i].num_threads = num_threads;
+				receiver[i].pid = getpid();
+				sprintf(f_opt, "-fr%d", i);
+				args[0] = argv[0];
+				args[1] = f_opt;
+				args[2] = NULL;
+				execvp(args[0], args);
+				fprintf(stderr,
+				    "Could not execute receiver child process "
+				    "#%d\n", i);
+			}
+		} else
+			pthread_create(&receiver[i].threadid, NULL,
+			    semathread, &receiver[i]);
+
+		nanosleep(&launchdelay, NULL);
+
+		memcpy(&sender[i], &receiver[i], sizeof(receiver[0]));
+		sender[i].sender = 1;
+		sender[i].neighbor = &receiver[i];
+		if (mustfork) {
+			pid_t pid = fork();
+			if (pid == -1) {
+				fprintf(stderr, "Could not fork\n");
+				return 1;
+			} else if (pid == 0) {
+				char *args[3];
+
+				sender[i].num_threads = num_threads;
+				sender[i].pid = getpid();
+				sprintf(f_opt, "-fs%d", i);
+				args[0] = argv[0];
+				args[1] = f_opt;
+				args[2] = NULL;
+				execvp(args[0], args);
+				fprintf(stderr,
+				    "Could not execute sender child process "
+				    "#%d\n", i);
+			}
+		} else
+			pthread_create(&sender[i].threadid, NULL, semathread,
+			    &sender[i]);
+	}
+
+	while (!mustshutdown) {
+		int printed;
+		int errorlines = 0;
+
+		for (i = 0; i < num_threads; i++)
+			mustshutdown |= receiver[i].shutdown |
+			    sender[i].shutdown;
+
+		if (receiver[0].samples > oldsamples || mustshutdown) {
+			for (i = 0; i < num_threads; i++) {
+				int receiver_pid, sender_pid;
+
+				if (mustfork) {
+					receiver_pid = receiver[i].pid;
+					sender_pid = sender[i].pid;
+				} else {
+					receiver_pid = receiver[i].tid;
+					sender_pid = sender[i].tid;
+				}
+				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: "
+				    "ID%d, P%d, CPU%d, Cycles %d\n",
+				    i*2, receiver_pid, receiver[i].priority,
+				    receiver[i].cpu, receiver[i].delay.tv_nsec /
+				    1000, i*2+1, sender_pid, sender[i].priority,
+				    sender[i].cpu, sender[i].samples);
+			}
+			for (i = 0; i < num_threads; i++) {
+				if (receiver[i].mindiff == -1)
+					printf("#%d -> #%d (not yet ready)\n",
+					    i*2+1, i*2);
+				else
+					printf("#%d -> #%d, Min %4d, Cur %4d, "
+					    "Avg %4d, Max %4d\n",
+					    i*2+1, i*2, receiver[i].mindiff,
+					    (int) receiver[i].diff.tv_usec,
+					    (int) ((receiver[i].sumdiff /
+					    receiver[i].samples) + 0.5),
+					    receiver[i].maxdiff);
+				if (receiver[i].error[0] != '\0') {
+					printf(receiver[i].error);
+					receiver[i].error[0] = '\0';
+					errorlines++;
+				}
+				if (sender[i].error[0] != '\0') {
+					printf(sender[i].error);
+					sender[i].error[0] = '\0';
+					errorlines++;
+				}
+			}
+			printed = 1;
+		} else
+			printed = 0;
+
+		sigemptyset(&sigset);
+		sigaddset(&sigset, SIGTERM);
+		sigaddset(&sigset, SIGINT);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		nanosleep(&maindelay, NULL);
+
+		sigemptyset(&sigset);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		if (printed && !mustshutdown)
+			printf("\033[%dA", num_threads*2 + errorlines);
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		receiver[i].shutdown = 1;
+		sender[i].shutdown = 1;
+	}
+	nanosleep(&receiver[0].delay, NULL);
+
+	for (i = 0; i < num_threads; i++) {
+		if (!receiver[i].stopped) {
+			if (mustfork)
+				kill(receiver[i].pid, SIGTERM);
+			else
+				pthread_kill(receiver[i].threadid, SIGTERM);
+		}
+		if (!sender[i].stopped) {
+			if (mustfork)
+				kill(sender[i].pid, SIGTERM);
+			else
+				pthread_kill(sender[i].threadid, SIGTERM);
+		}
+	}
+
+	nosem:
+	for (i = 0; i < num_threads; i++)
+		semctl(receiver[i].semid, -1, IPC_RMID);
+
+ 	nomem:
+	if (mustfork) {
+		munmap(param, totalsize);
+		shm_unlink("/sigwaittest");
+	}
+
+	return 0;
+}
-- 
1.6.5.2

