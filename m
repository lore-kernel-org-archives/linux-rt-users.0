From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.22.1-rt1
Date: Thu, 12 Jul 2007 14:13:55 +0200
Message-ID: <20070712121355.GA10949@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40027 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763554AbXGLMOB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 08:14:01 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


we are pleased to announce the v2.6.22.1-rt1 kernel, which can be 
downloaded from the usual place:
 
   http://redhat.com/~mingo/realtime-preempt/
  
more info about the -rt patchset can be found in the RT wiki:
  
   http://rt.wiki.kernel.org
 
This release is a port of -rt to the latest upstream kernel. Thomas' 
latest -hrt queue is included and also the latest CFS changes. The SMP 
balancing fix from Sebastien Dugue is included as well.

to build a 2.6.22.1-rt1 tree, the following patches should be applied:
 
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.22.1-rt1
 
	Ingo
