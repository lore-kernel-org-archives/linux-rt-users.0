From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Replacement for Xenomai's Message queues?
Date: Thu, 28 Jan 2010 10:56:50 -0800
Message-ID: <4B61DDF2.6010309@us.ibm.com>
References: <21390406.1264666196447.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:55109 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932277Ab0A1S44 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 13:56:56 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SIkr1Q023394
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 13:46:53 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o0SIurUh148846
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 13:56:54 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o0SIuqg2015017
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 16:56:52 -0200
In-Reply-To: <21390406.1264666196447.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

M. Koehrer wrote:
> Hi all,
> 
> I am about to switch an realtime application from Xenomai to the RT_PREEMPTION patch.
> Everything works really smooth, however I have one question.
> With my Xenomai application I use the message queue which combine transfer (including queuing)
> of data with activation of the thread.
> In my Xenomai application I use this feature quite frequently. Now, I am not sure how to do an equivalent
> with the RT_PREEMPT patch.
> (see http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__native__queue.html)
> Of course I could use condition variables and a struct or array to hold the data I want to pass with the activation
> of a thread. However, using this approach I do not have the queuing (which is some extra effort I could spent...).
> Another idea I have: I could use sockets which realize the queuing but the overhead is too high.
> 
> Is there any suitable way to implement a message queue like approach using RT_PREEMPT patch?
> I am running x86 (Dual/Quad Cores).

I don't if we have many xenomai experts on this list. It would help to 
understand which aspects of the Xenomai message queue are important to 
you (other than the ability to block on a queue and wake when a message 
is available). For a basic message queueing system with the ability to 
prioritize messages, you can look to the POSIX.4 Message Queues. A 
google search will provide plenty of howto's, and the API appears at 
least similar to what you were using with Xenomai.

I haven't looked, but I don't think Linux supports message driven 
Priority Inheritance 
(http://www.qnx.com/developers/docs/6.3.2/neutrino/sys_arch/kernel.html#Priority_inheritance_messages).

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
