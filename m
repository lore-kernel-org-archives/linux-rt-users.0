From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Tue, 22 Dec 2015 11:43:51 -0500 (EST)
Message-ID: <486903158.1453998.1450802631110.JavaMail.zimbra@redhat.com>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu> <20151211165240.GG6720@linutronix.de> <20151213113935.59cfd847@balder.valhalla.alchemy.lu> <20151222151117.GD27274@linutronix.de> <591364261.1447150.1450801543631.JavaMail.zimbra@redhat.com> <56797B8F.6090008@linutronix.de>
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
Received: from mx4-phx2.redhat.com ([209.132.183.25]:42560 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbbLVQoH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 11:44:07 -0500
In-Reply-To: <56797B8F.6090008@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



----- Original Message -----
> On 12/22/2015 05:25 PM, John Kacur wrote:
> > The script can be made to handle it, that's not a big deal. I think the
> > historical
> > reason was worrying that people could be accidentally running a kernel with
> > some really heavy weight debugging that would affect performance. However,
> > let people
> > hang themselves if they want.
> 
> How can people hang themselves if they build it *into* the kernel? If I
> understand *how* this can happen I will try to address it. However from
> what I can see right now, nothing will happen if this module is built
> into the kernel.
> 
> > 
> > John
> > 
> Sebastian

All I mean is if you are accidentally running a debug kernel, you're going
to get really bad performance, which is obvious. However, why are you arguing
with me, I'm agreeing with and Clark is agreeing with you, let's make it possible
for people to enable it now, and forget whatever historical reason stopped us from
doing that before.

John
