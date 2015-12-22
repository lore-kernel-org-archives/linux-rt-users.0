From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Tue, 22 Dec 2015 16:11:17 +0100
Message-ID: <20151222151117.GD27274@linutronix.de>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
 <20151211165240.GG6720@linutronix.de>
 <20151213113935.59cfd847@balder.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, John Kacur <jkacur@redhat.com>
To: Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54293 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbbLVPLT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 10:11:19 -0500
Content-Disposition: inline
In-Reply-To: <20151213113935.59cfd847@balder.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Joakim Hernberg | 2015-12-13 11:39:35 [+0100]:

>I looked at the IRC logs from when this was discussed.  The hwlatdetect
>script looks for the kernel module and will fail if it's built-in (or
>compressed).  Also this quote from irc: <jkacur> I need to look
>at the code, but offhand, I think we said, it cannot be a built-in by design

Why can't it work by design in built-in mode? The module parameters
`enabled` and `threshold` can be set via debugfs (and via command line).
So I don't see here the difference between module and built-in.
Is there something I missed?

If the hwlatdetect script is not able to handle that then it deserves to
be fixed. The same goes for support of compressed modules.

>These were the reasons for the patch.

Sebastian
