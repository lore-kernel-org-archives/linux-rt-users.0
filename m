From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [ANNOUNCE] v4.4.4-rt11
Date: Tue, 29 Mar 2016 13:12:50 +0200
Message-ID: <20160329111250.GA26103@breakpoint.cc>
References: <20160309135142.GF10517@linutronix.de>
 <nbq16a$7li$1@ger.gmane.org>
 <20160311171446.GB3815@breakpoint.cc>
 <56E3776B.9030200@sysnux.pf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Jean-Denis Girard <jd.girard@sysnux.pf>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:42331 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805AbcC2LMy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 07:12:54 -0400
Content-Disposition: inline
In-Reply-To: <56E3776B.9030200@sysnux.pf>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-03-11 15:56:59 [-1000], Jean-Denis Girard wrote:
> Hi,
Hi,

> Here are the interrupts, I hope this is what you want:
> jdg@arietta:~$ cat /proc/interrupts
>            CPU0
>  16:     145825  atmel-aic   1 Level     at91_rtc, ttyS0

Yes, thank you. This means that the IRQ can be re-used. Now we need to
rid of the warning :)

Sebastian
