From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] Add ssdd test to the rt-tests suite
Date: Mon, 14 Jan 2019 18:09:08 +0100
Message-ID: <20190114170908.5287-2-jkacur@redhat.com>
References: <20190114170908.5287-1-jkacur@redhat.com>
Reply-To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
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
        Joe Korty <joe.korty@concurrent-rt.com>,
        John Kacur <jkacur@redhat.com>
To: Joe Korty <Joe.Korty@concurrent-rt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114170908.5287-1-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Joe Korty <joe.korty@concurrent-rt.com>

The following program might make a good addition to the rt
test suite.  It tests the reliability of PTRACE_SINGLESTEP.
It does by default 10,000 ssteps against a simple,
spinner tracee.  Also by default, it spins off ten of these
tracer/tracee pairs, all of which are to run concurrently.

Starting with 4.13-rt, this test occasionally encounters a
sstep whose waitpid returns a WIFSIGNALED (signal SIGTRAP)
rather than a WIFSTOPPED.  This usually happens after
thousands of ssteps have executed.  Having multiple
tracer/tracee pairs running dramatically increases the
chances of failure.

The is what the test output looks like for a good run:

forktest#0/22872: STARTING
forktest#7/22879: STARTING
forktest#8/22880: STARTING
forktest#6/22878: STARTING
forktest#5/22877: STARTING
forktest#3/22875: STARTING
forktest#4/22876: STARTING
forktest#9/22882: STARTING
forktest#2/22874: STARTING
forktest#1/22873: STARTING
forktest#0/22872: EXITING, no error
forktest#8/22880: EXITING, no error
forktest#3/22875: EXITING, no error
forktest#7/22879: EXITING, no error
forktest#6/22878: EXITING, no error
forktest#5/22877: EXITING, no error
forktest#2/22874: EXITING, no error
forktest#4/22876: EXITING, no error
forktest#9/22882: EXITING, no error
forktest#1/22873: EXITING, no error
All tests PASSED.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.c | 315 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 315 insertions(+)
 create mode 100644 src/ssdd/ssdd.c

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
new file mode 100644
index 000000000000..6d09d54e34e1
--- /dev/null
+++ b/src/ssdd/ssdd.c
@@ -0,0 +1,315 @@
+/*
+ * Have a tracer do a bunch of PTRACE_SINGLESTEPs against
+ * a tracee as fast as possible.  Create several of these
+ * tracer/tracee pairs and see if they can be made to
+ * interfere with each other.
+ *
+ * Usage:
+ *   ssdd nforks niters
+ * Where:
+ *   nforks - number of tracer/tracee pairs to fork off.
+ *            default 10.
+ *   niters - number of PTRACE_SINGLESTEP iterations to
+ *            do before declaring success, for each tracer/
+ *            tracee pair set up.  Default 10,000.
+ *
+ * The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
+ * and checks that waitpid's return values for correctness.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <errno.h>
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ptrace.h>
+
+/* do_wait return values */
+#define STATE_EXITED	1
+#define STATE_STOPPED	2
+#define STATE_SIGNALED	3
+#define STATE_UNKNOWN	4
+#define STATE_ECHILD	5
+#define STATE_EXITED_TSIG	6	/* exited with termination signal */
+#define STATE_EXITED_ERRSTAT	7	/* exited with non-zero status */
+
+char *state_name[] = {
+	[STATE_EXITED] = "STATE_EXITED",
+	[STATE_STOPPED] = "STATE_STOPPED",
+	[STATE_SIGNALED] = "STATE_SIGNALED",
+	[STATE_UNKNOWN] = "STATE_UNKNOWN",
+	[STATE_ECHILD] = "STATE_ECHILD",
+	[STATE_EXITED_TSIG] = "STATE_EXITED_TSIG",
+	[STATE_EXITED_ERRSTAT] = "STATE_EXITED_ERRSTAT"
+};
+
+const char *get_state_name(int state)
+{
+	if (state < STATE_EXITED || state > STATE_EXITED_ERRSTAT)
+		return "?";
+	return state_name[state];
+}
+
+#define unused __attribute__((unused))
+
+static int got_sigchld;
+
+static int do_wait(pid_t *wait_pid, int *ret_sig)
+{
+	int status, child_status;
+
+	*ret_sig = -1; /* initially mark 'nothing returned' */
+
+	while (1) {
+		status = waitpid(-1, &child_status, WUNTRACED | __WALL);
+		if (status == -1) {
+			if (errno == EINTR)
+				continue;
+			if (errno == ECHILD) {
+				*wait_pid = (pid_t)0;
+				return STATE_ECHILD;
+			}
+			printf("do_wait/%d: EXITING, ERROR: "
+			       "waitpid() returned errno %d\n",
+			       getpid(), errno);
+			exit(1);
+		}
+		break;
+	}
+	*wait_pid = (pid_t)status;
+
+	if (WIFEXITED(child_status)) {
+		if (WIFSIGNALED(child_status))
+			return STATE_EXITED_TSIG;
+		if (WEXITSTATUS(child_status))
+			return STATE_EXITED_ERRSTAT;
+		return STATE_EXITED;
+	}
+	if (WIFSTOPPED(child_status)) {
+		*ret_sig = WSTOPSIG(child_status);
+		return STATE_STOPPED;
+	}
+	if (WIFSIGNALED(child_status)) {
+		*ret_sig = WTERMSIG(child_status);
+		return STATE_SIGNALED;
+	}
+	return STATE_UNKNOWN;
+}
+
+int check_sigchld(void)
+{
+	int i;
+	/*
+	 * The signal is asynchronous so give it some
+	 * time to arrive.
+	 */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(1000); /* 10 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(2000); /* 20 + 10 = 30 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(4000); /* 40 + 30 = 70 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(8000); /* 80 + 70 = 150 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(16000); /* 160 + 150 = 310 msecs */
+
+	return got_sigchld;
+}
+
+pid_t parent;
+int nforks = 10;
+int nsteps = 10000;
+
+static void sigchld(int sig, unused siginfo_t * info, unused void *arg)
+{
+	got_sigchld = 1;
+}
+
+static void child_process(void)
+{
+	unused volatile int i;
+
+	/* wait for ptrace attach */
+	usleep(100000);
+	while (1)
+		i = 0;
+}
+
+static int forktests(int testid)
+{
+	int i, status, ret_sig;
+	long pstatus;
+	pid_t child, wait_pid;
+	struct sigaction act, oact;
+
+	parent = getpid();
+	printf("forktest#%d/%d: STARTING\n", testid, parent);
+
+	child = fork();
+	if (child == -1) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "fork returned errno %d\n", testid, parent, errno);
+		exit(1);
+	}
+	if (!child)
+		child_process();
+
+	act.sa_sigaction = sigchld;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	status = sigaction(SIGCHLD, &act, &oact);
+	if (status) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "sigaction returned %d, errno %d\n",
+		       testid, parent, status, errno);
+		exit(1);
+	}
+
+	/* give both our child and parent time to set things up */
+	usleep(125000);
+
+	/*
+	 * Attach to the child.
+	 */
+	pstatus = ptrace(PTRACE_ATTACH, child, NULL, NULL);
+	if (pstatus == ~0l) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "attach failed.  errno %d\n",
+		       testid, getpid(), errno);
+		exit(1);
+	}
+
+	/*
+	 * The attach should cause the child to receive a signal.
+	 */
+	status = do_wait(&wait_pid, &ret_sig);
+	if (wait_pid != child) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "attach: Unexpected wait pid %d\n",
+		       testid, getpid(), wait_pid);
+		exit(1);
+	}
+	if (status != STATE_STOPPED) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "attach: wait on PTRACE_ATTACH returned %d "
+		       "[%s, wanted STATE_STOPPED], signo %d\n",
+		       testid, getpid(), status, get_state_name(status),
+		       ret_sig);
+		exit(1);
+	}
+	else if (!check_sigchld()) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
+		       testid, getpid(), got_sigchld);
+		exit(1);
+	}
+	got_sigchld = 0;
+
+
+	/*
+	 * Generate 'nsteps' PTRACE_SINGLESTEPs, make sure they all actually
+	 * step the tracee.
+	 */
+	for (i = 0; i < nsteps; i++) {
+		pstatus = ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
+
+		if (pstatus) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "PTRACE_SINGLESTEP #%d: returned status %ld, "
+			       "errno %d, signo %d\n",
+			       testid, getpid(), i, pstatus, errno, ret_sig);
+			exit(1);
+		}
+
+		status = do_wait(&wait_pid, &ret_sig);
+		if (wait_pid != child) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: returned wrong pid %d, "
+			       "expected %d\n",
+			       testid, getpid(), i, wait_pid, child);
+			exit(1);
+		}
+		if (status != STATE_STOPPED) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: wanted STATE_STOPPED, "
+			       "saw %s instead (and saw signo %d too)\n",
+			       testid, getpid(), i,
+			       get_state_name(status), ret_sig);
+			exit(1);
+		}
+		if (ret_sig != SIGTRAP) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: returned signal %d, "
+			       "wanted SIGTRAP\n",
+			       testid, getpid(), i, ret_sig);
+			exit(1);
+		}
+		if (!check_sigchld()) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: no SIGCHLD seen "
+			       "(signal count == 0), signo %d\n",
+			       testid, getpid(), i, ret_sig);
+			exit(1);
+		}
+		got_sigchld = 0;
+	}
+
+	/* There is no need for the tracer to kill the tracee. It will
+	 * automatically exit when its owner, ie, us, exits.
+	 */
+
+	printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	int i, ret_sig, status;
+	pid_t child = 0, wait_pid;
+	int error = 0;
+
+	setbuf(stdout, NULL);
+
+	argc--, argv++;
+	if (argc) {
+		nforks = atoi(*argv);
+		argc--, argv++;
+		if (argc)
+			nsteps = atoi(*argv);
+	}
+	printf("#forks: %d\n", nforks);
+	printf("#steps: %d\n", nsteps);
+	printf("\n");
+
+	for (i = 0; i < nforks; i++) {
+		child = fork();
+		if (child == -1) {
+			printf("main: fork returned errno %d\n", errno);
+			exit(1);
+		}
+		if (!child)
+			forktests(i);
+	}
+
+	for (i = 0; i < nforks; i++) {
+		status = do_wait(&wait_pid, &ret_sig);
+		if (status != STATE_EXITED) {
+			if (0) printf("main/%d: ERROR: "
+			       "forktest#%d unexpected do_wait status %d "
+			       "[%s, wanted STATE_EXITED]\n",
+			       getpid(), wait_pid, status,
+			       get_state_name(status));
+			error = 1;
+		}
+	}
+
+	printf("%s.\n", error ?
+		"One or more tests FAILED" :
+		"All tests PASSED");
+	exit(error);
+}
-- 
2.20.1
