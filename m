From: Vivek Ayer <vivek.ayer@gmail.com>
Subject: Re: Run RTLinux in a VM?
Date: Thu, 5 Aug 2010 10:12:28 -0700
Message-ID: <AANLkTin3JZ_r1oqUU9=px-VTqq5oTBB-HJny6M5twize@mail.gmail.com>
References: <AANLkTinOFkUU1DdyWdL+YhPCiYhfEA=+zV9fpLsq-J2_@mail.gmail.com>
	<20100803152230.GA9224@opentech.at>
	<AANLkTimkBkt42rDJagHyg-jLyz4HjAnpxCLXxROWN=Fz@mail.gmail.com>
	<20100803162759.GA19493@opentech.at>
	<AANLkTimVh6LQJYv9F12Sa42wN90v6wQubG_J-r4FzsmT@mail.gmail.com>
	<20100803171651.GA20357@opentech.at>
	<AANLkTimxqokyOyW6uNiJTj61sQTfHwQTTysOvABOtQ90@mail.gmail.com>
	<20100805150304.GA5787@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34176 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab0HERMa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Aug 2010 13:12:30 -0400
Received: by wyb39 with SMTP id 39so6862630wyb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Aug 2010 10:12:29 -0700 (PDT)
In-Reply-To: <20100805150304.GA5787@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Great. Will let you know if it works out in a couple of hours.

Thanks again,
Vivek

On Thu, Aug 5, 2010 at 8:03 AM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Tue, 03 Aug 2010, Vivek Ayer wrote:
>
>> Great! I appreciate it.
>>
>
> HI !
>
> took a bit longer - had to check up on a few things.
>
> qemu+gdb notes:
>
> host machine infomation:
> operation syetem: gentoo 64bits
> kernel version: 2.6.34-gentoo-r1
> cpu : amd64 x2
> qemu version: 0.11.1
>
> virtual machine infomation:
> config file: linux kernel 2.6.33.2 (attached)
> operation system in qemu: debian 5.0.3 32bits
> using net bridge and tap for network, network device is set to rtl8139
>
> qemu start arguments:
> #qemu -s -S -hda i386.img -kernel linux-2.6.33.2/arch/x86/boot/bzImage -append "root=/dev/hda1 console=ttyS0,115200 " -nographic -net nic,model=rtl8139 -net tap
>
> on host machine in directory linux-2.6.33.2/
> #gdb vmlinux
>
> du run within debugger.
>
> to run without debugger just remove the -s -S in the above commandline.
>
>
> HTH
> hofrat
>
