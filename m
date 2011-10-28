From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: Re: rt for newbie
Date: Fri, 28 Oct 2011 09:37:38 +0200
Message-ID: <4EAA5BC2.4020908@googlemail.com>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com> <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com> <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com> <4EA9D980.5080903@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sashka@mail.ru, linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab1J1Hhm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Oct 2011 03:37:42 -0400
Received: by faan17 with SMTP id n17so3390256faa.19
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Oct 2011 00:37:41 -0700 (PDT)
In-Reply-To: <4EA9D980.5080903@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

I think, your small "howto" is a little confusing. You are describing 
the kernel options needed for RT-capabilities, but there is no asterisk 
within the square brackets in order to show, that they should be 
enabled. The way it is written in your email, it seems like they should 
be disabled. Or did you really mean to disable the "Tickless System" 
option and the "Check for stack overflows" option?

Best regards,
Dennis


Am 28.10.2011 00:21, schrieb Carsten Emde:
> Sashka,
>
>> [..]
>> I've got it build several time. I'm confused with all those different
>> guides telling me what to enable and disable. Most of them are
>> outdated, as I can see.
> The usual recommendation is:
>
> 1. Get the config of your distro
> # cd /usr/src/kernels/linux-3.0.7-rt20
> # cp /boot/config-`uname -r` .config
>
> 2. Configure the kernel for RT
> # make menuconfig
> Processor type and features  --->
>       [ ] Tickless System (Dynamic Ticks)
>       Preemption Model (Fully Preemptible Kernel (RT))  --->
> Kernel hacking  --->
>       [ ] Check for stack overflows
>
> To check out the new kernel for its RT capabilities:
> # cd /usr/src
> # git clone https://github.com/clrkwllms/rt-tests
> # cd rt-tests
> # make rpm
> # rpm -ivh RPMS/*/rt-tests*.rpm
> # cyclictest -m -Sp99 -i100 -d0
>
> Let us know what worst-case latency you got.
>
>     -Carsten.
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

