From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
Date: Wed, 29 Aug 2018 16:00:07 +0200
Message-ID: <20180829140007.fivwhrpmwcghls3u@linutronix.de>
References: <20180817162340.6e8482fd@gandalf.local.home>
 <1534588142.2516.10.camel@gmx.de>
 <1534597992.15909.17.camel@gmx.de>
 <1534660115.6187.4.camel@gmx.de>
 <20180822121749.5c4632d7@gandalf.local.home>
 <20180822123315.3a184f9c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180822123315.3a184f9c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-08-22 12:33:15 [-0400], Steven Rostedt wrote:
> I'm going to hold off on pulling this in until I see it in your tree,
> because a stable RT branch should not carry anything that isn't in the
> head RT tree. And it appears that this can affect your repo too.

applied.

Sebastian
