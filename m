From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: [PATCH][RT] pty low latency
Date: Wed, 12 Aug 2009 21:42:17 -0700
Message-ID: <1250138537.15796.18.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47415 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751512AbZHMEmW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Aug 2009 00:42:22 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Subject: add hunks dropped in rt 2.6.31-rc5-rt1.1 forward port
From: patch-2.6.31-rc4-rt1
Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -52,6 +52,7 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 		return;
 	tty->link->packet = 0;
 	set_bit(TTY_OTHER_CLOSED, &tty->link->flags);
+	tty_flip_buffer_push(tty->link);
 	wake_up_interruptible(&tty->link->read_wait);
 	wake_up_interruptible(&tty->link->write_wait);
 	if (tty->driver->subtype == PTY_TYPE_MASTER) {
@@ -207,6 +208,7 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	set_bit(TTY_THROTTLED, &tty->flags);
 	retval = 0;
+	tty->low_latency = 1;
 out:
 	return retval;
 }


