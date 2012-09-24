From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: cleanup duplicate functions in tty_buffer
Date: Mon, 24 Sep 2012 10:25:47 +0100
Message-ID: <20120924102547.62581af4@pyramind.ukuu.org.uk>
References: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com>
	<20120920171717.04ee9098@bob.linux.org.uk>
	<CAMSQXEHkjWubwNXiCd_bBnUdzQ2M+sa8HPs2KCzwcOOp2dSsBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41398 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab2IXJVB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Sep 2012 05:21:01 -0400
In-Reply-To: <CAMSQXEHkjWubwNXiCd_bBnUdzQ2M+sa8HPs2KCzwcOOp2dSsBw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I agree that when the tty->low_latency flag is set on these machines,
> the drivers that were modified by my patch will behave differently:
> they will call the flush_to_ldisc() function directly instead of using
> the work queue. So that indeed introduces different functionality.

flush_to_ldisc calls into the tty core code which sleeps. The rule is
that you may not call flush_to_ldisc except from a workqueue context.

If you break that rule then various bad things will occur (eg rx ->
flush_to_ldisc -> n_tty -> flow control -> tx -> deadlock) in a lot of
drivers.

> But what I don't understand is how this would cause the machine to
> crash? Even when the flush_to_ldisc() function is called from hard IRQ
> context this would cause no problems: the flush_to_ldisc() function
> uses IRQ save spin locks instead of mutexes to protect it's critical
> section. Right?
> 
> Furthermore the majority of TTY drivers currently already use the
> tty_flip_buffer_push() function.

Several of them are ones that shouldn't.

Alan
