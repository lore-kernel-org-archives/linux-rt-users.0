From: Joe Korty <Joe.Korty@concurrent-rt.com>
Subject: Re: [ptrace, rt] erratic behaviour in PTRACE_SINGLESET on 4.13-rt and
 later.
Date: Tue, 27 Nov 2018 15:10:07 +0000
Message-ID: <20181127151004.GB15742@zipoli.concurrent-rt.com>
References: <20181119194619.GA32121@zipoli.concurrent-rt.com>
 <20181120122900.625b1d98@gandalf.local.home> <20181127085819.7e0865ee@tagon>
Reply-To: Joe Korty <Joe.Korty@concurrent-rt.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="_002_20181127151004GB15742zipoliconcurrentrtcom_"
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "julia@ni.com" <julia@ni.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127085819.7e0865ee@tagon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--_002_20181127151004GB15742zipoliconcurrentrtcom_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D7AB52A8E7A7C40BF08813EB22A1D4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 08:58:19AM -0600, Clark Williams wrote:
> Joe,
>=20
> This looks interesting. Do you have a git repo where I can pull the
> source?
>=20
> Clark


Hi Clark,
No I don't, sorry.  I am attaching the LAG version, it is a few
dozen lines shorter than the version I first sent out to the
mailing list.

Joe

PS: Oh, I forgot to do....

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>




> On Tue, 20 Nov 2018 12:29:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> > [ Adding Clark and John who manage the rt-tests repo ]
> >=20
> > -- Steve
> >=20
> > On Mon, 19 Nov 2018 19:46:23 +0000
> > Joe Korty <Joe.Korty@concurrent-rt.com> wrote:
> >=20
> > > Hi Julia & the RT team,
> > >=20
> > > The following program might make a good addition to the rt
> > > test suite.  It tests the reliability of PTRACE_SINGLESTEP.
> > > It does by default 10,000 ssteps against a simple,
> > > spinner tracee.  Also by default, it spins off ten of these
> > > tracer/tracee pairs, all of which are to run concurrently.
> > >=20
> > > Starting with 4.13-rt, this test occasionally encounters a
> > > sstep whose waitpid returns a WIFSIGNALED (signal SIGTRAP)
> > > rather than a WIFSTOPPED.  This usually happens after
> > > thousands of ssteps have executed.  Having multiple
> > > tracer/tracee pairs running dramatically increases the
> > > chances of failure.
> > >=20
> > > The is what the test output looks like for a good run:
> > >=20
> > >   #forks: 10
> > >   #steps: 10000
> > >  =20
> > >   forktest#0/22872: STARTING
> > >   forktest#7/22879: STARTING
> > >   forktest#8/22880: STARTING
> > >   forktest#6/22878: STARTING
> > >   forktest#5/22877: STARTING
> > >   forktest#3/22875: STARTING
> > >   forktest#4/22876: STARTING
> > >   forktest#9/22882: STARTING
> > >   forktest#2/22874: STARTING
> > >   forktest#1/22873: STARTING
> > >   forktest#0/22872: EXITING, no error
> > >   forktest#8/22880: EXITING, no error
> > >   forktest#3/22875: EXITING, no error
> > >   forktest#7/22879: EXITING, no error
> > >   forktest#6/22878: EXITING, no error
> > >   forktest#5/22877: EXITING, no error
> > >   forktest#2/22874: EXITING, no error
> > >   forktest#4/22876: EXITING, no error
> > >   forktest#9/22882: EXITING, no error
> > >   forktest#1/22873: EXITING, no error
> > >   All tests PASSED.
> > >=20
> > > This is what the test output looks like for a failing run:
> > >=20
> > >   #forks: 10
> > >   #steps: 10000
> > >  =20
> > >   forktest#0/22906: STARTING
> > >   forktest#1/22907: STARTING
> > >   forktest#2/22909: STARTING
> > >   forktest#3/22911: STARTING
> > >   forktest#4/22912: STARTING
> > >   forktest#5/22915: STARTING
> > >   forktest#6/22916: STARTING
> > >   forktest#7/22919: STARTING
> > >   forktest#8/22920: STARTING
> > >   forktest#9/22923: STARTING
> > >   forktest#2/22909: EXITING, ERROR: wait on PTRACE_SINGLESTEP #9: wan=
ted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#5/22915: EXITING, no error
> > >   forktest#3/22911: EXITING, ERROR: wait on PTRACE_SINGLESTEP #7953: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#0/22906: EXITING, ERROR: wait on PTRACE_SINGLESTEP #5072: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#9/22923: EXITING, ERROR: wait on PTRACE_SINGLESTEP #7992: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#4/22912: EXITING, ERROR: wait on PTRACE_SINGLESTEP #9923: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#1/22907: EXITING, ERROR: wait on PTRACE_SINGLESTEP #7723: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#7/22919: EXITING, ERROR: wait on PTRACE_SINGLESTEP #5036: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#8/22920: EXITING, ERROR: wait on PTRACE_SINGLESTEP #4943: =
wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
> > >   forktest#6/22916: EXITING, no error
> > >   One or more tests FAILED.
> > >=20
> > > Here are the observations from my testing so far:
> > >=20
> > >   - It has never failed when confined to a single cpu.
> > >   - It has never failed on !rt kernels.
> > >   - It has never failed on any kernel prior to 4.13.
> > >   - More failures than what chance would dictate happen
> > >     near the end of a test run (ie, if a test of 10,000=20
> > >     steps is run, the failure will be at the 9,xxx'th step,
> > >     if 100,000 steps are run, the failure will be at
> > >     the 9x,xxx'th step).
> > >=20
> > > The above results are from kernels 4.{4,9,11,13,14,19}-rt
> > > and some !rt's of these as well.
> > >=20
> > > I have yet to see or hear of this bug, if it is a bug,
> > > giving anyone a problem in a debug session.  It might not
> > > even be a bug but merely expected behaviour. And of course
> > > there is the possibility of a misuse of ptrace/waitpid in
> > > my test program. Its API, after all, is rather convoluted.
> > >=20
> > > Regards,
> > > Joe
> > >=20
> > >=20
> > >=20
> > >=20
> > > /*
> > >  * Have a tracer do a bunch of PTRACE_SINGLESTEPs against
> > >  * a tracee as fast as possible.  Create several of these
> > >  * tracer/tracee pairs and see if they can be made to
> > >  * interfere with each other.
> > >  *
> > >  * Usage:
> > >  *   ssdd nforks niters
> > >  * Where:
> > >  *   nforks - number of tracer/tracee pairs to fork off.
> > >  *            default 10.
> > >  *   niters - number of PTRACE_SINGLESTEP iterations to
> > >  *            do before declaring success, for each tracer/
> > >  *            tracee pair set up.  Default 10,000.
> > >  *
> > >  * The tracee waits on each PTRACE_SINGLESTEP with a waitpid(2)
> > >  * and checks that waitpid's return values for correctness.
> > >  */
> > > #include <stdio.h>
> > > #include <stdlib.h>
> > > #include <stddef.h>
> > > #include <unistd.h>
> > > #include <string.h>
> > > #include <signal.h>
> > > #include <errno.h>
> > >=20
> > > #include <sys/types.h>
> > > #include <sys/wait.h>
> > > #include <sys/ptrace.h>
> > >=20
> > > /* do_wait return values */
> > > #define STATE_EXITED	1
> > > #define STATE_STOPPED	2
> > > #define STATE_SIGNALED	3
> > > #define STATE_UNKNOWN	4
> > > #define STATE_ECHILD	5
> > > #define STATE_EXITED_TSIG	6	/* exited with termination signal */
> > > #define STATE_EXITED_ERRSTAT	7	/* exited with non-zero status */
> > >=20
> > > char *state_name[] =3D {
> > > 	[STATE_EXITED] =3D "STATE_EXITED",
> > > 	[STATE_STOPPED] =3D "STATE_STOPPED",
> > > 	[STATE_SIGNALED] =3D "STATE_SIGNALED",
> > > 	[STATE_UNKNOWN] =3D "STATE_UNKNOWN",
> > > 	[STATE_ECHILD] =3D "STATE_ECHILD",
> > > 	[STATE_EXITED_TSIG] =3D "STATE_EXITED_TSIG",
> > > 	[STATE_EXITED_ERRSTAT] =3D "STATE_EXITED_ERRSTAT"
> > > };
> > >=20
> > > const char *get_state_name(int state)
> > > {
> > > 	if (state < STATE_EXITED || state > STATE_EXITED_ERRSTAT)
> > > 		return "?";
> > > 	return state_name[state];
> > > }
> > >=20
> > > #define unused __attribute__((unused))
> > >=20
> > > static int got_sigchld;
> > >=20
> > > static int do_wait(pid_t *wait_pid, int *ret_sig)
> > > {
> > > 	int status, child_status;
> > >=20
> > > 	*ret_sig =3D -1; /* initially mark 'nothing returned' */
> > >=20
> > > 	while (1) {
> > > 		status =3D waitpid(-1, &child_status, WUNTRACED | __WALL);
> > > 		if (status =3D=3D -1) {
> > > 			if (errno =3D=3D EINTR)
> > > 				continue;
> > > 			if (errno =3D=3D ECHILD) {
> > > 				*wait_pid =3D (pid_t)0;
> > > 				return STATE_ECHILD;
> > > 			}
> > > 			printf("do_wait/%d: EXITING, ERROR: "
> > > 			       "waitpid() returned errno %d\n",
> > > 			       getpid(), errno);
> > > 			exit(1);
> > > 		}
> > > 		break;
> > > 	}
> > > 	*wait_pid =3D (pid_t)status;
> > >=20
> > > 	if (WIFEXITED(child_status)) {
> > > 		if (WIFSIGNALED(child_status))
> > > 			return STATE_EXITED_TSIG;
> > > 		if (WEXITSTATUS(child_status))
> > > 			return STATE_EXITED_ERRSTAT;
> > > 		return STATE_EXITED;
> > > 	}
> > > 	if (WIFSTOPPED(child_status)) {
> > > 		*ret_sig =3D WSTOPSIG(child_status);
> > > 		return STATE_STOPPED;
> > > 	}
> > > 	if (WIFSIGNALED(child_status)) {
> > > 		*ret_sig =3D WTERMSIG(child_status);
> > > 		return STATE_SIGNALED;
> > > 	}
> > > 	return STATE_UNKNOWN;
> > > }
> > >=20
> > > int check_sigchld(void)
> > > {
> > > 	int i;
> > > 	/*
> > > 	 * The signal is asynchronous so give it some
> > > 	 * time to arrive.
> > > 	 */
> > > 	for (i =3D 0; i < 10 && !got_sigchld; i++)
> > > 		usleep(1000); /* 10 msecs */
> > > 	for (i =3D 0; i < 10 && !got_sigchld; i++)
> > > 		usleep(2000); /* 20 + 10 =3D 30 msecs */
> > > 	for (i =3D 0; i < 10 && !got_sigchld; i++)
> > > 		usleep(4000); /* 40 + 30 =3D 70 msecs */
> > > 	for (i =3D 0; i < 10 && !got_sigchld; i++)
> > > 		usleep(8000); /* 80 + 40 =3D 150 msecs */
> > > 	for (i =3D 0; i < 10 && !got_sigchld; i++)
> > > 		usleep(16000); /* 160 + 150 =3D 310 msecs */
> > > 	for (i =3D 0; i < 10 && !got_sigchld; i++)
> > > 		usleep(32000); /* 320 + 310 =3D 630 msecs */
> > >=20
> > > 	return got_sigchld;
> > > }
> > >=20
> > > pid_t parent;
> > > int nforks =3D 10;
> > > int nsteps =3D 10000;
> > >=20
> > > static void sigchld(int sig, unused siginfo_t * info, unused void *ar=
g)
> > > {
> > > 	got_sigchld =3D 1;
> > > }
> > >=20
> > > static void child_process(void)
> > > {
> > > 	unused volatile int i;
> > >=20
> > > 	/* wait for ptrace attach */
> > > 	usleep(100000);
> > > 	while (1)
> > > 		i =3D 0;
> > > }
> > >=20
> > > static int forktests(int testid)
> > > {
> > > 	int i, status, ret_sig;
> > > 	long pstatus;
> > > 	pid_t child, wait_pid;
> > > 	struct sigaction act, oact;
> > >=20
> > > 	parent =3D getpid();
> > > 	printf("forktest#%d/%d: STARTING\n", testid, parent);
> > >=20
> > > 	child =3D fork();
> > > 	if (child =3D=3D -1) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "fork returned errno %d\n", testid, parent, errno);
> > > 		exit(1);
> > > 	}
> > > 	if (!child)
> > > 		child_process();
> > >=20
> > > 	act.sa_sigaction =3D sigchld;
> > > 	sigemptyset(&act.sa_mask);
> > > 	act.sa_flags =3D SA_SIGINFO;
> > > 	status =3D sigaction(SIGCHLD, &act, &oact);
> > > 	if (status) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "sigaction returned %d, errno %d\n",
> > > 		       testid, parent, status, errno);
> > > 		exit(1);
> > > 	}
> > >=20
> > > 	/* give both our child and parent time to set things up */
> > > 	usleep(125000);
> > >=20
> > > 	/*
> > > 	 * Attach to the child.
> > > 	 */
> > > 	pstatus =3D ptrace(PTRACE_ATTACH, child, NULL, NULL);
> > > 	if (pstatus =3D=3D ~0l) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "attach failed.  errno %d\n",
> > > 		       testid, getpid(), errno);
> > > 		exit(1);
> > > 	}
> > >=20
> > > 	/*
> > > 	 * The attach should cause the child to receive a signal.
> > > 	 */
> > > 	status =3D do_wait(&wait_pid, &ret_sig);
> > > 	if (wait_pid !=3D child) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "attach: Unexpected wait pid %d\n",
> > > 		       testid, getpid(), wait_pid);
> > > 		exit(1);
> > > 	}
> > > 	if (status !=3D STATE_STOPPED) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "attach: wait on PTRACE_ATTACH returned %d "
> > > 		       "[%s, wanted STATE_STOPPED], signo %d\n",
> > > 		       testid, getpid(), status, get_state_name(status),
> > > 		       ret_sig);
> > > 		exit(1);
> > > 	}
> > > 	else if (!check_sigchld()) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be =
1\n",
> > > 		       testid, getpid(), got_sigchld);
> > > 		exit(1);
> > > 	}
> > > 	got_sigchld =3D 0;
> > >=20
> > >=20
> > > 	/*
> > > 	 * Generate 'nsteps' PTRACE_SINGLESTEPs, make sure they all actually=
 step
> > > 	 * the tracee.
> > > 	 */
> > > 	for (i =3D 0; i < nsteps; i++) {
> > > 		pstatus =3D ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
> > >=20
> > > 		if (pstatus) {
> > > 			printf("forktest#%d/%d: EXITING, ERROR: "
> > > 			       "PTRACE_SINGLESTEP #%d: returned status %ld, "
> > > 			       "errno %d, signo %d\n",
> > > 			       testid, getpid(), i, pstatus, errno, ret_sig);
> > > 			exit(1);
> > > 		}
> > >=20
> > > 		status =3D do_wait(&wait_pid, &ret_sig);
> > > 		if (wait_pid !=3D child) {
> > > 			printf("forktest#%d/%d: EXITING, ERROR: "
> > > 			       "wait on PTRACE_SINGLESTEP #%d: returned wrong pid %d, "
> > > 			       "expected %d\n",
> > > 			       testid, getpid(), i, wait_pid, child);
> > > 			exit(1);
> > > 		}
> > > 		if (status !=3D STATE_STOPPED) {
> > > 			printf("forktest#%d/%d: EXITING, ERROR: "
> > > 			       "wait on PTRACE_SINGLESTEP #%d: wanted STATE_STOPPED, "
> > > 			       "saw %s instead (and saw signo %d too)\n",
> > > 			       testid, getpid(), i,
> > > 			       get_state_name(status), ret_sig);
> > > 			exit(1);
> > > 		}
> > > 		if (ret_sig !=3D SIGTRAP) {
> > > 			printf("forktest#%d/%d: EXITING, ERROR: "
> > > 			       "wait on PTRACE_SINGLESTEP #%d: returned signal %d, "
> > > 			       "wanted SIGTRAP\n",
> > > 			       testid, getpid(), i, ret_sig);
> > > 			exit(1);
> > > 		}
> > > 		if (!check_sigchld()) {
> > > 			printf("forktest#%d/%d: EXITING, ERROR: "
> > > 			       "wait on PTRACE_SINGLESTEP #%d: no SIGCHLD seen "
> > > 			       "(signal count =3D=3D 0), signo %d\n",
> > > 			       testid, getpid(), i, ret_sig);
> > > 			exit(1);
> > > 		}
> > > 		got_sigchld =3D 0;
> > > 	}
> > >=20
> > > 	/*
> > > 	 * We are all done, kill the tracee and wait for it to die.  We test
> > > 	 * the killing results as much as the above attach and sstep results=
,
> > > 	 * though failure here really isn't the point of this test.
> > > 	 */
> > > 	status =3D kill(child, SIGKILL);
> > >=20
> > > 	if (status) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "kill of child %d returned %d\n",
> > > 		       testid, getpid(), child, errno);
> > > 		exit(1);
> > > 	}
> > >=20
> > > 	status =3D do_wait(&wait_pid, &ret_sig);
> > > 	if (wait_pid !=3D child) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "kill: Unexpected wait pid %d\n",
> > > 		       testid, getpid(), wait_pid);
> > > 		exit(1);
> > > 	}
> > > 	if (status !=3D STATE_SIGNALED) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "kill: Unexpected child, do_wait status %d "
> > > 		       "[%s, wanted STATE_SIGNALED]\n",
> > > 		       testid, getpid(), status, get_state_name(status));
> > > 		exit(1);
> > > 	}
> > > 	if (ret_sig !=3D SIGKILL) {
> > > 		printf("forktest#%d/%d: EXITING, ERROR: "
> > > 		       "kill: Unexpected child signal %d\n",
> > > 		       testid, getpid(), ret_sig);
> > > 		exit(1);
> > > 	}
> > >=20
> > > 	printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
> > > 	exit(0);
> > > }
> > >=20
> > > int main(int argc, char **argv)
> > > {
> > > 	int i, ret_sig, status;
> > > 	pid_t child =3D 0, wait_pid;
> > > 	int error =3D 0;
> > >=20
> > > 	setbuf(stdout, NULL);
> > >=20
> > > 	argc--, argv++;
> > > 	if (argc) {
> > > 		nforks =3D atoi(*argv);
> > > 		argc--, argv++;
> > > 		if (argc)
> > > 			nsteps =3D atoi(*argv);
> > > 	}
> > > 	printf("#forks: %d\n", nforks);
> > > 	printf("#steps: %d\n", nsteps);
> > > 	printf("\n");
> > >=20
> > > 	for (i =3D 0; i < nforks; i++) {
> > > 		child =3D fork();
> > > 		if (child =3D=3D -1) {
> > > 			printf("main: fork returned errno %d\n", errno);
> > > 			exit(1);
> > > 		}
> > > 		if (!child)
> > > 			forktests(i);
> > > 	}
> > >=20
> > > 	for (i =3D 0; i < nforks; i++) {
> > > 		status =3D do_wait(&wait_pid, &ret_sig);
> > > 		if (status !=3D STATE_EXITED) {
> > > 			if (0) printf("main/%d: ERROR: "
> > > 			       "forktest#%d unexpected do_wait status %d "
> > > 			       "[%s, wanted STATE_EXITED]\n",
> > > 			       getpid(), wait_pid, status,
> > > 			       get_state_name(status));
> > > 			error =3D 1;
> > > 		}
> > > 	}
> > >=20
> > > 	printf("%s.\n", error ?
> > > 		"One or more tests FAILED" :
> > > 		"All tests PASSED");
> > > 	exit(error);
> > > } =20
> >=20
>=20
>=20
> --=20
> The United States Coast Guard
> Ruining Natural Selection since 1790

--_002_20181127151004GB15742zipoliconcurrentrtcom_
Content-Type: text/plain; name="ssdd.c"
Content-Description: ssdd.c
Content-Disposition: attachment; filename="ssdd.c"; size=8043;
	creation-date="Tue, 27 Nov 2018 15:10:07 GMT";
	modification-date="Tue, 27 Nov 2018 15:10:07 GMT"
Content-ID: <29A51744C386C846839CFCAB252F3F37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

LyoNCiAqIEhhdmUgYSB0cmFjZXIgZG8gYSBidW5jaCBvZiBQVFJBQ0VfU0lOR0xFU1RFUHMgYWdh
aW5zdA0KICogYSB0cmFjZWUgYXMgZmFzdCBhcyBwb3NzaWJsZS4gIENyZWF0ZSBzZXZlcmFsIG9m
IHRoZXNlDQogKiB0cmFjZXIvdHJhY2VlIHBhaXJzIGFuZCBzZWUgaWYgdGhleSBjYW4gYmUgbWFk
ZSB0bw0KICogaW50ZXJmZXJlIHdpdGggZWFjaCBvdGhlci4NCiAqDQogKiBVc2FnZToNCiAqICAg
c3NkZCBuZm9ya3Mgbml0ZXJzDQogKiBXaGVyZToNCiAqICAgbmZvcmtzIC0gbnVtYmVyIG9mIHRy
YWNlci90cmFjZWUgcGFpcnMgdG8gZm9yayBvZmYuDQogKiAgICAgICAgICAgIGRlZmF1bHQgMTAu
DQogKiAgIG5pdGVycyAtIG51bWJlciBvZiBQVFJBQ0VfU0lOR0xFU1RFUCBpdGVyYXRpb25zIHRv
DQogKiAgICAgICAgICAgIGRvIGJlZm9yZSBkZWNsYXJpbmcgc3VjY2VzcywgZm9yIGVhY2ggdHJh
Y2VyLw0KICogICAgICAgICAgICB0cmFjZWUgcGFpciBzZXQgdXAuICBEZWZhdWx0IDEwLDAwMC4N
CiAqDQogKiBUaGUgdHJhY2VyIHdhaXRzIG9uIGVhY2ggUFRSQUNFX1NJTkdMRVNURVAgd2l0aCBh
IHdhaXRwaWQoMikNCiAqIGFuZCBjaGVja3MgdGhhdCB3YWl0cGlkJ3MgcmV0dXJuIHZhbHVlcyBm
b3IgY29ycmVjdG5lc3MuDQogKi8NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0ZGxp
Yi5oPg0KI2luY2x1ZGUgPHN0ZGRlZi5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUg
PHN0cmluZy5oPg0KI2luY2x1ZGUgPHNpZ25hbC5oPg0KI2luY2x1ZGUgPGVycm5vLmg+DQoNCiNp
bmNsdWRlIDxzeXMvdHlwZXMuaD4NCiNpbmNsdWRlIDxzeXMvd2FpdC5oPg0KI2luY2x1ZGUgPHN5
cy9wdHJhY2UuaD4NCg0KLyogZG9fd2FpdCByZXR1cm4gdmFsdWVzICovDQojZGVmaW5lIFNUQVRF
X0VYSVRFRAkxDQojZGVmaW5lIFNUQVRFX1NUT1BQRUQJMg0KI2RlZmluZSBTVEFURV9TSUdOQUxF
RAkzDQojZGVmaW5lIFNUQVRFX1VOS05PV04JNA0KI2RlZmluZSBTVEFURV9FQ0hJTEQJNQ0KI2Rl
ZmluZSBTVEFURV9FWElURURfVFNJRwk2CS8qIGV4aXRlZCB3aXRoIHRlcm1pbmF0aW9uIHNpZ25h
bCAqLw0KI2RlZmluZSBTVEFURV9FWElURURfRVJSU1RBVAk3CS8qIGV4aXRlZCB3aXRoIG5vbi16
ZXJvIHN0YXR1cyAqLw0KDQpjaGFyICpzdGF0ZV9uYW1lW10gPSB7DQoJW1NUQVRFX0VYSVRFRF0g
PSAiU1RBVEVfRVhJVEVEIiwNCglbU1RBVEVfU1RPUFBFRF0gPSAiU1RBVEVfU1RPUFBFRCIsDQoJ
W1NUQVRFX1NJR05BTEVEXSA9ICJTVEFURV9TSUdOQUxFRCIsDQoJW1NUQVRFX1VOS05PV05dID0g
IlNUQVRFX1VOS05PV04iLA0KCVtTVEFURV9FQ0hJTERdID0gIlNUQVRFX0VDSElMRCIsDQoJW1NU
QVRFX0VYSVRFRF9UU0lHXSA9ICJTVEFURV9FWElURURfVFNJRyIsDQoJW1NUQVRFX0VYSVRFRF9F
UlJTVEFUXSA9ICJTVEFURV9FWElURURfRVJSU1RBVCINCn07DQoNCmNvbnN0IGNoYXIgKmdldF9z
dGF0ZV9uYW1lKGludCBzdGF0ZSkNCnsNCglpZiAoc3RhdGUgPCBTVEFURV9FWElURUQgfHwgc3Rh
dGUgPiBTVEFURV9FWElURURfRVJSU1RBVCkNCgkJcmV0dXJuICI/IjsNCglyZXR1cm4gc3RhdGVf
bmFtZVtzdGF0ZV07DQp9DQoNCiNkZWZpbmUgdW51c2VkIF9fYXR0cmlidXRlX18oKHVudXNlZCkp
DQoNCnN0YXRpYyBpbnQgZ290X3NpZ2NobGQ7DQoNCnN0YXRpYyBpbnQgZG9fd2FpdChwaWRfdCAq
d2FpdF9waWQsIGludCAqcmV0X3NpZykNCnsNCglpbnQgc3RhdHVzLCBjaGlsZF9zdGF0dXM7DQoN
CgkqcmV0X3NpZyA9IC0xOyAvKiBpbml0aWFsbHkgbWFyayAnbm90aGluZyByZXR1cm5lZCcgKi8N
Cg0KCXdoaWxlICgxKSB7DQoJCXN0YXR1cyA9IHdhaXRwaWQoLTEsICZjaGlsZF9zdGF0dXMsIFdV
TlRSQUNFRCB8IF9fV0FMTCk7DQoJCWlmIChzdGF0dXMgPT0gLTEpIHsNCgkJCWlmIChlcnJubyA9
PSBFSU5UUikNCgkJCQljb250aW51ZTsNCgkJCWlmIChlcnJubyA9PSBFQ0hJTEQpIHsNCgkJCQkq
d2FpdF9waWQgPSAocGlkX3QpMDsNCgkJCQlyZXR1cm4gU1RBVEVfRUNISUxEOw0KCQkJfQ0KCQkJ
cHJpbnRmKCJkb193YWl0LyVkOiBFWElUSU5HLCBFUlJPUjogIg0KCQkJICAgICAgICJ3YWl0cGlk
KCkgcmV0dXJuZWQgZXJybm8gJWRcbiIsDQoJCQkgICAgICAgZ2V0cGlkKCksIGVycm5vKTsNCgkJ
CWV4aXQoMSk7DQoJCX0NCgkJYnJlYWs7DQoJfQ0KCSp3YWl0X3BpZCA9IChwaWRfdClzdGF0dXM7
DQoNCglpZiAoV0lGRVhJVEVEKGNoaWxkX3N0YXR1cykpIHsNCgkJaWYgKFdJRlNJR05BTEVEKGNo
aWxkX3N0YXR1cykpDQoJCQlyZXR1cm4gU1RBVEVfRVhJVEVEX1RTSUc7DQoJCWlmIChXRVhJVFNU
QVRVUyhjaGlsZF9zdGF0dXMpKQ0KCQkJcmV0dXJuIFNUQVRFX0VYSVRFRF9FUlJTVEFUOw0KCQly
ZXR1cm4gU1RBVEVfRVhJVEVEOw0KCX0NCglpZiAoV0lGU1RPUFBFRChjaGlsZF9zdGF0dXMpKSB7
DQoJCSpyZXRfc2lnID0gV1NUT1BTSUcoY2hpbGRfc3RhdHVzKTsNCgkJcmV0dXJuIFNUQVRFX1NU
T1BQRUQ7DQoJfQ0KCWlmIChXSUZTSUdOQUxFRChjaGlsZF9zdGF0dXMpKSB7DQoJCSpyZXRfc2ln
ID0gV1RFUk1TSUcoY2hpbGRfc3RhdHVzKTsNCgkJcmV0dXJuIFNUQVRFX1NJR05BTEVEOw0KCX0N
CglyZXR1cm4gU1RBVEVfVU5LTk9XTjsNCn0NCg0KaW50IGNoZWNrX3NpZ2NobGQodm9pZCkNCnsN
CglpbnQgaTsNCgkvKg0KCSAqIFRoZSBzaWduYWwgaXMgYXN5bmNocm9ub3VzIHNvIGdpdmUgaXQg
c29tZQ0KCSAqIHRpbWUgdG8gYXJyaXZlLg0KCSAqLw0KCWZvciAoaSA9IDA7IGkgPCAxMCAmJiAh
Z290X3NpZ2NobGQ7IGkrKykNCgkJdXNsZWVwKDEwMDApOyAvKiAxMCBtc2VjcyAqLw0KCWZvciAo
aSA9IDA7IGkgPCAxMCAmJiAhZ290X3NpZ2NobGQ7IGkrKykNCgkJdXNsZWVwKDIwMDApOyAvKiAy
MCArIDEwID0gMzAgbXNlY3MgKi8NCglmb3IgKGkgPSAwOyBpIDwgMTAgJiYgIWdvdF9zaWdjaGxk
OyBpKyspDQoJCXVzbGVlcCg0MDAwKTsgLyogNDAgKyAzMCA9IDcwIG1zZWNzICovDQoJZm9yIChp
ID0gMDsgaSA8IDEwICYmICFnb3Rfc2lnY2hsZDsgaSsrKQ0KCQl1c2xlZXAoODAwMCk7IC8qIDgw
ICsgNzAgPSAxNTAgbXNlY3MgKi8NCglmb3IgKGkgPSAwOyBpIDwgMTAgJiYgIWdvdF9zaWdjaGxk
OyBpKyspDQoJCXVzbGVlcCgxNjAwMCk7IC8qIDE2MCArIDE1MCA9IDMxMCBtc2VjcyAqLw0KDQoJ
cmV0dXJuIGdvdF9zaWdjaGxkOw0KfQ0KDQpwaWRfdCBwYXJlbnQ7DQppbnQgbmZvcmtzID0gMTA7
DQppbnQgbnN0ZXBzID0gMTAwMDA7DQoNCnN0YXRpYyB2b2lkIHNpZ2NobGQoaW50IHNpZywgdW51
c2VkIHNpZ2luZm9fdCAqIGluZm8sIHVudXNlZCB2b2lkICphcmcpDQp7DQoJZ290X3NpZ2NobGQg
PSAxOw0KfQ0KDQpzdGF0aWMgdm9pZCBjaGlsZF9wcm9jZXNzKHZvaWQpDQp7DQoJdW51c2VkIHZv
bGF0aWxlIGludCBpOw0KDQoJLyogd2FpdCBmb3IgcHRyYWNlIGF0dGFjaCAqLw0KCXVzbGVlcCgx
MDAwMDApOw0KCXdoaWxlICgxKQ0KCQlpID0gMDsNCn0NCg0Kc3RhdGljIGludCBmb3JrdGVzdHMo
aW50IHRlc3RpZCkNCnsNCglpbnQgaSwgc3RhdHVzLCByZXRfc2lnOw0KCWxvbmcgcHN0YXR1czsN
CglwaWRfdCBjaGlsZCwgd2FpdF9waWQ7DQoJc3RydWN0IHNpZ2FjdGlvbiBhY3QsIG9hY3Q7DQoN
CglwYXJlbnQgPSBnZXRwaWQoKTsNCglwcmludGYoImZvcmt0ZXN0IyVkLyVkOiBTVEFSVElOR1xu
IiwgdGVzdGlkLCBwYXJlbnQpOw0KDQoJY2hpbGQgPSBmb3JrKCk7DQoJaWYgKGNoaWxkID09IC0x
KSB7DQoJCXByaW50ZigiZm9ya3Rlc3QjJWQvJWQ6IEVYSVRJTkcsIEVSUk9SOiAiDQoJCSAgICAg
ICAiZm9yayByZXR1cm5lZCBlcnJubyAlZFxuIiwgdGVzdGlkLCBwYXJlbnQsIGVycm5vKTsNCgkJ
ZXhpdCgxKTsNCgl9DQoJaWYgKCFjaGlsZCkNCgkJY2hpbGRfcHJvY2VzcygpOw0KDQoJYWN0LnNh
X3NpZ2FjdGlvbiA9IHNpZ2NobGQ7DQoJc2lnZW1wdHlzZXQoJmFjdC5zYV9tYXNrKTsNCglhY3Qu
c2FfZmxhZ3MgPSBTQV9TSUdJTkZPOw0KCXN0YXR1cyA9IHNpZ2FjdGlvbihTSUdDSExELCAmYWN0
LCAmb2FjdCk7DQoJaWYgKHN0YXR1cykgew0KCQlwcmludGYoImZvcmt0ZXN0IyVkLyVkOiBFWElU
SU5HLCBFUlJPUjogIg0KCQkgICAgICAgInNpZ2FjdGlvbiByZXR1cm5lZCAlZCwgZXJybm8gJWRc
biIsDQoJCSAgICAgICB0ZXN0aWQsIHBhcmVudCwgc3RhdHVzLCBlcnJubyk7DQoJCWV4aXQoMSk7
DQoJfQ0KDQoJLyogZ2l2ZSBib3RoIG91ciBjaGlsZCBhbmQgcGFyZW50IHRpbWUgdG8gc2V0IHRo
aW5ncyB1cCAqLw0KCXVzbGVlcCgxMjUwMDApOw0KDQoJLyoNCgkgKiBBdHRhY2ggdG8gdGhlIGNo
aWxkLg0KCSAqLw0KCXBzdGF0dXMgPSBwdHJhY2UoUFRSQUNFX0FUVEFDSCwgY2hpbGQsIE5VTEws
IE5VTEwpOw0KCWlmIChwc3RhdHVzID09IH4wbCkgew0KCQlwcmludGYoImZvcmt0ZXN0IyVkLyVk
OiBFWElUSU5HLCBFUlJPUjogIg0KCQkgICAgICAgImF0dGFjaCBmYWlsZWQuICBlcnJubyAlZFxu
IiwNCgkJICAgICAgIHRlc3RpZCwgZ2V0cGlkKCksIGVycm5vKTsNCgkJZXhpdCgxKTsNCgl9DQoN
CgkvKg0KCSAqIFRoZSBhdHRhY2ggc2hvdWxkIGNhdXNlIHRoZSBjaGlsZCB0byByZWNlaXZlIGEg
c2lnbmFsLg0KCSAqLw0KCXN0YXR1cyA9IGRvX3dhaXQoJndhaXRfcGlkLCAmcmV0X3NpZyk7DQoJ
aWYgKHdhaXRfcGlkICE9IGNoaWxkKSB7DQoJCXByaW50ZigiZm9ya3Rlc3QjJWQvJWQ6IEVYSVRJ
TkcsIEVSUk9SOiAiDQoJCSAgICAgICAiYXR0YWNoOiBVbmV4cGVjdGVkIHdhaXQgcGlkICVkXG4i
LA0KCQkgICAgICAgdGVzdGlkLCBnZXRwaWQoKSwgd2FpdF9waWQpOw0KCQlleGl0KDEpOw0KCX0N
CglpZiAoc3RhdHVzICE9IFNUQVRFX1NUT1BQRUQpIHsNCgkJcHJpbnRmKCJmb3JrdGVzdCMlZC8l
ZDogRVhJVElORywgRVJST1I6ICINCgkJICAgICAgICJhdHRhY2g6IHdhaXQgb24gUFRSQUNFX0FU
VEFDSCByZXR1cm5lZCAlZCAiDQoJCSAgICAgICAiWyVzLCB3YW50ZWQgU1RBVEVfU1RPUFBFRF0s
IHNpZ25vICVkXG4iLA0KCQkgICAgICAgdGVzdGlkLCBnZXRwaWQoKSwgc3RhdHVzLCBnZXRfc3Rh
dGVfbmFtZShzdGF0dXMpLA0KCQkgICAgICAgcmV0X3NpZyk7DQoJCWV4aXQoMSk7DQoJfQ0KCWVs
c2UgaWYgKCFjaGVja19zaWdjaGxkKCkpIHsNCgkJcHJpbnRmKCJmb3JrdGVzdCMlZC8lZDogRVhJ
VElORywgRVJST1I6ICINCgkJICAgICAgICJ3YWl0IG9uIFBUUkFDRV9BVFRBQ0ggc2F3IGEgU0lH
Q0hMRCBjb3VudCBvZiAlZCwgc2hvdWxkIGJlIDFcbiIsDQoJCSAgICAgICB0ZXN0aWQsIGdldHBp
ZCgpLCBnb3Rfc2lnY2hsZCk7DQoJCWV4aXQoMSk7DQoJfQ0KCWdvdF9zaWdjaGxkID0gMDsNCg0K
DQoJLyoNCgkgKiBHZW5lcmF0ZSAnbnN0ZXBzJyBQVFJBQ0VfU0lOR0xFU1RFUHMsIG1ha2Ugc3Vy
ZSB0aGV5IGFsbCBhY3R1YWxseQ0KCSAqIHN0ZXAgdGhlIHRyYWNlZS4NCgkgKi8NCglmb3IgKGkg
PSAwOyBpIDwgbnN0ZXBzOyBpKyspIHsNCgkJcHN0YXR1cyA9IHB0cmFjZShQVFJBQ0VfU0lOR0xF
U1RFUCwgY2hpbGQsIE5VTEwsIE5VTEwpOw0KDQoJCWlmIChwc3RhdHVzKSB7DQoJCQlwcmludGYo
ImZvcmt0ZXN0IyVkLyVkOiBFWElUSU5HLCBFUlJPUjogIg0KCQkJICAgICAgICJQVFJBQ0VfU0lO
R0xFU1RFUCAjJWQ6IHJldHVybmVkIHN0YXR1cyAlbGQsICINCgkJCSAgICAgICAiZXJybm8gJWQs
IHNpZ25vICVkXG4iLA0KCQkJICAgICAgIHRlc3RpZCwgZ2V0cGlkKCksIGksIHBzdGF0dXMsIGVy
cm5vLCByZXRfc2lnKTsNCgkJCWV4aXQoMSk7DQoJCX0NCg0KCQlzdGF0dXMgPSBkb193YWl0KCZ3
YWl0X3BpZCwgJnJldF9zaWcpOw0KCQlpZiAod2FpdF9waWQgIT0gY2hpbGQpIHsNCgkJCXByaW50
ZigiZm9ya3Rlc3QjJWQvJWQ6IEVYSVRJTkcsIEVSUk9SOiAiDQoJCQkgICAgICAgIndhaXQgb24g
UFRSQUNFX1NJTkdMRVNURVAgIyVkOiByZXR1cm5lZCB3cm9uZyBwaWQgJWQsICINCgkJCSAgICAg
ICAiZXhwZWN0ZWQgJWRcbiIsDQoJCQkgICAgICAgdGVzdGlkLCBnZXRwaWQoKSwgaSwgd2FpdF9w
aWQsIGNoaWxkKTsNCgkJCWV4aXQoMSk7DQoJCX0NCgkJaWYgKHN0YXR1cyAhPSBTVEFURV9TVE9Q
UEVEKSB7DQoJCQlwcmludGYoImZvcmt0ZXN0IyVkLyVkOiBFWElUSU5HLCBFUlJPUjogIg0KCQkJ
ICAgICAgICJ3YWl0IG9uIFBUUkFDRV9TSU5HTEVTVEVQICMlZDogd2FudGVkIFNUQVRFX1NUT1BQ
RUQsICINCgkJCSAgICAgICAic2F3ICVzIGluc3RlYWQgKGFuZCBzYXcgc2lnbm8gJWQgdG9vKVxu
IiwNCgkJCSAgICAgICB0ZXN0aWQsIGdldHBpZCgpLCBpLA0KCQkJICAgICAgIGdldF9zdGF0ZV9u
YW1lKHN0YXR1cyksIHJldF9zaWcpOw0KCQkJZXhpdCgxKTsNCgkJfQ0KCQlpZiAocmV0X3NpZyAh
PSBTSUdUUkFQKSB7DQoJCQlwcmludGYoImZvcmt0ZXN0IyVkLyVkOiBFWElUSU5HLCBFUlJPUjog
Ig0KCQkJICAgICAgICJ3YWl0IG9uIFBUUkFDRV9TSU5HTEVTVEVQICMlZDogcmV0dXJuZWQgc2ln
bmFsICVkLCAiDQoJCQkgICAgICAgIndhbnRlZCBTSUdUUkFQXG4iLA0KCQkJICAgICAgIHRlc3Rp
ZCwgZ2V0cGlkKCksIGksIHJldF9zaWcpOw0KCQkJZXhpdCgxKTsNCgkJfQ0KCQlpZiAoIWNoZWNr
X3NpZ2NobGQoKSkgew0KCQkJcHJpbnRmKCJmb3JrdGVzdCMlZC8lZDogRVhJVElORywgRVJST1I6
ICINCgkJCSAgICAgICAid2FpdCBvbiBQVFJBQ0VfU0lOR0xFU1RFUCAjJWQ6IG5vIFNJR0NITEQg
c2VlbiAiDQoJCQkgICAgICAgIihzaWduYWwgY291bnQgPT0gMCksIHNpZ25vICVkXG4iLA0KCQkJ
ICAgICAgIHRlc3RpZCwgZ2V0cGlkKCksIGksIHJldF9zaWcpOw0KCQkJZXhpdCgxKTsNCgkJfQ0K
CQlnb3Rfc2lnY2hsZCA9IDA7DQoJfQ0KDQoJLyogVGhlcmUgaXMgbm8gbmVlZCBmb3IgdGhlIHRy
YWNlciB0byBraWxsIHRoZSB0cmFjZWUuIEl0IHdpbGwNCgkgKiBhdXRvbWF0aWNhbGx5IGV4aXQg
d2hlbiBpdHMgb3duZXIsIGllLCB1cywgZXhpdHMuDQoJICovDQoNCglwcmludGYoImZvcmt0ZXN0
IyVkLyVkOiBFWElUSU5HLCBubyBlcnJvclxuIiwgdGVzdGlkLCBwYXJlbnQpOw0KCWV4aXQoMCk7
DQp9DQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCnsNCglpbnQgaSwgcmV0X3Np
Zywgc3RhdHVzOw0KCXBpZF90IGNoaWxkID0gMCwgd2FpdF9waWQ7DQoJaW50IGVycm9yID0gMDsN
Cg0KCXNldGJ1ZihzdGRvdXQsIE5VTEwpOw0KDQoJYXJnYy0tLCBhcmd2Kys7DQoJaWYgKGFyZ2Mp
IHsNCgkJbmZvcmtzID0gYXRvaSgqYXJndik7DQoJCWFyZ2MtLSwgYXJndisrOw0KCQlpZiAoYXJn
YykNCgkJCW5zdGVwcyA9IGF0b2koKmFyZ3YpOw0KCX0NCglwcmludGYoIiNmb3JrczogJWRcbiIs
IG5mb3Jrcyk7DQoJcHJpbnRmKCIjc3RlcHM6ICVkXG4iLCBuc3RlcHMpOw0KCXByaW50ZigiXG4i
KTsNCg0KCWZvciAoaSA9IDA7IGkgPCBuZm9ya3M7IGkrKykgew0KCQljaGlsZCA9IGZvcmsoKTsN
CgkJaWYgKGNoaWxkID09IC0xKSB7DQoJCQlwcmludGYoIm1haW46IGZvcmsgcmV0dXJuZWQgZXJy
bm8gJWRcbiIsIGVycm5vKTsNCgkJCWV4aXQoMSk7DQoJCX0NCgkJaWYgKCFjaGlsZCkNCgkJCWZv
cmt0ZXN0cyhpKTsNCgl9DQoNCglmb3IgKGkgPSAwOyBpIDwgbmZvcmtzOyBpKyspIHsNCgkJc3Rh
dHVzID0gZG9fd2FpdCgmd2FpdF9waWQsICZyZXRfc2lnKTsNCgkJaWYgKHN0YXR1cyAhPSBTVEFU
RV9FWElURUQpIHsNCgkJCWlmICgwKSBwcmludGYoIm1haW4vJWQ6IEVSUk9SOiAiDQoJCQkgICAg
ICAgImZvcmt0ZXN0IyVkIHVuZXhwZWN0ZWQgZG9fd2FpdCBzdGF0dXMgJWQgIg0KCQkJICAgICAg
ICJbJXMsIHdhbnRlZCBTVEFURV9FWElURURdXG4iLA0KCQkJICAgICAgIGdldHBpZCgpLCB3YWl0
X3BpZCwgc3RhdHVzLA0KCQkJICAgICAgIGdldF9zdGF0ZV9uYW1lKHN0YXR1cykpOw0KCQkJZXJy
b3IgPSAxOw0KCQl9DQoJfQ0KDQoJcHJpbnRmKCIlcy5cbiIsIGVycm9yID8NCgkJIk9uZSBvciBt
b3JlIHRlc3RzIEZBSUxFRCIgOg0KCQkiQWxsIHRlc3RzIFBBU1NFRCIpOw0KCWV4aXQoZXJyb3Ip
Ow0KfQ0K

--_002_20181127151004GB15742zipoliconcurrentrtcom_--
