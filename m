From: Dorian VEGARA <dorian.vegara@gmail.com>
Subject: Cannot boot RTLinux
Date: Thu, 22 Jan 2015 20:39:34 +0100
Message-ID: <CAOQDsMw6H_eQg9-kVCi2HVxO9-Di4es82VW_Wm2K4OqfM_9N_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:59259 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbbAVTjg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Jan 2015 14:39:36 -0500
Received: by mail-la0-f51.google.com with SMTP id ge10so3570329lab.10
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jan 2015 11:39:35 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone,

I'm trying to boot RTLinux but I'm encountering problems to load it.
I patched successfully the Linux kernel (version 3.14.25) with the
RTLinux one (3.14.25 too).

Then, I typed this command :
make defconfig (in the linux-patched-repertory). It chose the x86_64 defconfig.

After it, I typed make && make modules_install. The x86-only bzImage
has been created.
The modules have been installed properly. The last message is "DEPMOD
3.14.25-rt22".

The GRUB2 configuration is OK. But when I boot RTLinux, it crashes.
A "Warning CPU" message appears :
http://nsa33.casimages.com/img/2015/01/22/150122084114722488.jpg

Could anyone tell me what is wrong please ?
Here is a PowerPoint document to explain in details the bug and what
exactly I did :

https://drive.google.com/file/d/0BxBRiO4INcfxWnltOFZDeDNBZmM/view?usp=sharing



Thanks a lot !
Best regards,
