From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] kernel/printk: Don't try to print from IRQ/NMI region
Date: Fri, 27 May 2016 18:13:54 +0200
Message-ID: <20160527161354.GD24120@linutronix.de>
References: <20160527135812.GB24120@linutronix.de>
 <20160527101251.0ae36e23@gandalf.local.home>
 <20160527145601.GC24120@linutronix.de>
 <20160527110658.41cdd123@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160527110658.41cdd123@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2016-05-27 11:06:58 [-0400]:

>You probably didn't remove it. It may have been removed a while ago
>when Thomas did his big rewrite to get things working again.

okay. As long as I don't lose patches :)

>> about adding such a flag=E2=80=A6 I remember you had something in yo=
ur tree to
>> print from IRQ off regions via UART.
>
>I had a few hacks for a while, but they were nothing more than hacks.
>
>Perhaps we should make a better early_printk() or simple console for R=
T
>that can handle printk in atomic locations.
>
>I have a hack patch that gives early_printk() a new "spin lock", where
>it only takes the lock if the owner isn't on the CPU. Otherwise it
>allows lock to continue (and wont release it). That hack was required
>to get legible output from early_printk() when I was getting a bunch o=
f
>crashes on all the CPUs, because early_printk() has no locks, and the
>console is just a mess when all CPUs print at once.

An "atomic" console would be nice debugging wise. pstore with rawlocks
would be available after a reboot if you can use pstore. And its
overhead is probably not that huge. But its availability is limited.

Another thing might be a dedicated 8250 UART console which would print
in IRQ-off regions (and increase latency) but you would have the output
which you wouldn't have otherwise (say from panic() handler). Anyway,
nothing for production.

Sebastian
