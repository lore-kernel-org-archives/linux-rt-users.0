From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Thu, 12 Nov 2009 21:12:55 +0100
Message-ID: <20091112211255.09cd884a@hyperion.delvare>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	<20091107210147.3e754278@hyperion.delvare>
	<4AF7148C.9090706@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF7148C.9090706-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hello Sven,

On Sun, 08 Nov 2009 10:57:16 -0800, Sven-Thorsten Dietrich wrote:
> On 11/07/2009 12:01 PM, Jean Delvare wrote:
> >
> > One thing I do not understand: if yield() is a bug to RT kernels, then
> > we would have to remove them all? But so far, yield() still exists in
> > the kernel tree, and it serves a purpose. Are you going to ask all
> > developers to remove all occurrences of yield() in their code? Doesn't
> > sound terribly realistic.
> 
> The flaw in using yield() with RT priorities, is that it doesn't do what 
> you expect.

You know, I did not really expect anything in the first place, given
how little I know about RT ;)

> The scheduler will run, and pick the highest-priority thread, which is 
> the one yield()-ing.

Unless there are several real-time threads running, I presume?

> So the risk is, that whatever the yield() intended to do, it won't do, 
> and worse, that you will end up endlessly yielding to yourself, locking 
> the machine.
> 
> So the call is for something more explicit of an implementation.

This seem to imply an affirmative answer to my initial question: your
plan is to get rid of the ~500 occurrences of yield() throughout the
kernel tree?

As far as I can see, yield() doesn't have clear semantics attached.
It's more of a utility function everyone could use as they see fit. In
that respect, I understand your concerns about the coders' expectations
and how they could be dismissed by RT. OTOH, I don't think that asking
all developers to get rid of yield() because it _may not be_
RT-compliant will lead you anywhere.

In the 3 occurrences I've looked at, yield() is used as a way to
busy-wait in a multitask-friendly way. What other use cases do you
expect? I've never seen yield() used as a way to avoid deadlocks, which
seems to be what you fear. I guess it could statistically be used that
way, but obviously I wouldn't recommend it. Anything else?

I would recommend that you audit the various use cases of yield(), and
then offer replacements for the cases which are RT-unfriendly, leaving
the rest alone and possibly clarifying the intended use of yield() to
avoid future problems.

In the i2c-algo-bit case, which started this thread, I can't really see
what "something more explicit of an implementation" would be. yield()
is as optimum as you can get, only delaying the processing if other
tasks want to run. A sleep or a delay would delay the processing
unconditionally, for an arbitrary amount of time, with no good reason.
Removing yield() would increase the latency. This particular feature of
i2c-algo-bit isn't necessarily terribly useful, but the code does the
right thing, regardless of RT, so I just can't see any reason to change
it.

-- 
Jean Delvare
