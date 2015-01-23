From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: Cannot boot RTLinux
Date: Fri, 23 Jan 2015 08:28:52 +0100
Message-ID: <20150123082852.37d5dfe3@archlinux>
References: <CAOQDsMw6H_eQg9-kVCi2HVxO9-Di4es82VW_Wm2K4OqfM_9N_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail236c50.megamailservers.eu ([91.136.10.246]:52630 "EHLO
	mail56c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751514AbbAWIAa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Jan 2015 03:00:30 -0500
Received: from archlinux (g231004128.adsl.alicedsl.de [92.231.4.128])
	(authenticated bits=0)
	by mail56c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id t0N7SrPn012266
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 23 Jan 2015 07:28:55 +0000
In-Reply-To: <CAOQDsMw6H_eQg9-kVCi2HVxO9-Di4es82VW_Wm2K4OqfM_9N_A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 22 Jan 2015 20:39:34 +0100, Dorian VEGARA wrote:
> The GRUB2 configuration is OK.

Are you sure?
Isn't there missing something similar too
linux	/boot/foo root=UUID=1234 ro
                  ^^^^^^^^^^^^^^^^^
initrd	/boot/init*-foo
^^^^^^^^^^^^^^^^^^^^^^^
?

> http://nsa33.casimages.com/img/2015/01/22/150122084114722488.jpg
> https://drive.google.com/file/d/0BxBRiO4INcfxWnltOFZDeDNBZmM/view?usp=sharing

I didn't read all the screenshots, consider to post ASCII log files
instead of photos and the output of
> uname -a
Does it include PREEMPT RT?

You can quasi chroot in by

# systemd-nspawn -D /mnt/point/of/your/suse

to get ASCII output of the odd binary journalctl files and uname.
