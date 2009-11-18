From: Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Wed, 18 Nov 2009 17:28:53 +0100
Message-ID: <c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	 <20091107210147.3e754278@hyperion.delvare>
	 <4AF7148C.9090706@thebigcorporation.com>
	 <20091112211255.09cd884a@hyperion.delvare>
	 <alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
	 <20091116155606.GC29479@sirena.org.uk>
	 <c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
	 <20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091118010520.4cd397d4-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

On Wed, Nov 18, 2009 at 2:05 AM, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>> I think the yield()s in the device driver code means "I need a small
>> delay before the hardware is ready" which might translate to some
>> arbitrary "let me msleep()" or "do not select this task in the next
>> scheduler run, EVEN IF this task is highest priority".
>
> Yield() in a driver is almost always a bug.
>

I know and that's exactly why I started this thread (and of course,
because I ran into the bug on my system).


> Our timers are very efficient and some day we will need to make jiffies a
> function and stop the timer ticking for best performance. At that point
> timers are probably the most efficient way to do much of this.
>
The problem with I2C bitbanged is the stringent timing, we need a way
to have fine-grained sleeping
mixed with real-time tasks in order to make this work.

As Thomas already said, the hardware is broken (in the sense that I2C
should really rely on hardware timers, i.e. an I2C host controller).

However, much of the cheaper/older/... embedded hardware is broken.
Given that I2C devices are relatively easy on the timing, we need
the least-dirty way that is not buggy in the kernel.

> Be that as it may, yield() in a driver is almost always the wrong thing
> to do.
>
Yes. What is your idea on removing those without breaking
functionality?  Fine-graining sleep()ing?

Regards,
-- 
Leon
