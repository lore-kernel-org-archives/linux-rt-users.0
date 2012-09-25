From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH-v2] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Tue, 25 Sep 2012 15:47:07 +0100
Message-ID: <20120925154707.33aa2fa4@pyramind.ukuu.org.uk>
References: <CAMSQXEGEf8xSYZa+0N77K-Ld5xHLefyMHtK6FxcKCqNhpnMp6g@mail.gmail.com>
	<1348574506-23625-1-git-send-email-meltedpianoman@gmail.com>
	<20120925140627.5aea6ad7@pyramind.ukuu.org.uk>
	<CAMSQXEHzWxqZZyAGrmdk-Grvz4EtTXFWivWnjQf5E4ReY88XoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMSQXEHzWxqZZyAGrmdk-Grvz4EtTXFWivWnjQf5E4ReY88XoQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Or should drivers that use tty_schedule_flip() function never set the
> low_latency flag? (a quick scan indeed shows that all drivers that use
> the low_latency flag indeed make use of the tty_flip_buffer_push()
> function).

They should never do that - and adding a WARN_ON() will ensure we catch
anyone who offends.

I think thats worth doing as the resulting code is clearer and faster.

Alan
