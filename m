From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (1/3)
Date: Thu, 10 May 2012 16:26:21 +0100
Message-ID: <20120510162621.4b5d7907@bob.linux.org.uk>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28634 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757948Ab2EJPLA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 May 2012 11:11:00 -0400
In-Reply-To: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Note: In a PREEMPT_RT system "normal" spin locks behave like mutexes
> and no interrupts (and therefor no scheduling) is disabled.
> 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>

(Coming back round to these patches now the urgent stuff is buried for
a bit)

>  void tty_schedule_flip(struct tty_struct *tty)
>  {
> -	unsigned long flags;
> -	spin_lock_irqsave(&tty->buf.lock, flags);
> -	if (tty->buf.tail != NULL)
> -		tty->buf.tail->commit = tty->buf.tail->used;
> -	spin_unlock_irqrestore(&tty->buf.lock, flags);
> -	schedule_work(&tty->buf.work);
> +	tty_flip_buffer_push(tty);
>  }

You'd need to ifdef both of these for non RT cases. I think it may be
right for RT although I'm not 100% sure on the locking.

At this point I think we'd be better off sorting out our tty locking in
general before tackling RT optimisations. However as an RT patch it
looks good and its interesting to see RT simplifying code not making it
more complex.
