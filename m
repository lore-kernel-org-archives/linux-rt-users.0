From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Real time micro benchmark suite - thread priority fix
Date: Mon, 21 May 2012 08:36:22 -0700
Message-ID: <4FBA60F6.7090008@us.ibm.com>
References: <4FB56A88.7050705@caviumnetworks.com> <CAONaPpFi8M7tutcvyMaTeCk5gYk2UjVBKJkorssAKYSEAzJYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Venkat Subbiah <vsubbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:49923 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2EUPga (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2012 11:36:30 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <niv@us.ibm.com>;
	Mon, 21 May 2012 16:36:29 +0100
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q4LFaPp52261068
	for <linux-rt-users@vger.kernel.org>; Mon, 21 May 2012 16:36:26 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q4LFaOTh028228
	for <linux-rt-users@vger.kernel.org>; Mon, 21 May 2012 09:36:24 -0600
In-Reply-To: <CAONaPpFi8M7tutcvyMaTeCk5gYk2UjVBKJkorssAKYSEAzJYPw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/18/2012 05:54 AM, John Kacur wrote:
> On Thu, May 17, 2012 at 11:15 PM, Venkat Subbiah
> <vsubbiah@caviumnetworks.com>  wrote:
>> Not sure whether Real time micro benchmark suite is still being maintained
>> at http://sourceforge.net/projects/rtmicrobench. The latest code from
>> sourceforge has issues while running rtmb_c tests. It fails complaining
>> about not being able to set thread priority.  Here's a fix for it.
>>
>> https://github.com/vsubbiah/rtmb/commit/2a6714030a4009b50b76e99a83bf4b042cc82780
>>
>> Thanks,
>> Venkat
>
> Are you on some kind of a quest to seek out obscure benchmarks? You
> need to track down Mike Fulton and ask him if he is maintaining it,
> no-one here is.

I'm pretty sure Mike Fulton isn't maintaining it, but I'll ask around to 
see if anyone else is.

thanks,
Nivedita


