From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/3] RT: scheduler newidle enhancements v2
Date: Tue, 24 Jun 2008 08:14:52 -0600
Message-ID: <20080624140926.28259.2884.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
	linux-rt-users@vger.kernel.org, ghaskins@novell.com,
	dbahi@novell.com
To: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lsg.lsg.lab.novell.com ([151.155.230.1]:4983 "EHLO
	lsg.lsg.lab.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYFXOOw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 10:14:52 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

 Here is v2 of the newidle patches I sent out yesterday:

http://lkml.org/lkml/2008/6/23/392

Changes since v1:

1) Added a new patch (1/3) for limiting balance operations to sd->span
2) Updated prologue to 2/3 according to comments from PeterZ.
3) Enhanced 2/3 by reducing the amount of unlock/lock cycles
4) Enhanced 2/3 by checking for need_resched() before taking the double-lock

Comments/feedback/bug-fixes welcome.

Regards,
-Greg
