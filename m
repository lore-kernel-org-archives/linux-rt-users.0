From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] kernel/futex: don't deboost too early
Date: Mon, 3 Oct 2016 19:38:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610031938190.5278@nanos>
References: <20160930083913.aqjpynzsj5d3xxho@linutronix.de> <20160930120038.5fe7d535@grimm.local.home> <alpine.DEB.2.20.1609302041410.5508@nanos> <20161002060137.2716b089@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161002060137.2716b089@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2 Oct 2016, Steven Rostedt wrote:
> 
> Grumble, how come the easy way is never a possibility :-p

Because futexes are cursed ....
