From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Tue, 22 Dec 2015 17:34:23 +0100
Message-ID: <56797B8F.6090008@linutronix.de>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
 <20151211165240.GG6720@linutronix.de>
 <20151213113935.59cfd847@balder.valhalla.alchemy.lu>
 <20151222151117.GD27274@linutronix.de>
 <591364261.1447150.1450801543631.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Joakim Hernberg <jhernberg@alchemy.lu>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54718 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbbLVQe1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 11:34:27 -0500
In-Reply-To: <591364261.1447150.1450801543631.JavaMail.zimbra@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/22/2015 05:25 PM, John Kacur wrote:
> The script can be made to handle it, that's not a big deal. I think the historical
> reason was worrying that people could be accidentally running a kernel with
> some really heavy weight debugging that would affect performance. However, let people
> hang themselves if they want.

How can people hang themselves if they build it *into* the kernel? If I
understand *how* this can happen I will try to address it. However from
what I can see right now, nothing will happen if this module is built
into the kernel.

> 
> John
> 
Sebastian
