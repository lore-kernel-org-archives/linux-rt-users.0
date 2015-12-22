From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Tue, 22 Dec 2015 11:25:43 -0500 (EST)
Message-ID: <591364261.1447150.1450801543631.JavaMail.zimbra@redhat.com>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu> <20151211165240.GG6720@linutronix.de> <20151213113935.59cfd847@balder.valhalla.alchemy.lu> <20151222151117.GD27274@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Joakim Hernberg <jhernberg@alchemy.lu>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53745 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbbLVQ0E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 11:26:04 -0500
In-Reply-To: <20151222151117.GD27274@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



----- Original Message -----
> * Joakim Hernberg | 2015-12-13 11:39:35 [+0100]:
> 
> >I looked at the IRC logs from when this was discussed.  The hwlatdetect
> >script looks for the kernel module and will fail if it's built-in (or
> >compressed).  Also this quote from irc: <jkacur> I need to look
> >at the code, but offhand, I think we said, it cannot be a built-in by design
> 
> Why can't it work by design in built-in mode? The module parameters
> `enabled` and `threshold` can be set via debugfs (and via command line).
> So I don't see here the difference between module and built-in.
> Is there something I missed?
> 
> If the hwlatdetect script is not able to handle that then it deserves to
> be fixed. The same goes for support of compressed modules.
> 
> >These were the reasons for the patch.
> 

The script can be made to handle it, that's not a big deal. I think the historical
reason was worrying that people could be accidentally running a kernel with
some really heavy weight debugging that would affect performance. However, let people
hang themselves if they want. Clark was going to send a patch to allow it, but probably
ran out of time before the holidays. You can beat him to the punch if you want, or wait
for him.

John
