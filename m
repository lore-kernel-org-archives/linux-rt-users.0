From: Clark Williams <williams@redhat.com>
Subject: RT 2.6.22.1-rt4 minor fixes for StGit import
Date: Mon, 16 Jul 2007 14:05:40 -0500
Message-ID: <469BC184.9080203@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090908010006010106040400"
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbXGPTI7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2007 15:08:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------090908010006010106040400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas/Ingo,

Attached is a minor patch against the broken out -rt4 which fixes a couple of things
that break an StGit import of the patch series.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGm8GEHyuj/+TTEp0RAnzfAKDml6jOrXp30x/np0orez9+dMVeMACg3n2o
0qQpWmxWM6uyStSgfJetm3c=
=fUj5
-----END PGP SIGNATURE-----

--------------090908010006010106040400
Content-Type: text/x-patch;
 name="rt4-patch-fixups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt4-patch-fixups.patch"

diff -ru patches/kstat-add-rt-stats.patch patch-queue-2.6.22.1-rt4/kstat-add-rt-stats.patch
--- patches/kstat-add-rt-stats.patch	2007-07-16 04:29:48.000000000 -0500
+++ patch-queue-2.6.22.1-rt4/kstat-add-rt-stats.patch	2007-07-16 13:57:21.000000000 -0500
@@ -1,4 +1,4 @@
-From: tglx
+From: Thomas Gleixner <tglx@linutronix.de>
 Subject: add rt stats to /proc/stat
 
 add RT stats to /proc/stat
diff -ru patches/preempt-realtime-net-softirq-fixups.patch patch-queue-2.6.22.1-rt4/preempt-realtime-net-softirq-fixups.patch
--- patches/preempt-realtime-net-softirq-fixups.patch	2007-07-16 04:29:49.000000000 -0500
+++ patch-queue-2.6.22.1-rt4/preempt-realtime-net-softirq-fixups.patch	2007-07-16 14:00:40.000000000 -0500
@@ -1,6 +1,6 @@
 Subject: NOHZ: local_softirq_pending with tickless
 
-From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz
+From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
 
 On one of my machines with tickless kernel and plip I get messages :
 

--------------090908010006010106040400--
