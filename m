From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: RT Kernel compile and install help needed.
Date: Tue, 4 Nov 2014 13:33:53 +0100
Message-ID: <20141104133353.1698412d@archlinux>
References: <CAD2dHrRkFxDCMCaB+sYd6bS9TbMSDNguu0V8c4igCpR2SFgF6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail235c50.megamailservers.eu ([91.136.10.245]:55156 "EHLO
	mail56c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751368AbaKDMd7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Nov 2014 07:33:59 -0500
Received: from archlinux (g231006077.adsl.alicedsl.de [92.231.6.77])
	(authenticated bits=0)
	by mail56c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id sA4CXr0P006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Nov 2014 12:33:56 +0000
In-Reply-To: <CAD2dHrRkFxDCMCaB+sYd6bS9TbMSDNguu0V8c4igCpR2SFgF6Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 4 Nov 2014 17:09:13 +0530
Chanchal Paul <paulchanchal.ece@gmail.com> wrote:

> I am fairly new to kernel compilation and installation process, still
> i managed to learn from Kernelnewbies and RT-wiki and managed to patch
> 3.12.14 vanilla kernel with rt patch 3.14.12. Then I followed the
> steps and installed rt-kernel in my lubuntu vm. While doing make
> menuconfig, i selected preemtion model as BASIC-RT from processor type
> and features option. It worked.
> 
> Now my confusion arises when i see my uname -a string as [Linux
> paul-lubuntu 3.14.12-rt9 #2 SMP PREEMPT Tue Oct 28 13:30:27 UTC 2014
> x86_64 x86_64 x86_64 GNU/Linux] which indicated that i have a
> preemptive kernel installed. but the c program from RT_PREEMPT_HOWTO
> section of RTwiki website for Runtime detection of an RT-PREEMPT
> Kernel only prints [this is a vanilla kernel]. So, my question is am I
> running a vanilla kernel or a real-time kernel? If I am not then what
> are the steps to properly install a real-time kernel?
> 
> Thanking you for giving attention to my mail.

Assume you should use Debian/Ubuntu or Arch Linux I can help you to
build a kernel-rt package. As long as RT isn't mentioned in the uname -a
string, you don't run a kernel-rt. Did you copy the original config of
your installed distros's kernel, run make oldconfig and cared about
questions regarding RT?

Please consider to ask such a question at
http://lists.linuxaudio.org/listinfo/linux-audio-user instead of this
list.
