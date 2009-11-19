From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Thu, 19 Nov 2009 14:06:54 +0100
Message-ID: <1258636014.4372.328.camel@twins>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	 <20091107210147.3e754278@hyperion.delvare>
	 <4AF7148C.9090706@thebigcorporation.com>
	 <20091112211255.09cd884a@hyperion.delvare>
	 <alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
	 <20091116155606.GC29479@sirena.org.uk>
	 <c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
	 <20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
	 <c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
	 <20091118175202.490989d8@hyperion.delvare>
	 <alpine.LFD.2.00.0911182127040.24119@localhost.localdomain>
	 <20091119130526.23a69b85@hyperion.delvare>
	 <20091119125906.6ad00edd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091119125906.6ad00edd-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2009-11-19 at 12:59 +0000, Alan Cox wrote:
> > Well, I guess only people monitoring system latency would notice, as
> > this is the only thing yield() was supposed to help with in the first
> > place.
> 
> 	if (need_resched())
> 		schedule();

aka.

	cond_resched();

> will make non-rt tasks act politely at the right moments. RT tasks will
> likely immediately get to take the CPU again depending upon the
> scheduling parameters in use.

Right, FIFO will simply NOP it, since if it was the highest running
task, it will still be. RR could possibly run out of its slice and
schedule to another RR of the same prio.
