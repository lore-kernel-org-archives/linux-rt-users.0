Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E84C43461
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 05:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC1B21D40
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 05:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T1Nb9V4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIIFIX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:08:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:44055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgIIFIS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 01:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599628068;
        bh=GeBdHItTmKrF/YKHv4ZsKGC2ILy9hKoQYV1wFDemBPI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=T1Nb9V4dgJ6sCKL0L7tenSIkREXRldGwcWE/1AIX8AV9xHOMq9KWvjetAzb1fFFce
         SSF+8dGCFMIROyY7GP4a5PWJ4I97+5IS3hmllYhWb4ylKRhAQkfaCV0tfMJ8YvwFjM
         8P/eN6Gg/EvZYI5fNqCQ1OqILnHxMfk/T6AZkvJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1jvCgj2TGH-00NTqh; Wed, 09
 Sep 2020 07:07:48 +0200
Message-ID: <72ca4a8f57c35701defea29ed83fa818561f684e.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.9-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 09 Sep 2020 07:07:47 +0200
In-Reply-To: <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:04zcps8n/yIqp1+/l3/9bnTVBTAnEfDJge4E8ugjTwHYo7iH5z+
 1hC9Xb1bHNYHf3tdyq0D3CHgAJZF9F+XuH45IZiyFuks2Lf3FDiYe+s4uu3N0MMjU4GCB3G
 JVChpM55q2XzOO2+901o/UoV5/Jr1+zGSPlj9KHKnbLwWmduCILVToCDcjizdsZn7DL+HCj
 Mt3yUHdKziEFg7bntUrPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KTkZO6+7WD0=:VRRj58tzShbd62Bpm4DqVb
 woKl8mAxLv09SlbpRaZPjuzcJ4EMkaoDyyxNVrJW1zFTkyRW17WAx8AgmdZC1BSibf7//NPEs
 zWBaUPKwuPJ7gbMdK3C/wqbemJvbRO6focBN5OwT97Y4oNMXEaLLKd4yS9n1mTZQDv7PYoYQx
 Ll6DQDvR1VuRRnkFNTkFwCbY0nWeGC5AkHDBMyRvXMlADc0+HCgx3qjoPbShqnx+hUSUW1RSA
 KROJgQJD7Lgydq+5g1v1KwLPaix4EgNZDQDR16rZtZq9m99q1rX76OSwfGEsb6ltCzgtgRUw/
 5ODX2JuyVanBgo5n3cPV96RMI4G0lHaoAD/c4tT4cacDiwIHY6xCvPEAulpQ6x5+xYfSBfqvK
 gt8iPG5Z5ZEe0FaMDLybSSOEPjbWcUQnpff+nU6hHdohCTFtPNjwcFEr5vn+eXym7OWOLWmzj
 R40mCinjDHNHGTGiZWx7zRJ3hVsNRQzY5FMVqvQ6qiW+slmuoPBkZQw0+TNBmbIJmDU1YfAlv
 0vLLLgdZ2u2/xRdj6EOWb++vMFDKuPuhXSFYMuobLnSoYW2RNuH3+1R8Wg1dJCcPrWKVPH/O7
 CvPRFkJQWvfdTKFiTl4f8tRdXYLckrB1w4L+Mtmkw5J2Y+RJCe3x6k5H+nZi2HJ/Ep4LUT1ig
 LayP4CXfoCHaZ0cjTOgV9p7vE6GP/u8sWAgcemcn+JcOAh4vHU9oNuM+BCBUGFHDBaB9S9Hc3
 o6ItGTOfKeKL9qevCxTGdLrK4OPEHZJL6tFoUCdDhah23tEL07oKEEZgoh4+ut3f/GDej1ANe
 85+a5DRMImK3lsOWJznoyudg6UH4yiFWQZYD5d8PYBDFn4yWl9HwvC+2myb8HafCelSEIAXt6
 3FdMQ6Q5mck6RvAEGPXLx36RQbl+twfG3+0puDqtiRTGIrjdmvozAWotWs2a3sZsVME4LoeyV
 68Re6ZyHOlYqMkhs+nc1YqKt+uumBxZKGZ49XwZ8U2K9X7u6X4yyz5Bw6ccJtMlexJiZ4e2a0
 voQ3IlqQ1aAhV9/urMFUuM6ygRTq34IWWPxvmt2lNxuTfDOsV2Ei2gTrhavpZNJUBtzijcyUR
 RvKS5SnkhzpsNU3ygTa0aZQ0y4n5iBSPKTsX2b1aaVjzONNT4rzov3cihJC6Ivf2j0JKFY11r
 zHQXZw1IoE8xcIYd58Ou46DAFG3z7aK8XgdkgOScB0p6x4+GY8u8iL2wIKqxzl6NDqJUdTnn8
 KVfU5onHUGmNFCX2D
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-09-09 at 05:12 +0200, Mike Galbraith wrote:
> On Wed, 2020-09-02 at 17:55 +0200, Sebastian Andrzej Siewior wrote:
> >
> > Known issues
> >      - It has been pointed out that due to changes to the printk code =
the
> >        internal buffer representation changed. This is only an issue i=
f tools
> >        like `crash' are used to extract the printk buffer from a kerne=
l memory
> >        image.
>
> Ouch.  While installing -rt5 on lappy via nfs, -rt5 server box exploded
> leaving nada in logs.  I have a nifty crash dump of the event, but...

I backed out 1ce98b8a0a1..463463c6fa3f so crash will work again, but
haven't as yet been able to convince box to explode.  Hohum, I'll give
it some time.

Lockdep did repeat dirtying of its diaper though, on both lappy and
desktop boxen at roughly the same uptime.

[  922.978106] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[  922.978112] turning off the locking correctness validator.
[  922.978116] CPU: 2 PID: 5837 Comm: kworker/u16:0 Kdump: loaded Tainted:=
 G S          E     5.9.0.gf4d51df-rt5-rt #3
[  922.978120] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[  922.978127] Workqueue: writeback wb_workfn (flush-8:48)
[  922.978131] Call Trace:
[  922.978138]  dump_stack+0x77/0x9b
[  922.978143]  validate_chain+0xf60/0x1230
[  922.978147]  __lock_acquire+0x880/0xbf0
[  922.978151]  lock_acquire+0x92/0x3f0
[  922.978155]  ? rt_spin_lock_slowlock_locked+0x5d/0x2c0
[  922.978160]  _raw_spin_lock+0x2f/0x40
[  922.978163]  ? rt_spin_lock_slowlock_locked+0x5d/0x2c0
[  922.978169]  rt_spin_lock_slowlock_locked+0x5d/0x2c0
[  922.978173]  __read_rt_lock+0x97/0xc0
[  922.978194]  ext4_es_lookup_extent+0x4f/0x410 [ext4]
[  922.978205]  ext4_map_blocks+0x50/0x530 [ext4]
[  922.978209]  ? kmem_cache_alloc+0x636/0x8b0
[  922.978220]  ext4_writepages+0xa2c/0x1330 [ext4]
[  922.978228]  ? do_writepages+0x3c/0xe0
[  922.978231]  do_writepages+0x3c/0xe0
[  922.978236]  ? __writeback_single_inode+0x62/0x890
[  922.978240]  __writeback_single_inode+0x62/0x890
[  922.978244]  writeback_sb_inodes+0x217/0x580
[  922.978250]  __writeback_inodes_wb+0x5d/0xd0
[  922.978254]  wb_writeback+0x28c/0x620
[  922.978259]  ? wb_workfn+0x2bc/0x7f0
[  922.978262]  wb_workfn+0x2bc/0x7f0
[  922.978266]  ? lock_acquire+0x92/0x3f0
[  922.978270]  ? process_one_work+0x1fa/0x730
[  922.978274]  ? process_one_work+0x284/0x730
[  922.978278]  ? process_one_work+0x251/0x730
[  922.978281]  process_one_work+0x284/0x730
[  922.978285]  ? _raw_spin_lock_irq+0x16/0x50
[  922.978289]  ? process_one_work+0x730/0x730
[  922.978293]  worker_thread+0x39/0x3f0
[  922.978297]  ? process_one_work+0x730/0x730
[  922.978300]  kthread+0x171/0x190
[  922.978304]  ? kthread_park+0x90/0x90
[  922.978308]  ret_from_fork+0x1f/0x30

