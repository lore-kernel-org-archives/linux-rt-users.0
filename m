From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ide: Build break in ide-iops.c
Date: Fri, 12 Mar 2010 13:40:54 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003121340120.22855@localhost.localdomain>
References: <1268395850-23408-1-git-send-email-jkacur@redhat.com>  <1268395850-23408-2-git-send-email-jkacur@redhat.com> <1268396220.9130.4.camel@falcon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: Wu Zhangjin <wuzhangjin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34766 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab0CLMlU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Mar 2010 07:41:20 -0500
In-Reply-To: <1268396220.9130.4.camel@falcon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 12 Mar 2010, Wu Zhangjin wrote:

> On Fri, 2010-03-12 at 13:10 +0100, John Kacur wrote:
> > I get the following build break due to 876c52cc046e00eaa2ffc5124dc187106ef57594
> > 
> > drivers/ide/ide-iops.c:29:26: error: asm/bootinfo.h: No such file or directory
> > 
> 
> I think we'd better revert that commit
> 876c52cc046e00eaa2ffc5124dc187106ef57594 for it has introduced some arch
> specific parts into the common ide source code.
> 
> And that commit doesn't influence the preempt-rt support, so, Thomas,
> could you please revert it directly, thanks!

Right, that just popped up in testing. I pushed -rt7 with the revert

Thanks,

	tglx
