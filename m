From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 09:56:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Walker <dwalker@mvista.com>, linux-rt-users@vger.kernel.org
To: Calin Culianu <cculianu@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:47768 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbXH0H4V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 03:56:21 -0400
In-Reply-To: <664539.31533.qm@web36101.mail.mud.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 25 Aug 2007, Calin Culianu wrote:

> Now, there is no way to raise the priority of particular driver's ISRs is
> there?  So that a specific ISR can preempt anything including a hard realtime
> process?

It's the second time you say "hard" real-time, so, just wanted to warn - 
it is not hard. It is still only soft real time, but a pretty good one, I 
think.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
