From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT-3.10.6_p3 fails to boot: home.mount mounting timed out
Date: Fri, 24 Jan 2014 20:14:17 +0100
Message-ID: <20140124191417.GA29618@linutronix.de>
References: <526B46AA.1090407@gmail.com>
 <20131122151343.GE8698@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Light <sgsdxzy@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59009 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaAXTOU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jan 2014 14:14:20 -0500
Content-Disposition: inline
In-Reply-To: <20131122151343.GE8698@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2013-11-22 16:13:44 [+0100]:

>* Light | 2013-10-26 12:35:54 [+0800]:
>
>> I am trying to build a RT kernel, however it cannot boot because it
>>cannot mount /home, which is a subvolume of btrfs.  This is the entry
>>of it in /etc/fstab:
>>
>>/dev/sda3    /home    btrfs
>>subvol=gentoohome,defaults,compress=lzo,autodefrag 0 2

So I tried this myself. I've setup a FC19 box with btrfs with a root
subvolume and a home subvolume. The etc/fstab
|[root@fc19-64 ~]# grep btrfs /etc/fstab 
|UUID=b5045733-8f7d-48e4-a4ad-a58bf44cb49f /      btrfs subvol=root     1 1
|UUID=b5045733-8f7d-48e4-a4ad-a58bf44cb49f /home  btrfs subvol=home     1 1

and it booted:
|[root@fc19-64 ~]# uname -a
|Linux fc19-64.testing 3.12.8-rt10 #250 SMP PREEMPT RT Fri Jan 24 19:18:38 CET 2014 x86_64 x86_64 x86_64 GNU/Linux
|[root@fc19-64 ~]# mount | grep btrfs
|/dev/vda2 on / type btrfs (rw,relatime,seclabel,space_cache)
|/dev/vda2 on /home type btrfs (rw,relatime,seclabel,space_cache)

except for the different mount opts (compress=lzo,autodefrag) I don't
see what is different here.

Sebastian
