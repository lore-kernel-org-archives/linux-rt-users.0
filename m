From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch-rt] kvm: Convert pvclock_gtod_sync_lock to raw_spinlock_t
Date: Fri, 20 Jan 2017 18:32:42 +0100
Message-ID: <1484933562.20890.7.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1482735248.4476.58.camel@gmx.de>
         <20170120164423.iunwa3hntguswabj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:57318 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbdATRc5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2017 12:32:57 -0500
In-Reply-To: <20170120164423.iunwa3hntguswabj@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-01-20 at 17:44 +0100, Sebastian Andrzej Siewior wrote:

> kvm_make_mclock_inprogress_request() will do zalloc_cpumask_var().
> off-stack zalloc is not yet working but I would like to enable it. Also
> it does a SMP function call.
> 
> Couldn't we go the other way around and drop the local_irq_disable()?

I suppose so.

	-MIke
