From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Thu, 13 Sep 2012 08:58:03 +0200
Message-ID: <CA+69FtA+9LeKTsPJFHfDwJw1UBdV0PCvaSmjMRxy2AWhxfsMAw@mail.gmail.com>
References: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
	<F97B0B2A-C7D7-4EF5-AF59-74BEA56FEA09@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64520 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab2IMG6E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 02:58:04 -0400
Received: by obbuo13 with SMTP id uo13so4016215obb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Sep 2012 23:58:03 -0700 (PDT)
In-Reply-To: <F97B0B2A-C7D7-4EF5-AF59-74BEA56FEA09@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It's really quite trivial:

The kernel in question i used is available at
git://www.sakoman.com/git/linux-omap-2.6.git.
I used the omap-3.2 branch, commit 33128932803c3f8c35fe8dae257901deb60db2aa

I applied patch-3.2.28 from http://www.kernel.org/pub/linux/kernel/v3.x/

The only change required to patch-3.2.28 in order for it to apply cleanly is:

--- patch-3.2.28        2012-09-13 06:15:07.000000000 +0200
+++ patch-3.2.28.patch  2012-09-13 06:15:09.000000000 +0200
@@ -3176,6 +3176,7 @@
        outer_cache.inv_all = l2x0_inv_all;
        outer_cache.disable = l2x0_disable;
 -      outer_cache.set_debug = l2x0_set_debug;
+       outer_cache.clean_all = l2x0_clean_all;

        printk(KERN_INFO "%s cache controller enabled\n", type);
        printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL
0x%08x, Cache size: %d B\n",

Following this, the patch-3.2.28-rt42 from
http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/ applies
cleanly as well.

On Wed, Sep 12, 2012 at 10:22 PM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
>
> On Sep 12, 2012, at 3:20 AM, Hartmut Behrens <hartmut.behrens@gmail.com> wrote:
>
>> Hi,
>>
>> I have patched a 3.2 kernel for a OMAP compatible processor (ARM
>> Cortex A8) to be used on an Gumstix Overo with the CONFIG_PREEMPT_RT
>> patch.
>>
>
> Any interest in sending the patches to the list?
>
> Thanks
>
> Sven
