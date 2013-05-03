From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Suspend resume problem (WAS Re: [ANNOUNCE] 3.8.10-rt6)
Date: Fri, 3 May 2013 12:27:03 +0200
Message-ID: <20130503102703.GC8230@linutronix.de>
References: <20130429201202.GB7979@linutronix.de>
 <20130429161925.2a6ea78a@riff.lan>
 <20130430170948.GB4688@linutronix.de>
 <2408558.MfQ5MZYUhX@bs8>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44403 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761957Ab3ECK1E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 May 2013 06:27:04 -0400
Content-Disposition: inline
In-Reply-To: <2408558.MfQ5MZYUhX@bs8>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Bernhard Schiffner | 2013-05-01 10:32:43 [+0200]:

>This patch together with the in_nmi() patch solves the resume problem for me.
>Architecture X64, patched against 3.8.10-rt6.

You should be able to drop the in_nmi() patch have it still working.

>THANKS!
>
>Bernhard

Sebastian
