From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
Date: Tue, 7 Aug 2018 16:46:00 +0200
Message-ID: <20180807144600.pmyckao2brlsatsr@linutronix.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532764179.9882.14.camel@gmx.de>
 <1532768853.9882.73.camel@gmx.de>
 <1533192980.11791.8.camel@gmx.de>
 <20180802123104.7fed73b4@gandalf.local.home>
 <1533228650.12550.15.camel@gmx.de>
 <1533231816.12550.54.camel@gmx.de>
 <1533385520.5602.31.camel@gmx.de>
 <1533444777.9157.10.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533444777.9157.10.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-08-05 06:52:57 [+0200], Mike Galbraith wrote:
> 
> FWIW, I had thought that something 4.16..master had made that business
> go entirely away, but it only became much more infrequent.  So much for
> plan to slowly sneak up on whatever than was via ~bisect.

I just released v4.18 based RT. Please repost the kvm/RT patches once
things have settled.

Sebastian
