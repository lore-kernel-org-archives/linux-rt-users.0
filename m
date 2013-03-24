From: Oliver Nittka <oly@nittka.com>
Subject: Re: Beginner's questions on userspace latency
Date: Sun, 24 Mar 2013 21:09:47 +0100
Message-ID: <514F5D8B.7070706@nittka.com>
References: <514CB285.4050100@nittka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Staffan Tjernstrom <stjernstrom@eagleseven.com>,
	tstone@krieglstein.org, tglx@linutronix.de
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout10.t-online.de ([194.25.134.21]:41739 "EHLO
	mailout10.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab3CXUKE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Mar 2013 16:10:04 -0400
In-Reply-To: <514CB285.4050100@nittka.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you all very much for your insights!

I was experimenting some more on the weekend, and before I could
investigate everything I learned from you, CPU isolation did the trick
for me (using cset just like shown in the wiki).

I originally thought sched_setaffinity() would suffice, but giving the
application its own CPU helped a lot. Didn't get anything over 1.735 ms
for two days now.

FYI: this is running on a Kontron pITX-SP
http://de.kontron.com/products/boards+and+mezzanines/embedded+sbc/pitx+25+sbc/pitxsp.html.

Thanks again!

  -- o

