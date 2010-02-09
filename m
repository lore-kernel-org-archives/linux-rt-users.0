From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: Converting a device driver for real time kernel
Date: Tue, 09 Feb 2010 01:50:22 -0800
Message-ID: <1265709022.9686.14.camel@quadrophenia.thebigcorporation.com>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	SLE-RT Development <slert-devel@suse.de>
To: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:38317 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753868Ab0BIKKd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2010 05:10:33 -0500
In-Reply-To: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-02-09 at 09:32 +0000, Leggo, Adam (UK) wrote:
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

Hi Adam,

Generally this list is focused on the mainline RT patch set, and not so
much on distro Kernels. 

I might be wrong, but out-of-tree drivers probably won't get too much
TLC here either.

That being said, your version of the SLERT Kernel is quite old.

I would suggest the following:

1. first update your system and reproduce the issue
2. file a bug and attach the driver source here:
http://bugzilla.novell.com
3. Report any specific error you could capture on a serial / net
console, and provide additional details for "locks up and crashes".

Thanks,

Sven


> Any assistance would be useful.
> 
> Regards,
> Adam Leggo 
>  
> 
> ********************************************************************
> This email and any attachments are confidential to the intended
> recipient and may also be privileged. If you are not the intended
> recipient please delete it from your system and notify the sender.
> You should not copy it or use it for any purpose nor disclose or
> distribute its contents to any other person.
> ********************************************************************
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


