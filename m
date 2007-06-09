From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.21.4-rt11
Date: Sat, 9 Jun 2007 23:05:07 +0200
Message-ID: <20070609210507.GA29194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:43033 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760357AbXFIVFZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Jun 2007 17:05:25 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


i'm pleased to announce the v2.6.21.4-rt11 kernel, which can be 
downloaded from the usual place:
 
     http://people.redhat.com/mingo/realtime-preempt/
  
more info about the -rt patchset can be found in the RT wiki:
   
     http://rt.wiki.kernel.org

-rt11 is a bit more experimental than usual: it includes the CFS 
scheduler. Several people have suggested the inclusion of CFS into the 
-rt tree: the determinism of the CFS scheduler is a nice match to the 
determinism offered by PREEMPT_RT. The port of CFS to -rt was done by 
Dinakar Guniguntala. Tested on i686 and x86_64.
 
to build a 2.6.21.4-rt11 tree, the following patches should be applied:
  
    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.4.tar.bz2
    http://people.redhat.com/mingo/realtime-preempt/patch-2.6.21.4-rt11
  
	Ingo
