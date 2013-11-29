From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.0-rt2
Date: Fri, 29 Nov 2013 17:13:38 +0100
Message-ID: <20131129161338.GF31099@linutronix.de>
References: <20131116194633.GD11518@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EE68DA@edb0.wapice.localdomain>
 <20131122142345.GC8698@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EF1DCA@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Langfinger <linux-rt-users@langfinger.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sami =?utf-8?Q?Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35187 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3K2QNj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 11:13:39 -0500
Content-Disposition: inline
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA67EF1DCA@edb1.wapice.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sami Pietik=C3=A4inen | 2013-11-25 13:21:13 [+0000]:

>In clocksource-tclib-allow-higher-clockrates.patch the clockevent devi=
ce frequency is
>stored to a local variable but never written to the tc_clkevt_device s=
truct (setup_clkevents function).

Thanks, no idea how I could overlook this.

>Fix: replace local freq variable with clkevt.freq in setup_clkevents f=
unction.
>I also renamed clk32k_divisor_idx to divisor_idx because the 32k frequ=
ency is not
>hard coded in RT.

Yeah, the right thing to do, Applied

>
>BR,
>Sami Pietik=C3=A4inen

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
