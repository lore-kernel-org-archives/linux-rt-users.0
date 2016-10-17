From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Mon, 17 Oct 2016 18:29:01 +0200
Message-ID: <20161017162900.y337rfe6ydmolbn3@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476587662.1538.8.camel@gmail.com>
 <20161017142428.25dyxefk2arjeyfz@linutronix.de>
 <1476721140.30636.10.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476721140.30636.10.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-10-17 18:19:00 [+0200], Mike Galbraith wrote:
> I used a local lock first, but lockdep was unhappy with it.  Ok, back
> to the drawing board.  Seems to work, but...

locallock can be taken recursively so unless preemption was already
disabled, lockdep shouldn't complain. But then from the small context
it should not be taken recursively.

> 	-Mike

Sebastian
