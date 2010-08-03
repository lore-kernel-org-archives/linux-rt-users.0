From: Vivek Ayer <vivek.ayer@gmail.com>
Subject: Re: Run RTLinux in a VM?
Date: Tue, 3 Aug 2010 08:44:57 -0700
Message-ID: <AANLkTikPWFff5VyWgtG4VGm1V3kK6Q4Gy1WBEX663qDJ@mail.gmail.com>
References: <AANLkTinOFkUU1DdyWdL+YhPCiYhfEA=+zV9fpLsq-J2_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56935 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226Ab0HCPpA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Aug 2010 11:45:00 -0400
Received: by qwh6 with SMTP id 6so2101066qwh.19
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Aug 2010 08:44:58 -0700 (PDT)
In-Reply-To: <AANLkTinOFkUU1DdyWdL+YhPCiYhfEA=+zV9fpLsq-J2_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

Thanks for the quick responses. I'm not so concerned about the ill
effects of rt performance right this moment. I will probably get a
physical machine for it in two months or so. The main reason now is to
just get quick started on rt programming per say. My host machine is a
client written in PyQt that will be interfacing with RTLinux machine
and I just wanted to test a couple of things before I invested in a
rig for the RTLinux machine. I just want something that runs the RT
kernel for now.

The last time I tried with KVM, the rt kernel would panic on me while
loading some modules I suspect. So, if I'm going to use QEMU (No KVM),
running on a i386 host, running a i386 RTLinux guest, would I need to
apply any special patches to make sure the panic didn't occur.

See this thread for it hanging up in VMWare:
http://osdir.com/ml/linux.real-time.rtlinux.general/2004-11/msg00076.html

Apparently the rtl_time module causes the panic. Has this been taken
care of in the latest kernel?

Thanks,
Vivek

On Tue, Aug 3, 2010 at 7:35 AM, Vivek Ayer <vivek.ayer@gmail.com> wrote:
> Hi all,
>
> I'm building an application that requires the use of a real-time
> kernel. I don't have money right now to purchase a physical machine to
> run rtlinux on, and was going to try a virtual solution. Can I install
> rtlinux in kvm, qemu, or uml?
>
> Thanks,
> Vivek
>
