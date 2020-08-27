Return-Path: <SRS0=N+eC=CF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62EC433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06292080C
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 09:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgH0JTO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:19:14 -0400
Received: from mail.monom.org ([188.138.9.77]:49848 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgH0JTN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Aug 2020 05:19:13 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 144C250035A;
        Thu, 27 Aug 2020 11:19:11 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id A7627500103;
        Thu, 27 Aug 2020 11:19:10 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:19:10 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 26, 2020 at 12:43:26PM +0200, Daniel Wagner wrote:
> All looks good, no crash and all tests do pass on x86_64. Firing up the
> ARM boards now.

All test pass on the BeagleBone Black.

Something is a bit weird with my RPi3 in 64bit mode. uboot loads
the the dtb file via ftp and then does a booti. For all non PREEMPT_RT
kernels (PREEMPT, NONE, SMP=n, ...) everything works fine. For the
PREEMPT_RT kernel uboot complains with

  U-Boot> booti 0x00080000 - 0x02600000
  bootloader-commands: Wait for prompt Starting kernel (timeout 00:03:43)
  booti 0x00080000 - 0x02600000
  ERROR: Did not find a cmdline Flattened Device Tree
  Starting kernel ...

It's the same dtb in all cases. Not totally sure what is upsetting uboot
here, maybe the load addresses don't work anymore?

In short, I can't really say if v5.9-rt for ARMv8 works for me.
