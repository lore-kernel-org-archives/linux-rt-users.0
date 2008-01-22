From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: AW: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
Date: Tue, 22 Jan 2008 05:57:18 -0700
Message-ID: <4795A1DE.BA47.005A.0@novell.com>
References: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET>
 <20080122115436.GC8660@linux.vnet.ibm.com>
 <7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "Lampersperger Andreas" <lampersperger.andreas@heidenhain.de>,
	"Chirag Jog" <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:46565 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYAVNXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2008 08:23:45 -0500
In-Reply-To: <7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Tue, Jan 22, 2008 at  7:14 AM, in message
<7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET>,
"Lampersperger Andreas" <lampersperger.andreas@heidenhain.de> wrote: 
> No, there is no BIOS option which indicates HPET support. But the
> BIOS on my system is IMHO very very bad. It knows nothing about the
> features on the board. Is ist crucial to have here BIOS support? Or
> can these features be enabled by e.g. boot parameters?

I had a similar problem once.  It turned out that "nmi_watchdog=1" in the kernel-args disables HPET such that you will see that warning from cyclictest.  Not sure if you have a similar setup, but perhaps this info will help.

-Greg  
