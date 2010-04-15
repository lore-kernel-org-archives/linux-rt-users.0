From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Debugging a hard lockup with no symptoms
Date: Thu, 15 Apr 2010 15:47:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004151533090.24951@haggis.caltech.edu>
References: <Pine.LNX.4.64.1004132345050.14952@haggis.caltech.edu>
 <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:41306 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab0DOWrQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Apr 2010 18:47:16 -0400
In-Reply-To: <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It is now looking as though the lockups may be caused by a problem in
the commercial analog I/O card that I am using, rather than in either
my code or the kernel. The dramatic increase in the frequency of the
lockups today, allowed me to associate the lockups with a couple of
outw() instructions that pass values to two digital to analog
converters on the card. When I comment out those instructions, or put
a few microseconds of delay between them, then the lockups stop. I
have talked to the manufacturer's tech support, and they have a
suspicion of the cause, and are working on trying to reproduce the
problem.

Martin
