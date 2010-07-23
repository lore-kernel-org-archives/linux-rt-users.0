From: Mike Galbraith <efault@gmx.de>
Subject: 2.6.33.6-rt26: consoles not working properly
Date: Fri, 23 Jul 2010 16:39:45 +0200
Message-ID: <1279895985.9947.10.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050Ab0GWOjM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Jul 2010 10:39:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

Consoles (serial and vt) are going silent after.

[    1.100178] Freeing initrd memory: 9348k freed
[    1.453009] Freeing unused kernel memory: 1000k freed
[    1.464463] Freeing unused kernel memory: 512k freed
[    1.469724] Freeing unused kernel memory: 360k freed

If the kernel is configured PREEMPT_VOLUNTARY, consoles work fine again.
So far, I've only eyeballed the rt patch, and noticed nothing.  I'll be
poking around in (shudder) console code soon I suppose, but before I
start that.. adventure, is this a known issue?

	-Mike

