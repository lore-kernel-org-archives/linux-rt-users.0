From: PRINGLE Chris <chris.pringle@miranda.com>
Subject: RE: PowerPC, Full Preemption and HIGHMEM
Date: Thu, 9 Aug 2012 09:11:58 +0000
Message-ID: <E7D6489E57008E4088E37F78D30C62E611C741@LB-OPS-EXCH01.miranda.com>
References: <E7D6489E57008E4088E37F78D30C62E60EAE91@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60F0CFF@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E61013F3@LB-OPS-EXCH01.miranda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from stanmail.omnibus.co.uk ([194.201.223.253]:26775 "EHLO
	exch-lb.miranda.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751270Ab2HIJMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2012 05:12:03 -0400
In-Reply-To: <E7D6489E57008E4088E37F78D30C62E61013F3@LB-OPS-EXCH01.miranda.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 
> > >
> > > HIGHMEM support with full preemption has been disabled for quite
> > > some time on PowerPC; does anyone have any ideas as to what needs to
> > > be done to get it working again?
> > >
> >
> > Anyone got any ideas?
> 
> I've been looking into adjusting the LOWMEM size to provide a 2G/2G split so
> I can access at least ~2GB of memory; I've got something half working but I'm
> now having issues with hardware access on PCIe which leads me to believe
> there is a mapping issue somewhere.
> 
> I've adjusted PAGE_OFFSET to 0x80000000, KERNEL_START to 0x80000000,
> LOWMEM_SIZE to 0x70000000, LOWMEM_CAM_NUM to 7 and TASK_SIZE to
> 0x80000000. Linux boots and reports that it has ~1750MB RAM (as expected
> with the specified LOWMEM_SIZE) but these changes seem to cause issues
> with hardware access - no calls fail, but reads from registers on PCIe devices
> aren't giving correct values.
> 
> Has anyone tried adjusting the LOWMEM size on PowerPC before? Are there
> any other gotchas I should be looking at?


Sorry to post again, but we're not making any progress with this. Is anyone with experience with PowerPC memory management able to help here? Either to advise on how we can get 2GB of lowmem working reliably, or how we can get HIGHMEM support working with the RT patches.

Thanks again.
Chris
