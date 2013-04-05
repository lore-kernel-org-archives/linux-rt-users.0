From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: malloc/free and priority inheritance?
Date: Fri, 05 Apr 2013 10:39:48 -0700
Message-ID: <515F0C64.20609@linux.intel.com>
References: <515B647C.3080505@meduna.org> <515D7943.5000401@meduna.org> <515D808C.8090808@meduna.org> <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com> <515D97B8.5030101@meduna.org> <CAAHN_R0oHL+oWxs_0SBwi4dRWM9HDrFM0Y7ZDLZQGNHnnxYzHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stanislav Meduna <stano@meduna.org>,
	libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7308 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162184Ab3DERj7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Apr 2013 13:39:59 -0400
In-Reply-To: <CAAHN_R0oHL+oWxs_0SBwi4dRWM9HDrFM0Y7ZDLZQGNHnnxYzHQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 04/04/2013 08:39 AM, Siddhesh Poyarekar wrote:
> On 4 April 2013 20:39, Stanislav Meduna <stano@meduna.org> wrote:
>> The first thing e.g. the __pthread_cond_broadcast (and most of the
>> other functions as well) does is to grab lll_lock. Is the following
>> scenario possible?
> 
> Yes this is possible.  I think there is a bug report that describes
> this.  We need to convert the pthread_cond_t internal lock into a PI
> one if the mutex guarding it is PI.  It's probably tricky to do
> though; I haven't thought it through.

I have patches out on the glibc alpha list that do this. It is on my
plate to dust these off, reapply and test them, and try to push them
again, I just haven't been able to get to it.

Patches and test cases available here:
http://sourceware.org/bugzilla/show_bug.cgi?id=11588

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
