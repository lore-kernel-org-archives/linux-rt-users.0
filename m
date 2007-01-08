From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Mon, 08 Jan 2007 12:43:41 +0100
Message-ID: <45A22E6D.2010306@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de> <20070104115215.GN29495@pengutronix.de> <459CFDF1.80807@imc-berlin.de> <1167917257.23138.17.camel@localhost.localdomain> <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain> <45A22CFE.7070402@imc-berlin.de> <20070108114206.GQ29495@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:3558 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbXAHLnr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jan 2007 06:43:47 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20070108114206.GQ29495@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:
> On Mon, Jan 08, 2007 at 12:37:34PM +0100, Steven Scholz wrote:
>> Well the statically linked version on SuSE 10.0 hangs as well.
>>
>> Using the crosstool chains
>>
>> 	gcc-4.1.1-glibc-2.3.6-linux-2.6.15.1 (2.6.12 headers)
>> 	gcc-3.4.4-glibc-2.3.5-linux-2.6.12
>>
>> the cyclictest segafaults on the SuSE host and target system. strace attached.
>>
>> Any more ideas? Maybe? Please?
> 
> How much RAM does your box have?

The desktop has 1GB. The kontron cp306 target has 512MB.

--
Steven
