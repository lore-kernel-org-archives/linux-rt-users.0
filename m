From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 4 Oct 2013 20:34:40 +0200
Message-ID: <20131004183440.GM19953@linutronix.de>
References: <20130829184228.GD15360@linutronix.de>
 <5125727.2P4PZHk0nB@bs8>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55701 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953Ab3JDSel (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 14:34:41 -0400
Content-Disposition: inline
In-Reply-To: <5125727.2P4PZHk0nB@bs8>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Bernhard Schiffner | 2013-08-30 12:32:48 [+0200]:

>Just for the records:
>
>older, but recent rt-kernels (3.10.*, rt [1,3]) stopped booting here 
>indicating some problems with initialisation of the nouveau drm driver.
>(might also be a PCI-E problem)
>
>This was not the case with 3.8.*-rt*.
>The problem gone with 3.10.10-rt7 tested today.

In that case it was probably fixed by the stable series.

>A lot of thanks!
>
>
>Bernhard 
>
>PS:
>Would it be much work to activate netconsole with rt-kernels?
>(I was ready to send some "real screenshots" of the probelm next days,  but 
>the problem gone :-) )

You could enable and check what explodes. I would assume the problem is
somewhere around write_msg() :)

Sebastian
