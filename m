From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Thu, 09 Apr 2015 14:37:19 +0200
Message-ID: <5526727F.1060703@linutronix.de>
References: <55245FC8.9090509@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47201 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018AbbDIMhV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2015 08:37:21 -0400
In-Reply-To: <55245FC8.9090509@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/08/2015 12:52 AM, Carsten Emde wrote:
> Hi Sebastian,

Hi Carsten,

> an Intel Bay Trail board (Intel(R) Celeron(R) CPU  J1900  @ 1.99GHz) at
> the OSADL QA Farm rack #b/slot #6 (https://www.osadl.org/?id=1894) stops
> working every 12 to 36 hours. The only way to get the board back to work
> is to power cycle it. Such crashes did not happen with any of the
> previously tested 3.12-rt kernels. About eight crashes have been
> observed so far - the kernel message obtained at the serial console (see
> below) was similar in all cases.

This backtrace looks familiar I think. I think the problem is that
hrtimer_cancel() is called from hrtimer_interrupt() and deadlocks. Is
there anything special you do here except runnin FULL_NOHZ?

> 
> Thanks,
> Carsten.
Sebastian

