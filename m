From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.21.4-rt10
Date: Sat, 9 Jun 2007 22:40:54 +0200
Message-ID: <20070609204054.GA24503@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:55408 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbXFIUlA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Jun 2007 16:41:00 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

i'm pleased to announce the v2.6.21.4-rt10 kernel, which can be 
downloaded from the usual place:

     http://redhat.com/~mingo/realtime-preempt/
  
more info about the -rt patchset can be found in the RT wiki:
  
     http://rt.wiki.kernel.org

This is a fixes-only release assembled by Thomas Gleixner again. On 
popular request this -rt tree is against the stable dot kernel - i.e. 
apply it to a v2.6.21.4 tree, not a v2.6.21 tree.

-rt10 includes the futex fixes and the latest hrtimer updates from 
Thomas Gleixner, latency tracer fixes from Carsten Emde, tasklet fix 
from John Stultz, rcu tasklet -> softirq conversion and the 
enable-irqs-in-pagefaults fix from Steven Rostedt, and other, smaller 
fixes.

to build a 2.6.21.4-rt10 tree, the following patches should be applied:
 
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.4.tar.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.21.4-rt10
 
	Ingo
