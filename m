From: Lukasz Majewski <majess1982@gmail.com>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Mon, 23 Feb 2009 00:01:04 +0100
Message-ID: <49A1D930.4010600@gmail.com>
References: <49A1BA49.7060308@gmail.com> <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:37371 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbZBVXBI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Feb 2009 18:01:08 -0500
Received: by bwz5 with SMTP id 5so4253985bwz.13
        for <linux-rt-users@vger.kernel.org>; Sun, 22 Feb 2009 15:01:06 -0800 (PST)
In-Reply-To: <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Thank you for this extremely fast response. :-)

I haven't try to run my application from RAM disk (as suppose you 
suggest building initramrd or initramfs). It's inconvenient, for 
development, since size of such init ram disk is limited. I will try it 
anyway.

Now some explanation about uClibc. I know that this C library lacks of 
many features (for instance NTPL support for ARM). Unfortunately, for 
ARM architecture, there is nice utility -> buildroot  for building 
toolchain and  root filesystems. I'm not using x86 as target 
architecture, so cross compiling toolchain without errors is success as 
it is :-).

I've tried pxtdist tool from pengutronix.de , but I cannot build proper 
toolchain without errors for my Atmel's ARM9 device (ARMv5tej arch to be 
precise). Or saying it in another way -> I gave up after spending some 
time and moved back toward working uClibc. I've build some toolchains, 
but during build I've encountered some errors and despite of that it, 
built arm-linux-gcc which worked, I wasn't sure if glibc is not cracked 
in some way.

On my first post I haven't mention that I was checking rusage struct for 
minor and major page faults.
In my program I checked it twice: first before calling mlockall() - on 
the beginning of the program and after munlockall() when program ends 
either when delay occurs or in normal termination. In both cases I've 
got the same number of minor and major page faults. So it looks that no 
page fault appears.


I've checked, and it turns out that uClibc 0.9.30 is not supporting PI 
(priority inversion) and futexes. This may cause my bug ,since I'm 
heavily using read/write on /dev/ files (read/write to 4 differen 
files). There's a lot of space for priority inversion in my code :-/. I 
was writing this code with holly faith that "in some way" priority 
inversion is avoided. I assumed, that access to some device (resource in 
this case) has some mechanism to inheritance the priority.

Is looks,that the only solution for me is to build toolchain with glibc 
at least 2.6 and gcc 4.+ with full support of Priority Inheritance, 
futexses and "clock_" set of functions.  As I mentioned it's a bit 
tricky for ARM (especialy with proper ABI and software floating point 
support (msoft-float)). But it looks as the only feasible solution.

Thanks for advice.

Regards,
Lukasz



Remy Bohmer wrote:
> Hello Lukasz,
>
>   
>> I'm also using NFS to mount root file system from my host x86 ubuntu PC.
>>     
>
> Have you tried already running from a ram-disk?
>
>   
>> When I start my application it runs for some time and ends as expected. It
>> seems that everything is OK. Static schedule is not violated. Unfortunately,
>> after running this application for couple of times (6 to 10) I can see that
>> static schedule is violated(delayed in execution) for about 2-4 seconds.
>> Application is running for 1-2 seconds as expected and then crashes(I mean
>> exits with static schedule delay of 2-4 seconds). It looks like page fault,
>>     
>
> You can trace the number of page-faults during run, by means of
> getrusage(), see rt-wiki.
> 2-4 seconds sounds quite long for page fault handling to me (unless
> you are using page/swap files)
>
>   
>> but in my main() I've add mlockall() as writen in the examples from rt.wiki.
>> Moreover I've prevent stack as written  in "square_wave example". Before my
>> application exits I'm calling munlockall(). When I log via ssh to my
>> embedded system and start top,I cannot see that I've got some memory leaks
>> or zombi processes during run of my RT application.
>>
>> May it be possible that by some chance some global variable is not locked in
>> the memory? What is the "scope" of mlockall? Is it only valid in one .o
>>     
>
> mlockall() is somewhat tricky. It locks all allocated data pages (and
> future pages, if specified) in to RAM, but IIRC code segments are not
> forced to be loaded into RAM, but only code segments that are loaded
> once, will be locked. So, in theory, there could be pages still on the
> NFS share that are not loaded when the problem arises. So, this could
> be the problem you see, but it would not be the first suspect I would
> look for.
>
>   
>> I'd appreciate any hints/comments what can cause this bug.
>>     
>
> I read you use uClibc, the last time I looked at it (quite some time
> ago), it lacked support for priority inheritance mutexes... Aren't you
> running in a mutex priority inversion?
>
> Or priority inversion related to other interrupt threads? You run at
> prio 71, if you leave the network, or block device
> softirqs/irq-threads on 50, you could have a priority inversion on
> this level as well. This would be my prime suspect...
>
>   
>> I was trying to
>> use strace and gdb to fix this problem, but this tools are to slow and they
>> cause violation of my cyclic static schedule.
>>     
>
> No ETM trace available? Really nice to have in such cases...
>
>
> Kind Regards,
>
> Remy
>
>   

