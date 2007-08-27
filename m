From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 12:55:02 +0200
Message-ID: <46D2AD86.2080003@l1nuxh4ck3r.de>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com> <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de> <46D28A9F.1050008@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <gl@dsa-ac.de>,
	Calin Culianu <cculianu@yahoo.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:37130 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbXH0Kvh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 06:51:37 -0400
Received: from mo-p00-ob.rzone.de (mrclete-mo-p00-ob.mail [192.168.63.64])
	by charnel-fb-02.store (RZmta 10.2) with ESMTP id r0367ej7R8mw4d
	for <linux-rt-users@vger.kernel.org>;
	Mon, 27 Aug 2007 12:51:36 +0200 (MEST)
In-Reply-To: <46D28A9F.1050008@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Carsten Emde wrote:
> So why are we not allowed to call this "hard real-time"?

:-)

I guess the disconnect is that even an RTOS can't guarantee
timing when the user didn't analysed his application software
with due diligence before going into production.

For example, someone can very well do something like
"for(;;);" at fifo priority 99, locking out all other threads
completely. The RTOS might think this is what the user likes
to do - means: an RTOS doesn't prevent a user to do silly things!

In this respect, it is even more dangerous if i.e. multimedia
application make use of real time priorties, because it can
easily lookup the whole system whereas "nice" priorities only
reduce system responsivness in case something went wrong.

Even if the developer carefully reviews what the application
is doing, then there is still the risk that he has overlooked
something. This is the reason why RTOSes like OSEK have a
"timing protection" that checks if a certain thread doesn't
exceed a given amount of allowed time per system cycle.
Not truly the best solution, either, but at least a means
of detecting that something went wrong ...

Concerning locking: the amount of time a low priority
thread holds a lock and in turn prevents a high priority
thread from acquiring it is a pure application problem
(means, something the developer has to take care about).
However, -rt implements the priority inheritance protocol
to soften that issue.

BTW.: Avoiding locks is a good real time programming
practice, *g* (However this is not always achivable).

regards

Bernhard
