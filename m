From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: 2.6.26.8-rt16 powerpc and mem=...
Date: Wed, 18 Feb 2009 12:48:39 +0100
Message-ID: <gngsin$50r$1@ger.gmane.org>
References: <gnet5c$7k2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35990 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbZBRLs4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2009 06:48:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZkv7-00065S-8C
	for linux-rt-users@vger.kernel.org; Wed, 18 Feb 2009 11:48:53 +0000
Received: from fw-emea.rohde-schwarz.com ([80.246.32.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 11:48:53 +0000
Received: from euphoria by fw-emea.rohde-schwarz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 11:48:53 +0000
In-Reply-To: <gnet5c$7k2$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I did some further tests in the meanwhile.
If the memory is reduced to 256M with mem=256M Linux does not make use 
of highmem, since memory can be completely mapped using a single CAM entry.
(Kernel output: Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb 
residual: 0Mb)

In that case the initrd is successfully mounted at all times up to now.

When I was starting to play with mem=... on vanilla kernels I was told 
[1] that it should be trivial to allow more than three levels of CAM 
mappings. May be this is an intermediate solution.

   Florian

[1] http://ozlabs.org/pipermail/linuxppc-embedded/2008-June/030638.html

