From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 11 Jun 2015 14:34:29 +0200
Message-ID: <20150611123429.GG16115@linutronix.de>
References: <20150519213923.GA26363@linutronix.de>
 <20150526083449.5357059b@sluggy>
 <20150526093832.558e2e46@gandalf.local.home>
 <20150526084802.2cfd055b@sluggy>
 <20150526111924.20836deb@gandalf.local.home>
 <20150526104343.51fad474@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56338 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbFKMec (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 08:34:32 -0400
Content-Disposition: inline
In-Reply-To: <20150526104343.51fad474@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Clark Williams | 2015-05-26 10:43:43 [-0500]:

>From: Clark Williams <williams@redhat.com>
>Date: Thu, 21 May 2015 12:51:53 -0500
>Subject: [PATCH] [rt] i915: bogus warning from i915 when running on PREEMPT_RT
>
>The i915 driver has a 'WARN_ON(!in_interrupt())' in the display
>handler, which whines constanly on the RT kernel (since the interrupt
>is actually handled in a threaded handler and not actual interrupt
>context).
>
>Change the WARN_ON to WARN_ON_NORT
>
>Signed-off-by: Clark Williams <williams@redhat.com>

Applied, thanks.

Sebastian
