From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] v4.14.15-rt12
Date: Thu, 25 Jan 2018 19:58:39 +0100
Message-ID: <20180125195839.53866ca0@archlinux.localdomain>
References: <20180125151706.v6pgbeixt2jfpph2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail222c50.megamailservers.eu ([91.136.10.232]:38084 "EHLO
        mail33c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750994AbeAYS6o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Jan 2018 13:58:44 -0500
Received: from archlinux.localdomain (x4e321512.dyn.telefonica.de [78.50.21.18])
        (authenticated bits=0)
        by mail33c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id w0PIwdDS024253
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jan 2018 18:58:41 +0000
In-Reply-To: <20180125151706.v6pgbeixt2jfpph2@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 25 Jan 2018 16:17:06 +0100, Sebastian Andrzej Siewior wrote:
>I'm pleased to announce the v4.14.15-rt12 patch set. 

Hi,

I already installed two page-table isolation kernels, that aren't rt
patched kernels.

At the moment I don't have time to test if booting with or without
nokaiser/nopti does make a difference.



[root@archlinux moonstudio]# grep \ no..i /boot/syslinux/syslinux.cfg
    APPEND root=LABEL=archlinux ro threadirqs nopti
    APPEND root=LABEL=moonstudio ro nokaiser
[root@archlinux moonstudio]# pacman -Q linux
linux 4.14.15-1
[root@archlinux moonstudio]# systemd-nspawn apt changelog linux-image-4.4.0.112-lowlatency 2>/dev/null | grep "nokaiser"
    - kaiser: add "nokaiser" boot option, using ALTERNATIVE



Does performance differ when booting 4.14.15-rt11 with or without nopti?

Regards,
Ralf
