From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
Date: Tue, 27 Aug 2013 23:12:13 +0200
Message-ID: <521D162D.3030301@osadl.org>
References: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:48626 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3H0VXM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Aug 2013 17:23:12 -0400
In-Reply-To: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Wolfgang,

> I know that in 2.6.33 there were splitted softirqs, and that it was possible to configure each thread with its own priority.
> What are the steps that need to be done in 3.x to achieve similar results as in 2.6.33?
The full story is here -> https://www.osadl.org/?id=930. Among others, 
it says "Thomas Gleixner found the most elegant solution that directly 
runs the network task in the context of the IRQ thread of the related 
device and, thus, implicitly adopts its priority." BTW: Thomas did this 
work when he ported RT to kernel version 3.6, Sebastian posted his 
backport to 3.2 and 3.4 half a year ago. The missed softirq split is 
history.

	-Carsten.
