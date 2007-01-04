From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 16:01:37 +0100
Message-ID: <459D16D1.4040306@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de> <1167917257.23138.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4956 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964890AbXADPBn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 10:01:43 -0500
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id E3AE02F02C
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Jan 2007 16:55:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 1BA1510B46
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Jan 2007 16:01:41 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 34C1B10760
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Jan 2007 16:01:40 +0100 (CET)
In-Reply-To: <1167917257.23138.17.camel@localhost.localdomain>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Thu, 2007-01-04 at 14:15 +0100, Steven Scholz wrote:
>> Robert Schwebel wrote:
>>> On Thu, Jan 04, 2007 at 12:43:11PM +0100, Steven Scholz wrote:
>>>> Will I need a special version of glibc or libpthread? NTPL?
>>>> I am using a cross tool chain gcc-3.4.4-glibc-2.3.5 for i686 built with
>>>> "crosstool".
>>> You usually need NPTL, and if I remember correctly you also needed the
>>> hrtimer-support lib for older glibcs.
>> Any pointers where I could find this hrtimer-support?
> 
> cyclictest does not need any extra functionality. You only need a new
> glibc if you want to use priority inheritance mutexes.

So IIUC the cyclictest should run and give results even on kernels with no
real time, preempt, lowlatency support at all?

Just tried it on a plain 2.6.19. posix timer version still hangs ...
--
Steven
