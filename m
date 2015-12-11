From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Fri, 11 Dec 2015 17:52:40 +0100
Message-ID: <20151211165240.GG6720@linutronix.de>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48167 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbLKQwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:52:43 -0500
Content-Disposition: inline
In-Reply-To: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Joakim Hernberg | 2015-09-23 19:33:40 [+0200]:

>Since the HWLAT_DETECTOR driver supposedly shouldn't be builtin, but a
>module when used at all, it would make sense to limit the configuratio=
n
>choices:

what is wrong with it beeing built-in? The default is m already.

>Signed-off-by: Joakim Hernberg <jhernberg@alchemy.lu>
>Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
