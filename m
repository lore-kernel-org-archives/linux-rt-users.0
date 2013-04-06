From: "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: malloc/free and priority inheritance?
Date: Sat, 06 Apr 2013 10:27:28 -0400
Message-ID: <516030D0.7070102@redhat.com>
References: <515B647C.3080505@meduna.org> <515D7943.5000401@meduna.org> <515D808C.8090808@meduna.org> <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com> <515D97B8.5030101@meduna.org> <CAAHN_R0oHL+oWxs_0SBwi4dRWM9HDrFM0Y7ZDLZQGNHnnxYzHQ@mail.gmail.com> <515F0C64.20609@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>,
	Stanislav Meduna <stano@meduna.org>,
	libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31944 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758199Ab3DFO1q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 6 Apr 2013 10:27:46 -0400
In-Reply-To: <515F0C64.20609@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/05/2013 01:39 PM, Darren Hart wrote:
> On 04/04/2013 08:39 AM, Siddhesh Poyarekar wrote:
>> On 4 April 2013 20:39, Stanislav Meduna <stano@meduna.org> wrote:
>>> The first thing e.g. the __pthread_cond_broadcast (and most of the
>>> other functions as well) does is to grab lll_lock. Is the following
>>> scenario possible?
>>
>> Yes this is possible.  I think there is a bug report that describes
>> this.  We need to convert the pthread_cond_t internal lock into a PI
>> one if the mutex guarding it is PI.  It's probably tricky to do
>> though; I haven't thought it through.
> 
> I have patches out on the glibc alpha list that do this. It is on my
> plate to dust these off, reapply and test them, and try to push them
> again, I just haven't been able to get to it.
> 
> Patches and test cases available here:
> http://sourceware.org/bugzilla/show_bug.cgi?id=11588

Darren,

Thanks, and I assume you have copyright assignment through Intel
which is great.

As a community I think we're in a better place to review and
accept these kinds of patches.

Thanks for sticking around for 3 years to make sure these changes
get into glibc :-)

Cheers,
Carlos.
 

