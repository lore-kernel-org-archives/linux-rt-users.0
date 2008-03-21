From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt] rt-slab: fix cpu inconsistency case
Date: Fri, 21 Mar 2008 11:11:17 -0700
Message-ID: <1206123077.10894.221.camel@localhost.localdomain>
References: <47E2A63B.4020003@ct.jp.nec.com>
	 <Pine.LNX.4.58.0803201519160.21990@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:45844 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759495AbYCUSLW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Mar 2008 14:11:22 -0400
In-Reply-To: <Pine.LNX.4.58.0803201519160.21990@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2008-03-20 at 15:32 -0400, Steven Rostedt wrote:
> And these are the PREEMPT_RT version. So basically, this patch is a
> nop
> for PREEMPT_RT. I doubt it will solve your bug ;-)


He said it was a !PREEMPT_RT issue (in the -rt tree) ..

Daniel

