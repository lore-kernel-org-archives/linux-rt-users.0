From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: 3.0.4-rt14 "shutdown -h now" hangs on x86 32b
Date: Tue, 04 Oct 2011 15:46:50 -0700
Message-ID: <4E8B8CDA.6060105@linux.intel.com>
References: <4E89FBDE.7080406@linux.intel.com>  <4E8ABB4B.6000204@iis.fraunhofer.de> <1317720489.6260.9.camel@marge.simson.net> <alpine.LFD.2.02.1110042319060.18778@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <efault@gmx.de>,
	Simon Sudler <Simon.Sudler@iis.fraunhofer.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65507 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933158Ab1JDWqv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 18:46:51 -0400
In-Reply-To: <alpine.LFD.2.02.1110042319060.18778@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 10/04/2011 02:20 PM, Thomas Gleixner wrote:
> On Tue, 4 Oct 2011, Mike Galbraith wrote:
> 
>> On Tue, 2011-10-04 at 09:52 +0200, Simon Sudler wrote: 
>>> Hi Darren,
>>>
>>> i had the same problem on a Z530 with all RT kernels 3.0. I didn't 
>>> search for the reason, however the problem went away when i used the 
>>> "Intel Atom" at the "Processor family" option.
>>
>> I see something similar at least on my Q6600 and E5620 boxen.
> 
> That should be solved by a CPU hotplug fix in rt16. Could you please
> verify?

Confirmed, fixed.

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
