From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Mon, 17 Oct 2016 16:24:28 +0200
Message-ID: <20161017142428.25dyxefk2arjeyfz@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476587662.1538.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755064AbcJQOYb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Oct 2016 10:24:31 -0400
Content-Disposition: inline
In-Reply-To: <1476587662.1538.8.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-16 05:14:22 [+0200], Mike Galbraith wrote:
> 
> In v4.7, the driver switched to percpu compression streams, disabling
> preemption (get/put_cpu_ptr()).  Use get/put_cpu_light() instead.

I am not convinced that this will work. Nothing prevents
zram_bvec_write() to be reentrant on the same CPU what I can tell from
browsing over the code and since it uses zstrm->buffer for compression
it can go wrong. Also I don't know if crypto's tfm handler can be used
in parallel for any ops (it usually does not work for crypto).

I suggest a local lock or a good reason why the this patch works.

Sebastian
