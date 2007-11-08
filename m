From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Priority Ceiling for SMP?
Date: Thu, 08 Nov 2007 18:26:55 +0100
Message-ID: <473346DF.3080108@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:42822 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759437AbXKHR1W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2007 12:27:22 -0500
Received: from mo-p00-ob.rzone.de (mrclete-mo-p00-ob.mail [192.168.63.64])
	by charnel-fb-04.store (RZmta 14.0) with ESMTP id R03711jA8DD1Gf
	for <linux-rt-users@vger.kernel.org>;
	Thu, 8 Nov 2007 18:27:20 +0100 (MET)
	(envelope-from: <kuhn@l1nuxh4ck3r.de>)
Received: from [192.168.0.1]
	(ppp-88-217-14-166.dynamic.mnet-online.de [88.217.14.166])
	by post.webmailer.de (mrclete mo64) (RZmta 14.0)
	with ESMTP id t02788jA8EJQDn for <linux-rt-users@vger.kernel.org>;
	Thu, 8 Nov 2007 18:26:00 +0100 (MET)
	(envelope-from: <kuhn@l1nuxh4ck3r.de>)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi!

I'm thinking about adding the priority ceiling protocol to -rt
(implemented in a way so that you can select between priority
inheritance and priority ceiling with the kernel configurator).

Since this mechanism inherently avoids dead-locks, it could be
helpful for applications that need high safety integrity levels!?

The priority ceiling protocol is basically no rocket science
and implemented for other OSes for a while, so it should be
a no-brainer get it going with Linux. However. I'm struggling
at the point where it comes to SMP: it seems like when a task
acquires a lock, it is necessary to un-schedule any active
tasks on other cores sharing the same lock. This would be
very inefficient, of course, because tasks sharing a lock
couldn't run in parallel on different CPUs.

Does anybody know of any other priority inversion and
dead-lock avoidance mechanism that would efficiently work
on SMP?

Feedback is highly appreciated!

regards

Bernhard
