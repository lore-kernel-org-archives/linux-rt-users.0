From: Neil Bradley <neil.bradley@windowslive.com>
Subject: Re: [ANNOUNCE] 3.18.9-rt4
Date: Mon, 9 Mar 2015 22:54:54 +0000 (UTC)
Message-ID: <loom.20150309T235034-919@post.gmane.org>
References: <20150307141536.GA6485@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48504 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbbCIXAG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2015 19:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1YV6eZ-0000ew-OQ
	for linux-rt-users@vger.kernel.org; Tue, 10 Mar 2015 00:00:04 +0100
Received: from 97.246.109.203.static.cust.vf.net.nz ([203.109.246.97])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2015 00:00:03 +0100
Received: from neil.bradley by 97.246.109.203.static.cust.vf.net.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2015 00:00:03 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian Andrzej Siewior <bigeasy <at> linutronix.de> writes:

> 
> Dear RT folks!
> 
.. <snip>


Hi there.

If I compile the rt patch with any pre-emption model other than full
preemption, I get a compile error in kernel/irq_work:150:20.
hirq_work_list Undeclared.

Using current 3.18.9 sources & patch-3.18.9-rt4.

Cheers, Neil.

