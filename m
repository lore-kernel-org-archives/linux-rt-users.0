From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.4.1-rt9
Date: Fri, 15 Jun 2012 01:28:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206150127430.3086@ionos>
References: <1339076397.7559.4.camel@gandalf.stny.rr.com> <4FD148F6.3040309@linuxsystems.it> <4FD2374E.1010105@linuxsystems.it>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-710937746-1339716513=:3086"
Cc: RT <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-15?Q?Niccol=F2_Belli?= <darkbasic@linuxsystems.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33861 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab2FNX2e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jun 2012 19:28:34 -0400
In-Reply-To: <4FD2374E.1010105@linuxsystems.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-710937746-1339716513=:3086
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 8 Jun 2012, Niccolò Belli wrote:

> Il 08/06/2012 02:36, Niccolò Belli ha scritto:
> > After upgrading from 3.4.0-rt7 to 3.4.1-rt9 the system hangs as soon as
> > kde plays the startup sound.
> 
> Errata corrige: same problem with -rt7. The culprit is the config, I attached
> the config diff, if you can identify where the problem relies please let me
> know.

Just a guess, the area which I would suspect is:

 # CONFIG_PCIEASPM_DEBUG is not set
-# CONFIG_PCIEASPM_DEFAULT is not set
-CONFIG_PCIEASPM_POWERSAVE=y
+CONFIG_PCIEASPM_DEFAULT=y
--8323328-710937746-1339716513=:3086--
