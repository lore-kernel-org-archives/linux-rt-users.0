From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Mon, 17 Oct 2016 19:46:46 +0200
Message-ID: <1476726406.30832.3.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
         <1476587662.1538.8.camel@gmail.com>
         <20161017142428.25dyxefk2arjeyfz@linutronix.de>
         <1476721140.30636.10.camel@gmail.com>
         <20161017162900.y337rfe6ydmolbn3@linutronix.de>
         <1476724685.19030.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34949 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbcJQRqv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Oct 2016 13:46:51 -0400
In-Reply-To: <1476724685.19030.5.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-10-17 at 19:18 +0200, Mike Galbraith wrote:

> BTW, 4.8 either needs the btrfs deadlock fix (0ccd05285e7f) or the LTP
> testcase has to be hacked to not test btrfs.  It also fails the first
> time it's run in 4.8/4.8-rt, doesn't do that in master/tip-rt.

Belay that, the first run failure is there in master/tip too, it's just
intermittent.  From there on, it's solid.  Hohum.

	-Mike
