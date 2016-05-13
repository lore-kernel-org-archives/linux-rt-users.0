From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: Housekeeping fix some spelling errors.
Date: Fri, 13 May 2016 15:11:53 +0200
Message-ID: <1463145113-9025-3-git-send-email-jkacur@redhat.com>
References: <1463145113-9025-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34327 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbcEMNMJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 May 2016 09:12:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so3625839wmn.1
        for <linux-rt-users@vger.kernel.org>; Fri, 13 May 2016 06:12:08 -0700 (PDT)
In-Reply-To: <1463145113-9025-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46ix a number of errors like procesor->processor, specifed->specified =
and
cylictest->cyclictest.

Note, Uwe Kleine-K=C3=B6nig <ukleinek@debian.org> pointed out some of t=
hese
spelling errors previously.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/backfire/sendme.8         | 2 +-
 src/pi_tests/pi_stress.8      | 2 +-
 src/pmqtest/pmqtest.8         | 4 ++--
 src/ptsematest/ptsematest.8   | 6 +++---
 src/signaltest/signaltest.8   | 2 +-
 src/sigwaittest/sigwaittest.8 | 8 ++++----
 src/svsematest/svsematest.8   | 6 +++---
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/backfire/sendme.8 b/src/backfire/sendme.8
index b9857ab6eba8..05f3a1c14d8b 100644
--- a/src/backfire/sendme.8
+++ b/src/backfire/sendme.8
@@ -12,7 +12,7 @@ The program \fBsendme\fR uses the \fBbackfire\fR driv=
er to send a signal from dr
 .SH "OPTIONS"
 .TP
 .B \-a, \-\-affinity[=3DPROC]
-Run on procesor number PROC. If PROC is not specified, run on current =
processor.
+Run on processor number PROC. If PROC is not specified, run on current=
 processor.
 .TP
 .B \-b, \-\-breaktrace=3DUSEC
 Send break trace command when latency > USEC. This is a debugging opti=
on to control the latency tracer in the realtime preemption patch.
diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index 4fecab5b7bd4..c92b4bdf5609 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -38,7 +38,7 @@ code paths for POSIX mutexes, in both the Linux kerne=
l and the C
 library. It runs as a realtime-priority task and launches
 .IR "inversion machine"
 thread groups. Each inversion group causes a
-.IR "priorty inversion"
+.IR "priority inversion"
 condition that will deadlock if=20
 .IR "priority inheritance"
 doesn't work.
diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 6e9719815165..05421e01e70b 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -12,7 +12,7 @@ The program \fBpmqtest\fR starts pairs of threads tha=
t are synchronized via mq_s
 .SH "OPTIONS"
 .TP
 .B \-a, \-\-affinity[=3DPROC]
-Run on procesor number PROC. If PROC is not specified, run on current =
processor.
+Run on processor number PROC. If PROC is not specified, run on current=
 processor.
 .TP
 .B \-b, \-\-breaktrace=3DUSEC
 Send break trace command when latency > USEC. This is a debugging opti=
on to control the latency tracer in the realtime preemption patch.
@@ -37,7 +37,7 @@ Set the priority of the process.
 Test mode for symmetric multi-processing, implies -a and -t and uses t=
he same priority on all threads.
 .TP
 .B \-t, \-\-threads[=3DNUM]
-Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fied, NUM is set to the number of available CPUs.
 .TP
 .B \-T, \-\-timeout=3DTO
 Use mq_timedreceive() instead of mq_receive() and specify timeout TO i=
n seconds.
diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 001e80936349..9d835337ec27 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -12,14 +12,14 @@ The program \fBptsematest\fR starts two threads tha=
t are synchronized via pthrea
 .SH "OPTIONS"
 .TP
 .B \-a, \-\-affinity[=3DPROC]
-Run on procesor number PROC. If PROC is not specified, run on current =
processor.
+Run on processor number PROC. If PROC is not specified, run on current=
 processor.
 .TP
 .B \-b, \-\-breaktrace=3DUSEC
 Send break trace command when latency > USEC. This is a debugging opti=
on to control the latency tracer in the realtime preemption patch.
 It is useful to track down unexpected large latencies of a system.
 .TP
 .B \-d, \-\-distance=3DDIST
-Set the distance of thread intervals in microseconds (default is 500 u=
s). When  cylictest is called with the -t option and more than one thre=
ad is created, then this distance value is added to the interval of the=
 threads: Interval(thread N) =3D Interval(thread N-1) + DIST
+Set the distance of thread intervals in microseconds (default is 500 u=
s). When  cyclictest is called with the -t option and more than one thr=
ead is created, then this distance value is added to the interval of th=
e threads: Interval(thread N) =3D Interval(thread N-1) + DIST
 .TP
 .B \-i, \-\-interval=3DINTV
 Set the base interval of the thread(s) in microseconds (default is 100=
0 us). This sets the interval of the first thread. See also -d.
@@ -31,7 +31,7 @@ Set the number of loops. The default is 0 (endless). =
This option is useful for a
 Set the priority of the process.
 .TP
 .B \-t, \-\-threads[=3DNUM]
-Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fied, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
 The following example was running on a 4-way processor:
 .LP
diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
index d6c11c213e11..634d392a6da5 100644
--- a/src/signaltest/signaltest.8
+++ b/src/signaltest/signaltest.8
@@ -11,7 +11,7 @@ These programs follow the usual GNU command line synt=
ax, with long options
 starting with two dashes ('\-\-').
 .TP
 .B \-b, \-\-breaktrace=3DUSEC
-Send break trace command whn latency > USEC
+Send break trace command when latency > USEC
 .TP
 .B \-l, \-\-loops=3DLOOPS
 Number of loops: default=3D0 (endless)
diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittes=
t.8
index 89a97f1e7557..2290ca2c76bc 100644
--- a/src/sigwaittest/sigwaittest.8
+++ b/src/sigwaittest/sigwaittest.8
@@ -8,18 +8,18 @@ sigwaittest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i=
 INTV] [-l loops] [-p PRIO]
 .br
 .SH "DESCRIPTION"
 .LP
-The program \fBsigwaittest\fR starts two threads or, optionally, forks=
 two processes that are synchonized via signals and measures the latenc=
y between sending a signal and returning from sigwait().
+The program \fBsigwaittest\fR starts two threads or, optionally, forks=
 two processes that are synchronized via signals and measures the laten=
cy between sending a signal and returning from sigwait().
 .SH "OPTIONS"
 .TP
 .B \-a, \-\-affinity[=3DPROC]
-Run on procesor number PROC. If PROC is not specified, run on current =
processor.
+Run on processor number PROC. If PROC is not specified, run on current=
 processor.
 .TP
 .B \-b, \-\-breaktrace=3DUSEC
 Send break trace command when latency > USEC. This is a debugging opti=
on to control the latency tracer in the realtime preemption patch.
 It is useful to track down unexpected large latencies of a system.
 .TP
 .B \-d, \-\-distance=3DDIST
-Set the distance of thread intervals in microseconds (default is 500 u=
s). When  cylictest is called with the -t option and more than one thre=
ad is created, then this distance value is added to the interval of the=
 threads: Interval(thread N) =3D Interval(thread N-1) + DIST
+Set the distance of thread intervals in microseconds (default is 500 u=
s). When  cyclictest is called with the -t option and more than one thr=
ead is created, then this distance value is added to the interval of th=
e threads: Interval(thread N) =3D Interval(thread N-1) + DIST
 .TP
 .B \-f, \-\-fork
 Instead of creating threads (which is the default), fork new processes
@@ -34,7 +34,7 @@ Set the number of loops. The default is 0 (endless). =
This option is useful for a
 Set the priority of the process.
 .TP
 .B \-t, \-\-threads[=3DNUM]
-Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fied, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
 The following example was running on a 4-way CPU:
 .LP
diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
index 93b163ea4dc0..0d4eaf3bb7ff 100644
--- a/src/svsematest/svsematest.8
+++ b/src/svsematest/svsematest.8
@@ -12,14 +12,14 @@ The program \fBsvsematest\fR starts two threads or,=
 optionally, forks two proces
 .SH "OPTIONS"
 .TP
 .B \-a, \-\-affinity[=3DPROC]
-Run on procesor number PROC. If PROC is not specified, run on current =
processor.
+Run on processor number PROC. If PROC is not specified, run on current=
 processor.
 .TP
 .B \-b, \-\-breaktrace=3DUSEC
 Send break trace command when latency > USEC. This is a debugging opti=
on to control the latency tracer in the realtime preemption patch.
 It is useful to track down unexpected large latencies of a system.
 .TP
 .B \-d, \-\-distance=3DDIST
-Set the distance of thread intervals in microseconds (default is 500 u=
s). When  cylictest is called with the -t option and more than one thre=
ad is created, then this distance value is added to the interval of the=
 threads: Interval(thread N) =3D Interval(thread N-1) + DIST
+Set the distance of thread intervals in microseconds (default is 500 u=
s). When  cyclictest is called with the -t option and more than one thr=
ead is created, then this distance value is added to the interval of th=
e threads: Interval(thread N) =3D Interval(thread N-1) + DIST
 .TP
 .B \-f, \-\-fork
 Instead of creating threads (which is the default), fork new processes
@@ -34,7 +34,7 @@ Set the number of loops. The default is 0 (endless). =
This option is useful for a
 Set the priority of the process.
 .TP
 .B \-t, \-\-threads[=3DNUM]
-Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not gi=
ven). If NUM is specified, create NUM test threads. If NUM is not speci=
fied, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
 The following example was running on a 4-way CPU:
 .LP
--=20
2.4.11

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
