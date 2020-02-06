Return-Path: <SRS0=JiWK=33=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E54BC3F68F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 00:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F4A22314
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 00:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgBGARt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:17:49 -0500
Received: from mx0a-00000d04.pphosted.com ([148.163.149.245]:7050 "EHLO
        mx0a-00000d04.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgBGARt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Feb 2020 19:17:49 -0500
X-Greylist: delayed 1010 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 19:17:48 EST
Received: from pps.filterd (m0102887.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016NnnKl004943;
        Thu, 6 Feb 2020 16:00:04 -0800
Received: from mx0b-00000d03.pphosted.com (mx0b-00000d03.pphosted.com [148.163.153.234])
        by mx0a-00000d04.pphosted.com with ESMTP id 2xyhq93e11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 16:00:03 -0800
Received: from pps.filterd (m0190086.ppops.net [127.0.0.1])
        by mx0a-00000d03.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016NpuO5030619;
        Thu, 6 Feb 2020 16:00:02 -0800
Received: from codegreen6.stanford.edu (codegreen6.stanford.edu [171.67.224.8])
        by mx0a-00000d03.pphosted.com with ESMTP id 2xyhpr2hn9-1
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Thu, 06 Feb 2020 16:00:02 -0800
Received: from codegreen6.stanford.edu (localhost.localdomain [127.0.0.1])
        by codegreen6.stanford.edu (Postfix) with ESMTP id 49D0B83;
        Thu,  6 Feb 2020 16:00:01 -0800 (PST)
Received: from smtp.stanford.edu (smtp5.stanford.edu [171.67.219.71])
        by codegreen6.stanford.edu (Postfix) with ESMTP id 2F4E47E;
        Thu,  6 Feb 2020 16:00:01 -0800 (PST)
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id E116CC1FA0;
        Thu,  6 Feb 2020 16:00:00 -0800 (PST)
Received: from localhost.localdomain (cm-guestnet.stanford.edu [171.64.197.42])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 016NxvPX030896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 6 Feb 2020 15:59:59 -0800
Cc:     nando@ccrma.Stanford.EDU, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.4.17-rt9
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
From:   Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Message-ID: <cda47e2f-fd9d-c4c8-7991-64fef38af0ef@ccrma.stanford.edu>
Date:   Thu, 6 Feb 2020 15:59:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
x-proofpoint-stanford-dir: outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=100 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002060172
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2/4/20 8:58 AM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.4.17-rt9 patch set.

Thanks!
I see a continuous stream of these:

----
[165992.032318] BUG: sleeping function called from invalid context at 
kernel/locking/rtmutex.c:973
[165992.032320] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 
12209, name: kworker/u8:3
[165992.032322] INFO: lockdep is turned off.
[165992.032322] irq event stamp: 0
[165992.032323] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[165992.032325] hardirqs last disabled at (0): [<ffffffff980ed372>] 
copy_process+0x802/0x2000
[165992.032329] softirqs last  enabled at (0): [<ffffffff980ed372>] 
copy_process+0x802/0x2000
[165992.032331] softirqs last disabled at (0): [<0000000000000000>] 0x0
[165992.032332] CPU: 2 PID: 12209 Comm: kworker/u8:3 Tainted: G        W 
         5.4.17-100.rt9.1.fc30.ccrma.x86_64+rt #1
[165992.032333] Hardware name:  /NUC6i7KYB, BIOS 
KYSKLi70.86A.0034.2016.0503.1003 05/03/2016
[165992.032369] Workqueue: i915 retire_work_handler [i915]
[165992.032369] Call Trace:
[165992.032373]  dump_stack+0x8f/0xd0
[165992.032377]  ___might_sleep.cold+0xb3/0xc3
[165992.032380]  rt_spin_lock_nested+0x8e/0xd0
[165992.032382]  ? __i915_sw_fence_complete+0x15c/0x200 [i915]
[165992.032407]  __i915_sw_fence_complete+0x15c/0x200 [i915]
[165992.032432]  __i915_request_queue+0x19/0x50 [i915]
[165992.032463]  __engine_park+0xe2/0x1d0 [i915]
[165992.032489]  ____intel_wakeref_put_last+0x1e/0x50 [i915]
[165992.032511]  i915_request_retire+0x293/0x480 [i915]
[165992.032541]  retire_requests+0x54/0x60 [i915]
[165992.032569]  i915_retire_requests+0xea/0x220 [i915]
[165992.032598]  retire_work_handler+0x56/0x60 [i915]
[165992.032626]  process_one_work+0x261/0x6c0
[165992.032631]  worker_thread+0x50/0x3b0
[165992.032634]  kthread+0x106/0x140
[165992.032636]  ? process_one_work+0x6c0/0x6c0
[165992.032638]  ? kthread_park+0x90/0x90
[165992.032640]  ret_from_fork+0x3a/0x50
----

Something similar used to happen a while back, but I had not seen it on 
5.2.x rt patched kernels. It is back (or something very similar).

This is on Fedora 30 upgraded to the latest, and the kernel is based on 
(as I normally do) the source package for the equivalent Fedora kernel, 
with the RT patch added (and configured).

Thanks again for your work!
-- Fernando


> Changes since v5.4.17-rt8:
> 
>    - A rework of percpu-rwsem locking. The fs core was using a
>      percpu-rwsem and returned with acquired lock to userland during
>      `fsfreeze' which led warnings. On !RT the warnings were disabled but
>      the same lockdep trick did not work on RT.
>      Reported by Juri Lelli, patch(es) by Peter Zijlstra.
> 
>    - Include a header file the `current' macro to not break an allmod
>      build on ARM.
> 
>    - A tweak to migrate_enable() to not having to wait until
>      stop_one_cpu_nowait() finishes in case CPU-mask changed during
>      migrate_disable() and the CPU has to be changed. Patch by Scott
>      Wood.
> 
>    - Drop a lock earlier in mm/memcontrol. Not a bug but there is no need
>      for the additional locked section. Patch by Matt Fleming.
> 
> Known issues
>       - None

