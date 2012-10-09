From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH-v2] tty: Use raw spin lock to protect RX flip buffer
Date: Tue, 9 Oct 2012 19:43:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210091934010.10988@ionos>
References: <1348478680-11505-1-git-send-email-meltedpianoman@gmail.com> <1349781313-8670-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1349781313-8670-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Oct 2012, Ivo Sieben wrote:
> The "normal" spin lock that guards the RX flip buffer is replaced by a raw
> spin lock.
> 
> On a PREEMP_RT system this prevents unwanted scheduling overhead when data is
> read at the same time as data is being received: while RX IRQ threaded handling
> is busy a TTY read call is performed from a RT priority > threaded IRQ priority.
> The read call tries to take the flip buffer spin lock (held by the threaded IRQ)
> which blocks and causes a context switch to/from the threaded IRQ handler until
> the spin lock is unlocked.
> 
> On a 200 MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
> overhead on the TTY read call.

Cute, but ...
 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
> ---
> 
> @Thomas Gleixner & Steven Rostedt:
> Alan Cox has responded to this patch: "I've no real opinion on the spin/raw_spin
> choices as it's basically an RT question not a tty one so if the rt folks are
> happy with it so am I." Do you agree?
> 
> v2:
> Patch was based on another - abandoned - patch om mine, what introduced a bug in
> the tty_schedule_flip() function. Fixed this and rebased it on the latest kernel
> tree.
> 
> 
>  drivers/tty/tty_buffer.c |   44 ++++++++++++++++++++++----------------------
>  include/linux/kbd_kern.h |    4 ++--
>  include/linux/tty.h      |    2 +-
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 91e326f..70cf324 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -135,20 +135,20 @@ static void __tty_buffer_flush(struct tty_struct *tty)
>  void tty_buffer_flush(struct tty_struct *tty)
>  {
>  	unsigned long flags;
> -	spin_lock_irqsave(&tty->buf.lock, flags);
> +	raw_spin_lock_irqsave(&tty->buf.lock, flags);
>  
>  	/* If the data is being pushed to the tty layer then we can't
>  	   process it here. Instead set a flag and the flush_to_ldisc
>  	   path will process the flush request before it exits */
>  	if (test_bit(TTY_FLUSHING, &tty->flags)) {
>  		set_bit(TTY_FLUSHPENDING, &tty->flags);
> -		spin_unlock_irqrestore(&tty->buf.lock, flags);
> +		raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
>  		wait_event(tty->read_wait,
>  				test_bit(TTY_FLUSHPENDING, &tty->flags) == 0);
>  		return;
>  	} else
>  		__tty_buffer_flush(tty);

__tty_buffer_flush() can call tty_buffer_free() which in turn can call
kfree(), which is a nono on RT with preemption and interrupts
disabled. Enabling CONFIG_DEBUG_ATOMIC_SLEEP and extensive testing
should have told you that.

I did not look at the other places where this lock is used, but I
suspect there is more fallout lurking.

Thanks,

	tglx
