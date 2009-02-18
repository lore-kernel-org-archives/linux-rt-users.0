From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: 2.6.26.8-rt16 powerpc and mem=...
Date: Wed, 18 Feb 2009 17:13:43 +0100
Message-ID: <gnhc3n$1jo$1@ger.gmane.org>
References: <gnet5c$7k2$1@ger.gmane.org> <gngsin$50r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:42732 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbZBRQOF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2009 11:14:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZp3c-0000JB-5n
	for linux-rt-users@vger.kernel.org; Wed, 18 Feb 2009 16:13:56 +0000
Received: from fw-emea.rohde-schwarz.com ([80.246.32.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 16:13:56 +0000
Received: from euphoria by fw-emea.rohde-schwarz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 16:13:56 +0000
In-Reply-To: <gngsin$50r$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi again,

I adapted the kernel to allow a four-level CAM mapping.
If the memory is reduced to 448M (i.e. result is CAM0=256Mb, CAM1=64Mb, 
CAM2=64Mb CAM3=64Mb residual: 0Mb) there will be no highmem assigned by 
the kernel at all.

In that case the U-Boot boot loader is set to initrd_high=0x1C000000, 
i.e. it will put the initrd right at the "upper end" of available memory.

linux-rt doesn't fail to mount the initrd.

I tend to believe that the issue is related to the use of highmem in 
linux-rt (OK, pretty vague:).

    Florian

