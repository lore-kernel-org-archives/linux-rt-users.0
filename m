From: nourry@free.fr
Subject: Re: Real-Time & Determinism
Date: Thu, 28 May 2009 12:16:32 +0200
Message-ID: <1243505792.4a1e6480d4e8a@imp.free.fr>
References: <4A17F444.6070005@free.fr>  <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com>  <4A180113.8030203@free.fr> <20090526232202.GC7006@linux.vnet.ibm.com> <75b66ecd0905271821q110b52dbq186242a3738d98a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Lee Revell <rlrevell@joe-job.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:41168 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZE1KRq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2009 06:17:46 -0400
Received: from wmproxy1-g27.free.fr (wmproxy1-g27.free.fr [212.27.42.91])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 72C5AD1A9C8
	for <linux-rt-users@vger.kernel.org>; Thu, 28 May 2009 12:17:42 +0200 (CEST)
In-Reply-To: <75b66ecd0905271821q110b52dbq186242a3738d98a3@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Selon Lee Revell <rlrevell@joe-job.com>:

>
> Hi Antoine,
>
> Keep in mind also that in -rt the non-preemptible sections are a very
> small subset of the kernel code - last time I checked it was just the
> timer ISR, the scheduler's SCHED_FIFO code, and the stub ISRs for the
> other interrupts.  The rest does not need to be audited for
> determinism.
>
> Of course, for "total determinism" you also have to mathematically
> prove the hardware behaves as expected...
>
> Lee
>

Thank you very much to all for your enlightments. Now it's time for me to test
this patch.

Antoine
