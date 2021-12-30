Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDBC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Dec 2021 13:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbhL3NmL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 08:42:11 -0500
Received: from [40.92.98.96] ([40.92.98.96]:30694 "EHLO
        JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S235159AbhL3NmK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Dec 2021 08:42:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jI9q8t6RCmcEHbBQfZmghis9eQoNWCWWd9Vl9ssxeUKY/vtLkKceMAn6wWB1UhVqTmLZUdstrRLKhAysZo4ixOOPP7We3rttIzx94jWDkV3+JLmtyuzympShzBlkB1U48dg2N5t191iNzhcMoQEH7GhjtczGc5HVbHmI/V+OOr7gh5+pDga2OzdEG+ubIVOU2RCCePilOw4HsrF5AFAuoiSfRwMHOeoGUYVG9jomr2sxeANr/4p34knaJEysxVmwJ7RmQdrVvVLoIZ1bQR4egwcPuNJ4jFLr39/dGQVvQdgBU9Cl1Bfa4NC/VgQiU0QwcAL+5pQTvb8ZXahDACRAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHCMXikrluKD6q1V4HfHnYvc+oTr2oisyaSzbbRnx3Q=;
 b=bHZlL7QpQQ6nc7bcr2KkCJ3jHpZ7AN91kroGPYHTCVrN+MdZX+7RBLdp4tK622A9kLKLHT22coqhvkYSm8ef1jdog6jLac6zNfHQutYR2F40shvuejZIsjCIOWSfEz/3ZQYO1gzC6wMqEtIWKBVIPqsXIFWZt7e96yvHitNWP2YuUYYmuY1w9DXIb24hFcQjEN3TsYdG90tjl9TVJnxGWUCaMApYVygEN45QlABx9IYKJZyG7l2oGUt9JdS4MLTocNNTP27MpJJCeJgtvno30OLxRm2sOS76C7Cnfr8SqqCnmjRzAXs1KCXlkOnlr9d6kYG/rxOlDrDcRyM1MWTFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB2001.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:159::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 13:42:08 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2%4]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 13:42:08 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     peterx@redhat.com, linux-rt-users@vger.kernel.org,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] rt-tests: oslat.8: Remove the argument of --bias
Date:   Thu, 30 Dec 2021 21:41:58 +0800
Message-ID: <TYCP286MB19139F2712AF29EB517F70FBA1459@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [qk4m8bdWD1QFMHphCwvL/D8jlGj8e3Fl]
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20211230134158.56514-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a6f5be5-72bd-4106-88c1-08d9cb9a2c7a
X-MS-TrafficTypeDiagnostic: TYCP286MB2001:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHB/bveuKKL+Dls378+DkTvRU3V1u0t8QwUMX0hglQRTCnTEVar0M28PzQQCQrLKcelXjG/pfL1H4b+cxIA0KdXVBshNpuJowoKhILkLwqNx5lFSl+3fy3/xKbCFaGwXGx0i064Ey2PAyDL39cM6ovN3WNmKUGXSXXd9B67/BDO4S2vMuyJA3Ca7TGFyIE87WAJCZ497lsbVJM8UqTgx3relYE6wpYtxUI+ZhD5I9sqHkr7srWxMLjhxX2nzvpRtbJA/H7hjFFrzI+E4ZKtJoBP/7sIvqhyU5mIOQBK0h/r5R2H9tTS/DppA2sG/dmxMus3HNqCoPhcR1fwazDWUJkuW2Gy8WA0m37DhPTUR6EjgV1brI5S7mmgt3B0l9ysYyDSIqppCf36+2H2qJduWCCQmGIk6fWD3OvwNXXCR30oNDsjLPqTRhK8qNl5BSMsmqr+q2btdChGCbkru4MP2zPmWkUa92cszmUKK8PQM1r9SPj2/TWL95nkYOd/9bSvYsnPluInYx7R3gYeVM1XlySAuvpPhR7X2Y7hx3+4LmrBDVnpshsykj/0tNuw4s99KlXsWs7+ggAwZ+KF1Pe2mvA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZspCa4Jb6wYbgVZGEm9iNAA2FM6lddxBvyWxgj8fhBaIJ9l5q7Q/e6/bLdj?=
 =?us-ascii?Q?D86EuCG1X4qE89H+JITUWPJZuWHwSh1z3LlWSSRPdjUX+77QV5AZdNK55j33?=
 =?us-ascii?Q?EasKU4PM8VO6J7dNOYT9dhgVGc7AYZ5O9ZyvdZya5t57OfilsU/MAP66JWYn?=
 =?us-ascii?Q?eOtD+1stb+2/cjo3jhV1LXq72WAYEK37WlZflRt5Q6evWpLHBB279EAhvALr?=
 =?us-ascii?Q?Pe3t7E0Q9jIcbBXu/6yUfCWc1oY4j7H1OMsrkb1zv+I4l7pRjp405aHyjLta?=
 =?us-ascii?Q?f28DPIqwKqlAKQczYwmzxXv9JuiPskuwyFNY4E2q7u0FJUcXx1QQcub3ts98?=
 =?us-ascii?Q?rrYTI6ymCzlRB4J16j2wBKyU++zhZaA7gunXeRCRmJxMlQidvH8NiiGac487?=
 =?us-ascii?Q?Rmo/ebNnfP4SfVVOxltn4vXCaPyTTHOD2AWdDMz5GHCNs9M3HYcTgljJSKF/?=
 =?us-ascii?Q?hYNVBU7Jtrz8nBcwAEDLpawN2gO3XsGbHQ23bqoNYCSLL+HDg9XNw9xf1XVJ?=
 =?us-ascii?Q?FySPkj/D4mgioVpqkViRJa1mfMsHUQiwo0Kq/il6/abxGDzLPwtYNDK5zjfZ?=
 =?us-ascii?Q?7byBV/GSqyj+4vz8C37Ext4pHK6sVNlk+5LVE8Pwdls1H9RrS1pDrrV8A5rh?=
 =?us-ascii?Q?wyQxMYyKdFiHqfFZVv3XOxfyKXxlj9y7M6BRvdGLlIx4K4qG7ZYB3uss2Oja?=
 =?us-ascii?Q?Kga8JYSy76MYE9QMeHhtHRG6B9iZ41TDsWLIdZxVdtE2pUWUjnGpGL40bL/b?=
 =?us-ascii?Q?vRcmArmf/5TGrO1m1l9Oq+pDV8H6KZT2o2KLcWfJlFJ1gG5VLgx0ZfU4bu/d?=
 =?us-ascii?Q?w9zG+YtBawR5vUKj1wwzZfdWbiBvgmpf4FuPFSIGApZmNW6UzC1XPuSJqx6w?=
 =?us-ascii?Q?CgLc5gECpatmwG5YV5sryRMa6S36wcBOX5Xj5vP4kr1xFAwUSFgUKFYWZDin?=
 =?us-ascii?Q?S/+63ioAJxhd8Uf23aLL/Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6f5be5-72bd-4106-88c1-08d9cb9a2c7a
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 13:42:08.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2001
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The option --bias does not require an argument and the bias should
be estimated later.

There is no need to provide USEC to --bias option.

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 src/oslat/oslat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
index 4b28abd..39b36df 100644
--- a/src/oslat/oslat.8
+++ b/src/oslat/oslat.8
@@ -18,7 +18,7 @@ TSC information and measuring the time frequently during the process.
 .B \-b, \-\-bucket-size=N
 Specify the number of the buckets (4-1024).
 .TP
-.B \-B, \-\-bias=USEC
+.B \-B, \-\-bias
 Add a bias to all the buckets using the estimated mininum.
 .TP
 .B \-c, \-\-cpu-list=CPULIST
-- 
2.25.1

