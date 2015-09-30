From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Long max latencies on Wandbaord / Freescale i.MX6
Date: Wed, 30 Sep 2015 09:11:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509300909240.4500@nanos>
References: <5606677A.1020705@gmx.net> <alpine.DEB.2.11.1509271346160.4500@nanos> <560A3020.5090909@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Matthias Meier <matthias.j.meier@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56689 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbI3HMS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Sep 2015 03:12:18 -0400
In-Reply-To: <560A3020.5090909@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 29 Sep 2015, Matthias Meier wrote:

> just for imformation what causes the long latencies...
> 
> cause of the latency problem of up to 10ms was 'CONFIG_PROVE_LOCKING' enabled
> in the kernel config. After disabling it, the max latency is now below 400us.
> (many thx to tglx who found the problem).

There are plenty of other debug options enabled in that config file,
which introduce latencies. If you switch them off you should get
results which are below 100us.

Thanks,

	tglx
