From: "Sydir, Jerry" <jerry.sydir@intel.com>
Subject: RE: perf and oprofile causing kernel oops on 2.6.33.7-rt29 kernel
Date: Fri, 27 Aug 2010 14:42:59 -0700
Message-ID: <8EA2C2C4116BF44AB370468FBF85A7770179C68163@orsmsx504.amr.corp.intel.com>
References: <8EA2C2C4116BF44AB370468FBF85A777017965B296@orsmsx504.amr.corp.intel.com>
 <alpine.LFD.2.00.1008271114450.2768@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60808 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab0H0VnP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 17:43:15 -0400
In-Reply-To: <alpine.LFD.2.00.1008271114450.2768@localhost.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>-----Original Message-----
>From: Thomas Gleixner [mailto:tglx@linutronix.de]
>Sent: Friday, August 27, 2010 2:16 AM
>To: Sydir, Jerry
>Cc: linux-rt-users@vger.kernel.org
>Subject: Re: perf and oprofile causing kernel oops on 2.6.33.7-rt29 kernel
>
>On Wed, 18 Aug 2010, Sydir, Jerry wrote:
>
>> Hello,
>>
>> I am having trouble running profiling tools on the 2.6.33.7 kernel
>> with the rt29 patch. I am running on an Intel Core 2 machine. When I
>> run perf record I get a kernel oops. Here is the relevant log info:
>>
>> BUG: sleeping function called from invalid context at
>arch/x86/mm/highmem_32.c:9
>
>Grrr, I really hate highmem. What happens if you disable
>CONFIG_HIGHMEM or just run a 64 bit kernel on that machine ?
>
>Thanks,
>
>	tglx

I tried disabling CONFIG_HIGHMEM and that worked. (The patch that Jan suggested also worked).

Thanks for your help.
Jerry
