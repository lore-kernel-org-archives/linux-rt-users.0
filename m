From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Tue, 14 Jul 2015 10:29:04 -0400
Message-ID: <20150714102904.0229e96d@gandalf.local.home>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
	<alpine.DEB.2.11.1507091605410.5134@nanos>
	<c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
	<20150710132318.GA27402@linutronix.de>
	<3c9ae4a1f9cb4ac3a96a28c3f65f9442@FE-MBX1012.de.bosch.com>
	<20150713091237.GA31747@linutronix.de>
	<20150713113430.4c18c965@gandalf.local.home>
	<523c30ce4e4c4b53befcd288db178db9@FE-MBX1012.de.bosch.com>
	<20150714101551.2f39f196@gandalf.local.home>
	<55A51BB6.4070606@etas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Mathias Koehrer" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:55570 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752344AbbGNO3G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 10:29:06 -0400
In-Reply-To: <55A51BB6.4070606@etas.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 14 Jul 2015 16:24:54 +0200
"Mathias Koehrer" <mathias.koehrer@etas.com> wrote:

> > How reproducible is this?
> Unfortunately this is not really reproducable.
> I caught this bug after approx. 400 reboots while hunting another bug...

Can you send me your config.

Thanks!

-- Steve

