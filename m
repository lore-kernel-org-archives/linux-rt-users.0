From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [4.0.5-rt4] i915: sleeping function called from invalid context
 at intel_pipe_update_start/end
Date: Fri, 10 Jul 2015 11:14:49 -0300
Message-ID: <20150710141449.GI5216@uudg.org>
References: <20150625150947.GA10320@uudg.org>
 <20150710140826.GB27402@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34797 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932559AbbGJOOy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 10:14:54 -0400
Received: by qkcl188 with SMTP id l188so24211965qkc.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 07:14:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150710140826.GB27402@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jul 10, 2015 at 04:08:26PM +0200, Sebastian Andrzej Siewior wrote:
| * Luis Claudio R. Goncalves | 2015-06-25 12:09:47 [-0300]:
| 
| >Hi!
| Hi,
| 
| >I have been seeing the annoying message below non-stop: 
| >
| >i915: sleeping function called from invalid context at intel_pipe_update_start/end
| 
| I am not sure what we break here if we drop the irq-off. It waits to sync
| with the interrupt and expects no interruption after that. What about if
| we skip this mmio_flip thing entirely? Either via modprobe or kernel
| commandline
| 
|     i915.use_mmio_flip=-1
| 
| should do the trick. Either way
|     /sys/module/i915/parameters/use_mmio_flip
| should be -1. Could you please try and test?

I will need to test that during the weekend, but I can surely test.

Luis
