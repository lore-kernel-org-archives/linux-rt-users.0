Return-Path: <SRS0=UrLp=EJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBCFC388F9
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 23:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D451223AC
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 23:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="C5GnCEbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgKCXbo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 18:31:44 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:1868 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725763AbgKCXbn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 18:31:43 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0A3NT4VS020520;
        Tue, 3 Nov 2020 17:31:16 -0600
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00010702.pphosted.com with ESMTP id 34h5esgrqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 17:31:16 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+UOY3AYRRHGQwkKo11/qiRnChYiht0xkBlA/0KEG3LMV3VX7juof5ciFEegaeZtz++KKVOH+KpAky+m1X9guL6PTysPtvR++yqtZzNlmDuHoct0SXeKS/RTrggUSHG3zWf6yJ3Fr13f9kJjACIc0AOHQgiEpWdqtg02kD8OEJUSiaXnn2oJ3qz9tMqy3jhrRiP9+agvY7fjwTsrz+5N605JPvi3A+JvQolEohnT1jqg9wSXbKq1ihWN9BWNo4SDIVnBmiQharA4coGd5vgHxCf8BxNCaX5eYHk5csCbZXsbDO5AFpHiqCa7NqMDxAUgsPdi9fpqHDEld8/WcfuEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWCDlRpuk5vsSbjXtoVx8MKVEYDBvPdm6PwzwapgorM=;
 b=eMpDH0doPwI3s6o/mkpOf9tSew2elCKegRIUSMKahulEMWQFg6R/PydrZl/VXHLdNJ8v0Iss7g8S/OEHE+yTl+qFqo05tsyhkAKkSLjTTgQGOrmoBLL7ZQe6Z4eBQYufXYwDxkJahTpLTrZtCeiePMSvsA0o+MiUMZuxjQ7Ze9BNQY5THhXwVw37rS//6WMHmS5rpNNqHQy9M2yLwucL7viJuX2XucyvW+jLDTdwAX5KRXNtaz8NbUDr4YCyixGVqvhSw9AjTX2tT3VEmuwLJzOKhnWwnUVABzQBD9PwHKIClryK0dl4LZoUnhC57jrne4P9T/wd0LBNQjwPn3ZDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWCDlRpuk5vsSbjXtoVx8MKVEYDBvPdm6PwzwapgorM=;
 b=C5GnCEbWNgv1mL1j9eNayIB34duuIiUOkR4s9l5dMPx4th1UET9fZMIBa+/DG635gMHcw5PFYM2FHVvtSXSmLQA8B2HkHd8kvgDZF9ks3XLfu79PwZlFUlRUWQ4bLbZstzOfMiWUAaWUQhTBii7RdQgaA47ewWKM46QS3wBtVbQ=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by SN6PR04MB4078.namprd04.prod.outlook.com (2603:10b6:805:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 23:31:13 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::cc42:669f:a4f2:c1]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::cc42:669f:a4f2:c1%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 23:31:13 +0000
References: <87a6w6x7bb.fsf@ni.com>
User-agent: mu4e 1.3.2; emacs 27.1
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-reply-to: <87a6w6x7bb.fsf@ni.com>
Date:   Tue, 03 Nov 2020 17:31:07 -0600
Message-ID: <878sbixbk4.fsf@ni.com>
Content-Type: text/plain
X-Originating-IP: [130.164.62.38]
X-ClientProxiedBy: SA9PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:806:23::33) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from quark (130.164.62.38) by SA9PR13CA0088.namprd13.prod.outlook.com (2603:10b6:806:23::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 23:31:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35503cee-c166-41d4-7465-08d880508c55
X-MS-TrafficTypeDiagnostic: SN6PR04MB4078:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB4078B383175C63D2968C75FDFE110@SN6PR04MB4078.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZp+bY2jCTTQzmoi6U+L5buC3S3YFxpiNxlXFLG+Q2q2G73G0iGCK6ggXDSvstNyOwtBeP1K0x9BbakOlwZhPkOgY6h+UqJYRnyYEMWej/Y3cssBAaYUDwVYSU/0WXG4si3YZz49eNDK2CfVI+WEk3lLOXzNkDPc7KZF7p/c9gf6G5mQ6NbTdshbsIUz1I0Z/oEDEjSWDK8ELxuMwF4Njylu2P8OP0ne4k5sAQl0KOaLGAC2kvY/ktR0BJz5Mg8Wy7zdGuRiTQNveoi+bzHmpHuSKd/2TnvDMSxZJUb1RlzpmfcYheD0oCDM+rstLRa5eRhQ/U1JNDcCu2xQ5dL6vwzy9UiqoE3u09xoASenve8WGgHVVxGh0fIN8gl8KUKYIb5CYBaZGZt1wckv9SuP2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(66946007)(6496006)(52116002)(956004)(2616005)(54906003)(36756003)(4326008)(186003)(44832011)(110136005)(66556008)(66476007)(16526019)(316002)(966005)(26005)(6666004)(45080400002)(478600001)(8936002)(5660300002)(86362001)(8676002)(2906002)(30864003)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rCJ4ABG//STKxeeRNgVeCionPmcwlKKGoWJ30JZEhdfJc0CzFEBYBKOPqaRKJ7OeQDu8/ee+AhKJYg+Aib7dqpQX1kwB03YJhrnQa4KuV7CM+q7O86l4wkbRImLKL3+BeNd2b5zKVuu6MmQwAxr4nu/aCg7HUTKXuogYy1aaCicA2lWZx9qlfaG+ZsYyuTA2xLApFGot6hKFxdHey9syqlgPt888odmifeQ8sYtEc50pEveVXHOsuaxVGcw3sO+HKKKmhilKmjfoiV02d6WsCVssNUq8/8OZD0EOuLDBN69TuPgTpeUkVEyDUoMYcH2iNH6mX2iMeQSOf6H9HX6YhEI2Tu0cRQtVBreRBxKjk4f5pZyrLxFmoB2b2XVMbbD2YMJpZLxzfhWVjytHoLFxUtpGvid6rIIp3t8PKZml0PcPZk7nJKHDcL5a6JG2sZH27sFWdLDSJFyB/wiWk3MaNJuL75pU0CmtqcBjAmbS0gP1M0EoXAYWu77ZN0BDGQ0NV29U8MisuNUb4AgoU9oz1dKOJnxUiPUK9gSnVnq2Twr79mSGQv3BKzvHKcPo4iURO7w7k4GECd96uVbUtRps/ANor846+Vw08obYS7qpQ+itmQbp799g2BA9E5KWidzb9Kto9H7apEJ8weqh2JiDTQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35503cee-c166-41d4-7465-08d880508c55
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 23:31:12.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaK5ghQkF3iIJHyZAJCkUtiq7F6LvntQCNq83gvv/x83mZEdKFuYWfDOTNPDSKnWVQLN3Dur9oJhpUjduEzZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4078
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030156
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

I apologize for waking up the futex demons (and replying to my own
email), but ...

Gratian Crisan writes:
>
> Brandon and I have been debugging a nasty race that leads to
> BUG_ON(!newowner) in fixup_pi_state_owner() in futex.c. So far
> we've only been able to reproduce the issue on 4.9.y-rt kernels.
> We are still testing if this is a problem for later RT branches.

I was able to reproduce the BUG_ON(!newowner) in fixup_pi_state_owner()
with a 5.10.0-rc1-rt1 kernel (currently testing 5.10.0-rc2-rt4).

The kernel branch I had set up for this test is available here:
https://github.com/gratian/linux/commits/devel-rt/v5.10-rc1-rt1-ni-serial

It has a minimal set of commits on top of devel-rt/5.10.0-rc1-rt1 to
enable the UART on this hardware and add a kgdb breakpoint (so I can
extract more information before the BUG_ON).

I've captured the reproducer, boot messages, OOPS, full event ftrace
dump and some kgdb info here: https://github.com/gratian/traces

The abbreviated OOPS (w/o the ftrace dump since it's too large to
include inline; see link[1]):

[15812.238958] ------------[ cut here ]------------
[15812.238963] kernel BUG at kernel/futex.c:2399!
[15812.238974] invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
[15812.261428] CPU: 1 PID: 1972 Comm: f_waiter Tainted: G     U  W         5.10.0-rc1-rt1-00015-g10c3af983f2e #1
[15812.271341] Hardware name: National Instruments NI cRIO-9035/NI cRIO-9035, BIOS 1.3.0f1 07/18/2016
[15812.280298] RIP: 0010:fixup_pi_state_owner.isra.0+0x2d7/0x380
[15812.286047] Code: 0f 85 a5 fe ff ff 48 8b 7d b8 e8 e4 fe 6b 00 85 c0 0f 85 94 fe ff ff 4d 8b 75 28 49 83 e6 fe 0f 85 bd fd ff ff e8 f9 f2 02 00 <0f> 0b 48 8b 45 a8 48 8b 38 e8 ab 1a 6c 00 48 8b 7d b8 e8 52 19 6c
[15812.304817] RSP: 0018:ffffc90001877b88 EFLAGS: 00010046
[15812.310043] RAX: 0000000000000000 RBX: ffff888006c52640 RCX: 0000000000000001
[15812.317177] RDX: 0000000000000078 RSI: 000000000000005c RDI: ffff888003e7f028
[15812.324310] RBP: ffffc90001877c08 R08: 0000000000000001 R09: ffff888003e7f010
[15812.331443] R10: 00000000000001d8 R11: 0000000000000000 R12: 000056469b8770e4
[15812.338576] R13: ffff888003e7f000 R14: 0000000000000000 R15: ffff88801f281708
[15812.345713] FS:  00007f0d0f4e1700(0000) GS:ffff888037b00000(0000) knlGS:0000000000000000
[15812.353802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15812.359547] CR2: 00007f2f6e5830e1 CR3: 0000000008a36000 CR4: 00000000001006e0
[15812.366682] Call Trace:
[15812.369131]  fixup_owner+0x6a/0x70
[15812.372534]  futex_wait_requeue_pi.constprop.0+0x5a1/0x6b0
[15812.378024]  ? __hrtimer_init_sleeper+0x60/0x60
[15812.382562]  do_futex+0x515/0xc90
[15812.385879]  ? trace_buffer_unlock_commit_regs+0x40/0x1f0
[15812.391278]  ? trace_event_buffer_commit+0x7b/0x260
[15812.396158]  ? trace_event_raw_event_sys_enter+0x9a/0x100
[15812.401558]  ? _copy_from_user+0x2b/0x60
[15812.405484]  __x64_sys_futex+0x144/0x180
[15812.409410]  do_syscall_64+0x38/0x50
[15812.412986]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[15812.418037] RIP: 0033:0x7f0d0ec6b4c9
[15812.421613] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9f 39 2b 00 f7 d8 64 89 01 48
[15812.440383] RSP: 002b:00007f0d0f4e0ec8 EFLAGS: 00000216 ORIG_RAX: 00000000000000ca
[15812.447952] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0d0ec6b4c9
[15812.455085] RDX: 00000000001a560b RSI: 000000000000008b RDI: 000056469b8770e0
[15812.462219] RBP: 00007f0d0f4e0f10 R08: 000056469b8770e4 R09: 0000000000000000
[15812.469352] R10: 00007f0d0f4e0f30 R11: 0000000000000216 R12: 0000000000000000
[15812.476485] R13: 00007ffdd55cb86f R14: 0000000000000000 R15: 00007f0d0f56e040
[15812.483622] Modules linked in: g_ether u_ether libcomposite udc_core ipv6 i915 mousedev hid_multitouch intel_gtt coretemp drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops aesni_intel glue_helper crypto_simd igb drm i2c_i801 lpc_ich mfd_core i2c_algo_bit i2c_smbus agpgart dwc3_pci video backlight button [last unloaded: rng_core]
[15812.513719] Dumping ftrace buffer:
[15812.517121] ---------------------------------

<snip> see:
[1] https://github.com/gratian/traces/blob/main/oops_ftrace-5.10.0-rc1-rt1-00015-g10c3af983f2e-dump1.txt

[16492.155124] ---------------------------------
[16492.159486] ---[ end trace 0000000000000003 ]---
[16492.159489] printk: enabled sync mode
[16492.167762] RIP: 0010:fixup_pi_state_owner.isra.0+0x2d7/0x380
[16492.173513] Code: 0f 85 a5 fe ff ff 48 8b 7d b8 e8 e4 fe 6b 00 85 c0 0f 85 94 fe ff ff 4d 8b 75 28 49 83 e6 fe 0f 85 bd fd ff ff e8 f9 f2 02 00 <0f> 0b 48 8b 45 a8 48 8b 38 e8 ab 1a 6c 00 48 8b 7d b8 e8 52 19 6c
[16492.192282] RSP: 0018:ffffc90001877b88 EFLAGS: 00010046
[16492.197508] RAX: 0000000000000000 RBX: ffff888006c52640 RCX: 0000000000000001
[16492.204642] RDX: 0000000000000078 RSI: 000000000000005c RDI: ffff888003e7f028
[16492.211776] RBP: ffffc90001877c08 R08: 0000000000000001 R09: ffff888003e7f010
[16492.218910] R10: 00000000000001d8 R11: 0000000000000000 R12: 000056469b8770e4
[16492.226043] R13: ffff888003e7f000 R14: 0000000000000000 R15: ffff88801f281708
[16492.233180] FS:  00007f0d0f4e1700(0000) GS:ffff888037b00000(0000) knlGS:0000000000000000
[16492.241270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16492.247016] CR2: 00007f2f6e5830e1 CR3: 0000000008a36000 CR4: 00000000001006e0
[16492.254150] Kernel panic - not syncing: Fatal exception
[16493.395619] Shutting down cpus with NMI
[16493.399460] Dumping ftrace buffer:
[16493.402861]    (ftrace buffer empty)
[16493.406436] Kernel Offset: disabled
[16493.409923] Rebooting in 30 seconds..
[16523.417644] ACPI MEMORY or I/O RESET_REG.

I've also included the modified reproducer that triggers the issue
below.

Ideas?

Thanks,
    Gratian

--8<---------------cut here---------------start------------->8---
/*
 * fbomb_v2.c
 * Reproducer for BUG_ON(!newowner) in fixup_pi_state_owner()
 * <linux>/kernel/futex.c
 */
#define _GNU_SOURCE
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <err.h>
#include <errno.h>
#include <sched.h>
#include <time.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <sys/sysinfo.h>
#include <linux/futex.h>
#include <limits.h>

#define TEST_CPU	1
#define NSEC_PER_USEC	1000ULL
#define NSEC_PER_SEC	1000000000ULL
#define NOISE_THREADS	64

#define FUTEX_TID_MASK	0x3fffffff

typedef uint32_t futex_t;

static futex_t cond;
static futex_t lock1 = 0;
static futex_t lock2 = 0;
static pthread_barrier_t start_barrier;

static int futex_lock_pi(futex_t *futex)
{
	int ret;
	pid_t tid;
	futex_t zero = 0;

	if (!futex)
		return EINVAL;

	tid = syscall(SYS_gettid);
	if (tid == (*futex & FUTEX_TID_MASK))
		return EDEADLOCK;

	ret = __atomic_compare_exchange_n(futex, &zero, tid, false,
					  __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
	/* no pending waiters; we got the lock */
	if (ret)
		return 0;

	ret = syscall(SYS_futex, futex,
		      FUTEX_LOCK_PI | FUTEX_PRIVATE_FLAG,
		      0, NULL, NULL, 0);
	return (ret) ? errno : 0;
}

static int futex_unlock_pi(futex_t *futex)
{
	int ret;
	pid_t tid;

	if (!futex)
		return EINVAL;

	tid = syscall(SYS_gettid);
	if (tid != (*futex & FUTEX_TID_MASK))
		return EPERM;

	ret = __atomic_compare_exchange_n(futex, &tid, 0, false,
					  __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
	if (ret)
		return 0;

	ret = syscall(SYS_futex, futex,
		      FUTEX_UNLOCK_PI | FUTEX_PRIVATE_FLAG,
		      0, NULL, NULL, 0);
	return (ret) ? errno : 0;
}

static int futex_wait_requeue_pi(futex_t *cond, futex_t *futex,
				 const struct timespec *to)
{
	int ret;

	(*cond)++;
	futex_unlock_pi(futex);

	ret = syscall(SYS_futex, cond,
		      FUTEX_WAIT_REQUEUE_PI | FUTEX_PRIVATE_FLAG,
		      *cond, to, futex, 0);
	if (ret) {
		ret = errno;
		/* on error, the kernel didn't acquire the lock for us */
		futex_lock_pi(futex);
	}

	return ret;
}

static int futex_cmp_requeue_pi(futex_t *cond, futex_t *futex)
{
	int ret;

	(*cond)++;
	ret = syscall(SYS_futex, cond,
		      FUTEX_CMP_REQUEUE_PI | FUTEX_PRIVATE_FLAG,
		      1, INT_MAX, futex, *cond);

	return (ret) ? errno : 0;
}

static void tsnorm(struct timespec *ts)
{
	while (ts->tv_nsec >= NSEC_PER_SEC) {
		ts->tv_nsec -= NSEC_PER_SEC;
		ts->tv_sec++;
	}
}

static unsigned long long tsdiff(struct timespec *start, struct timespec *end)
{
	unsigned long long t1 = (unsigned long long)(start->tv_sec) * NSEC_PER_SEC +
		start->tv_nsec;
	unsigned long long t2 = (unsigned long long)(end->tv_sec) * NSEC_PER_SEC +
		end->tv_nsec;

	return t2 - t1;
}

static void set_cpu_affinity(int cpu)
{
	cpu_set_t mask;

	CPU_ZERO(&mask);
	CPU_SET(cpu, &mask);
	if (sched_setaffinity(0, sizeof(mask), &mask) < 0)
		err(1, "Failed to set the CPU affinity");
}

static void clr_cpu_affinity()
{
	cpu_set_t mask;
	int i;

	CPU_ZERO(&mask);
	for (i = 0; i < get_nprocs(); i++)
		CPU_SET(i, &mask);

	if (sched_setaffinity(0, sizeof(mask), &mask) < 0)
		err(1, "Failed to clear the CPU affinity");
}

static void set_fifo_priority(int prio)
{
	struct sched_param schedp;

	memset(&schedp, 0, sizeof(schedp));
	schedp.sched_priority = prio;
	if (sched_setscheduler(0, SCHED_FIFO, &schedp) < 0)
		err(1, "Failed to set the test thread priority");
}

static void do_busy_work(unsigned long long nsec)
{
	struct timespec start_ts;
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &start_ts);
	do {
		clock_gettime(CLOCK_MONOTONIC, &ts);
	} while (tsdiff(&start_ts, &ts) < nsec);
}


static void* boosted_thread(void *param)
{
	struct timespec sleep_ts = {.tv_sec = 0, .tv_nsec = 600000ULL};

	while (1)
	{
		set_cpu_affinity(TEST_CPU);
		pthread_barrier_wait(&start_barrier);
		clr_cpu_affinity();

		futex_lock_pi(&lock2);
		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleep_ts, NULL);
		futex_lock_pi(&lock1);
		futex_unlock_pi(&lock1);
		futex_unlock_pi(&lock2);
	}
}

#define SWEEP_START	500000ULL
#define SWEEP_END	900000ULL
#define SWEEP_STEP	100

static void* rt_thread(void *param)
{
	struct timespec sleep_ts;
	unsigned long long nsec;

	set_cpu_affinity(TEST_CPU);
	set_fifo_priority(7);

	nsec = SWEEP_START;
	while(1) {
		pthread_barrier_wait(&start_barrier);
		nsec += SWEEP_STEP;
		if (nsec > SWEEP_END)
			nsec = SWEEP_START;
		sleep_ts.tv_sec = 0;
		sleep_ts.tv_nsec = nsec;
		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleep_ts, NULL);

		/* preempt the waiter thread right after it got
		 * signaled and allow the boosted_thread to block on
		 * lock1 after taking lock2 */
		do_busy_work(2000000ULL);

		/* this should boost the boosted_thread and migrate it */
		futex_lock_pi(&lock2);
		futex_unlock_pi(&lock2);
	}
}

static void* waiter_thread(void *param)
{
	struct timespec ts;

	set_cpu_affinity(TEST_CPU);

	while(1) {
		pthread_barrier_wait(&start_barrier);

		futex_lock_pi(&lock1);
		clock_gettime(CLOCK_MONOTONIC, &ts);
		ts.tv_nsec += 800000ULL;
		tsnorm(&ts);
		futex_wait_requeue_pi(&cond, &lock1, &ts);
		futex_unlock_pi(&lock1);
	}
}

static void* waker_thread(void *param)
{
	struct timespec sleep_ts = {.tv_sec = 0, .tv_nsec = 500000ULL};

	set_cpu_affinity(TEST_CPU);

	while(1) {
		pthread_barrier_wait(&start_barrier);
		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleep_ts, NULL);

		futex_lock_pi(&lock1);
		futex_cmp_requeue_pi(&cond, &lock1);
		futex_unlock_pi(&lock1);
	}
}

static void* noise_thread(void *param)
{
	struct timespec ts;

	set_cpu_affinity(0);

	while(1) {
		ts.tv_sec = 0;
		ts.tv_nsec = random() % 1000000;
		clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
	}
}

int main(int argc, char *argv[])
{
	pthread_t waiter;
	pthread_t waker;
	pthread_t rt;
	pthread_t boosted;
	pthread_t noise[NOISE_THREADS];
	int i;

	if (pthread_barrier_init(&start_barrier, NULL, 4))
		err(1, "Failed to create start_barrier");

	if (pthread_create(&waker, NULL, waker_thread, NULL) != 0)
		err(1, "Failed to create waker thread");
	pthread_setname_np(waker, "f_waker");

	if (pthread_create(&waiter, NULL, waiter_thread, NULL) != 0)
		err(1, "Failed to create waiter thread");
	pthread_setname_np(waiter, "f_waiter");

	if (pthread_create(&rt, NULL, rt_thread, NULL) != 0)
		err(1, "Failed to create rt thread");
	pthread_setname_np(rt, "f_rt");

	if (pthread_create(&boosted, NULL, boosted_thread, NULL) != 0)
		err(1, "Failed to create boosted thread");
	pthread_setname_np(boosted, "f_boosted");

	for (i = 0; i < NOISE_THREADS; i++) {
		if (pthread_create(&noise[i], NULL, noise_thread, NULL) != 0)
			err(1, "Failed to create noise thread");
		pthread_setname_np(noise[i], "f_noise");
	}

	/* block here */
	pthread_join(waker, NULL);
	pthread_join(waiter, NULL);
	pthread_join(rt, NULL);
	pthread_join(boosted, NULL);
}
--8<---------------cut here---------------end--------------->8---
