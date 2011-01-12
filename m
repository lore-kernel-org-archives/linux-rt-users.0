From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: RT patch for 2.6.34?
Date: Tue, 11 Jan 2011 17:33:41 -0800
Message-ID: <4D2D04F5.40200@linux.intel.com>
References: <8988_1294150773_4D232C75_8988_10048783_1_4D232C74.1080309@sopragroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Philippe Midol-Monnet <pmidolmonnet@sopragroup.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62303 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab1ALBdn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Jan 2011 20:33:43 -0500
In-Reply-To: <8988_1294150773_4D232C75_8988_10048783_1_4D232C74.1080309@sopragroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/04/2011 06:19 AM, Philippe Midol-Monnet wrote:
> Hello
>
> I have to use kernel 2.6.34-6 (for PPC) and I need the RT patch. Do you
> know if there is an easy way to apply the RT patch to this kernel version?

There is a version floating around, but it hasn't received the stamp of 
approval from tglx, mingo, or rostedt. A review is pending, and others 
are working to polish it up.

I'm working on integrating this into the Yocto Project. I'll post here 
when that is all available.


-- 
Darren Hart
Yocto Linux Kernel
