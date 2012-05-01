From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Tue, 1 May 2012 16:30:10 +0200
Message-ID: <CAMSQXEGb9moJbCQwwXgEq7H-HvaSiuS5JBL55jr0ZhEEeAmqzw@mail.gmail.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419001407.GA24710@kroah.com>
	<CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
	<20120419154609.GA9263@kroah.com>
	<CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

2012/4/26 Ivo Sieben <meltedpianoman@gmail.com>:
>
> I did some analyses using the ftrace 'function_graph' tracer to find
> out what causes the TTY read to take longer than expected.
> I use a test application, running on RT prioirty 99 that writes bursts
> of 24 Bytes data to a my TTY device. A loop back connector is used, so
> the application also reads back these 24 bytes. Non blocking reads &
> writes are used.
>
> This analyses is still ongoing...
> Regards,
> Ivo Sieben

I've proceeded with my analyses, and I think I've found one cause for
the non deterministic read behavior ...
(there is also an issue with the flip buffer read handling, but I'm
still investigating that)

On line 47 of tty_ldisc.c a Spin Lock is defined that guards the line
discipline administration.
It protects two reference counters:
"users", atomic counter in the tty_ldisc struct, that holds the number
of active users of the ldisc in each tty instance. Used for "idle"
handling.
"refcount", counter in the tty_ldisc_ops struct, that holds the number
of lines using the discipline. (when the user count of a line reaches
0, the refcount of the line discipline is decreased by one) Only when
the refcount is 0, it is allowed to unregister the line discipline.

This Spin Lock is defined globally, This causes that my high priority
process to get blocked because of a lower priority process that holds
this spin lock. Of course you get priority inheritance, but this adds
quite a lot of extra execution time to the read function (because of
additional spin lock behavior, and scheduling to the lower priority
process)

Since the "user" and "refcount" reference counters have combined
behavior (refcount is decremented when users reaches zero), I don't
see a way to remove this global lock. Any ideas how this can be
improved?

We are considering to implement our UART device driver as a "normal"
character device driver and bypass the TTY framework. But that would
be a pitty, since we would have to re-implement some functionality
that is already in the TTY framework.

Regards,
Ivo Sieben
