From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: simulate load with cycletest
Date: Thu, 2 Feb 2017 22:38:26 +0200
Message-ID: <CAJ2oMh+wW=BNz5Aw-Ha60J5htwjTu+=R67mCO53Q3fhW52iJAA@mail.gmail.com>
References: <CAJ2oMhKQkSsNqsmmJnnQ=JO9Haqoo4y10cg6JDFwAWVjt=YxnA@mail.gmail.com>
 <20170202145347.GT5599@jcartwri.amer.corp.natinst.com> <CAJ2oMhJJ+6u2azXh4OBHpLu2orfsOmZ412vbOChe9NVNwSW08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38801 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdBBUi2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2017 15:38:28 -0500
Received: by mail-wm0-f54.google.com with SMTP id r141so4901411wmg.1
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Feb 2017 12:38:28 -0800 (PST)
In-Reply-To: <CAJ2oMhJJ+6u2azXh4OBHpLu2orfsOmZ412vbOChe9NVNwSW08A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 2, 2017 at 6:48 PM, Ran Shalit <ranshalit@gmail.com> wrote:
> On Thu, Feb 2, 2017 at 4:53 PM, Julia Cartwright <julia@ni.com> wrote:
>> On Thu, Feb 02, 2017 at 07:53:55AM +0200, Ran Shalit wrote:
>>> Hello,
>>
>> Hello Ran-
>>
>>> I have followed instruction for using cycletest in:
>>> https://rt.wiki.kernel.org/index.php/Cyclictest
>>>
>>> It described command lines for different scenarios.
>>> usually one with load and the next without load.
>>> Yet, I see no difference between the load 100% and no-load commands.
>>>
>>> How can you simulate load with cycletest ?
>>
>> cyclictest itself doesn't do any loading, it's common to run it with
>> some other processes in the background which generate a simulated load.
>>
>> Keep in mind that the using a utility like the ones I've listed below is
>> only _simulating_ what a load _might_ be like in a real application.
>> The best thing to do is to actually test your application.
>>
>>    - hackbench - scheduling load (nice because it's part of rt-tests)
>>    - stress - load-generating swiss-army knife
>>    - xfstests - disk / filesystem load
>>    - 'make -j' in a kernel source tree
>>    - iperf - network load
>>    - glxgears - gfx load
>>

Hi,

If I may please ask one more on this subject:

I have made several tests today with cyclictest, and I noticed that
even if I just click the shell or open another shell it results
immediately in a larger max value, especially in non-rt linux.

So, it seems that even if I won't simulate 100% load I will get very
easily to the max value if I do some actions in the environment, Right
?

But the more important question is:
Is it important if the cpu is 100% or 50%, (or even less) , i.e.
should I expect to get the same  (probably)  max value in both cases
?

Best Regards,
Ran

>> (those are the ones that come to mind, there are others I'm forgetting)
>>
>>   Julia
>
> Hi Julia , Joakim , Kannan,
>
> Thank you very much for answering my question !
>
> Regards,
> Ran
