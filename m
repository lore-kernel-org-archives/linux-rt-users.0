From: Mike Galbraith <bitbucket@online.de>
Subject: [RFC PATCH] rt, lockdep: double
 MAX_LOCKDEP_ENTRIES/MAX_LOCKDEP_CHAINS_BITS
Date: Wed, 24 Apr 2013 09:11:15 +0200
Message-ID: <1366787475.5977.16.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52231 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab3DXHLa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Apr 2013 03:11:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Test driving v3.6-rt, lockdep shuts itself off soon after boot.

[  117.940497] BUG: MAX_LOCKDEP_ENTRIES too low!
[  117.940498] turning off the locking correctness validator.
[  117.940502] Pid: 5242, comm: kio_trash Not tainted 3.6.11.1-rt32-smp #51

Doubling MAX_LOCKDEP_ENTRIES/MAX_LOCKDEP_CHAINS_BITS appeased it.  Box
has been up for an hour without lockdep taking it's toys and going home.

Signed-off-by: Mike Galbraith <bitbucket@online.de>

---
 kernel/lockdep_internals.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/lockdep_internals.h
+++ b/kernel/lockdep_internals.h
@@ -54,9 +54,9 @@ enum {
  * table (if it's not there yet), and we check it for lock order
  * conflicts and deadlocks.
  */
-#define MAX_LOCKDEP_ENTRIES	16384UL
+#define MAX_LOCKDEP_ENTRIES	32768UL
 
-#define MAX_LOCKDEP_CHAINS_BITS	15
+#define MAX_LOCKDEP_CHAINS_BITS	16
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
 #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)


