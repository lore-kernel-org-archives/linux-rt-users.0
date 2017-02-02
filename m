From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: simulate load with cycletest
Date: Thu, 2 Feb 2017 18:48:41 +0200
Message-ID: <CAJ2oMhJJ+6u2azXh4OBHpLu2orfsOmZ412vbOChe9NVNwSW08A@mail.gmail.com>
References: <CAJ2oMhKQkSsNqsmmJnnQ=JO9Haqoo4y10cg6JDFwAWVjt=YxnA@mail.gmail.com>
 <20170202145347.GT5599@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37022 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdBBQsn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2017 11:48:43 -0500
Received: by mail-wm0-f42.google.com with SMTP id v77so95919827wmv.0
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Feb 2017 08:48:43 -0800 (PST)
In-Reply-To: <20170202145347.GT5599@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 2, 2017 at 4:53 PM, Julia Cartwright <julia@ni.com> wrote:
> On Thu, Feb 02, 2017 at 07:53:55AM +0200, Ran Shalit wrote:
>> Hello,
>
> Hello Ran-
>
>> I have followed instruction for using cycletest in:
>> https://rt.wiki.kernel.org/index.php/Cyclictest
>>
>> It described command lines for different scenarios.
>> usually one with load and the next without load.
>> Yet, I see no difference between the load 100% and no-load commands.
>>
>> How can you simulate load with cycletest ?
>
> cyclictest itself doesn't do any loading, it's common to run it with
> some other processes in the background which generate a simulated load.
>
> Keep in mind that the using a utility like the ones I've listed below is
> only _simulating_ what a load _might_ be like in a real application.
> The best thing to do is to actually test your application.
>
>    - hackbench - scheduling load (nice because it's part of rt-tests)
>    - stress - load-generating swiss-army knife
>    - xfstests - disk / filesystem load
>    - 'make -j' in a kernel source tree
>    - iperf - network load
>    - glxgears - gfx load
>
> (those are the ones that come to mind, there are others I'm forgetting)
>
>   Julia

Hi Julia , Joakim , Kannan,

Thank you very much for answering my question !

Regards,
Ran
