From: Michael Haberler <mail17@mah.priv.at>
Subject: RT_PREEMPT autodetection from user program
Date: Sun, 20 Jan 2013 01:49:59 +0100
Message-ID: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.mah.priv.at ([86.59.12.250]:37930 "EHLO sil1.mah.priv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab3ATB0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Jan 2013 20:26:45 -0500
Received: from macbook.stiwoll.mah.priv.at ([193.228.47.195])
	by sil1.mah.priv.at with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mail17@mah.priv.at>)
	id 1Twj6m-00014K-4b
	for linux-rt-users@vger.kernel.org; Sun, 20 Jan 2013 00:50:00 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I need to autodetect the RT kernel for an application which runs under RTAI, Xenomai, RT_PREEMPT and vanilla kernels. 

To support a unified binary, I need to runtime detect the RT OS - what are my best options for RT_PREEMPT? from https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#Checking_the_Kernel I gather the single method:

parsing 'ps' output for IRQ handlers being kthreads, i.e. for '[IRQ' or '[irq'

any chance of doing better than that, or parsing of utsname.release for "-rt"?  A false positive on a vanilla kernel could be a safety hazard.

thanks in advance,

Michael


