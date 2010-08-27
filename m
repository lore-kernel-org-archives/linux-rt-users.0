From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: perf and oprofile causing kernel oops on 2.6.33.7-rt29 kernel
Date: Fri, 27 Aug 2010 11:15:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1008271114450.2768@localhost.localdomain>
References: <8EA2C2C4116BF44AB370468FBF85A777017965B296@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Sydir, Jerry" <jerry.sydir@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38813 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0H0JQE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 05:16:04 -0400
In-Reply-To: <8EA2C2C4116BF44AB370468FBF85A777017965B296@orsmsx504.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 18 Aug 2010, Sydir, Jerry wrote:

> Hello,
> 
> I am having trouble running profiling tools on the 2.6.33.7 kernel
> with the rt29 patch. I am running on an Intel Core 2 machine. When I
> run perf record I get a kernel oops. Here is the relevant log info:
>
> BUG: sleeping function called from invalid context at arch/x86/mm/highmem_32.c:9

Grrr, I really hate highmem. What happens if you disable
CONFIG_HIGHMEM or just run a 64 bit kernel on that machine ?

Thanks,

	tglx
