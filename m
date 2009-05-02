From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] escape minus signs in manpages
Date: Sat,  2 May 2009 20:53:20 +0200
Message-ID: <1241290402-15234-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090502185004.GA14150@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46471 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbZEBSx1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 May 2009 14:53:27 -0400
In-Reply-To: <20090502185004.GA14150@cassiopeia.tralala>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

'-' chars are interpreted as hyphens by groff, not as minus signs.  Thi=
s
means that if you're using an UTF-8 locale searching for '-' to find
options doesn't work.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/cyclictest/cyclictest.8 |   14 +++++++-------
 src/pi_tests/pi_stress.8    |   16 ++++++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index b54e213..48b2c5e 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -79,13 +79,13 @@ CLOCK_REALTIME can be set by settimeofday, while CL=
OCK_MONOTONIC can not be modi
 This option has no influence when the \-s option is given.
 .TP
 .B \-C, \-\-context
-context switch tracing (used with -b)
+context switch tracing (used with \-b)
 .TP
 .B \-d, \-\-distance=3DDIST
-Set the distance of thread intervals in microseconds (default is 500us=
). When cylictest is called with the \-t option and more than one threa=
d is created, then this distance value is added to the interval of the =
threads: Interval(thread N) =3D Interval(thread N-1) + DIST
+Set the distance of thread intervals in microseconds (default is 500us=
). When cylictest is called with the \-t option and more than one threa=
d is created, then this distance value is added to the interval of the =
threads: Interval(thread N) =3D Interval(thread N\-1) + DIST
 .TP
 .B \-E, \-\-event
-event tracing (used with -b)
+event tracing (used with \-b)
 .TP
 .B \-f, \-\-ftrace
 Enable function tracing using ftrace as tracer. This option is availab=
le only with \-b.
@@ -114,7 +114,7 @@ times for multiple trace options. For example trace=
 options look at /sys/kernel/
 .TP
 .B \-p, \-\-prio=3DPRIO
 Set the priority of the first thread. The given priority is set to the=
 first test thread. Each further thread gets a lower priority:
-Priority(Thread N) =3D max(Priority(Thread N-1) - 1, 0)
+Priority(Thread N) =3D max(Priority(Thread N\-1) \- 1, 0)
 .TP
 .B \-q, \-\-quiet
 Run the tests quiet and print only a summary on exit. Useful for autom=
ated tests, where only the summary output needs to be captured.
@@ -126,7 +126,7 @@ Use relative timers instead of absolute. The defaul=
t behaviour of the tests is t
 Use sys_nanosleep and sys_setitimer instead of posix timers. Note, tha=
t \-s can only be used with one thread because itimers are per process =
and not per thread. \-s in combination with \-n uses the nanosleep sysc=
all and is not restricted to one thread.
 .TP
 .B \-T, \-\-tracer=3DTRACEFUNC
-set the ftrace tracer function. Used with the -b option. Must be one
+set the ftrace tracer function. Used with the \-b option. Must be one
 of the trace functions available from <debugfs-mountpoint>/kernel/debu=
g/tracing/available_tracers
 .TP
 .B \-t, \-\-threads[=3DNUM]
@@ -147,10 +147,10 @@ where n=3Dtask number c=3Dcount v=3Dlatency value=
 in us. Use this option in combinatio
 Run the test for the specified time, which defaults to seconds. Append=
 'm', 'h', or 'd' to specify minutes, hours or days
 .TP
 .B \\-w, \-\-wakeup=20
-task wakeup tracing (used with -b)
+task wakeup tracing (used with \-b)
 .TP
 .B \\-W, \-\-wakeuprt
-rt-task wakeup tracing (used with -b)
+rt-task wakeup tracing (used with \-b)
 .\" .SH SEE ALSO
 .\" .BR bar (1),
 .\" .BR baz (1).
diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index cfff3f9..4fecab5 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -19,13 +19,13 @@ pi_stress \- a stress test for POSIX Priority Inher=
itance mutexes
 .IR seconds ]
 .RB [ \-g|\-\-groups
 .IR groups
-.RB [ \-d|--debug ]
-.RB [ \-v|--verbose ]
-.RB [ \-s|--signal ]
-.RB [ \-r|--rr ]
-.RB [ \-p|--prompt ]
-.RB [ \-m|--mlockall ]
-.RB [ \-u|--uniprocessor ]
+.RB [ \-d|\-\-debug ]
+.RB [ \-v|\-\-verbose ]
+.RB [ \-s|\-\-signal ]
+.RB [ \-r|\-\-rr ]
+.RB [ \-p|\-\-prompt ]
+.RB [ \-m|\-\-mlockall ]
+.RB [ \-u|\-\-uniprocessor ]
 .br
 .\" help
 .B pi_stress
@@ -48,7 +48,7 @@ doesn't work.
 Run for
 .I n
 number of inversion conditions. This is the total number of inversions
-for all inversion groups. Default is -1 for infinite.
+for all inversion groups. Default is \-1 for infinite.
 .IP "\-t n|\-\-duration=3Dn"
 Run the test for=20
 .I n
--=20
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
