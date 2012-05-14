From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH 1/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (1/3)
Date: Mon, 14 May 2012 14:25:58 +0200
Message-ID: <CAMSQXEG5okiqKasmh3_niGh_WCKNvekiwK9oSDnQkokcMPqArg@mail.gmail.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
	<20120510162621.4b5d7907@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
	RT <linux-rt-users@vger.kernel.org>
To: Alan Cox <alan@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120510162621.4b5d7907@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

2012/5/10 Alan Cox <alan@linux.intel.com>:
>
> You'd need to ifdef both of these for non RT cases. I think it may be
> right for RT although I'm not 100% sure on the locking.

Alan, I don't completely understand what you mean with "ifdef both".

Regarding the following two functions defined in drivers/tty/tty_buffer.c
- tty_schedule_flip
- tty_flip_buffer_push

They both implement almost the same functionality:

void tty_schedule_flip(struct tty_struct *tty)
{
	unsigned long flags;
	spin_lock_irqsave(&tty->buf.lock, flags);
	if (tty->buf.tail != NULL)
		tty->buf.tail->commit = tty->buf.tail->used;
	spin_unlock_irqrestore(&tty->buf.lock, flags);
	schedule_work(&tty->buf.work);
}

void tty_flip_buffer_push(struct tty_struct *tty)
{
	unsigned long flags;
	spin_lock_irqsave(&tty->buf.lock, flags);
	if (tty->buf.tail != NULL)
		tty->buf.tail->commit = tty->buf.tail->used;
	spin_unlock_irqrestore(&tty->buf.lock, flags);

#ifndef CONFIG_PREEMPT_RT_FULL
	if (tty->low_latency)
		flush_to_ldisc(&tty->buf.work);
	else
		schedule_work(&tty->buf.work);
#else
	flush_to_ldisc(&tty->buf.work);
#endif
}

Only difference is that tty_schedule_flip() always uses the work
queue, while the tty_flip_buffer_push only uses the work queue in case
of a non prempt_rt system and low_latency flag unset.

I see that most serial drivers use the tty_flip_buffer_push()
function. But still a number of drivers use the tty_schedule_flip()
function. I even found one driver that uses both
(drivers/staging/serqt_usb2/serqt_usb2.c). Is is there a reason for
these two functions implementing slightly different behavior?

If not, I think it would be better to remove the tty_schedule_flip()
function completely in a separate patch...

Regards,
Ivo Sieben
