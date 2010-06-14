From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/6] hvc_console: Fix race between hvc_close and hvc_remove
Date: Tue, 15 Jun 2010 00:21:27 +0200
Message-ID: <1276554087-3632-7-git-send-email-jkacur@redhat.com>
References: <1276554087-3632-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55901 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079Ab0FNWVm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 18:21:42 -0400
In-Reply-To: <1276554087-3632-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Anton Blanchard <anton@samba.org>

I don't claim to understand the tty layer, but it seems like hvc_open and
hvc_close should be balanced in their kref reference counting.

Right now we get a kref every call to hvc_open:

        if (hp->count++ > 0) {
                tty_kref_get(tty); <----- here
                spin_unlock_irqrestore(&hp->lock, flags);
                hvc_kick();
                return 0;
        } /* else count == 0 */

        tty->driver_data = hp;

        hp->tty = tty_kref_get(tty); <------ or here if hp->count was 0

But hvc_close has:

        tty_kref_get(tty);

        if (--hp->count == 0) {
...
                /* Put the ref obtained in hvc_open() */
                tty_kref_put(tty);
...
        }

        tty_kref_put(tty);

Since the outside kref get/put balance we only do a single kref_put when
count reaches 0.

The patch below changes things to call tty_kref_put once for every
hvc_close call, and with that my machine boots fine.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Upstream-commit: 320718ee074acce5ffced6506cb51af1388942aa
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 drivers/char/hvc_console.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index da70f68..2898084 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -367,16 +367,12 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 	hp = tty->driver_data;
 
 	spin_lock_irqsave(&hp->lock, flags);
-	tty_kref_get(tty);
 
 	if (--hp->count == 0) {
 		/* We are done with the tty pointer now. */
 		hp->tty = NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
 
-		/* Put the ref obtained in hvc_open() */
-		tty_kref_put(tty);
