Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28920C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Oct 2021 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADA761152
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Oct 2021 08:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhJLItR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:49:17 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:46892 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235306AbhJLItP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Oct 2021 04:49:15 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C6mnfY005890;
        Tue, 12 Oct 2021 08:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=JQIL3Ekyt1BDcVWHKhRCwGGx53jYVwrhbQ7oh7+oxR8=;
 b=Ickr/rYUrc0AYDAlOjArUrEPIZToBqma0/4E2Evrfa7+csANyOfozKVv5GC77KQiRNUv
 j3FTL3nAOvWGS+/hal60Y5Q7olCGQAHI1Z1yFu0tZQ5mHuR3ZShJXLPQMumQGI1CyZ08
 i6vjmFBlyJl5ETO7lGZp+vgKqBoozWlBZDRWER9rvLtxW618gCS75Z+emCoK8BP5EiXZ
 lmVef2UDVPq78AzbZ0bw6fQyNIzkIPAO7Q/rID2ttDqX4hNNejJ9T9VWOy79Z0t9XgZx
 VGlFm1ProoZGFLQc4DZnQexOZO8oQTw3YJN4ujc+J15KM3NSgfNox/43eityaYhjEODy ew== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bmu31reuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 08:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA0DXmFslKASg7ff3qQCaPPOhmFcLo9HtV6IO95jGN+Dd0XOAL/tbUoqF26K4Q0AUx4dP7/lGz45c2bUzv/BP/1rq9KzrZl5xj+TPN1VdVBw+eAkF0SO0ehfm79gF+S77nVodI1zfH6Drw9SRDcNPQmkz1lO38JSfx2AFODPanmscLGZkPHfZQ1mRSEksKT/i0YAsQBHaTy7UDzrPqoTVGYSwxyP01fH9AKzmj+2X99ElFOd053ftvcxSYpjOv7poET1G+czAyvmw9eCAb2yRVNaR6tPjTymp94sFSb9kF3J0v5Bn2dqkaR12zjN3tAJUzqunwPCFz0hm3lr/V/r2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQIL3Ekyt1BDcVWHKhRCwGGx53jYVwrhbQ7oh7+oxR8=;
 b=AQ5NK2mVHnPJUiPxKnysS/zrxU2/JH6DgISZpUgTb5YpbWLKvA9xKm3u0nlZW+dyCf0YjltfKEKJ8CgXCk2ks0hQMsgQqRrv/tiJFhcVd07QRg3f0jmNcQB0OPCEe8Rsix7YGlhCc/S6QA9OU2wu9bIqj/04kAzIbEEbPwXoDEv4vTDuKW0ud2j9uXipdMJikqfcBcKuMhxPyqvCQzJqkRIB+SgtGGOSJE46LncYHfil45BWr5Xq6swvgDq6h5mqbpyrdURWdRMFZW+qhfdjHhYrr86IbKoqRhfp4RodymPhGbZINx2/YkEcAno1VbDu2wqJWcKFU0N4eq0jeZ1S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 DM8PR11MB5656.namprd11.prod.outlook.com (2603:10b6:8:38::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Tue, 12 Oct 2021 08:46:32 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::1014:3f00:b74f:46d9]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::1014:3f00:b74f:46d9%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:46:32 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhe.he@windriver.com, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Subject: [PATCH] arm64: signal: Delay calling signals in atomic
Date:   Tue, 12 Oct 2021 16:44:21 +0800
Message-Id: <20211012084421.35136-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:203:c9::15) To DM8PR11MB5637.namprd11.prod.outlook.com
 (2603:10b6:8:33::5)
MIME-Version: 1.0
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HKAPR03CA0028.apcprd03.prod.outlook.com (2603:1096:203:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Tue, 12 Oct 2021 08:46:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b1ae0d0-597d-42f1-413b-08d98d5cca43
X-MS-TrafficTypeDiagnostic: DM8PR11MB5656:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR11MB56562110FEFA8E283F0DB3AD8FB69@DM8PR11MB5656.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAARKnXXRgUeC9FnFml1LrIjfwWC6a8iQZXtP7U1fiv1s2Hf1qk3hVtKvtlW1MW6Xth3zk2FJb4ZYDqr6AmuRKobRQx1CJ2tL7IJYiTlQH2CXOMM94MiXkdO/rRgv4PGQU4ntQXEon+jCZ0OZGJlCuBPTDxEKH7GfJel0p9P9HvcxctWt102rkC25m/JPXCf8XTzNbMka+ZX+abZe5pVWg+ohezSOMog9RKr+GYrvsXzJqEA5RbOVHolVmWn5e2ARVZyZPMrQRw7Bzp9CUwn1HS449sRgNZbQY12tNtOXvt1Bp8GU1L6rSWnHhpuFFWHujcZ/z5u23RLDysD6MiRg6xkrOy2rNV1Q7NMqKwKPaaJxj7qYqSxTInDhJUX0vLEpq1h1HfHpwF/uqvqSlZUDRwhWJNO2WDozNyoxcZFAijY74Nr+NUNNGI/hst6CEFWJhXl8bVTWOiQDaEDuEs+k0/97scyOGVMUmHlKqcTsNWFfVzFThxyEn5BwlqjV+Mhu2VWFNvYe3ej01d+XbbG56M2GkHfk9cL/nZgmxJjR/LwkNlR81Dc0lp+abZ1WMgxVvm2IaaWfnW+uxRMCmqh4KIqePAelosoJqdXaZwaHkv9MYEgTJhTdzCgXLlWBapH+nBb8C2h18YVipcpem6i8LKfovl44UE+FoC/XAic+g/MhJlbrtr+vnWFg4RAZMSN7MbKRRkPjpj0xQuQIvdN5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(38350700002)(66476007)(6666004)(8676002)(66556008)(6486002)(6506007)(66946007)(36756003)(316002)(956004)(83380400001)(2616005)(508600001)(6512007)(86362001)(52116002)(26005)(1076003)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ln5L5gvl9T1QZZKStA/X6yqv4HcPgRcZuB+k+qCsMWz2Zj8vWSbpU1kODSMN?=
 =?us-ascii?Q?8ZsXa350+m999TQZ3RVsoKNyMLhFBdIili7Cw5NMV50ty1AY/47MibRdyPA4?=
 =?us-ascii?Q?Vz3z83zPGU6yT9z+mokO6fvgQlAEg8nEw+rCFD9HX4nXa2Bes11ugw1mgRGu?=
 =?us-ascii?Q?mm8J5WzLoI08fgBlVLUhHdqsdaqJiCvq2WvnV+QputF55rklfUpqh5GbVC9R?=
 =?us-ascii?Q?7BTTV+bVwkBnIw3vuu7nZeQ8IU9/461kq8ocUqweI7jNEvN1d9cPjHkNPGAQ?=
 =?us-ascii?Q?5RKmDA+yQYrSCmpkUqCHG4LqbnNE8AbkVTYelPL3rGI64ZnYGg1M0qWJRfrj?=
 =?us-ascii?Q?tzH0gOirKh9UbfvywV9iH09p3HehKzC9WUmvkgNFRUboGQyo7HKpmUjOmJ+n?=
 =?us-ascii?Q?2vMt2ZITL4MxH8kSWUWrlUYJig4DVeyac96S6Jv86tAOD0u2fAWAq8RBD/D5?=
 =?us-ascii?Q?t1AqOBTdOM+0Q0liGyGqPmvqXaVJ1wqdQWOs4uiRy40mlOBJQKC5XlBWKax6?=
 =?us-ascii?Q?SeYEByUtQkbEhhK1T38KdWatYZM/1WB7UrHJEGBxwfS3EDr1AR3XZr8FmiGv?=
 =?us-ascii?Q?YN3yHmvzJ0ZWheqaEZnCS+yXoTfOkGIWeK/J2B2nMMk0yFRwJML736V1Noxi?=
 =?us-ascii?Q?0JruPtFRQTUFmYYbu2st6CM4nZW0d7B/tkCRmNJ3INDjzJF3ycMR+36RJaiS?=
 =?us-ascii?Q?t3GtL6/KgVtMKdd3jeCgrf/zjufEqqbv+TptpVWU/QaTtAU6aQ1lIOavkfq2?=
 =?us-ascii?Q?CsHZx012WwHe/1sD2eOaipR1+g8x+a92CdRK2raE83JPabnf1QYJf+q38hjQ?=
 =?us-ascii?Q?i2VVGf1WsIc9zLeI2rMTHsv1QH/2dEFaLik67GtXoBiL0BXZ/eJCt0KhvuFZ?=
 =?us-ascii?Q?1NMGJlkM+mXwQ1IbeRpMYy770+oHZoYWtN+aE2LO8Sw06P8pEjf+d5ucHgVJ?=
 =?us-ascii?Q?Mcy3VvhN8UY/V+0BtDhc9ZC64WJGoDNKhuBr+K32RC3U4YfxrMEBZpjrM821?=
 =?us-ascii?Q?gjkb4NSIa2KL9SvKsiFxbrwGwFD4DZQjD5/evJ9mgVxB2ZHnH3m1zQDVokbu?=
 =?us-ascii?Q?QrqVYqe8dewm9JhiD5c4CphpExa6H7YhhuqZ4rbuXfxHlluUxTz/ocxy3Y/o?=
 =?us-ascii?Q?ywkW4MCuVONMOEszb+dDC5qb8wEHTE9wiwVbLu+QmukSAQI48vRy6IOstAdi?=
 =?us-ascii?Q?DMrFU1FMo3ffrHYdru6STBO05BlmL2IIm+JfJI7tZweo0WxkNknZp6Jg/NE6?=
 =?us-ascii?Q?SI4cx3qZsEUB3LD2zlXVb4GbxLLVbGlnduWmAu2wUIawXY9J/zWdUuQFwWCk?=
 =?us-ascii?Q?mNHOxAG6pl7KOuFb0nMkCAdh?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1ae0d0-597d-42f1-413b-08d98d5cca43
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 08:46:32.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3o33uzzaXUgjS49sdaa2j09JjMV2w8sv3CL0uKOYt0GbgDI/9IAeuUPwZvZlzvwjBi7VB0Bt+9oUgmL97kB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5656
X-Proofpoint-GUID: NIWUZP4GCDZ32rxUNnm6AvtM6x7ztYEM
X-Proofpoint-ORIG-GUID: NIWUZP4GCDZ32rxUNnm6AvtM6x7ztYEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_02,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=453 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120049
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Debugging with breakpoints on arm64 and RT would trigger the following
call trace. When CONFIG_PREEMPT_RT is enabled, spin_locks become mutexes,
and one of these is the spin lock used in signal handling.

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 357, name: multi-timer
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
[<ffffffc01002f11c>] do_debug_exception+0x58/0x14c
CPU: 0 PID: 357 Comm: multi-timer Not tainted 5.15.0-rc4-rt8-yocto-preempt-rt #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x19c
 show_stack+0x24/0x30
 dump_stack_lvl+0x7c/0xa0
 dump_stack+0x18/0x34
 __might_resched+0x160/0x1c0
 rt_spin_lock+0x3c/0xb0
 force_sig_info_to_task+0x38/0x14c
 force_sig_fault+0x60/0x84
 arm64_force_sig_fault+0x4c/0x7c
 send_user_sigtrap+0x70/0x84
 single_step_handler+0x50/0xf0
 do_debug_exception+0xa4/0x14c
 el0_dbg+0x20/0x60
 el0t_64_sync_handler+0x110/0x1b0
 el0t_64_sync+0x1a0/0x1a4

Fix potential sleep while atomic in the similar way of
2dbbc3a07009 ("signal/x86: Delay calling signals in atomic")

Define ARCH_RT_DELAYS_SIGNAL_SEND to enable delaying action in
force_sig_info_to_task. Add actual sending action to arm64 specific path.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/arm64/include/asm/signal.h | 4 ++++
 arch/arm64/kernel/signal.c      | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
index ef449f5f4ba8..5e535c3e4926 100644
--- a/arch/arm64/include/asm/signal.h
+++ b/arch/arm64/include/asm/signal.h
@@ -22,4 +22,8 @@ static inline void __user *arch_untagged_si_addr(void __user *addr,
 }
 #define arch_untagged_si_addr arch_untagged_si_addr
 
+#if defined(CONFIG_PREEMPT_RT)
+#define ARCH_RT_DELAYS_SIGNAL_SEND
+#endif
+
 #endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8a9194ed981c..1d65f2801e13 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -928,6 +928,14 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+			if (unlikely(current->forced_info.si_signo)) {
+				struct task_struct *t = current;
+				force_sig_info(&t->forced_info);
+				t->forced_info.si_signo = 0;
+			}
+#endif
+
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
-- 
2.17.1

