From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH][RT] Compile-time fix.
Date: Tue, 09 Dec 2008 22:53:22 -0800
Message-ID: <1228892002.9542.4.camel@dd>
References: <alpine.DEB.1.10.0812090946210.16798@gandalf.stny.rr.com>
	 <1228890920.9542.2.camel@dd>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Gregory Haskins <ghaskins@novell.com>,
	Darren Hart <dvhltc@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:47475 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbYLJGx1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2008 01:53:27 -0500
Received: by wf-out-1314.google.com with SMTP id 27so30483wfd.4
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Dec 2008 22:53:27 -0800 (PST)
In-Reply-To: <1228890920.9542.2.camel@dd>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Compile-time fix.

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 585feed..b74fdc2 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -14,7 +14,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/linkage.h>
 #include <linux/lockdep.h>
