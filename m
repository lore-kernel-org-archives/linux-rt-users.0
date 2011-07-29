From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: How to contribute PREEMPT_RT?
Date: Fri, 29 Jul 2011 08:28:44 -0700
Message-ID: <4E32D1AC.2030402@linux.intel.com>
References: <CADr7Lg=XniTWvhhxtvsUW5S-E+S_3knXLiOGEopL7wU8NdkLfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: YOSHIDA Shigeru <yshigeru@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61429 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1G2P2p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:28:45 -0400
In-Reply-To: <CADr7Lg=XniTWvhhxtvsUW5S-E+S_3knXLiOGEopL7wU8NdkLfg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 07/29/2011 02:30 AM, YOSHIDA Shigeru wrote:
> Hi,
> 
> I develop real-time systems in my job.
> Our product uses Conccurent RedHawk Linux.
> So, I became interested in real-time Linux internals,
> and PREEMPT_RT is very attractive.
> 
> Where do I start from?

Have a look at rt.wiki.kernel.org

> How to contribute PREEMPT_RT?
> Are there anything like a bug list?

We use this mailing list and LKML to report issues with RT and provide
fixes (respectively). We do not yet have a separate bugzilla.

Thomas, would it be inappropriate to use the kernel.org bugzilla?
Perhaps if we had another "Product" defined for preempt_rt ?


Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
