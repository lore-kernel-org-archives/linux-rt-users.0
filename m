From: Richard Tollerton <richard.tollerton@gmail.com>
Subject: Re: How do embedded linux-rt systems fill their entropy/randomness pools?
Date: Mon, 18 Jun 2012 13:19:53 -0500
Message-ID: <CAM7vvUcno9bt06cjrj5QhDQ0a-EFRa1gdkXjnu_ct2woqOkrVw@mail.gmail.com>
References: <CAM7vvUeRQ0K5J-wtir4JmJcPRfFJtmvxn-yud16BG7KZupFNKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:56614 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab2FRS0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jun 2012 14:26:07 -0400
Received: by qafl39 with SMTP id l39so1745666qaf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Jun 2012 11:26:06 -0700 (PDT)
In-Reply-To: <CAM7vvUeRQ0K5J-wtir4JmJcPRfFJtmvxn-yud16BG7KZupFNKg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas and others,

Your "genirq: Disable random call on preempt-rt" commit on Jul 21 2009
removes interrupt timings as a potential source of randomness for the
kernel entropy pool, if=C2=A0CONFIG_PREEMPT_RT_FULL=C2=A0 is set. I hav=
e no
qualms with this change, per se; manipulating the entropy pool is
clearly something that shouldn't be happening at IRQ priority.

However: on an embedded linux-rt system with solid-state storage,
add_input_randomness() ought to contribute no entropy at all, and
add_disk_randomness() likely contributes a marginal amount of entropy,
since SSD seek timings have little variance. That leaves
ioctl(/dev/random, RNDADDENTROPY) as the only remaining entropy
source. But no kernel drivers appear to use that, and few
distributions have egd set up out-of-the-box.

Thus, for a stock linux-rt kernel, it appears to be the case that
**NOTHING POPULATES THE ENTROPY POOL**. I can readily reproduce this
on a live linux-rt ARM system: after boot,
/proc/sys/kernel/random/entropy_avail is 0, and stays there.

This, to me, seems to be a severe problem. In particular, if the
embedded RT system is responsible for generating its own RSA keys for
e.g. SSH/SSL on first boot, then the lack of entropy leaves it
susceptible to catastrophic factorization attacks as documented in
"Ron was wrong, Whit is right",=C2=A0http://eprint.iacr.org/2012/064.pd=
f,
which made the news 3 months or so ago.

Do you agree with this analysis?

How have other linux-rt users solved this sort of problem, besides
userspace=C2=A0ioctl(RNDADDENTROPY) calls from an entropy gathering dae=
mon?

Would anybody (else) be interested in pursing a realtime-safe way to
use interrupt timings as an entropy source?


-- Richard Tollerton <richard.tollerton@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
