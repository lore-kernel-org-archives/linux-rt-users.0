From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: Set hardirq tracing to on when idling
Date: Tue, 27 May 2014 20:49:27 +0200
Message-ID: <4475199.26Fs5MKAfh@wuerfel>
References: <1401045323-7116-1-git-send-email-minyard@acm.org> <4559339.apo3Fd10HK@wuerfel> <5384BF89.6010509@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Stanislav Meduna <stano@meduna.org>,
	Corey Minyard <cminyard@mvista.com>,
	linux-rt-users@vger.kernel.org, minyard@acm.org,
	linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5384BF89.6010509@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 27 May 2014 18:38:33 Stanislav Meduna wrote:
> On 26.05.2014 11:26, Arnd Bergmann wrote:
> 
> > It seems like the right thing to do, I just don't understand
> > why nobody hit this before.
> 
> Looks like this is what I did hit a month ago and
> was not able to find the culprit:
> http://www.spinics.net/lists/linux-rt-users/msg11656.html

Ok, so you get a 2.2ms latency on i.mx28 here, which comes
from exactly the same code location, and is quite alarming
by itself, but much less so than the 4 second latency that
Corey is seeing. This could just be an artifact of i.mx28
not staying idle for as long as vexpress.

> > How exactly do you see this manifest? If it's clear
> > that the trace comes from the idle function, maybe
> > everybody just ignores it?
> 
> That was definitely what I did 

You also commented in that thread about stop_critical_timings()/
start_critical_timings(). Corey, can you look at that, too? I
think it's designed to avoid the issue you are seeing but
for some reason doesn't.

Maybe the problem is that the tracing infrastructure gets confused
when the irq_disable() happens in a different function from
irq_enable().

	Arnd
