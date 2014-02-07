From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.12.6-rt9 on AM335x (armv7)
Date: Fri, 7 Feb 2014 17:07:32 +0100
Message-ID: <20140207160732.GD2382@linutronix.de>
References: <52C44448.3030405@ma-fu.de>
 <15611103.51LOkxSQt9@dabox>
 <52CC6F94.6070906@ma-fu.de>
 <10785809.PZUZGWPMgY@hydra>
 <52CD071D.9060207@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Sander <tim@krieglstein.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Matthias Fuchs <mfuchs@ma-fu.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46892 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaBGQHe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 11:07:34 -0500
Content-Disposition: inline
In-Reply-To: <52CD071D.9060207@ma-fu.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Matthias Fuchs | 2014-01-08 09:06:53 [+0100]:

>Hi Tim,
Hi Matthias,

>I already linked to trace for a 2508us run in a previous post. Here is the
>most interesting section. A added two comments:

Do you see this also without runtime-pm? Now that I think about it, I
remember that I disabled it in my config a while ago because they were
taking sleeping locks in hard irq context. Not sure if this is still the
case.

Sebastian
