From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: oops with 4.9.13-rt12 under mild load (and no rt-tasks active)
Date: Fri, 10 Mar 2017 23:19:38 +0100
Message-ID: <20170310231938.73c27c48@archlinux.localdomain>
References: <20170310194717.GE32625@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail233c50.megamailservers.eu ([91.136.10.243]:45602 "EHLO
        mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932711AbdCJWkG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 17:40:06 -0500
Received: from archlinux.localdomain (x4e321735.dyn.telefonica.de [78.50.23.53])
        (authenticated bits=0)
        by mail37c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id v2AMJalw007503
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Mar 2017 22:19:38 +0000
In-Reply-To: <20170310194717.GE32625@osadl.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 10 Mar 2017 19:47:17 +0000, Nicholas Mc Guire wrote:
> Has anyone seen 4.9.13-rt12 oopses related to ext4 or vfs in general ?

Hi,

no, I've got good luck, using a cheaper Intel.

Earlier today I mixed a song with around 40 tracks, each track > 10
minutes long, all playing at the same time. The wav files are stored on
an ext4 partition and the Linux install is on an ext4 partition, too. In
around 8 hours Ardour crashed 2 times, apart from this there were no
issues.

[rocketmouse@archlinux ~]$ hwinfo --cpu | grep Model | sort -u
  Model: 6.60.3 "Intel(R) Celeron(R) CPU G1840 @ 2.80GHz"
[rocketmouse@archlinux ~]$ uname -a
Linux archlinux 4.9.13-rt12-1-rt-persianrug #1 SMP PREEMPT RT Wed Mar 8 02:21:10 CET 2017 x86_64 GNU/Linux
[rocketmouse@archlinux ~]$ grep ext4 /etc/fstab
/dev/sda9       /               ext4  rw,relatime,data=ordered 0 1
/dev/sda11      /mnt/music      ext4  defaults,noatime         0 2
/dev/sdb12      /home/music     ext4  defaults,noatime         0 2
/dev/sda5       /home/s1.music  ext4  defaults,noatime         0 2
[rocketmouse@archlinux ~]$ pacman -Q ardour5 jack2
ardour5 5.8-1
jack2 1.9.10.r241.ge0281d82-1

Regards,
Ralf
