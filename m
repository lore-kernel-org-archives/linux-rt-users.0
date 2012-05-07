From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH 2/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (2/3)
Date: Mon, 7 May 2012 09:45:51 +0200
Message-ID: <CAMSQXEEofb_4mLjNffTK1ZEHXA0UcY1dXm5NR-GD1jJzDgDu+w@mail.gmail.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
	<1336048663-21882-2-git-send-email-meltedpianoman@gmail.com>
	<20120503162529.GB3063@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120503162529.GB3063@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

2012/5/3 Greg KH <gregkh@linuxfoundation.org>:
>
> Why, what does this cause to have happen? =A0What's the difference he=
re
> that causes any speedups or latency fixes?
>

This patch solves the following scenario:
- A low priority process starts to send data to serial port A
- In order to do this, the low priority process calls the
tty_ldisc_ref_wait() function to retrieve a reference to its line
discipline.
- In the tty_ldisc_ref_wait() function, the global ldisc spinlock is lo=
cked.
- While the spin lock is still locked, a context switch takes place
and a second process on high real-time priority starts reading data
from another serial port B (this is a possible scenario on a
PREEMPT_RT system where a "normal" spin lock behaves like a mutex and
no interrupts are actually disabled, although the "irqsave" postfix in
the spinlock function name suggests otherwise)
- The second project also calls the tty_ldisc_ref_wait() function, and
therefor gets blocked on the global ldisc spin lock.
- As a result priority inversion takes place, and the second process
is scheduled out, the first process is scheduled in on high priority.
After the first process has released the spin lock, the second process
is scheduled again.

The above scenario is not wrong, it works fine... but the scheduling &
mutex handling requires a lot of extra processing time what makes that
a normal read operation of about 50us sometimes can last up to 230us.
By using raw spin locks this situation is prevented. I think it is
legitimate to use raw spin locks because the critical sections in
ldisc are small.

Regards,
Ivo Sieben
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
