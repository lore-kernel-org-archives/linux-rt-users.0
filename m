From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: RT_PREEMPT autodetection from user program
Date: Sat, 19 Jan 2013 17:56:07 -0800
Message-ID: <8A87BD7C-0C1D-415D-8017-9B7739D4D088@thebigcorporation.com>
References: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Michael Haberler <mail17@mah.priv.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38373 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab3ATB4J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Jan 2013 20:56:09 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so2706644pbc.36
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Jan 2013 17:56:08 -0800 (PST)
In-Reply-To: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Jan 19, 2013, at 4:49 PM, Michael Haberler <mail17@mah.priv.at> wrote:

> Hi,
> 
> I need to autodetect the RT kernel for an application which runs under RTAI, Xenomai, RT_PREEMPT and vanilla kernels. 
> 
> To support a unified binary, I need to runtime detect the RT OS - what are my best options for RT_PREEMPT? from https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#Checking_the_Kernel I gather the single method:
> 
> parsing 'ps' output for IRQ handlers being kthreads, i.e. for '[IRQ' or '[irq'
> 
> any chance of doing better than that, or parsing of utsname.release for "-rt"?  A false positive on a vanilla kernel could be a safety hazard.
> 

Not sure what distro you are supporting and so on, but zcat /proc/config.gz | grep PREEMPT_RT might work.


Sven


