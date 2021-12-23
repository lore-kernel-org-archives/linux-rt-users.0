Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B731C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Dec 2021 14:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhLWOBb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:01:31 -0500
Received: from [40.92.98.89] ([40.92.98.89]:28344 "EHLO
        JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S236964AbhLWOBa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Dec 2021 09:01:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXGIbSFuztKgxT/kRyHyY17OXBrBt+hjtPGu84HXwq/MBsMK3tOEzSccK8o1sT2saor495QjUpxL/HNuEvP9mldCf5AlbWoomzSzY+5JNKn/rA25D0rFM5Hc3y88J4oEktYSnmsHkTS3CbwDSf/Cc2p7gpp5kfFq+BUZFWZSy2r+5MlO2zuDvBEUKE/XGb/70Wgp1pnaebeOHfQ2t2e4PFFj36+0ojaxNsD41HXr2sFFuc8npCuMfcEvgzxHVdc1dNNyKSkCwDZanIWHdbnU4a/Tam+o1NKrK7GddOLf3QJnKJYoI6fKbJ4Fm7OjZha4aB8tT6dA7Ha/TFLPXWbGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWWB+Ulf3A+a0CB5cCm1u9kwI7bfHI17XFhGwOBTjBg=;
 b=Y5EWlPUU6R8PtwOgD4PJMgaN/sWa/13H3QqVkUguXcKhH7RM+ULHbQErEKbqsIGeDUuDvzRFPEZ9mYseuiq5V3dNRCiOd7DuVaQjvIgTPe/+pLA5TcYfnhioSEOCyKIxwV0OqCzyftrOhCEr7iDQnOHEGfFiAcdJidKj3zvn6l7Od0dUIyB3vfh24QgAK1RN8bDPxDKLipgXt7JlpD//KOlFLohPM8MsRfWmNTN4DOHs0IPc+muq+ncZyVBUuUSDUgJvJ259R/WBZk+/yd1k8IOrTFRtNYUCTcpDZskTVC5GBSF25E9A4yT2cYBnKJd1Inwpxc/oyEmXhp7R2+n0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB1540.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 14:01:28 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2%6]) with mapi id 15.20.4801.020; Thu, 23 Dec 2021
 14:01:27 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] rt-numa: Correct the comment of numa_initialize()
Date:   Thu, 23 Dec 2021 22:01:07 +0800
Message-ID: <TYCP286MB1913AD6234046FE1CF1D3877A17E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [rVleqExLJEUp5Pd47UCteuFfUC6Ros3+]
X-ClientProxiedBy: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20211223140107.12509-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b57664e-c311-47ad-5b6f-08d9c61cb6bc
X-MS-TrafficTypeDiagnostic: TYCP286MB1540:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mz3ZsrNUmnYolZcIjFVYciEpamr5UcpdIlFgyT9un4TX7I2B8RTt7xmMb18xhekT4J3BDL/bUBmqjUR3IeGHNyB1b4ERAZMzoMRsji4xlHseD0wHzi4AsfwnUkn7Zd7GW98UIOUMgFapLQeEALWnorEztra36njA5MlhxoJNJU2AyN+l4FpNh48sA/nD6exdq+h8FExLqYflcdEE+rz3LH6Qr4vlyGTpKj89QUAmVedfrr1deF4WaPbUmrRUjtIG4YWMjYNXBc0sv0fauWXBlMa+k+2mHpEiTZw+BEjJNfRa8LFLcqnsyfTFCAwvdCKhCnF8P5SagtkqtKvUFmsZ1+9A6M23gJsmZ9eU4vbooIDXHG04KXirFEE94DStH1bfr+ulXKqjUVsotuuLC575f4QSdojmXkFb6cROnitRZaQFEoKW7eLWAQtkaWzlGDUfzkyVtMoZurT7FDiK9vUYFf7cih/lSwQh+bHTCxe7q8jIgOPQSreOqA7Bcw+s7HBtAIz4/fKKHyS0QCwv9pIRrYvA2XLzvMLAOe2N5mIqNi1AUP7VLa+x2Sp7j7c+cE09KZ1Uj56CDNkOLzo6bl0L1w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MtO05hrGI0RAXrX6ECjqgCITV4UwnXLcFqJ3NKDdPEbRCxpIRf5ucZIgC5E?=
 =?us-ascii?Q?SmE8YQN1Mi4s4sVpnBlcqc2qfcm9ChL/i9nFjlAbiWb8gyOcM69bKrIlKrP1?=
 =?us-ascii?Q?iYy5HAyAEgqpRsLPRY8cZqJ22m5MgSgntTt54jGBIXS3zDnafJFZJFEqH58u?=
 =?us-ascii?Q?mIeKmSZYvmvyw2M8MKrtTbpzo+lcF/v+bXCiN+wlc2RyE+wtgnJ1uPa2Yiuu?=
 =?us-ascii?Q?ceQKXWpkPdD6u1Qfh8PwwANyEPQfCQ5sgoP0IDc4ULhXK3IQ61cGeA7u0cPK?=
 =?us-ascii?Q?Hm3EHhitLaruQe2eisO6uC0VTruESne9+3pnIrVuKll31d6ddukdFBzjQkuV?=
 =?us-ascii?Q?WcIMvYdQpQFCsZNY/ghNQ9slLZ0SyXaXiohPTZFy711W+ExcQbP6hT8ta8+r?=
 =?us-ascii?Q?Ap9KcNtYMCmmdg7XYWs4ZHeLniAN2gGeFAut9qNjXUpKhAfyL9RDkkZRHvD8?=
 =?us-ascii?Q?/ifa3SDIQ/Z6bDTsoI158MNk7o1mb2RBnJuQBb7VE9yH6L0v8ElPmcml+xYh?=
 =?us-ascii?Q?c9R8BGwCHwi1S5xTLBVmxEaeGDeXYu5eoqJG4Pa4w+M4eOd+4O+EbwcsLu2r?=
 =?us-ascii?Q?CAyGw7rYF2SKutmVPt/AeWVbRyOoV70SdJIwhG/tgTijvnqEA38oXrSVx7dU?=
 =?us-ascii?Q?+PZcyTaNVijTG8FoMyskMI3ZF3dNRpL/JgbpoMrci+15D5cRPrzhNpguQSj7?=
 =?us-ascii?Q?eKGfrr9AoCTeKb90/L/ez9ntWEY5fZVJ4O5JV+EXf+7Y4XuQ0bOhQbjf0Mo6?=
 =?us-ascii?Q?gyZbz99maQAj0hevAcjnxn5SxZyOfGEXPInL9DzHWSEikLsh0/pmadZtPJpe?=
 =?us-ascii?Q?ihugFVNB2A0R3Ev8kYoRAStXxoOUgbQDzgEgLb3hmmNyaUl7gEE3BX4XVUU7?=
 =?us-ascii?Q?a/G53ud7thyD5rS4+hpZEdsU19Yo4Lj+THPu44rYOjL248yeL2YApDgC64wx?=
 =?us-ascii?Q?BU++PB9FoX5XeaEBfstKQQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b57664e-c311-47ad-5b6f-08d9c61cb6bc
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 14:01:27.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1540
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

numa_initialize() returns 0 only when numa_available() returns -1,
which means that libnuma is unavailable.

The return values in the comment should be corrected to 1 if all
functions are available and 0 when the functions are unavailable.

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 src/lib/rt-numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index bb0121a..ee5ab99 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -15,7 +15,7 @@
 
 /*
  * numa_available() must be called before any other calls to the numa library
- * returns 0 if numa is available, or 1 if numa is not available
+ * returns 1 if numa is available, or 0 if numa is not available
  */
 int numa_initialize(void)
 {
-- 
2.25.1

