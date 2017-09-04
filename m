From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v4.11.12-rt10 - hotplug lockdep splat
Date: Mon, 4 Sep 2017 16:58:14 +0200
Message-ID: <20170904145814.tenvql4vdkexfzeb@linutronix.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
 <1503482024.4970.5.camel@gmx.de>
 <20170831161834.t7ymwsnpbko6und5@linutronix.de>
 <1504406890.3054.3.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42407 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753667AbdIDO6R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Sep 2017 10:58:17 -0400
Content-Disposition: inline
In-Reply-To: <1504406890.3054.3.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-09-03 04:48:10 [+0200], Mike Galbraith wrote:
> Missed a spot.  With this on top, lockdep went silent.
> 
> kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock
> 
> kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
> missed a path, namely hrtimers_dead_cpu() -> migrate_hrtimer_list().  Defer
> raising softirq until after base lock has been released there as well.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
Thank you, applied.

Sebastian
