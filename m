Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4C9C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C5D61260
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbhJGRBk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:01:40 -0400
Received: from mail-dm3nam07on2129.outbound.protection.outlook.com ([40.107.95.129]:60001
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242969AbhJGRB1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPaZFdGel/LMHq7SLgP2sX4tpZdNBsCTAsuYr7dHFYzkqA8dE8KluDnF6wm5DxqWKKt/AQ8MqlotGXB/xUiOoq3+USMzsrXVQdlZOiR4SbIBlWVxJJKVEiUdP92SoWZJaK+/RUzVuXsSAeZio7T85A1u0WsPfb+95HLydkEZjmOCT1zEYKIk4P8mk2B95mWXjASL+uVXxBOuaAzLNLaPi6uBT9nIn0He0BMcjHt22zrti+st1zOPSGXAhzkZK3E1clZ5h1DzazWrqYABB08BONZKKtbLtly8P5MaYuuR8vG1LkyllpUZ8biZ2tBO6jhqR5qaOT9l+01THZZRvpPJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vryVwLEzSlDT+d76omN28n7TrYXL9A61E7r8kFHOprk=;
 b=E15z8116DTTNPRCUKPPLw4KEDzw7cJHtg4Jbklz6E44vJ5DtcPfqZ4XRuhxiagKH1bfPaKXvKS7vvM2dDBykYuHjoYbRNbzdeaAiTv8t25HD4k3ft4dgsT+wQJOgArHL5WsVlcy2oSpfqk/7ObqTvw/E3Ny2ShK0TwGcBWEqoghoxMOKukZd2D1gXpImoyLOPwH/4LC1UXOrZfhE1MffLN/mLNh2ZDIYSDEJjULeWm1AZeXmQ1Xj85qzOeii7wq2JO3s/qiSdUlRE4BYvJ6p2iWPsruy6CfWBjmgowaYOo3kRq/ptMa5G//8CkmEQs+F/MjAMEx2HlzpHfnd3eX9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vryVwLEzSlDT+d76omN28n7TrYXL9A61E7r8kFHOprk=;
 b=mVjSRrTJyAR21U54hHckzIdmF7RW+XqtAU/16r/4lA/V0OUtCLPHczOnvTRJMTSQ1BRX27NeZBZPchHHO4ne+2Pt4ML61w2f87N12bT7VUIGq2OC29Vifjcrz5/kk9KM/JOJmC5s4xlA07MIlB5e6E+3YCxnazRV9ifWXOH3Veg=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB1718.namprd11.prod.outlook.com (2603:10b6:903:2c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 16:59:31 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::45cf:c7fe:9a7f:219f]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::45cf:c7fe:9a7f:219f%12]) with mapi id 15.20.4566.023; Thu, 7 Oct 2021
 16:59:31 +0000
Date:   Thu, 7 Oct 2021 12:59:28 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into local_lock.
Message-ID: <20211007165928.GA43890@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN9PR03CA0789.namprd03.prod.outlook.com
 (2603:10b6:408:13f::14) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN9PR03CA0789.namprd03.prod.outlook.com (2603:10b6:408:13f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 16:59:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b49ff65-82f4-44d2-4782-08d989b3d4c1
X-MS-TrafficTypeDiagnostic: CY4PR11MB1718:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1718E1275B5AB62A1184191DA0B19@CY4PR11MB1718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQvokvvrj/GuErLPDux7D5m4rrqoZ095JPpOS4090r8+GwGEG/pcLuINo0NPF/Zz08/o2kVle+ITruxzQxPr/36/oxrQu+azXyy/IoUqfKP+CHyVfriG2+nyHTkIHxZ1Tn8HyTv+tRCzX1hWWxpXj1QiX3uNt5iaRinJVQtQ9EAVlSDxcZomP4x55Wj23qh9rvqgwVy6umLBWr4BVZ40y+q66V7e5kC/Uk8EJLuxsBhA31zCmHieQBSFGyt9QuHoqL/42Z5A7dXlhhD9KMzJVWXdr/vKWi0x1WEeZGnod3fxUbV4hRbn3fuI7LSJAV/HKf3PJECIg/heAJjGXHUTOTA3nl09quBiyFyWvD1lXC8JP6KMaKU5+EtpCqiCtPoPXtD9uh403xoH4/bSHJY0e9OhqjlB/xDlFLGYF9FTk5ySr4bk08+rGv7JFHZ6orvzmvC5j2GSr8doBkIOSM5RxPlyOzLyKS2rwfGBtr8U8m9j5z3+u6OnEvP2W/T3C7lUKcJIpMLim5zyKHdgxd3CdpzU9cKkX92K8/pmkRy7w/SZ9On2zOnCkozyO1OmGBFFGgZXPcpr2AAOnfBiC6DNZanIYQX66Fc+SmUZyd++frUQ++huf9vr700SWLUGxp6O8cYdgXDZ0JvSP4C0WtjmZSDT8uaCcFjfDcQw7tB+ywEczUGJPct0gTHX/4udC4bJt6hfHKthGJlLsJ8Uv9IGow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39840400004)(366004)(136003)(86362001)(2906002)(44832011)(26005)(8936002)(38100700002)(66946007)(66476007)(66556008)(38350700002)(83380400001)(1076003)(4326008)(186003)(6916009)(508600001)(7696005)(52116002)(8676002)(5660300002)(3450700001)(316002)(55016002)(54906003)(956004)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhsmko599frZHh71iggSFbrub5tQ6OgEA6FjstjeUYLSMp2CX42sfa5J5X1X?=
 =?us-ascii?Q?EyaN/oLrRk90zCjS5CV5Fq4ofldUAEih7ny/9IpNETc+Qq9zJNTsSvhad8r3?=
 =?us-ascii?Q?owf2hjNRhvy58FQVK6Luc9oElAHX76qmliq5LuS0cwiCgfSIJyV8VzH3tGWI?=
 =?us-ascii?Q?TSLGJATQjbkx8tYFMXyLzHrg1VvjjyX7vCaLiZ9GXd2a5mNH6aAyoU0bFBlx?=
 =?us-ascii?Q?yg/IaMV+E5N6v9fRvOI/Djj6OdojrJYcKO41Fsp6CXr6mb7RdaNu3q/kYeQu?=
 =?us-ascii?Q?7mXFCLn/aZE0qf6VgU1LcryC6fZC8gewmoNdLfcztvB2oWGVQGVmu1wIthGt?=
 =?us-ascii?Q?ZCFRKwii7UqUim1q0HQBEvvk+hYhgGy4vzum2MnWe7Z61TmvdnanV2N5is9q?=
 =?us-ascii?Q?iPKkj+CXXWkDM6JoRbvtMF4Y+XGUQtxPyVrZnofU/9wu1Clf5E8hmb3sHAV+?=
 =?us-ascii?Q?EqN2/NlSmbZuB4wUAdxdm3+UTLxJ1XNHYEBoLT8OZuyXFqeXC66rXqlvgkWc?=
 =?us-ascii?Q?lR6/DvnP5K2fPfloEiXOgYiEk29XQ8CcKyVR6nEGcECpJMqd1zMDXIhf2U3q?=
 =?us-ascii?Q?O3pc7I+KYPwsYPVzQlowQv+GmhDcdeVYMiTrr8AyA1tEtdIjiVbXbZYE72ZU?=
 =?us-ascii?Q?JXQ1w5vF+nk+LJcHZ00A8ERQTZxXrNGP+TVb5n/ldYHmERNwR7ceVZ94vvi6?=
 =?us-ascii?Q?t/jb2+SBjiv0McJLFb2Fdw4rPgo/zS6xYyHX6zu8q1dcSyqTY7LJ6N3HCkZk?=
 =?us-ascii?Q?ZgAGzoxHjWgYDLioDFQYrdYlF25d//9lXMMpISRoRr390uhzis2nVrWo6s+t?=
 =?us-ascii?Q?jUN5Q3hRsmIPn0ewVkR7t/w2vEMr2cnzc/FH0Mmn4hCOYdZkLJGYPF+lsiji?=
 =?us-ascii?Q?rCWGKIvS6x6/o0MaA7qfgA0jO+kii6SQZ9wrMjvw3xZokmqzkZOBDuVlxTSn?=
 =?us-ascii?Q?55OKjTPtw6D0EhUbXpH6dZUYqprpheXt2q231F+JWp8sjbdOio3vuzNteZpM?=
 =?us-ascii?Q?hCK5/DA3jgc7R+hIv9DhiyrXpaxmI88iZISYRdLMZ3+gcC7ElJdHdtv2z7BX?=
 =?us-ascii?Q?mvs1h0koDAK/aZeCPli2iMbaUmvRL3JuPLxoSALmf1pQEyDWFWZ6X8CpXZoQ?=
 =?us-ascii?Q?GYs+5f65x7CKFCsCZ3232G1GSyg2Gktcxrhruc6o+PK6A2Ud8HAWI5t/FWiU?=
 =?us-ascii?Q?pThbbZFT4jAt4ZrjBMom4QR8pMxuCnRT1YieHTABJHsA2NGzRA+wcpj1dg4S?=
 =?us-ascii?Q?22gT9TzihG+xJFxfK8joRWOl/5MuB+m///tnAwrYeOU/beSjpTEPpCLhdA7r?=
 =?us-ascii?Q?IG0rjvrHs8UM6EguhLPFXaWv?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b49ff65-82f4-44d2-4782-08d989b3d4c1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 16:59:31.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz/lKWsWtggeNa7GWZz2JIwmKSzmbr8Ns8fc/gcJu6EW6RyhPjy6KogI/uemiR1SfOWV819cR+ml7SP805K0zJ0yevG8RX190cOvdurH43I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1718
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert IRQ blocking in intel_breadcrumbs_park() to a local lock.

Affects 5.10-rt and all later releases, up to and including when
rt was merged into mainline.

This problem has been reported in two other linux-rt-users postings,
  
   [PREEMPT_RT] i915: fix PREEMPT_RT locking splats (Clark Williams)
   [linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts enabled (Jun Miao)

Neither of these submit the obvious solution, nor,
AFAICT, has either yet been acted on.  So I muddy the
waters further by submitting this, a third fix.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
Tested-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
===================================================================
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -34,6 +34,16 @@
 #include "intel_gt_pm.h"
 #include "intel_gt_requests.h"
 
+#include <linux/local_lock.h>
+
+struct event_lock {
+	local_lock_t l;
+};
+
+static DEFINE_PER_CPU(struct event_lock, event_lock) = {
+	.l = INIT_LOCAL_LOCK(l),
+};
+
 static bool irq_enable(struct intel_engine_cs *engine)
 {
 	if (!engine->irq_enable)
@@ -342,9 +352,9 @@ void intel_breadcrumbs_park(struct intel
 	/* Kick the work once more to drain the signalers */
 	irq_work_sync(&b->irq_work);
 	while (unlikely(READ_ONCE(b->irq_armed))) {
-		local_irq_disable();
+		local_lock_irq(&event_lock.l);
 		signal_irq_work(&b->irq_work);
-		local_irq_enable();
+		local_unlock_irq(&event_lock.l);
 		cond_resched();
 	}
 	GEM_BUG_ON(!list_empty(&b->signalers));
