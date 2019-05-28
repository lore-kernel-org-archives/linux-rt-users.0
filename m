Return-Path: <SRS0=Q2zZ=T4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5CC04AB6
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 May 2019 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C7020679
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 May 2019 14:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE1Odc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 May 2019 10:33:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50798 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfE1Odc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 May 2019 10:33:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hVdAP-0007Z7-CT; Tue, 28 May 2019 16:33:29 +0200
Date:   Tue, 28 May 2019 16:33:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     ddu <dengke.du@windriver.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: rt kernel break printf command's parent process
Message-ID: <20190528143329.yxpzhu2ov5piiceb@linutronix.de>
References: <205dd879-fedc-2edf-92b3-0bd8a3ee1870@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <205dd879-fedc-2edf-92b3-0bd8a3ee1870@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-27 17:47:04 [+0800], ddu wrote:
> Hi all
Hi,

> I use yocto rt-kernel which rebase on rt kernel:
> 
> http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/log/?h=v5.0/standard/preempt-rt/intel-x86
> 
> yocto branch: master
> 
> run command:
> 
> printf "%0.0f\n" 123.4567
> 
> error:
> 
> [ OK ] Stopped Serial Getty on ttyS0.
> [ OK ] Started Serial Getty on ttyS0.

Doing this on a x86-64 does not lead to this. Is this 32bit oder 64bit?

> the system loged out, and let login again.
> 
> I using bisect to find which commit break the it:
…
> 
> When I want to revert it, I found it's a serial patches, so if I revert it,
> I need to revert a serial patches.
> 
> So can anyone help me to trace where break the return from printf and break
> the parent process?

You could remove the FPU patches from the series file and check it still
happens.

Sebastian
