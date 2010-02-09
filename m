From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Converting a device driver for real time kernel
Date: Tue, 9 Feb 2010 10:26:49 -0200
Message-ID: <20100209122649.GK2540@uudg.org>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:17958 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab0BIM07 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2010 07:26:59 -0500
Received: by qw-out-2122.google.com with SMTP id 9so845546qwb.37
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Feb 2010 04:26:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 09, 2010 at 09:32:30AM -0000, Leggo, Adam (UK) wrote:
| Hello,
|  
| What is the best way of converting an existing device driver to work
| under a real-time kernel?
|  
| A device driver provided for a special serial card (Curtiss Wright SL240
| sFDFP card http://www.cwcembedded.com/products/0/1/461.html) works under
| vanilla Linux (SLES SP10 SP2 kernel 2.6.16.60-0.21-smp), but compiling
| the driver under the real time kernel (2.6.22.19-0.14-rt) the system
| locks up and crashes. The rt kernel is being used to write large amounts
| of data from the serial card to disk and testing has found the rt kernel
| has the best consistent write performance.
|  
| I have gone back to the supplier and they are not interested in
| developing a real time version of the driver. So I am trying to modify
| the driver myself. The driver code can be provided if anyone wants a
| look (released under GPLv2).

The oops or panic messages issued when the kernel locks up are a good
starting point to find the underlying issue.

Due to the nature of PREEMPT_RT subtle concurrency problems on the driver,
that may take a lifetime to appear under upstream Linux, will show up every
now and then on RT.

I would also put my bets on locking. As regular spinlocks are converted to
rtmutexes and can therefore sleep, I would check locking on the driver and
eventually convert some of the locks to old-style spinlocks. The naming on
the non-sleeping locks varies according to the version of the PREEMPT_RT
patch in use.

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

