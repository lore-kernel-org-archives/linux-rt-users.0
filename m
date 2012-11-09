From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Thu, 8 Nov 2012 22:42:37 -0600
Message-ID: <20121109044237.GE1718@beefymiracle.amer.corp.natinst.com>
References: <509C3220.2050601@slac.stanford.edu>
 <20121109040810.GD1718@beefymiracle.amer.corp.natinst.com>
 <509C8685.3000704@slac.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Till Straumann <strauman@slac.stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:39232 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2KIEml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 23:42:41 -0500
In-Reply-To: <509C8685.3000704@slac.stanford.edu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 08, 2012 at 10:28:53PM -0600, Till Straumann wrote:
> Thanks, that's helpful.
> 
> Wouldn't it also be possible to make my own version of
> prepare_to_wait()/finish_wait()/wake_up() etc. which internally
> use a raw spinlock instead of a normal one?

I believe that what you described used to exist in the form of a
'simple' waitqueue, but I don't recall what happened to it.  Maybe
Thomas can shed some light here.

In general though, if you care about determinism, you'd want to avoid
the use of such a mechanism unless you can somehow externally provide an
upper bound on the number of waiters.

  Josh
