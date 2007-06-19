From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] disable preemption on running show all regs.
Date: Tue, 19 Jun 2007 17:36:01 -0400
Message-ID: <1182288961.15228.35.camel@localhost.localdomain>
References: <1182284276.15228.25.camel@localhost.localdomain>
	 <1182286634.18168.48.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:48683 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbXFSVgz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 17:36:55 -0400
In-Reply-To: <1182286634.18168.48.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-06-19 at 13:57 -0700, Daniel Walker wrote:

> Looks like you have a whitespace issue here.. Should be tabs, not
> spaces.


Bah, there's a "/* -*- linux-c -*- " at the top of that file that's
messing up with my emacs!

Is this better :-p

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.21.5-rt15/drivers/char/sysrq.c
===================================================================
--- linux-2.6.21.5-rt15.orig/drivers/char/sysrq.c
+++ linux-2.6.21.5-rt15/drivers/char/sysrq.c
@@ -213,7 +213,9 @@ static struct sysrq_key_op sysrq_showreg
 
 static void sysrq_handle_showallregs(int key, struct tty_struct *tty)
 {
+	preempt_disable();
 	nmi_show_all_regs();
+	preempt_enable();
 }
 
 static struct sysrq_key_op sysrq_showallregs_op = {
