From: Mike Galbraith <efault@gmx.de>
Subject: patches/mm-memory-rt.patch can go away
Date: Sun, 21 Aug 2011 10:30:18 +0200
Message-ID: <1313915418.12970.2.camel@marge.simson.net>
References: <1313232790.25267.7.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:37284 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751135Ab1HUIaW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Aug 2011 04:30:22 -0400
In-Reply-To: <1313232790.25267.7.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

marge:/usr/local/src/kernel/linux-3.0 # git grep ZAP_BLOCK_SIZE

mm/memory.c:# define ZAP_BLOCK_SIZE     (8 * PAGE_SIZE)
mm/memory.c:# define ZAP_BLOCK_SIZE     (1024 * PAGE_SIZE)
mm/memory.c: * So zap pages in ZAP_BLOCK_SIZE bytecounts.  This means we need to
lines 1-3/3 (END)

	-Mike

