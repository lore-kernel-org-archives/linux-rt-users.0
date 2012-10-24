From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Tue, 23 Oct 2012 22:01:54 -0700
Message-ID: <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain> <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmnlvqm76426ze@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37433 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab2JXFB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 01:01:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so961853pbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2012 22:01:56 -0700 (PDT)
In-Reply-To: <op.wmnlvqm76426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Oct 23, 2012, at 3:53 PM, Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com> wrote:

> I think it complains about not finding rootdevice. Anyway, I am getting a new machine, so it might not be much of an issue. If you still want to try and find the bug let me know. Also how do I compile without threadirqs, if I enable basic-rt, threadirqs are enabled in .config also.

rootdevice issues are most likely drivers/initrd related. Does your .config match a working Kernel's .config?

basic-rt is ambiguous, but IRQ threads are required to preempt inside critical sections shared with irqs.

Sven


> 
> Peace Be With You.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

