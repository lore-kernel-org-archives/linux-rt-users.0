From: Mike Galbraith <efault@gmx.de>
Subject: Re: timer signal loss on RT
Date: Sat, 10 Mar 2012 12:08:50 +0100
Message-ID: <1331377730.5641.4.camel@marge.simpson.net>
References: <4F5B2C50.2090907@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-rt <linux-rt-users@vger.kernel.org>,
	Mark Hounschell <markh@compro.net>,
	Thomas Gleixner <tglx@linutronix.de>
To: dmarkh@cfl.rr.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:39294 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751768Ab2CJLIy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Mar 2012 06:08:54 -0500
In-Reply-To: <4F5B2C50.2090907@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2012-03-10 at 05:26 -0500, Mark Hounschell wrote:

> compile with "cc rtc.c -o rtc -lrt -lpthread"
> 
> run it and in 10 seconds it should stop and indicate 600 timers signals 
> were caught by the RT thread. On RT, I usually get 0 but often I get some, 
> just not 600.

Increase the priority of ksoftirqd.

-Mike

