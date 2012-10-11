From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Crap, ksoftirqd/0 looping forever in softirq
Date: Thu, 11 Oct 2012 10:21:31 -0400
Message-ID: <20121011142130.GA22583@windriver.com>
References: <20121011001637.GA18628@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48169 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab2JKOVm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 10:21:42 -0400
Content-Disposition: inline
In-Reply-To: <20121011001637.GA18628@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Crap, ksoftirqd/0 looping forever in softirq] On 10/10/2012 (Wed 20:16) Paul Gortmaker wrote:

> Seeing the above message, I added a trivial change to print out the
> Mask and Pending, and I consistently saw it was (both p/m) in every
> case `was __IRQF_TIMER (0x200).

Of cource it helps if I look up the value in the right list.
I guess the ffs had me thinking "bits", instead of looking up
the value in the softirq enum list.

When I add a change to record the last vecs used and dump them
out when the Crap message is triggered (using softirq_to_name
instead of looking things up in random tables!)  I get this:

[   20.887137] Crap, ksoftirqd/0 looping forever in softirq
[   20.887150] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
[   20.920168] Crap, ksoftirqd/0 looping forever in softirq
[   20.920179] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
[   20.954200] Crap, ksoftirqd/0 looping forever in softirq
[   20.954213] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU

Which makes my previous guess complete garbage...

Paul.
