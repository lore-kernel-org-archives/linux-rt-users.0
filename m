From: Peter Zijlstra <peterz@infradead.org>
Subject: [ANNOUNCE] 3.0.1-rt11
Date: Sat, 13 Aug 2011 12:53:10 +0200
Message-ID: <1313232790.25267.7.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <efault@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45257 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1HMKxf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 13 Aug 2011 06:53:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Whee, I can skip release announcements too!

So no the subject ain't no mistake its not, 3.0.1-rt11 is there for the
grabs.

Changes include (including the missing -rt10):

  - hrtimer fix that should make RT_GROUP work again
  - RCU fixes that should make the RCU stalls go away
  - fixes SMP=n builds after breaking them in -rt9


The patch should be at (once the mirrors catch up):

  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0.1-rt11.patch.bz2

The quilt series can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0.1-rt11.tar.bz2


