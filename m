From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.33.3-rt19 kernel BUG's
Date: Fri, 07 May 2010 23:58:45 +0000
Message-ID: <1273276725.17045.4.camel@localhost.localdomain>
References: <1273197218.6768.10.camel@localhost.localdomain>
	 <alpine.LFD.2.00.1005071240350.3401@localhost.localdomain>
	 <1273275821.2776.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Piggin <npiggin@suse.de>
To: john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4.Stanford.EDU ([171.67.219.84]:54708 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075Ab0EHAJH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 May 2010 20:09:07 -0400
In-Reply-To: <1273275821.2776.3.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-05-07 at 16:43 -0700, john stultz wrote:
> On Fri, 2010-05-07 at 12:41 +0200, Thomas Gleixner wrote:
> > On Thu, 6 May 2010, Fernando Lopez-Lezcano wrote:
> > 
> > CC'ed John and Nick
> > 
> > > See below... just trying to boot (quad core desktop machine).
> 
> Ok. Got this to reproduce. Will hopefully have a fix for your soon.
> 
> Thanks for the bug report!

Thanks for looking at it! It had been a while since I had problems with
rt so I could not understand why I could not login :-) 

-- Fernando


