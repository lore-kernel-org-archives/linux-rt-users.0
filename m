From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Looking for a real time IPC to be used with select
Date: Mon, 19 Apr 2010 08:31:59 +0200 (CEST)
Message-ID: <29168504.1271658719738.JavaMail.ngmail@webmail18.arcor-online.net>
References: <r2r6d09081c1004170742ia4f0b1c5vfa51005c934617fd@mail.gmail.com> <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: pradysam@gmail.com, mathias_koehrer@arcor.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:46947 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214Ab0DSGcB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Apr 2010 02:32:01 -0400
In-Reply-To: <r2r6d09081c1004170742ia4f0b1c5vfa51005c934617fd@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Pradyumna,

thanks for this approach!

> > My question is now: What kind of IPC is preferred here?
> > The only IPC I see is a local socket communication, however
> > this looks like a huge overhead for triggering...
> 
> POSIX message queues in the kernel work fine for me. I had one problem
> with the accuracy of the timeouts in mq_timedreceieve and mq_timedsend
> which has been now fixed and is available as part of the latest -rt
> patch.
I read again the man page "mq_overview" and found that the message queue descriptor 
could be used with select/poll! That's a point I have not realized so far.
Thus, this allows to use this as another promising approach!
BTW: When I use select() for the timeouts and mq_receive (instead of mq_timedreceive), 
I hope to find no accuaracy issue... 
I think select() is using high accuracy with the timeout in -rt.

Regards

Mathias

-- 
Mathias Koehrer
mathias_koehrer@arcor.de


Traumziele - von Beschreibung bis Buchung jetzt kompakt auf den Reise-Seiten von Arcor.de! http://www.arcor.de/rd/footer.reise
