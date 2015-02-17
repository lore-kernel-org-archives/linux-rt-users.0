From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT is freezing
Date: Tue, 17 Feb 2015 18:16:12 +0100
Message-ID: <20150217171612.GV26177@linutronix.de>
References: <54AB147E.9060209@gmail.com>
 <54AB39D2.2090203@gmail.com>
 <20150107112423.228e67f3@balder.valhalla.alchemy.lu>
 <54ADC3AC.2090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joakim Hernberg <jhernberg@alchemy.lu>,
	linux-rt-users@vger.kernel.org
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44433 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbbBQRQP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:16:15 -0500
Content-Disposition: inline
In-Reply-To: <54ADC3AC.2090303@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gustavo Bittencourt | 2015-01-07 21:39:24 [-0200]:

>Unfortunately, the patch didn't work. But now I was able to get the
>stack (see below). This stack repeats more than 1500 times during 1
>second.

I suggest you play with RT without the graphics. I recall a backtrace
posted here from a crash and I've been told that there was no
proper locking around it. I think it was v3.12 but I am not sure how
much changeed since then.

Sebastian
