From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Beginner's questions on userspace latency
Date: Fri, 22 Mar 2013 21:23:06 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303222121100.22263@ionos>
References: <514CB285.4050100@nittka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Oliver Nittka <oly@nittka.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38624 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422768Ab3CVUXJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 16:23:09 -0400
In-Reply-To: <514CB285.4050100@nittka.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Mar 2013, Oliver Nittka wrote:
> The timing is fine most of the time, but putting the system under heavy
> CPU and USB load leads to occasional glitches where the time between two
> ioctl calls can be as high as 50ms.

The kernel tracer is your friend. Enable the kernel function tracer
and add a check into your application which detects the issue and then
stops the trace. See the cyclictest source code for an example how to
do that.

Thanks,

	tglx
