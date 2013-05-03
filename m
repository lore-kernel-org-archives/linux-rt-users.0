From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Subject: Re: Suspend resume problem (WAS Re: [ANNOUNCE] 3.8.10-rt6)
Date: Fri, 03 May 2013 19:46:45 +0200
Message-ID: <28497065.fpBpkFWOyd@bs8>
References: <20130429201202.GB7979@linutronix.de> <2408558.MfQ5MZYUhX@bs8> <20130503102703.GC8230@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57053 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812Ab3ECRq5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 May 2013 13:46:57 -0400
In-Reply-To: <20130503102703.GC8230@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Freitag, 3. Mai 2013, 12:27:03 schrieb Sebastian Andrzej Siewior:
> * Bernhard Schiffner | 2013-05-01 10:32:43 [+0200]:
> >This patch together with the in_nmi() patch solves the resume problem for
> >me. Architecture X64, patched against 3.8.10-rt6.
> 
> You should be able to drop the in_nmi() patch have it still working.
Confirmed.
(oops kernel is 3.8.11-rt6 now, but working)
> 
> >THANKS!
> >
> >Bernhard
> 
> Sebastian
