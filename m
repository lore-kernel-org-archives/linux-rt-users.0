From: Till Straumann <strauman@slac.stanford.edu>
Subject: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Thu, 08 Nov 2012 16:28:48 -0600
Message-ID: <509C3220.2050601@slac.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailbox.alumni.tu-berlin.de ([130.149.4.13]:39635 "EHLO
	mailbox.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756985Ab2KHWp2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 17:45:28 -0500
Received: from [189.138.186.238] (helo=[192.168.1.67])
	  by mailbox.alumni.tu-berlin.de (exim-4.76) with esmtpsa [TLSv1:DHE-RSA-AES256-SHA:256]
	  for <linux-rt-users@vger.kernel.org>
	  id 1TWaah-0005Bh-5n; Thu, 08 Nov 2012 23:28:51 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello list.

I have a driver which is designed to do most work in user-space.
The ISR is really simple. It just ACKs/clears the interrupt and
then should unblock a waiting thread.
It seems overkill (and costs me about 5-10us) to use a threaded
interrupt in such a case (hard isr unblocks a kthread whose only
'work' is unblocking another (user) thread).

I have found some references where users try to do a similar
thing via UIO
(e.g.,
http://article.gmane.org/gmane.linux.rt.user/7372/
http://article.gmane.org/gmane.linux.rt.user/7676)

However, the succinct answer was along the line 'that can't work with UIO'.

IMHO it would be very helpful to get a more detailed explanation
as to why it doesn't work (i.e., what things you are and are not
allowed to do from a hard-isr under RT_PREEMPT). I suspect it is
because UIO calls routines such as 'kill_fasync' which use
ordinary (as opposed to raw) spinlocks which means that the
caller could be preempted (under RT_PREEMPT), right?

What *is* the recommended mechanism to wake up a thread from
a hard-isr?

It would IMHO be desirable to modify the UIO driver so that it
is possible to support non-threaded handlers.

Thanks for any enlightenment (and the fantastic rt-preempt patch
in the first place)!

- Till

PS: Please CC me on any replies; I am currently not a subscriber.
