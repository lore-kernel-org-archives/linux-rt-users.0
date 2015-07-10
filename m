From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.0.5-rt4] i915: sleeping function called from invalid context
 at intel_pipe_update_start/end
Date: Fri, 10 Jul 2015 16:08:26 +0200
Message-ID: <20150710140826.GB27402@linutronix.de>
References: <20150625150947.GA10320@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46883 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbbGJOI3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 10:08:29 -0400
Content-Disposition: inline
In-Reply-To: <20150625150947.GA10320@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2015-06-25 12:09:47 [-0300]:

>Hi!
Hi,

>I have been seeing the annoying message below non-stop: 
>
>i915: sleeping function called from invalid context at intel_pipe_update_start/end

I am not sure what we break here if we drop the irq-off. It waits to sync
with the interrupt and expects no interruption after that. What about if
we skip this mmio_flip thing entirely? Either via modprobe or kernel
commandline

    i915.use_mmio_flip=-1

should do the trick. Either way
    /sys/module/i915/parameters/use_mmio_flip
should be -1. Could you please try and test?

Sebastian
