From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: Real time micro benchmark suite - thread priority fix
Date: Sun, 20 May 2012 20:36:33 -0700
Message-ID: <4FB9B841.7020409@caviumnetworks.com>
References: <4FB56A88.7050705@caviumnetworks.com> <CAONaPpFi8M7tutcvyMaTeCk5gYk2UjVBKJkorssAKYSEAzJYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Subbiah, Venkat" <Venkat.Subbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6698 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2EUDht (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 May 2012 23:37:49 -0400
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
> Are you on some kind of a quest to seek out obscure benchmarks? You
> need to track down Mike Fulton and ask him if he is maintaining it,
> no-one here is.
I got a list of benchmarks of the RT wiki and have been trying to 
exercise them. After looking into I do see that some of them are 
obscure. In the process ran into this and the fix I sent to
the maintainers bounced back, so wanted to send the fix out through
this forum.
Thanks,
Venkat
> Thanks
>
> John Kacur
>

