From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.22.1-rt5
Date: Mon, 23 Jul 2007 23:02:36 +0200
Message-ID: <20070723210236.GA25104@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36997 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761235AbXGWVCk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 17:02:40 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


we are pleased to announce the v2.6.22.1-rt5 kernel (collected and 
assembled by Thomas), which can be downloaded from the usual place:
  
  http://redhat.com/~mingo/realtime-preempt/
  
more info about the -rt patchset can be found in the RT wiki:
   
  http://rt.wiki.kernel.org

Changes since -rt4:

 - MM fix: PCP pages locking (Peter Zijlstra)

 - yield() fix: remove stale RCU-unlock (Daniel Walker)

 - dont do check_pgt_cache() in idle (found by Daniel Walker)

 - moved 8 patches, created 6 new patches out of larger patches to 
   make the -rt queue more bisectable (Daniel Walker)

 - cleanup (Daniel Walker)

 - fix the latency tracer under paravirt

to build a 2.6.22.1-rt5 tree, the following patches should be applied:
  
  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.22.1-rt5
  
	Ingo
