From: Chanchal Paul <paulchanchal.ece@gmail.com>
Subject: RT Kernel compile and install help needed.
Date: Tue, 4 Nov 2014 17:09:13 +0530
Message-ID: <CAD2dHrRkFxDCMCaB+sYd6bS9TbMSDNguu0V8c4igCpR2SFgF6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:36563 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbaKDLjO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Nov 2014 06:39:14 -0500
Received: by mail-ob0-f195.google.com with SMTP id m8so2575727obr.10
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Nov 2014 03:39:13 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am fairly new to kernel compilation and installation process, still
i managed to learn from Kernelnewbies and RT-wiki and managed to patch
3.12.14 vanilla kernel with rt patch 3.14.12. Then I followed the
steps and installed rt-kernel in my lubuntu vm. While doing make
menuconfig, i selected preemtion model as BASIC-RT from processor type
and features option. It worked.

Now my confusion arises when i see my uname -a string as [Linux
paul-lubuntu 3.14.12-rt9 #2 SMP PREEMPT Tue Oct 28 13:30:27 UTC 2014
x86_64 x86_64 x86_64 GNU/Linux] which indicated that i have a
preemptive kernel installed. but the c program from RT_PREEMPT_HOWTO
section of RTwiki website for Runtime detection of an RT-PREEMPT
Kernel only prints [this is a vanilla kernel]. So, my question is am I
running a vanilla kernel or a real-time kernel? If I am not then what
are the steps to properly install a real-time kernel?

Thanking you for giving attention to my mail.
