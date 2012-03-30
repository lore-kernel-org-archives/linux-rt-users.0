From: Frank Rowand <frank.rowand@am.sony.com>
Subject: spin locks and migrate_disable()
Date: Fri, 30 Mar 2012 14:57:45 -0700
Message-ID: <4F762C59.4050008@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:47812
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965386Ab2C3V62 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Mar 2012 17:58:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Two questions about spin_lock() in include/linux/spinlock_rt.h.

(1) spin_lock() and related functions invoke migrate_disable() and
migrate_enable().  These functions are created by your patch,
sched-migrate-disable.patch, and are EXPORT_SYMBOL_GPL().  Would
you be willing to change these to EXPORT_SYMBOL()?

(2) What is the purpose of the migrate_disable() in the spin lock?
Is it a correctness issue, or a performance issue, or something else?

Thanks!

-Frank

