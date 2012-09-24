From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH] tty: prevent unnecessary work queue lock checking on flip
 buffer copy
Date: Mon, 24 Sep 2012 11:33:17 +0200
Message-ID: <CAMSQXEGEf8xSYZa+0N77K-Ld5xHLefyMHtK6FxcKCqNhpnMp6g@mail.gmail.com>
References: <1348149762-4596-1-git-send-email-meltedpianoman@gmail.com>
	<20120920173305.15ea580a@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
	RT <linux-rt-users@vger.kernel.org>
To: Alan Cox <alan@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120920173305.15ea580a@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

2012/9/20 Alan Cox <alan@linux.intel.com>:
>
> This seems reasonable, but given its also relevant for upstream it
> would be nice to get it without the ifdef in upstream.
>
> The corner case is when the tty->low_latency flag is flipped but the
> drivers should handle that gracefully and if not we should fix them so
> you can get your 100uS.
>
> Alan

Actually this patch is related to my previous patch "tty: cleanup
duplicate functions in tty_buffer". Some drivers call the
tty_schedule_flip() function instead of tty_flip_buffer_push(). In
that case the work queue is always used, regardless the
tty->low_latency flag. That's why tried to get rid of the
tty_schedule_flip() function.

But from the first review remarks on the "tty: cleanup duplicate
functions in tty_buffer" patch, that patch seems to be invalid. So in
that case this patch is invalid also.

Regards,
Ivo Sieben
