From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.21-rt3
Date: Thu, 17 May 2007 21:41:43 +0200
Message-ID: <20070517194143.GA25394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36212 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437AbXEQTlr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 May 2007 15:41:47 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

i'm pleased to announce the v2.6.21-rt3 kernel, which can be downloaded 
from the usual place:

    http://redhat.com/~mingo/realtime-preempt/
 
more info about the -rt patchset can be found in the RT wiki:
 
    http://rt.wiki.kernel.org

This is a fixes-only release assembled by Thomas Gleixner. Many PPC 
fixes from Sergei Shtylyov, dynticks softirq fixes from Mikulas Patocka, 
a CONFIG_IRQSOFF_TIMING fix from Daniel Walker and x86_64 hrt fixes from 
Thomas Gleixner.

to build a 2.6.21-rt3 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.21-rt3

	Ingo
