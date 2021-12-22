Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8697C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Dec 2021 06:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhLVGm7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:42:59 -0500
Received: from mail-tycjpn01olkn2086.outbound.protection.outlook.com ([52.100.215.86]:39587
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233215AbhLVGm6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Dec 2021 01:42:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaVb66/hosj6StNlbQ8k5H4no42RY8v3eUn7uhK89YFtjpo4V9sqcsL0LXQi9SaCI8Kq08r7Qa63si8Qxd4IEkmjtjYTK1CuWXqOizjPe95CtkSzLDWWEk2QKNnebvHkcKjyDSkege27kM/3ySEpcDsjWWZOSeWlxSMmzFqcaNYCAC3fU+ATZA027a3zYsS/H2SLDgBHScUGzczZKOXYzkBMBIhSS0CMaNj+bS6pWPxuf60EFpJ0/K9Nvlfri8Q0IiseUacKYtVpKOvFPG2OlEa7McrGzUbX+8nyWv4l9Ke4Ert85ayHkRHt3nTAzlzMMKiveaX7nLmmJEzIE5sdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+xY58m/rcpQHBzDnTaAuoLjzLdL9QBrMDWmineXcSQ=;
 b=YO3V08zRERxYeHp6UCHjtkUrmLuP2wjuVu/KcTGbemWTDaeXaQHNyuL75Q8BaiQ82XLSYq0tOlUYRSWC9gstNEmK+BMzCf+MzQO8HHn2K2Fb6EUjmQf1dLdBj2PlqOaExZKd0fc5M99zWieTY7rjqhZQ/dT+Gvt2BfcX5b9iHl7H8+r8lq+v2iOtWznqla2AdM4lXRDJQupjFq0riScz90earHPz17dWXZsR2wRKSNsc56FchOaTdJdb2Z9Y+sxRevO56wqWFDgGnmt/eY3HZju+LXwaDfNjBHCg6iIYYCT9dloIBK0gaqUfJV3+taAnv9V1CBG+n9QJv3IhnVHVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB2416.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 06:28:38 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2%6]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 06:28:38 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] rt-numa: Fix the value to check in numa_initialize()
Date:   Wed, 22 Dec 2021 14:28:03 +0800
Message-ID: <TYCP286MB1913E08DE65A54E19F3286F3A17D9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [+dVgwdmlK4XXrmiuS7xUN67N4WwZbjD8]
X-ClientProxiedBy: SG2PR06CA0175.apcprd06.prod.outlook.com
 (2603:1096:1:1e::29) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20211222062803.5710-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ab42706-d244-4ca2-b05e-08d9c51449fb
X-MS-TrafficTypeDiagnostic: TYCP286MB2416:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rj4jeFEO/nZAbzL8PBmKCBEp+TcLmKwnTNREhOZSwo2P2+vBNwAmWhVbIhCjDmukTklKy/jBYiuDD1S4yMgGLfog9Zw5W76l6Gj6n334omByUXwoX6V9a6I7PbLQkqanGZ9m2/s0G43SLSOy2X39L+5NqzVrhMjl5lm0uffckz7KaQe3HYKm3L44Ns9bw15cDu1+WccTw00uGD7s3wSGMy44c1bQ7D2+45otlnDj4gE9mravRaAxDsYOfd6EDPRK9qbsSbJhqVZ+cVXzhvptB1kTholDxa08FdTpnocuTeiJlRxgMyAGdochpJzecKG2EI72WCjIWAjSjJ86NViUexuaC7LEWl3RLxRvRB0Ow4c+PazKmX4OQaUhYAdqI4Srs1VdBpUd0WCv5oIDhv5zoBsalaAjmMYSDd/6qeazOcb5H7QR1516dk+78eh3b0B0/xumU59mtrACEXJki5+pxgrYPrCAjkscuZlr5wsTJ7W7HHNlfnIuaLDKCvCztoQrwn1W7tMTT7Qgu9EVzJRGtZTMW1b2I7GZYSm3OQXXqKg9uU+FiaD47D400laVtreMfOZUPdPcF8TRhA/aUYXLc0d/MG2tt1FrefvT/BkkHtih72dybaV0hpYwS8v6Xwgt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTJ03b0HbtVSiQQwmsEMlK6taPp5/qZv6Lj9LuIr2LkU5lSwj/nXEv7y+T0v?=
 =?us-ascii?Q?Nw8hzh3CMJZVlp/vsVJEku68MbcV4mAKqc//MIPpwfHAaOZV6HWRB3V1xN9C?=
 =?us-ascii?Q?GMVZBllaCX5IFO82P9dA7ATyFKQSGfgBW9LiktT69eldLHc2uB56Z4h9nkS4?=
 =?us-ascii?Q?Jkjgg6ETvCOu8KuJhA9DHJ0rBOB4VQWXYPFMbusPgDyjja9sKz1YpJmWkgUO?=
 =?us-ascii?Q?oq6rgA21dV7Ub9ie1viD2FYebgC9/8KMLgXhOPIUHyB+2Yp+x8tXMYnymekI?=
 =?us-ascii?Q?+GxSQt30HZo/CLPybB4ty4I59Jb56J5st+d/E226gs1TVfMIisGXqdJn5v00?=
 =?us-ascii?Q?8Bt6gVXCXAAcMIOlimnKmoATpKlq55Ep0Y4WqCk1tx+iLPrngiG3KyHCCmw9?=
 =?us-ascii?Q?e4mRkPIPqTAPyspmcX+98oLCr/2V7IUM+of3dEHwh6g5puvMxl7c+jwNB2ep?=
 =?us-ascii?Q?B0A7Ia/bOopLVPXJ4IFIeUc7EVOjyeKLudYgQBTc62wdBzs6QW9/gLoN3mgF?=
 =?us-ascii?Q?2CNVhp0Wp4aTGvzgyVuLckO3KDGF9DtDgBFX9nUpy/7Ptxdfh0MqytxAaIkk?=
 =?us-ascii?Q?tLA+eB3SO6VdOpV/6gMi3QiwrCbQGKHsbJ8zCFM4uVzFB0q+94Ev1PecfNcQ?=
 =?us-ascii?Q?KiHfZ+pnChoyjSadSE4F6LWyGnyEKMcLOI4P/7oE84zZ3mNcS4SptQrs31MS?=
 =?us-ascii?Q?NRBh6UpFFaFhfA5D4B8URnwN47yRnpMOuQfgEGHqEpi59xZs6HDVSu73ksNA?=
 =?us-ascii?Q?x/DHyPTfiXbv4BviomPKqaXoxrNY9sII/lou4I9ZXeSC6ypjE2pYhwyXm7F6?=
 =?us-ascii?Q?G/e7c9KBDlPr/uFp+gr9YvWN8DgyVlFXFpwwr6IJb3egNyRUCdwGe7aw7F00?=
 =?us-ascii?Q?MsFTFQJmE0moV1A8PAgm2c7e59AHZf6UOfP0slS0VXbN3d8bpxSf8xBBEP0q?=
 =?us-ascii?Q?nAB5B/UyU3R02Ddp0kPKjw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab42706-d244-4ca2-b05e-08d9c51449fb
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 06:28:38.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2416
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

According to numa(3) [1], all numa functions are undefined if
numa_available() returns -1.

Thus numa_initialize() should not return 0, which indicates
libnuma is available, if numa_available() returns -1. It should
return 1 instead.

[1]: https://man7.org/linux/man-pages/man3/numa.3.html

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 src/lib/rt-numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index bb0121a..47a643e 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -25,7 +25,7 @@ int numa_initialize(void)
 	if (is_initialized == 1)
 		return numa;
 
-	if (numa_available() != -1)
+	if (numa_available() == -1)
 		numa = 1;
 
 	is_initialized = 1;
-- 
2.25.1

