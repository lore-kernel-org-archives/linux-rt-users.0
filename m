From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: Cannot boot RTLinux
Date: Fri, 23 Jan 2015 18:36:54 +0100
Message-ID: <20150123183654.7867797f@archlinux>
References: <CAOQDsMw6H_eQg9-kVCi2HVxO9-Di4es82VW_Wm2K4OqfM_9N_A@mail.gmail.com>
	<CAOQDsMwfZKCM67bEzdBbxUO5-Q+TrPeM39S4ftoZzFBRqXjUTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail226c50.megamailservers.eu ([91.136.10.236]:45247 "EHLO
	mail36c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751374AbbAWRhA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Jan 2015 12:37:00 -0500
Received: from archlinux (g224211243.adsl.alicedsl.de [92.224.211.243])
	(authenticated bits=0)
	by mail36c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id t0NHasrR018063
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 23 Jan 2015 17:36:56 +0000
In-Reply-To: <CAOQDsMwfZKCM67bEzdBbxUO5-Q+TrPeM39S4ftoZzFBRqXjUTw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 23 Jan 2015 14:23:03 +0100, Dorian VEGARA wrote:
> What am I supposed to write instead of "-foo" in the initrd
> instruction ? "-linux-3.14.25" for example ?

Is there a initramfs or initrd for your kernel in /boot?

> http://textup.fr/116850NO

I've got no time to read it.

I would copy the config of the distro's default kernel and run make
oldconfig to add rt settings.

> Do you believe the bug could be due to the CPU configuration (I didn't
> specified what sort of CPU is used exactly

No, in my experiences it doesn't make a difference, if you e.g. use
CONFIG_MK8=y
for Opteron/Athlon64/Hammer/K8
or the distro's default.

I usually don't use "manuall" mkinitcpio, I prefer to use the tools to
build kernel packages for Debian/Ubuntu and Arch Linux. When I used
Suse, I build the kernel the "old school" way without tools.
