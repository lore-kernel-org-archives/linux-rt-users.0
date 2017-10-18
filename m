From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] v4.13.7-rt1
Date: Wed, 18 Oct 2017 04:37:24 +0200
Message-ID: <20171018043724.51edd75a@archlinux.localdomain>
References: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
        <201710172047.07299.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail236c50.megamailservers.eu ([91.136.10.246]:41594 "EHLO
        mail56c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751616AbdJRCh2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Oct 2017 22:37:28 -0400
Received: from archlinux.localdomain (x5ce0d1c3.dyn.telefonica.de [92.224.209.195])
        (authenticated bits=0)
        by mail56c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id v9I2bOkQ001443
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2017 02:37:25 +0000
In-Reply-To: <201710172047.07299.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 17 Oct 2017 20:47:07 -0400, Gene Heskett wrote:
>A bit of a git noob here. Why am I getting this on an r-pi3b?
>
>pi@picnc:/media/slash/home/pi $
>git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
>v4.13.7-rt1 -bash:
>git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git:
>No such file or directory

git clone git://git.foo.org/bar
cd /bar
git pull --all

or

git checkout ...

Instead of using git I always download from

https://www.kernel.org/

https://www.kernel.org/pub/linux/kernel/
https://www.kernel.org/pub/linux/kernel/v4.x/

https://www.kernel.org/pub/linux/kernel/projects/
https://www.kernel.org/pub/linux/kernel/projects/rt/

Important: https://www.kernel.org/category/signatures.html
