From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Thu, 20 Sep 2012 17:33:05 +0100
Message-ID: <20120920173305.15ea580a@bob.linux.org.uk>
References: <1348149762-4596-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1348149762-4596-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> This prevents unnecessary spin lock/unlock on the workqueue spin lock
> that can cause additional scheduling overhead on a PREEMPT_RT system.
> On a 240 MHz AT91SAM9261 processor setup this fixes about 100us of
> scheduling overhead on the TTY read call.

This seems reasonable, but given its also relevant for upstream it
would be nice to get it without the ifdef in upstream.

The corner case is when the tty->low_latency flag is flipped but the
drivers should handle that gracefully and if not we should fix them so
you can get your 100uS.

Alan
