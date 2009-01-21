From: Gregory Haskins <ghaskins@novell.com>
Subject: [RT] [git pull] updates for rt/sched
Date: Wed, 21 Jan 2009 12:51:29 -0500
Message-ID: <497760A1.9090806@novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig24E8956E9FB4148533B458B3"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux >> LKML" <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:44869 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbZAURsm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Jan 2009 12:48:42 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24E8956E9FB4148533B458B3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Steve,
  Here is a backport of the latest patches that went into tip/sched/rt

-Greg


-------------
The following changes since commit 0ea6fdc871f24f65e28cd9a92ead1c88178374=
1a:
  Gregory Haskins (1):
        rt/sched: ensure interrupts are disabled during post-schedule()
processing

are available in the git repository at:

=20
git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/linux-2.6-hacks.gi=
t
rt/sched

Gregory Haskins (6):
      sched: cleanup inc/dec_rt_tasks
      sched: track the next-highest priority on each runqueue
      sched: use highest_prio.curr for pull threshold
      sched: use highest_prio.next to optimize pull operations
      sched: de CPP-ify the scheduler code
      sched: fix build error in kernel/sched_rt.c when RT_GROUP_SCHED &&
!SMP

Peter Zijlstra (1):
      sched: make plist a library facility

 init/Kconfig      |    1 -
 kernel/sched.c    |   12 ++-
 kernel/sched_rt.c |  372
++++++++++++++++++++++++++++++++++------------------
 lib/Kconfig       |    6 -
 lib/Makefile      |    4 +-
 5 files changed, 255 insertions(+), 140 deletions(-)



--------------enig24E8956E9FB4148533B458B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkl3YKEACgkQlOSOBdgZUxlnSQCgiWMjKc0G6WwUICf8AvzZvnaM
p8kAmwS+ISJVWoqcO7cU/mXZFx0JsVcK
=Hc5L
-----END PGP SIGNATURE-----

--------------enig24E8956E9FB4148533B458B3--
