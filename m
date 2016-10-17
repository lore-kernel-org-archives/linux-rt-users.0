From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Mon, 17 Oct 2016 18:19:00 +0200
Message-ID: <1476721140.30636.10.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
         <1476587662.1538.8.camel@gmail.com>
         <20161017142428.25dyxefk2arjeyfz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34324 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932702AbcJQQTE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Oct 2016 12:19:04 -0400
In-Reply-To: <20161017142428.25dyxefk2arjeyfz@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-10-17 at 16:24 +0200, Sebastian Andrzej Siewior wrote:
> On 2016-10-16 05:14:22 [+0200], Mike Galbraith wrote:
> > 
> > In v4.7, the driver switched to percpu compression streams, disabling
> > preemption (get/put_cpu_ptr()).  Use get/put_cpu_light() instead.
> 
> I am not convinced that this will work. Nothing prevents
> zram_bvec_write() to be reentrant on the same CPU what I can tell from
> browsing over the code and since it uses zstrm->buffer for compression
> it can go wrong. Also I don't know if crypto's tfm handler can be used
> in parallel for any ops (it usually does not work for crypto).
> 
> I suggest a local lock or a good reason why the this patch works.

I used a local lock first, but lockdep was unhappy with it.  Ok, back
to the drawing board.  Seems to work, but...

	-Mike
