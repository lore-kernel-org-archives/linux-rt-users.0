From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: uio_pci_generic not working ?
Date: Thu, 11 Feb 2010 09:20:23 +0100
Message-ID: <4B73BDC7.209@steinhoff.de>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET> <alpine.LFD.2.00.1002092317420.2811@localhost.localdomain> <4B72AF32.7000103@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64908 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0BKITK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2010 03:19:10 -0500
In-Reply-To: <4B72AF32.7000103@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

problem solved ... the board specific module is working.  uio_pci _ 
generic is sorted out ...

Regards

--Armin

Armin Steinhoff wrote:
>
> Hello,
>
> I'm using the module uio_pci_generic of the kernel 2.6.32 together 
> with uio of kernel 2.6.22 (openSUSE 10.3).  I hope this is OK ... ?
>
> After insmod uio.ko and insmod uio_pci_generic.ko I don't see the 
> device   /dev/uio0 ... also /sys/class doesn't have any related entries.
>
> What's the proper usage of uio_pci_generic ?
>
> Best Regards
>
> --Armin
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

