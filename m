From: Simon Falsig <simon@newtec.dk>
Subject: Re: Real-time kernel thread performance and optimization
Date: Thu, 11 Jul 2013 08:32:25 +0200
Message-ID: <d65eee941637bbf73bb2f5e939230e04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: dvhart@infradead.org, frank.rowand@am.sony.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:57740 "HELO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755031Ab3GKGc0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jul 2013 02:32:26 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so6322476lba.2
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Jul 2013 23:32:24 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>On 12/20/2012 12:21 AM, Simon Falsig wrote:
>> On 12/20/2012 01:12 AM, Darren Hart wrote:
>>> On 12/17/2012 02:18 PM, Frank Rowand wrote:
>>>> On 12/11/12 06:30, Simon Falsig wrote:
>>>>
>>>> < snip >
>>>>
>>>>>>> Once I get this finished up, I'll be happy to do a complete
>>>>>>> write-up of the timer-thread code, if anyone is interested. I
>>>>>>> remember looking for something similar (but without success), when
>>>>>>> I wrote the code earlier this year.
>>>>>>
>>>>>> It would be very useful to add your results to the wiki.
>>>>>>
>>>>>> -Frank
>>>>>
>>>>> Cool - is there any particular place it should go? A how-to, FAQ
>>>>> entry, etc? Just so I know how to do the write-up...
>>>>
>>>> https://rt.wiki.kernel.org/index.php/Main_Page would be my default
>>>> suggestion.  I'm not quite sure where on the wiki would be good
>>>> though.  Maybe under "Tips and Techniques"?
>>>>
>>>> I added the rtwiki maintainers to the cc: list.
>>>
>>> I don't have all the context, but this sounds a bit more like
something
>> for
>>> linux/Documentation (possibly for the preempt-rt patch set). If not,
the
>>> Documentation section on the wiki is a possibility.
>>> --
>>> Darren Hart
>>> Intel Open Source Technology Center
>>> Yocto Project - Technical Lead - Linux Kernel
>>
>> As I see it, the write-up could be done in two ways - 1) as a simple
code
>> example of a real-time loop in a kernel module, 2) as a blog-like post
of
>> the process I went through, investigating the performance, and
optimizing
>> my code.
>>
>> In the case of 1), I guess it could be added to
>> https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO, as a kernel
version
>> of the realtime example, or possibly to
>> https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
under
>> "Building Device Drivers"? In the case of 2) though, it could maybe be
on
>> its own page under "Tips and techniques"?
>
> I'd leave the exploration type write-up to your blog and we can link to
> it. An explicit example in one of the locations above also sounds
> appropriate.
>
> Thanks,
>
> Darren

So, it's been long overdue for some time now, but I finally got around to
finishing the writeup on my own blog. If anyone is still interested, it
can be found as a 3-part story here:

http://www.falsig.org/simon/blog/2013/03/30/real-time-linux-kernel-drivers
-part-1-the-setup/
http://www.falsig.org/simon/blog/2013/07/10/real-time-linux-kernel-drivers
-part-2-testing-and-first-implementation/
http://www.falsig.org/simon/blog/2013/07/10/real-time-linux-kernel-drivers
-part-3-the-better-implementation/

Any comments are more than welcome - and feel free to adapt any of the
code examples and put them on the wiki, if that could be of any help.

Best regards,
Simon
