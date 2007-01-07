From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 16:32:05 +0100
Message-ID: <45A11275.7040508@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de>	 <1167986882.23138.52.camel@localhost.localdomain>	 <45A0ECBB.1040107@imc-berlin.de>	 <1168179704.22701.86.camel@localhost.localdomain>	 <45A105F7.6010502@imc-berlin.de> <1168181575.22701.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2371 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbXAGPcL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 10:32:11 -0500
To: tglx@linutronix.de
In-Reply-To: <1168181575.22701.95.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

>>> The timer_* functions are in librt.
>> Then why does the static linking not work?
> 
> Are the static libs available ?

Well. On the host system with /lib/tls/librt.so.1 there is only a
/usr/lib/librt.a. So maybe that does not work.

But the crosstool chain (built with crosstool) has all the static libs ...

Steven
