From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 02:12:02 -0700
Message-ID: <1188205922.29859.53.camel@sx.thebigcorporation.com>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
	 <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Calin Culianu <cculianu@yahoo.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alnrmhc13.comcast.net ([206.18.177.53]:35682 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbXH0JMG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 05:12:06 -0400
In-Reply-To: <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-08-27 at 09:56 +0200, Guennadi Liakhovetski wrote:
> On Sat, 25 Aug 2007, Calin Culianu wrote:
> 
> > Now, there is no way to raise the priority of particular driver's ISRs is
> > there?  So that a specific ISR can preempt anything including a hard realtime
> > process?
> 
> It's the second time you say "hard" real-time, so, just wanted to warn - 
> it is not hard. It is still only soft real time, but a pretty good one, I 
> think.


Hard / Soft is a property of the application's deadline requirements,
not a property of the operating system.

The consequences of missing a deadline determine determine whether an RT
>application< is hard or soft RT. 

Therefore, it is inappropriate to qualify an operating system as hard or
soft RT without deadline context.

Sven
