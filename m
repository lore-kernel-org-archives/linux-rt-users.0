From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 15:29:58 +0100
Message-ID: <1200320998.4249.3.camel@homer.simson.net>
References: <1200250801.9190.7.camel@localhost.localdomain>
	 <200801132143.34889.m.kozlowski@tuxland.pl>
	 <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com>
	 <1200299260.4665.17.camel@homer.simson.net>
	 <478B0B7C.BA47.005A.0@novell.com>
	 <1200317101.3733.14.camel@homer.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:38346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750973AbYANOaF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 09:30:05 -0500
In-Reply-To: <1200317101.3733.14.camel@homer.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-01-14 at 14:25 +0100, Mike Galbraith wrote:

> No, I just copied the matching paranoia while leering at it.

Actually, I can't say definitively no, only that a panic() there didn't
make keyboard blink.  Suspend may be disabling blinkies, dunno.

	-Mike
