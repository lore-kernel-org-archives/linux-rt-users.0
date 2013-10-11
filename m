From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CONFIG_NO_HZ_FULL in x86 (32bit)?
Date: Fri, 11 Oct 2013 14:32:49 +0200
Message-ID: <20131011123249.GG6983@linutronix.de>
References: <F9467A784CC48947B1D879F07370839E1E0364DC@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33046 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197Ab3JKMcv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 08:32:51 -0400
Content-Disposition: inline
In-Reply-To: <F9467A784CC48947B1D879F07370839E1E0364DC@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Koehrer Mathias (ETAS/ESS2) | 2013-10-11 08:32:50 [+0000]:

>Hi all,
Hi Mathias,

>I found out that with the RT_PREEMPT patch for kernel 3.10 there is the cool feature rcu_nocbs (offload RCU callback processing) available which allows to free cores to run single real time user space applications on it.
>This feature depends on CONFIG_NO_HZ_FULL, however this is not available for x86 (32 bit).
>My question is now: Is there a way to get the rcu_nocbs running together with NO_HZ_FULL on a 32bit x86?

I *think* this is because VIRT_CPU_ACCOUNTING_GEN accounts everything in
nsec instead of jiffies and this could be very expensive on 32bit archs
doing 64bit math.
Frederic, is this everything or is there more to it?

>Thanks for any feedback
>
>Best regards
>
>Mathias

Sebastian
