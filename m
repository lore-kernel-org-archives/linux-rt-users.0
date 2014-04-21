From: Stanislav Meduna <stano@meduna.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Mon, 21 Apr 2014 11:11:10 +0200
Message-ID: <5354E0AE.2040702@meduna.org>
References: <53503BD8.8000506@meduna.org> <53525197.5040904@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:46936 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaDUJLS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Apr 2014 05:11:18 -0400
In-Reply-To: <53525197.5040904@xenomai.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.04.2014 12:36, Gilles Chanteperdrix wrote:

> #1 can be avoided by using the ARM FCSE extension.

An interesting stuff, thanks for pointing this up.

> A patch exists for #1 which is currently integrated into the Adeos patch
> but could exist independently. I could post the patch here for Linux
> vanilla here if there is enough interest, and let you do the merge with
> the preempt_rt patch.

I am surely not skilled enough to merge and test this, but publishing
the patch rebased to current kernels somewhere would be surely
interesting.

Thanks
-- 
                                            Stano

