From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam / EOD
Date: Thu, 09 Oct 2014 10:35:18 +0200
Message-ID: <543648C6.3040606@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos> <542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org> <542FE9B4.3060708@steinhoff.de> <alpine.DEB.2.11.1410042312440.4383@nanos> <54312C88.8060609@steinhoff.de> <alpine.DEB.2.11.1410051453590.4383@nanos> <54329A4B.7080706@steinhoff.de> <alpine.DEB.2.11.1410070237190.4383@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51611 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaJIIf1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Oct 2014 04:35:27 -0400
In-Reply-To: <alpine.DEB.2.11.1410070237190.4383@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner schrieb:
[ clip]

>that it is calling setpriority() with the arguments

>     which = 2 	   (PRIO_USER)
>     who   = 0     (root)
>     prio  = 0x14  (20)

>And that's exactly what is causing your problem.


OK, thanks a lot!! 


I jumped back to PREEMPT_RT  after several years and wonder:

- why isn't on kernel.org a direct link to this project? There is only a reference to an outdated page of RTwiki

- why is in the "latest News" of RTwiki (from 2012 / Reporting Bugs)) mentioned: 
"As always, please search the existing bug list and consider posting the issue to the linux-rt-users <https://rt.wiki.kernel.org/index.php/Mailinglists> mailing list before opening a new defect." ?

Do we have to add: "If you do so, you must be prepared to get personal attacks from kernel developers ??
 
- why is it neccessary to scroll down 4 screens of a 27" monitor to find the released "vanilla" kernels in 3.x?
  I gave up after the second screen and used then a "testing" kernel  -> and that's at the end the root of the chaos! 

Are you sure that the current representation of the PREEMPT_RT project will convince customers or developers to use it?

Next station in my test work is Minix 3.0: true mikrokernel system, drivers in user space ...

--Armin


