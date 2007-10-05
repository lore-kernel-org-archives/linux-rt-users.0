From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/2] [RFC] RT: Optionally allow IRQF_NODELAY on serial console
Date: Fri, 05 Oct 2007 11:42:04 -0400
Message-ID: <20071005153517.24349.62653.stgit@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	ghaskins@novell.com
To: mingo@elte.hu, tglx@linutronix.de, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:36243
	"EHLO ghaskins-t60p.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755739AbXJEPoV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Oct 2007 11:44:21 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This series may help debugging certain circumstances where the serial
console is unreponsive (e.g. RT51+ spinner, or scheduler problem).  It changes
the serial8250 driver to use IRQF_NODELAY so that interrupts execute in irq
context instead of a kthread.

It works pretty well on this end, though it is admitted not fully baked.  For
instance, a few paths in sysrq can still call into non-raw spinlocks
(sched_debug_show, for instance) which will cause subsequent errors.  Also,
if you use KDB, be sure to convert the kdb_printf_lock to raw as well.  I may
send a KDB related patch seperately.

I am sending this out now in case it is helpful to someone.

Regards,
-Greg   
