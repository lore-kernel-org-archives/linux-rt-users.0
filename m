From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: struct wait_queue_Head_t to struct swait_head warning
Date: Sat, 19 Mar 2016 09:52:55 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603190947130.3978@nanos>
References: <CAMDowVWB-ZBQ6ZEcGWohuZbVwzkSJALGKHf1-bP6OxenkAcROQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Matt Campbell <mcampbell@izotope.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39325 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcCSIyX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Mar 2016 04:54:23 -0400
In-Reply-To: <CAMDowVWB-ZBQ6ZEcGWohuZbVwzkSJALGKHf1-bP6OxenkAcROQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 17 Mar 2016, Matt Campbell wrote:
> It looks like this is due 'struct completion' changing to using the
> simple waitqueue in the RT patch. When looking at the rest of the RT
> patch it looks like cases like this are handled by changing the API to
> use the simple wait calls for these (for example usb/gadget/f_fs.c). I
> was able to get rid of the warning by switching from
> 'waitqueue_active' to 'swaitqueue_active'. I'm not fully knowledge
> about the possible effects, so I was hoping someone could let me know
> if this is or isn't a good solution. I know this isn't mainline, but I
> would appreciate any help to point me in the right direction.

Yes, the conversion is correct. Though that driver code is complete and utter
crap.

	if (waitqueue_active(&_pno_state->get_batch_done.wait))
		complete(&_pno_state->get_batch_done);

There is no point having this if () clause. Either the code completes or it
does not, but making it dependent whether there are waiters on the completion,
does not make any sense. And looking at the other instance where they fiddle
with the inner waitqueue of the completion, that makes no sense either. It's
just racy as hell. Oh well, why do I care?

Thanks,

	tglx




