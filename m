From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting a device driver for real time kernel
Date: Tue, 9 Feb 2010 23:27:48 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1002092317420.2811@localhost.localdomain>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:60684 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab0BIW15 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2010 17:27:57 -0500
In-Reply-To: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 9 Feb 2010, Leggo, Adam (UK) wrote:

> Hello,
>  
> What is the best way of converting an existing device driver to work
> under a real-time kernel?
>  
> A device driver provided for a special serial card (Curtiss Wright SL240
> sFDFP card http://www.cwcembedded.com/products/0/1/461.html) works under
> vanilla Linux (SLES SP10 SP2 kernel 2.6.16.60-0.21-smp), but compiling
> the driver under the real time kernel (2.6.22.19-0.14-rt) the system
> locks up and crashes. The rt kernel is being used to write large amounts
> of data from the serial card to disk and testing has found the rt kernel
> has the best consistent write performance.
>  
> I have gone back to the supplier and they are not interested in
> developing a real time version of the driver. So I am trying to modify
> the driver myself. The driver code can be provided if anyone wants a
> look (released under GPLv2).
>  
> Any assistance would be useful.

The problem of the driver is probably broken locking, which needs to
be fixed for !RT as well.

But if you want to fix it your self and need some assistance it would
be helpful if you could:

1) Run against a recent -rt kernel

2) provide a serial console log of the kernel crash

3) run the kernel with CONFIG_PROVE_LOCKING=y and provide the output

4) upload the source to some place so we can at least have a look at
   the code to give you hints.

Thanks,

	tglx

