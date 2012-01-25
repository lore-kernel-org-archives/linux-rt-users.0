From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT_PREEMPT with RS232 and USB-RS232 adapter
Date: Wed, 25 Jan 2012 11:56:15 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1201251153260.2716@ionos>
References: <38e80508-f150-4e9a-b0d4-303a391e8007@zmail.sgconsulting.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Forconi <forconi@wavecomm.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57867 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2AYK4Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 05:56:16 -0500
In-Reply-To: <38e80508-f150-4e9a-b0d4-303a391e8007@zmail.sgconsulting.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 19 Jan 2012, Forconi wrote:
> I'm working on an RT_PREEMPT patched kernel to test a small C
> program that sends 39B of data on the serial line every 50ms.

> I'm testing the timing accuracy using a scope on the TX pin of the
> serial cable.

> When I run the application using /dev/ttyS0 as serial port I see
> data starting every 50ms, but when I run the application using a
> Prolific PL2303 USB-RS232 adapter on /dev/ttyUSB0 I see data out
> every 250ms.

> Is this possible or I'm doing something wrong?

Why do you expect that USB is in any way deterministic?
