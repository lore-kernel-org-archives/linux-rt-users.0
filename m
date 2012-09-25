From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH-v2] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Tue, 25 Sep 2012 16:39:55 +0200
Message-ID: <CAMSQXEHzWxqZZyAGrmdk-Grvz4EtTXFWivWnjQf5E4ReY88XoQ@mail.gmail.com>
References: <CAMSQXEGEf8xSYZa+0N77K-Ld5xHLefyMHtK6FxcKCqNhpnMp6g@mail.gmail.com>
	<1348574506-23625-1-git-send-email-meltedpianoman@gmail.com>
	<20120925140627.5aea6ad7@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120925140627.5aea6ad7@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

2012/9/25 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>
>
> then surely the right fix is
>
>         if (tty->low_latency == 0)
>                 flush_work(&tty->buf.work);
>

Your are right, that is indeed more straightforward & logical.
But what if a TTY driver uses the tty_schedule_flip() function instead
of tty_flip_buffer_push() and has low_latency set to 1?
In that case the work queue will never be flushed...

Or should drivers that use tty_schedule_flip() function never set the
low_latency flag? (a quick scan indeed shows that all drivers that use
the low_latency flag indeed make use of the tty_flip_buffer_push()
function).

Best regards,
Ivo Sieben
