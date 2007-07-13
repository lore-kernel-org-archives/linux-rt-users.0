From: Thomas Gleixner <tglx@linutronix.de>
Subject: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 13:22:32 +0200
Message-ID: <1184325752.12353.312.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:54111 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753953AbXGMLWk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 07:22:40 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

we are pleased to announce the v2.6.22.1-rt3 kernel

Attention! 

Ingo is off for a long weekend and therefor the download location for
this release is:

 http://www.tglx.de/projects/preempt-rt/2.6.22.1
  
more info about the -rt patchset can be found in the RT wiki:
  
   http://rt.wiki.kernel.org
 
This release is bugfix release:

- update of the x8664 -hrt queue (resolve boot problems)
- gtod vsyscall fix from Gregory Haskins

to build a 2.6.22.1-rt3 tree, the following patches should be applied:
 
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.bz2
   http://www.tglx.de/projects/preempt-rt/2.6.22.1-rt3/patch-2.6.22.1-rt3.patch


	Thomas
