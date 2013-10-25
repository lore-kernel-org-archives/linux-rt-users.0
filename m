From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: All 3.10.x rt patched kernels are unusable on my machine
Date: Fri, 25 Oct 2013 22:14:28 +0200
Message-ID: <20131025201428.GC21841@linutronix.de>
References: <1381746965.3978.27.camel@archlinux>
 <20131025174537.GA21841@linutronix.de>
 <1382727082.656.24.camel@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42449 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab3JYUO2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Oct 2013 16:14:28 -0400
Content-Disposition: inline
In-Reply-To: <1382727082.656.24.camel@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Ralf Mardorf | 2013-10-25 20:51:22 [+0200]:

>Hi Sebastian,
Hi Ralf,

>> You try to connect an uart cable to year serial port and capture the
>> kernel's output.
>
>I don't know how to do this, but I suspect I at least need a second
>computer?! So this is not an option, at least not on the fly.

Okay. In that case maybe try to start slow. Just boot without X and see
how that goes. If that works well try to start X.

>>  Maybe it shows what is wrong. Information about the
>> platform is probably usefull, too. Do you use only kernel modules from
>> kernel.org or do you have any out of tree patches / driver like graphics
>> driver, etc?
>
>For Ubuntu, where I do everything myself, I only use the patches from
>kernel.org. For Arch there sometimes are additional patches.
>
>E.g. https://aur.archlinux.org/packages/li/linux-rt/linux-rt.tar.gz ,
>for linux-rt 3.10.15_rt11-1 it's only this one:

That patch looks harmless, that should be fine.

Your hardware configuration does look that unusual. If someone reading
this could say that he is also using radeon driver, that would be nice.
If your problems rise again once you do start X then someone should try
to start debugging this. You could also wait for the next stable release
hoping that the problems goes away.

>Regards,
>Ralf

Sebasitan
