From: Mike Galbraith <bitbucket@online.de>
Subject: [patch 0/3] ipc/sem: fix livelock issue
Date: Fri, 13 Sep 2013 08:12:33 +0200
Message-ID: <1379052753.5455.126.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52784 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3IMGMm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 02:12:42 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This series:
1. removes live lockable retry loop in sem_lock().
2. reverts the current -rt wakeup scheme
3. replaces it with a new completion scheme

Removing the retry loop alone fixes the livelock problem, but the
current -rt wakeup scheme then ensures that wakees see the array lock in
a locked state, which split lock semantics require they react to by
taking the array lock themselves, defeating the whole purpose of
splitting the lock into simple/complex operation locks.

-Mike

