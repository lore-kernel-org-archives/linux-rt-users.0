From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 14:31:10 +0100
Message-ID: <459D019E.1070906@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de> <1167917257.23138.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2223 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964867AbXADNbP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 08:31:15 -0500
To: tglx@linutronix.de
In-Reply-To: <1167917257.23138.17.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

>>>> Will I need a special version of glibc or libpthread? NTPL?
>>>> I am using a cross tool chain gcc-3.4.4-glibc-2.3.5 for i686 built with
>>>> "crosstool".
>>> You usually need NPTL, and if I remember correctly you also needed the
>>> hrtimer-support lib for older glibcs.
>> Any pointers where I could find this hrtimer-support?
> 
> cyclictest does not need any extra functionality. You only need a new
> glibc if you want to use priority inheritance mutexes.

Ok. Then any idea how I could find out why sigwait() is blocking?

Thanks!

Steven
