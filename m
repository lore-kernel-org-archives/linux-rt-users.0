From: Darren Hart <dvhart@infradead.org>
Subject: Re: Real-time kernel thread performance and optimization
Date: Wed, 02 Jan 2013 09:21:28 -0800
Message-ID: <50E46C98.7090405@infradead.org>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com> <d27143389b68c615c242b56c7cd4dd22@mail.gmail.com> <50CF9A1E.5000902@am.sony.com> <50D257BF.2060803@infradead.org> <32844ba58ef36b5032ce5aa08ca2a985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: frank.rowand@am.sony.com, linux-rt-users@vger.kernel.org,
	jkacur@redhat.com
To: Simon Falsig <simon@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19761 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab3ABRVa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jan 2013 12:21:30 -0500
In-Reply-To: <32844ba58ef36b5032ce5aa08ca2a985@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/20/2012 12:21 AM, Simon Falsig wrote:
> On 12/20/2012 01:12 AM, Darren Hart wrote:
>> On 12/17/2012 02:18 PM, Frank Rowand wrote:
>>> On 12/11/12 06:30, Simon Falsig wrote:
>>>
>>> < snip >
>>>
>>>>>> Once I get this finished up, I'll be happy to do a complete
>>>>>> write-up of the timer-thread code, if anyone is interested. I
>>>>>> remember looking for something similar (but without success), when
>>>>>> I wrote the code earlier this year.
>>>>>
>>>>> It would be very useful to add your results to the wiki.
>>>>>
>>>>> -Frank
>>>>
>>>> Cool - is there any particular place it should go? A how-to, FAQ
>>>> entry, etc? Just so I know how to do the write-up...
>>>
>>> https://rt.wiki.kernel.org/index.php/Main_Page would be my default
>>> suggestion.  I'm not quite sure where on the wiki would be good
>>> though.  Maybe under "Tips and Techniques"?
>>>
>>> I added the rtwiki maintainers to the cc: list.
>>
>> I don't have all the context, but this sounds a bit more like something
> for
>> linux/Documentation (possibly for the preempt-rt patch set). If not, the
>> Documentation section on the wiki is a possibility.
>> --
>> Darren Hart
>> Intel Open Source Technology Center
>> Yocto Project - Technical Lead - Linux Kernel
> 
> As I see it, the write-up could be done in two ways - 1) as a simple code
> example of a real-time loop in a kernel module, 2) as a blog-like post of
> the process I went through, investigating the performance, and optimizing
> my code.
> 
> In the case of 1), I guess it could be added to
> https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO, as a kernel version
> of the realtime example, or possibly to
> https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application under
> "Building Device Drivers"? In the case of 2) though, it could maybe be on
> its own page under "Tips and techniques"?

I'd leave the exploration type write-up to your blog and we can link to
it. An explicit example in one of the locations above also sounds
appropriate.

Thanks,

Darren

