From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Cyclictest on non apic plattforms
Date: Tue, 05 Dec 2006 21:13:57 +0100
Message-ID: <1165349637.24604.169.camel@localhost.localdomain>
References: <20061205200223.48889.qmail@web28012.mail.ukl.yahoo.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:41733 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030945AbWLEUKv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Dec 2006 15:10:51 -0500
To: cinetic bellini <cinetic19@yahoo.de>
In-Reply-To: <20061205200223.48889.qmail@web28012.mail.ukl.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2006-12-05 at 20:02 +0000, cinetic bellini wrote:
>

Please configure your MUA to make line breaks at 78 characters. Thanks.

> I uses the the RT patch on different x86 platforms (rt cyclictest).
> On Pentium 4  systems I got perfect results: around 50us jitter. 
> On older platforms like  P3 oder P1 I got a much worse jitter: bigger
> than 1000us. I think they use an older timer unit like the 8254.
> 
> It's possible to get a high resolution posix timer even on older x86
> systems?

Yes, we use the PIT for high resolution timers on UP systems. Can you
provide a bootlog please ?

	tglx
