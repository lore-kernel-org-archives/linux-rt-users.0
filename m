From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
Date: Sun, 05 Aug 2018 06:52:57 +0200
Message-ID: <1533444777.9157.10.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <1533192980.11791.8.camel@gmx.de>
         <20180802123104.7fed73b4@gandalf.local.home>
         <1533228650.12550.15.camel@gmx.de> <1533231816.12550.54.camel@gmx.de>
         <1533385520.5602.31.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533385520.5602.31.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2018-08-04 at 14:25 +0200, Mike Galbraith wrote:
> 
> Besides, there are more interesting fish in the arm64 sea than kvm.
> 
> virgin 4.16.18-rt12-rt
> 
> [  537.236131] ITS queue timeout (65440 65504 4640)
> [  537.236150] ITS cmd its_build_inv_cmd failed

FWIW, I had thought that something 4.16..master had made that business
go entirely away, but it only became much more infrequent.  So much for
plan to slowly sneak up on whatever than was via ~bisect.
