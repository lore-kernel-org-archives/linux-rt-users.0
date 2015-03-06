From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] mce: don't try to wake thread before it exists.
Date: Fri, 6 Mar 2015 22:01:27 +0100
Message-ID: <20150306210127.GH10155@linutronix.de>
References: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1425046838-4868-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56824 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbCFVBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 16:01:31 -0500
Content-Disposition: inline
In-Reply-To: <1425046838-4868-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Daniel Wagner | 2015-02-27 15:20:38 [+0100]:

>From: Paul Gortmaker <paul.gortmaker@windriver.com>
=E2=80=A6
>[wagi: Replaced WARN_ON_ONCE with a 'creative' defer logic]
>Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>

You can't use Paul's From: and submit a different patch with only one
change hit "creative".
But it is not that bad if we get an IRQ that early and can't process it=
=2E
We only miss a printk. The userland helper is not yet ready and we won'=
t
anyone one waiting on the wait queue. So it should be enough to simply
check if the swait is ready.
After userland is ready it should notice that there was a MCE event.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
