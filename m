From: Armin Steinhoff <armin@steinhoff.de>
Subject: uio_pci_generic not working ?
Date: Wed, 10 Feb 2010 14:05:54 +0100
Message-ID: <4B72AF32.7000103@steinhoff.de>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET> <alpine.LFD.2.00.1002092317420.2811@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65337 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0BJNEq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Feb 2010 08:04:46 -0500
In-Reply-To: <alpine.LFD.2.00.1002092317420.2811@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello,

I'm using the module uio_pci_generic of the kernel 2.6.32 together with 
uio of kernel 2.6.22 (openSUSE 10.3).  I hope this is OK ... ?

After insmod uio.ko and insmod uio_pci_generic.ko I don't see the device 
   /dev/uio0 ... also /sys/class doesn't have any related entries.

What's the proper usage of uio_pci_generic ?

Best Regards

--Armin
