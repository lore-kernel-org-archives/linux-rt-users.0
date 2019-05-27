Return-Path: <SRS0=pwVK=T3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C05AC282CE
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 May 2019 09:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198D921721
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 May 2019 09:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfE0Jrj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 May 2019 05:47:39 -0400
Received: from mail5.windriver.com ([192.103.53.11]:50586 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfE0Jrj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 May 2019 05:47:39 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x4R9lH7M027581
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2019 02:47:28 -0700
Received: from [128.224.162.135] (128.224.162.135) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May
 2019 02:47:07 -0700
To:     <linux-rt-users@vger.kernel.org>
From:   ddu <dengke.du@windriver.com>
Subject: rt kernel break printf command's parent process
Message-ID: <205dd879-fedc-2edf-92b3-0bd8a3ee1870@windriver.com>
Date:   Mon, 27 May 2019 17:47:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.135]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all

I use yocto rt-kernel which rebase on rt kernel:

http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/log/?h=v5.0/standard/preempt-rt/intel-x86

yocto branch: master

run command:

printf "%0.0f\n" 123.4567

error:

[ OK ] Stopped Serial Getty on ttyS0.
[ OK ] Started Serial Getty on ttyS0.

the system loged out, and let login again.

I using bisect to find which commit break the it:

---------------------------------------------------------------------------

commit 6115b04921fc2b8a6b9f7de6d35a0202204a36ba
Author: Rik van Riel <riel@surriel.com>
Date:   Sun Sep 9 18:30:50 2018 +0200

     x86/fpu: Always store the registers in copy_fpstate_to_sigframe()

     copy_fpstate_to_sigframe() stores the registers directly to user space.
     This is okay because the FPU register are valid and saving it directly
     avoids saving it into kernel memory and making a copy.
     However<E2><80><A6> We can't keep doing this if we are going to 
restore the FPU
     registers on the return to userland. It is possible that the FPU
     registers will be invalidated in the middle of the save operation and
     this should be done with disabled preemption / BH.

     Save the FPU registers to task's FPU struct and copy them to the user
     memory later on.

     This code is extracted from an earlier version of the patchset while
     there still was lazy-FPU on x86.

     Signed-off-by: Rik van Riel <riel@surriel.com>
     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

---------------------------------------------------------------------------

When I want to revert it, I found it's a serial patches, so if I revert 
it, I need to revert a serial patches.

So can anyone help me to trace where break the return from printf and 
break the parent process?

