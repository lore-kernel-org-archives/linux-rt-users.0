From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH] tty: cleanup duplicate functions in tty_buffer
Date: Mon, 24 Sep 2012 10:02:13 +0200
Message-ID: <CAMSQXEHkjWubwNXiCd_bBnUdzQ2M+sa8HPs2KCzwcOOp2dSsBw@mail.gmail.com>
References: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com>
	<20120920171717.04ee9098@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
	RT <linux-rt-users@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
To: Alan Cox <alan@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53135 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab2IXICO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Sep 2012 04:02:14 -0400
In-Reply-To: <20120920171717.04ee9098@bob.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2012/9/20 Alan Cox <alan@linux.intel.com>:
>
> So now when the user sets tty->low_latency on these devices the machine
> crashes ?
>
> This is the wrong direction - in fact we have a pile we need to move
> the other way !
>
> If they resolve to the same thing in hard RT patches fine, that's a
> different question.

Sorry, Allan you are probably right, but I don't get it...

I agree that when the tty->low_latency flag is set on these machines,
the drivers that were modified by my patch will behave differently:
they will call the flush_to_ldisc() function directly instead of using
the work queue. So that indeed introduces different functionality.

But what I don't understand is how this would cause the machine to
crash? Even when the flush_to_ldisc() function is called from hard IRQ
context this would cause no problems: the flush_to_ldisc() function
uses IRQ save spin locks instead of mutexes to protect it's critical
section. Right?

Furthermore the majority of TTY drivers currently already use the
tty_flip_buffer_push() function.

Regards,
Ivo Sieben
