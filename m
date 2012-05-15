From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (1/3)
Date: Tue, 15 May 2012 11:04:41 -0400
Message-ID: <1337094281.14207.308.camel@gandalf.stny.rr.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
	 <20120510162621.4b5d7907@bob.linux.org.uk>
	 <CAMSQXEG5okiqKasmh3_niGh_WCKNvekiwK9oSDnQkokcMPqArg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19563 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046Ab2EOPEn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 11:04:43 -0400
In-Reply-To: <CAMSQXEG5okiqKasmh3_niGh_WCKNvekiwK9oSDnQkokcMPqArg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-05-14 at 14:25 +0200, Ivo Sieben wrote:

> void tty_flip_buffer_push(struct tty_struct *tty)
> {
> 	unsigned long flags;
> 	spin_lock_irqsave(&tty->buf.lock, flags);
> 	if (tty->buf.tail != NULL)
> 		tty->buf.tail->commit = tty->buf.tail->used;
> 	spin_unlock_irqrestore(&tty->buf.lock, flags);
> 
> #ifndef CONFIG_PREEMPT_RT_FULL
> 	if (tty->low_latency)
> 		flush_to_ldisc(&tty->buf.work);
> 	else
> 		schedule_work(&tty->buf.work);
> #else
> 	flush_to_ldisc(&tty->buf.work);
> #endif
> }
> 

Note, just to keep ugly #ifdefs out of C code, or at least C functions,
it is usually better to wrap the above in something like:


#ifdef CONFIG_PREEMPT_RT_FULL
static inline void tty_flush_work(struct tty_struct *tty)
{
	flush_to_ldisc(&tty->buf.work);
}
#else
static inline void tty_flush_work(struct tty_struct *tty)
{
	if (tty->low_latency)
		flush_to_ldisc(&tty->buf.work);
	else
		schedule_work(&tty->buf.work);
}
#endif


Then the C function would just look like:

void tty_flip_buffer_push(struct tty_struct *tty)
{
        unsigned long flags;
        spin_lock_irqsave(&tty->buf.lock, flags);
        if (tty->buf.tail != NULL)
                tty->buf.tail->commit = tty->buf.tail->used;
        spin_unlock_irqrestore(&tty->buf.lock, flags);

	tty_flush_work(tty);
}

-- Steve


