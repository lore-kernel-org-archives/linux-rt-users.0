From: Neel Mehta <neelmehta89@gmail.com>
Subject: Re: Realtime linux kernel on multicore processor
Date: Wed, 23 Jun 2010 10:22:29 +0200
Message-ID: <AANLkTilzoBIjBM4sd4hjTcQhCmW4OUZpAD-oHqos7RPK@mail.gmail.com>
References: <AANLkTilTcAaRj49CiPgWmPkhWkDkz1CR5sHZygsHRyNA@mail.gmail.com>
	<4C1A82AC.1000804@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61664 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0FWIWu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jun 2010 04:22:50 -0400
Received: by iwn5 with SMTP id 5so484001iwn.19
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jun 2010 01:22:49 -0700 (PDT)
In-Reply-To: <4C1A82AC.1000804@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Since, Ubuntu is being run on the kernel, the standard processes of
Ubuntu are running in the background.

Now, I was just checking out RT_PREEMPT yesterday, and I came across
the kernel 2.6.31-9-rt (It is an RT_PREEMPT kernel) in the ubuntu
repositories (for ubuntu 9.10). I installed the kernel, and booted
into ubuntu using this kernel. Now, I see the results as I had
expected - 2 out of the 4 cores running on full load. What could be
the problem in my configuration as I am unable to see the same results
with the kernel that I configured?

Thanks and Regards,
Neel Mehta
Third year Undergraduate student,
Electrical Engineering,
IIT Bombay


On Thu, Jun 17, 2010 at 10:16 PM, Nivedita Singhvi <niv@us.ibm.com> wrote:
>
> Neel Mehta wrote:
>>
>> Hi. I have 2 computers with ubuntu:
>> 1. Core 2 Duo - Non realtime linux kernel
>> 2. Quad core - Realtime linux kernel
>>
>> Both of them are using ubuntu. I am running a process that generates 2
>> threads, both of which are continuously processing something.
>> 1. On core 2 duo (normal kernel): both the cores are running above 90% load.
>> 2. on quad core(realtime kernel): only one core runs above 90%, and
>> the other cores are not at such a high load. The core which is on high
>> load keeps on alternating among the 4 cores.
>>
>> So, my question is why doesnt 2 cores run on high load on quad core?
>> Is there a problem in multiprocessing in realtime linux kernel? Can
>> someone guide me where the source of problem could be?
>
> I'll start with the obvious - if the same amount of work is
> being done, but now on a larger number of cores, the load on
> each individual core could reduce (since you don't say what
> else is contributing to the load on the system, etc).
>
> As an example of this class of behavior, look at your irq distribution.
> The rotation of the load sounds a lot like it's being driven by
> interrupt round-robining, for instance.
>
> thanks,
> Nivedita
