From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 13:08:49 +0100
Message-ID: <459CEE51.8050308@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de> <20070104115215.GN29495@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:1585 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964795AbXADMIy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 07:08:54 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20070104115215.GN29495@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert,

Thanks for your fast reply.

>> Will I need a special version of glibc or libpthread? NTPL?
>> I am using a cross tool chain gcc-3.4.4-glibc-2.3.5 for i686 built with
>> "crosstool".
> 
> You usually need NPTL, and if I remember correctly you also needed the
> hrtimer-support lib for older glibcs.

How could I find out if the glibc on the OASDL CD uses a patch glibc? I only
see libc-2.3.5.so ...

Steven
