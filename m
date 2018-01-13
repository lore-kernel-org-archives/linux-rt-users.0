From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] v4.14.12-rt10
Date: Sat, 13 Jan 2018 06:07:17 +0100
Message-ID: <20180113060717.5e9a9514@archlinux.localdomain>
References: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
        <201801090929.19444.gheskett@shentel.net>
        <20180112184200.aufikphsttb2zbqk@linutronix.de>
        <201801121741.07887.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail226c50.megamailservers.eu ([91.136.10.236]:47762 "EHLO
        mail36c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750705AbeAMFHT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 13 Jan 2018 00:07:19 -0500
Received: from archlinux.localdomain (x4e3215f8.dyn.telefonica.de [78.50.21.248])
        (authenticated bits=0)
        by mail36c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id w0D57F7Q017668
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Sat, 13 Jan 2018 05:07:17 +0000
In-Reply-To: <201801121741.07887.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 12 Jan 2018 17:41:07 -0500, Gene Heskett wrote:
>I think I did not strip it to what the rock64 needed, so theres no
>doubt a bunch of gingerbread it will never use.

[rocketmouse@archlinux ~]$ grep -A19 "make localmodconfig" /usr/lib/modules/4.14.12-rt10-1-rt/build/Documentation/admin-guide/README.rst
     "make localmodconfig" Create a config based on current config and
                           loaded modules (lsmod). Disables any module
                           option that is not needed for the loaded modules.

                           To create a localmodconfig for another machine,
                           store the lsmod of that machine into a file
                           and pass it in as a LSMOD parameter.

                   target$ lsmod > /tmp/mylsmod
                   target$ scp /tmp/mylsmod host:/tmp

                   host$ make LSMOD=/tmp/mylsmod localmodconfig

                           The above also works when cross compiling.

     "make localyesconfig" Similar to localmodconfig, except it will convert
                           all module options to built in (=y) options.

   You can find more information on using the Linux kernel config tools
   in Documentation/kbuild/kconfig.txt.
