From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Real-Time & Determinism
Date: Thu, 28 May 2009 09:38:19 -0300
Message-ID: <20090528123819.GC21851@unix.sh>
References: <4A17F444.6070005@free.fr> <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com> <4A180113.8030203@free.fr> <20090526232202.GC7006@linux.vnet.ibm.com> <75b66ecd0905271821q110b52dbq186242a3738d98a3@mail.gmail.com> <1243505792.4a1e6480d4e8a@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lee Revell <rlrevell@joe-job.com>, linux-rt-users@vger.kernel.org
To: nourry@free.fr
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:33562 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686AbZE1Miq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2009 08:38:46 -0400
Received: by pxi29 with SMTP id 29so959675pxi.33
        for <linux-rt-users@vger.kernel.org>; Thu, 28 May 2009 05:38:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1243505792.4a1e6480d4e8a@imp.free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 28, 2009 at 12:16:32PM +0200, nourry@free.fr wrote:
| Selon Lee Revell <rlrevell@joe-job.com>:
| 
| >
| > Hi Antoine,
| >
| > Keep in mind also that in -rt the non-preemptible sections are a very
| > small subset of the kernel code - last time I checked it was just the
| > timer ISR, the scheduler's SCHED_FIFO code, and the stub ISRs for the
| > other interrupts.  The rest does not need to be audited for
| > determinism.
| >
| > Of course, for "total determinism" you also have to mathematically
| > prove the hardware behaves as expected...

That's a good point :)

I have been running tests in a fine piece of hardware that due to SMI
spikes (above 450us) may not be suitable for all the RT applications. That
must surely be taken in account and can be inspected using Jon Masters'
smi_detector kernel module.

| Thank you very much to all for your enlightments. Now it's time for me to test
| this patch.

Luis 
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

