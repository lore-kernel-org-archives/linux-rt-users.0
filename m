From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/3] sched: newidle and RT wake-buddy fixes
Date: Fri, 27 Jun 2008 14:29:44 -0600
Message-ID: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: npiggin@suse.de, ghaskins@novell.com, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu, peterz@infradead.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lsg.lsg.lab.novell.com ([151.155.230.1]:8144 "EHLO
	lsg.lsg.lab.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494AbYF0U3q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 16:29:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo,
  The following patches apply to linux-tip/sched/devel and enhance the
performance of the kernel (specifically in PREEMPT_RT, though they do
not regress mainline performance as far as I can tell).  They offer
somewhere between 50-100% speedups in netperf performance, depending
on the test.

Should you be interested in these patches, you can optionally pull them
from git at the following URL:

git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/linux-2.6-hacks.git sched-devel

Comments/feedback/bugfixes welcome

Regards,
-Greg
