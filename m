From: Vivek Ayer <vivek.ayer@gmail.com>
Subject: Re: Run RTLinux in a VM?
Date: Tue, 3 Aug 2010 09:47:35 -0700
Message-ID: <AANLkTimVh6LQJYv9F12Sa42wN90v6wQubG_J-r4FzsmT@mail.gmail.com>
References: <AANLkTinOFkUU1DdyWdL+YhPCiYhfEA=+zV9fpLsq-J2_@mail.gmail.com>
	<20100803152230.GA9224@opentech.at>
	<AANLkTimkBkt42rDJagHyg-jLyz4HjAnpxCLXxROWN=Fz@mail.gmail.com>
	<20100803162759.GA19493@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53336 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147Ab0HCQrg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Aug 2010 12:47:36 -0400
Received: by qyk7 with SMTP id 7so310663qyk.19
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Aug 2010 09:47:35 -0700 (PDT)
In-Reply-To: <20100803162759.GA19493@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

So you recommend I try a Linux 2.4 kernel instead? I wanted to see if
qemu could run 2.6, but if you recommend against that, then I'll try
2.4.

Can you attach your qemu config so I can try to clone you setup?

Thanks,
Vivek

On Tue, Aug 3, 2010 at 9:27 AM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Tue, 03 Aug 2010, Vivek Ayer wrote:
>
>> Hi all,
>>
>> Thanks for the quick responses. I'm not so concerned about the ill
>> effects of rt performance right this moment. I will probably get a
>> physical machine for it in two months or so. The main reason now is to
>> just get quick started on rt programming per say. My host machine is a
>> client written in PyQt that will be interfacing with RTLinux machine
>> and I just wanted to test a couple of things before I invested in a
>> rig for the RTLinux machine. I just want something that runs the RT
>> kernel for now.
>>
>> The last time I tried with KVM, the rt kernel would panic on me while
>> loading some modules I suspect. So, if I'm going to use QEMU (No KVM),
>> running on a i386 host, running a i386 RTLinux guest, would I need to
>> apply any special patches to make sure the panic didn't occur.
>>
>> See this thread for it hanging up in VMWare:
>> http://osdir.com/ml/linux.real-time.rtlinux.general/2004-11/msg00076.html
>>
>> Apparently the rtl_time module causes the panic. Has this been taken
>> care of in the latest kernel?
>>
> no this should not be necessary we have been running the 2.4.X RTLinux kernels
> on qemu for analysis purposes, as well as runing XtratuM (2.6.17,2.6.33) on
> qemu for debugging also - and functionally it seems to be ok - with timers
> set in the range of a few 10s of milliseconds it actually seems to run
> rt-tasks quite reliably at the functional level. RTLinux should not show
> any difference in behavior other than timing. If you use the rtl tracer you
> could see some strange results.
>
> hofrat
>
