From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Sat, 7 Nov 2009 21:01:47 +0100
Message-ID: <20091107210147.3e754278@hyperion.delvare>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c384c5ea0911071101u7415d37o2611c542e5fae309-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hi Leon,

On Sat, 7 Nov 2009 20:01:59 +0100, Leon Woestenberg wrote:
> during testing the Linux PREEMP_RT work (step-by-step being merged
> with mainline) together with I2C functionality I hit the fact that the
> I2C subsystem uses yield() in some of the non-happy code paths (mostly
> during chip / address probing etc).

The I2C subsystem itself doesn't; individual I2C bus drivers do. One of
them is i2c-algo-bit, which is a helper module widely used by other I2C
bus drivers.

yield() is only used once in i2c-algo-bit, when the slave device we are
talking to doesn't ack its address at first try (and adapter->retries
is set to non-zero.)

> My (embedded) system was running a low-priority real-time work on the
> generic workqueue which tried to blink a LED using an I2C I/O
> multiplexer when I hit the BUG where this real-time task ran into the
> yield() of try_address().

One thing I do not understand: if yield() is a bug to RT kernels, then
we would have to remove them all? But so far, yield() still exists in
the kernel tree, and it serves a purpose. Are you going to ask all
developers to remove all occurrences of yield() in their code? Doesn't
sound terribly realistic.

> Grepping through the I2C subsystem code there where more yield()
> sprinkled in, without it being clear to me why they are there.

The only occurrence I found is in driver i2c-bfin-twi, where it is used
to wait until the bus is ready. The use of yield() make the
busy-waiting less aggressive. Alternatives are sleeping (which I
presume RT wouldn't like either) or pure busy-waiting (which doesn't
sound terribly appealing, right?)

> Can those yield()s please be removed, and if they are needed for some
> reason (??) be replaced with something equivalent?

I don't think yield() is ever "needed". It is there when developers try
to be fair to other running threads. I can't think of cases where
anything will break when removing them, but system latency might
suffer. Isn't it a little odd that in the name of RT, you're asking for
people to remove a mechanism which was introduced to lower system
latency?

I think this all needs to be discussed at a higher level. Namely, RT
people need to discuss how yield() should behave with regards to RT
threads. Maybe it should simply become a no-op for these threads?
(Disclaimer if it wasn't obvious yet: I don't know much about RT.)

-- 
Jean Delvare
