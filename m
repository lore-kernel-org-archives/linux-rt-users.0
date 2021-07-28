Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1CBC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 11:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C3960FC4
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhG1LUU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:20:20 -0400
Received: from mail-eopbgr1410088.outbound.protection.outlook.com ([40.107.141.88]:54080
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234517AbhG1LUT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 07:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocQ+nV16YLD2FaSMvR04gp12M4CMwuuRSt527TpQveq8Kf0tkqURfhSS/R9uEclRxGlBnLcNFwHPOER4zqgX8R8hINDUTmf/v4Iu81pcc7BF5m0QjzIgylm3C6wTs6Ly2bJ+py7I/bMGMFmQag1mE2V7Cm6kCPTOQVoo8Up1XFWl+VUreAddDhmtWnnw1HE7/R+QYZ5BH1Q6npsmEFrTUClygHE9/CWf5vA1uXVFGvvOv6LcUiLVmbdgHXOaAZJZ4cKaZJ4clmMY/k6GAOdftO2vOCKnmJa4cVxp1I0TWRQFkhFBgtU3wb6r1H1FcYePcfbaNBZjmi8f6erf+n1TMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+qbMR2rYjli9uBKxp+FFeWYGMyHfobSnBa8HjiyXsE=;
 b=br6tK491kVwUcrVQRNwVORCmAqVGgx+stwtWhTxDa9MVENVNp/HFdRwJPFtcEpuV6xFKCmgN4uiCv5wsJrxEfvzmtOd4C6j92jK3nUXKIaTLFKwnSmhe/XelmW/R+2UoyS4daIaCuHJcjt0T1/ZY3C+KYQjWbSz8cxbGS1HTOW5oZrcuSQ5uMQpfM2FD72/NVoKnUZ8bkfqmUZyM1M+eE2Nw0FUgOBpT3gcxLnMeyK0aGShKWGfBURaniHPOig/ZJuY1LfqS+vUegdg6dMRYbqytF7sAaGWmBDHfgyOIRrFs9j6cliPwCPj5xoei8vsNSd0+FNXzwlkutvwk5NuvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+qbMR2rYjli9uBKxp+FFeWYGMyHfobSnBa8HjiyXsE=;
 b=aVqMeMk9sxZF7ROIomj3ycJn7d9NXehwTA2cC9rR5PXVN8b11IaI0hDM6yyQkP4oUYlK0lF2eq9asQ44ZtpajelXFKdmXCB3v5Ps5VoSv6S3MS359ebXCYpoY2QmhCf1yoQyWAvSkPHvlpqHwnXO5ZV/sUvZSjQW2Dx9ZZU61aM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OS3PR01MB5862.jpnprd01.prod.outlook.com (2603:1096:604:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 11:20:16 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%6]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 11:20:16 +0000
Date:   Wed, 28 Jul 2021 20:20:15 +0900 (JST)
Message-Id: <20210728.202015.848207132223180831.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [rteval PATCH] rteval: cyclictest.py: Do not pass obsolete
 --notrace option
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::22) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR0101CA0036.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::22) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4331.21 via Frontend Transport; Wed, 28 Jul 2021 11:20:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c66f7c8-9bc3-4004-64f6-08d951b9ad25
X-MS-TrafficTypeDiagnostic: OS3PR01MB5862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OS3PR01MB586214A598329818AEBD12D3BBEA9@OS3PR01MB5862.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmSq01Zemc2hPD91Fb5g2ONmYGtAEdkMZLQ8TvM2vZ77LlkCombLbqSsEYhXFBqhDTw325M8nyYArYcZgq/mHEZ/6QFgjRfOo6bzcv387vu8NI+WTZKixDRin1smoxvD4tiCfvB1pdalIHKsj4OdSZDhofhhUnpYEl6fSRYh3PT4J35OtCAY81pxoT6IvktrEuvKhasXKHMgvN3tGbBfpN506wJv9K9C6XverQGHkF2fcgM1mA/TXOPK5+lfcrz3lwsIveqCM2+jzogmKKe1c0Z2CKCvRHYugt1uZJQU1Eox8lBwU34LwFDeylqrxAhGzJx6U147hBkYU18FSkMC2j4S8hIOaUgS7VQPu8KUmzGGQ9ios6bdwhzLVY5VxlJtaCo/4KatcAb859w7yAmwBQJHu1qXH1Jp5SmwL47HFu10+lARdMkiEcohwJRTCfI8vsFfNJihnWnsAn41Dck/60AIjAcmM6k0YmpXSv3JNJ11BweNgneBsiGsXx4sghPGydyZPOYfJYjs9LVfMBrhRmFKggJFfuR/kdGSroS/72qx8c0PxefAvH6F0rt/BBqQGxE4kOH6AaOaKMPRPafYS46E29g53CqMhzeOXWtkT3cIPH6XwdKo92Z2m7bv2Wcwlr0NJKJN2Flj5xoBfzelMnlOByTKlJi0g2FUaurATGroA/snl+L8maI9iFBaFx/YCGEb48DgdXWsFvT8Q3HLKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(8936002)(6916009)(36756003)(83380400001)(103116003)(86362001)(4744005)(478600001)(2616005)(52116002)(956004)(66556008)(66476007)(6486002)(8676002)(6496006)(66946007)(44832011)(5660300002)(26005)(186003)(316002)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+X925ZiMLBvOhYCR8R7spMA3WXe8fw7Ndw4Cd0hjWqRrqvU1w/MBa+g+3yO?=
 =?us-ascii?Q?aXwjEItOkYy1WUOs9zFT1l9zWKJyfHduTP9GVzkunHSLiy99fe6h9gSHjgIx?=
 =?us-ascii?Q?LM+3B5iSBIY2k5zLdHZ1lN/zaynnc4PZRGHb+RoqNVaecKj7h21PTOzjadzF?=
 =?us-ascii?Q?KWH04ppz0cZWGdf7j1f1QBwmoQ0JjmJxVEBpC0MCfqvkiwX18UTiIB+gJJus?=
 =?us-ascii?Q?BAUxdFQ7zL5AF9GoPMBWkGGCSGHkmfglVWsYztBBzFW5wBg/LnxEFZvS7eah?=
 =?us-ascii?Q?8BCtBJTk4236xw60ZEtz4MLQV98AFosAocXwRfWX4H03BVHogsA9KmGtRGmM?=
 =?us-ascii?Q?dN1Zv85M6Z/+wo2N8QsjuZp3Sea7Z6l55fGQXtxIGwKrt4SzNCqSg8P6/I1H?=
 =?us-ascii?Q?825A0m5pTLImjd3ET0Qqq+5i2cmvQYT2SASHWZYvLWAkOTaRmovufgrQYAho?=
 =?us-ascii?Q?egGqGIEUWPFk23bsk2Pmx990EoWClmPoVxcARlpOGc494atDcRQasZHKAkgg?=
 =?us-ascii?Q?V/iXq+zTDmFgUgn+qqHA+NGu1QzCB86b+P5p6s0pLVNVXmX2kV4WpU9d20cj?=
 =?us-ascii?Q?W8g+quLoi0AGJtTwOOUEeEuI4Ib1Nh3r4BtLWyo4WjdFCCHWGs9a2DRhfG8z?=
 =?us-ascii?Q?vEXG4G2s41EnI/Cdbb0TIjhkN2UpDD2hFwkQjnPVtuMxrnsUBVSo71jn/ze5?=
 =?us-ascii?Q?NQlDyxOQMK0loi++J0DNMhjM4KdkpQ3Wq41/McPgrVq95jLUxViud97k/zE7?=
 =?us-ascii?Q?ngqQhuv/R7ieB7t/xx4Zq3xqyiAHZK7KnFc6d8sc67rEXsxLiDxC8NORujxK?=
 =?us-ascii?Q?gCQqr+ZclBK/dl3r7Gv52UbhT9PrUW8x907XyWLSFvTNbSlXhbxMvfpSHVlY?=
 =?us-ascii?Q?n2LYxd0xo3+aPszeRjUzpuJtnelcOjwII+Gvrb8AusgSClYK7eh610YBrlzy?=
 =?us-ascii?Q?zzCbmcIKelnvg7/FrdQucil7IMTIIukSwf1w60DtgmZfso9lUqIfy4zRiHq3?=
 =?us-ascii?Q?0N9+z7MAwOeJtbiL9BaQaDNTJZk9svEekYcizA7zg/K3vw819lEOdlppBEKJ?=
 =?us-ascii?Q?b597+AJkawkFY59J7FA9pkHuCI2Rm6ceDV7JmFLv7QVdzVWwh9LQJBVSHJ7K?=
 =?us-ascii?Q?ndH+L1tAD9kpcckhFLF/hq0G2svQ9lI3Fku0p6GwkCfdZHZBHotl+8/yRmgz?=
 =?us-ascii?Q?6aKDPLb+tDsXzKDU7UWjGhKAi5qP0hRdVG8kYWVihl0hQQlYsWY+GVXpys7+?=
 =?us-ascii?Q?vJHKPZthQpUtIiCdlZEyAg9BoqY35FRRq7eWf3FkK305XSykvBpNwyLuzkLV?=
 =?us-ascii?Q?yJlxAEmIsPdEF+5ZP8nHkWgp?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66f7c8-9bc3-4004-64f6-08d951b9ad25
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:20:16.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI9j2FuLTEF9mlcC4hfS0SsQbnn/I0nbd5Jq0AdF8n+phOhk+Lx3Hy7l4kSzOPaunTp9rOF+ODNaFeFlRI6mtcPVzfHIzvSG284aTE7aM7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5862
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The notrace option was removed from cyclictest on rt-tests v1.4 in 2019.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index ae91dbb..b1755d4 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -286,7 +286,6 @@ class Cyclictest(rtevalModulePrototype):
         if 'breaktrace' in self.__cfg and self.__cfg.breaktrace:
             self.__cmd.append("-b%d" % int(self.__cfg.breaktrace))
             self.__cmd.append("--tracemark")
-            self.__cmd.append("--notrace")
 
         # Buffer for cyclictest data written to stdout
         self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
-- 
2.11.0

