From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 08 Apr 2016 14:10:21 +0200
Message-ID: <1460117421.5582.35.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <57068F28.8010409@linutronix.de> <1460055880.4435.61.camel@gmail.com>
	 <5707883F.4080302@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34128 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbcDHMKZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2016 08:10:25 -0400
In-Reply-To: <5707883F.4080302@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2016-04-08 at 12:30 +0200, Sebastian Andrzej Siewior wrote:
> On 04/07/2016 09:04 PM, Mike Galbraith wrote:
> > > just to be clear: The patch I attached did _not_ work for you.
> > 
> > Sorry, I didn't test.  Marathon stress test session convinced me that
> > the lock added by -rt absolutely had to die.
> 
> Okay. And the patch did that. I removed the lock.

But also adds when it appears no addition is required.  I don't care
how it dies though, only that it does.

> I see. So what I don't like are all the exceptions you have: one for
> RCU and one kernfs. There might come more in the future. So what I aim
> is the removal of the lock.

Yes, those two were bandaids to allow searching for more -rt specific
disease (none found).  Removing that lock is the cure.

	-Mike
