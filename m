From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3][FYI only] 3.2-rt cpu hotplug fix (hack)
Date: Mon, 05 Mar 2012 21:38:35 -0500
Message-ID: <20120306023835.775610473@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Clark Williams <clark.williams@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3939 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030235Ab2CFCpX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Mar 2012 21:45:23 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an FYI patch set only. It fixes a lot of the races that the
current -rt patch has with stressing hotplug.

Although this patch set (well patch one really) does prove to solve a
lot of the race conditions caused by notifiers waiting on tasks
that may be on the CPU going down, the patch itself is not at the
state that it should be accepted.

I'm posting this only for those that need a current fix while we work
on a real fix. Again, this patch set is an actual fix to several issues
with hotplug. But it makes the code even more hacky and there's
better ways to solve the issues.

I've been running my CPU hotplug stress test and a distcc kernel
compile (-j20) on a 4 way machine for the last 30 minutes (both in a
while loop) and it's still going strong.

This patch set goes on top of 3.2.9-rt15

Have fun,

-- Steve

