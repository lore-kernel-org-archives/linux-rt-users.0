From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Mon, 16 Nov 2009 15:56:06 +0000
Message-ID: <20091116155606.GC29479@sirena.org.uk>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com> <20091107210147.3e754278@hyperion.delvare> <4AF7148C.9090706@thebigcorporation.com> <20091112211255.09cd884a@hyperion.delvare> <alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>,
	Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911132139560.24119-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Nov 13, 2009 at 11:03:39PM +0100, Thomas Gleixner wrote:

> Q: Why put people yield() into their code ?
> A: Because:
>    - it is less nasty than busy waiting for a long time
>    - it works better

...

> I can see the idea of using yield() to let other tasks making progress
> in situations where the hardware is a design failure as well,
> e.g. bitbang devices. But if we have to deal with hardware which is
> crap by design yield() is the worst of all answers simply due to its
> horrible semantics.

What other options are there available for the first case (which is
often why things work better with the use of yield) that don't involve
sleeps, or is the idea that in situations like this drivers should
always sleep?
