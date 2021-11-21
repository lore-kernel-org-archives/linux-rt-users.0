Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8D1C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun, 21 Nov 2021 15:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhKUPkx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Nov 2021 10:40:53 -0500
Received: from [40.92.99.98] ([40.92.99.98]:17053 "EHLO
        JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S237998AbhKUPkx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Nov 2021 10:40:53 -0500
X-Greylist: delayed 851 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Nov 2021 10:40:52 EST
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmfnZdStvB59wEIVXG66oJCJrJhYXL3Fyf/cYKlec0AOllzQ5Gtr5UlQo06b6FD9f+715VeDuOieeadQ74r1y60OTXKbmdzVXnRpanfEPcXZVXHlwLPEbPrFTglULa8DgMptRJvxu02vDvlF8rMFQTEWWnRs0fVRoXscTKmtQmEkv9J55T0Ky0j5yPwpkEJX1B0Qwnlp34nPlS7MBp85EbzhPcB1YTGQdtJOAXmQrGWWq0a2gdlclsnSY4GZhGhNP0l/+Mlse5DUxQc+D2uOWn/oogAF7h4EZ0va43IEOvR4vzumaAqpM0suEG8oCAjDOUG+8Sh+T4BcmLmocrO9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20Uh1byzZ4Tg8DVHO4fALDyxDwAygxHhUvJhGRg5TWg=;
 b=odzHzfcjqwkmyuVFrwRVYMB5Oxx9048yIh6oG9JzgKRUBhlwwEQz/jW7Evck23+CBhNMEcN/XCcF6HIIN3oBducGtodYtIpUEqwQLw5EVTZErZM5no+b/ay9FWELr53xmRSMY+Eq4JlWbg3gtSHk7km+eD95JR/cthwuXEFraHKrH4tr+OOawA+B+iHoOIqk+HKFJ61Ycasmm0QMXxkcbSDDVhLl8z0tGz3xppvXq8x/wzbIFoaaGvGd8vTZu3ZsC39Hp6r8Uewo/y0U8SzJvggkVJhDuwlrY8rOcxS3U0m/eO0TQNCqrh7W2VfmejuBLK5iYHYTLeIQuwc4Dlm9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYYP286MB1716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Sun, 21 Nov
 2021 15:23:34 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2%5]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 15:23:34 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     linux-rt-users@vger.kernel.org
Cc:     Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] rt-tests: cyclictest.8: Remove reference to -n in --system in manpage
Date:   Sun, 21 Nov 2021 23:23:24 +0800
Message-ID: <TYCP286MB19132EF284A2822EB8C64055A19E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [BP/xJSEG184CpMlCr/PyICm1zD3aSzRu]
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20211121152324.633657-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (140.116.112.80) by HK2PR02CA0160.apcprd02.prod.outlook.com (2603:1096:201:1f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 15:23:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb077742-8f66-4ce5-5e48-08d9ad02e1d3
X-MS-TrafficTypeDiagnostic: TYYP286MB1716:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cfm5rRdnBPh2HGrPM8E2h5bf2zq/BcoqAJrcXmvuNTXFFbEQ3CmIVacXF7OjIwihggU+mj5aY2TIfpjY88LCev3PKqg8GIsY1lh3WWFiuljzLv647ZhEKDqTTQOyL52OkD/CpjsDwa9jQy5pMFy8QhBSq+p8wIOL02XRi9B/+FPDImA+f6uEiw8NODqFBl84en7D/raevcV1e6ui2fbqV8tHWS5jAFQ/mDyyW45csjxIZzPQSBaTmQBZgXbIiejLzGNZhOCvfiiKmVzHidyCGa6DyyLKUcnQqozAmNxUqKk67BmllsM697cYaOVD0CRc09D0g/vpddQVaRIm2s/GICBMooIvFNDyY8HQ91dlcgpyVSW5bhQcXDH2rMtHBML8eU49EMK1qhV4m1NRu4tg/wMX1B+nb7HnUa9aPZXfxIL2swKrsWB4gk/JilSTjm7IBmwa5+nocTA8zibqYr+0n8GjocJ08/buAS796Knb+8xoiwUZdNSryFC2t1W89BMEhpsgcb5uVio/Yw0wqe6Q4hyj6wlEDPtfeLSYOquwb+4lgGBUDqf2XIUsS+eSSAgA9LKfBV8yQ3k5+96u8w0dNg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T9cd7k2Lao1YLGckibYuKsUox5zPN9rELhmvZ6SySlZuA5QK5X5cV5lGHnilbzElcUX+TUO4hfgVjteokIY1jd97WNpy7CDABZfq9qZRjThu8trjyn07m2l+luo5JGTBfAVAxRScm5G/ZF+g/60Q0jevOyLsiz6l+xra3uQ6GCeWEHCLbfvCYcAdxNnVGGqFb8c/H/OBfGhMB5dRa23HGQa3HyrAaZA6LDrfCdUWs0a55p/ilxPYX8N74BhxIkYMbL10BE6DnkY8VNa51aYeBsQ19RxCQ6HPkssvPnorLO584rad0lJDwg7/sxv2lR3eLlcVuFPEe9UASlsRsXjChsiZ6Ew3NuBLANCp1WgGQ8QSEZ1xua5TvHxHZVGtHph/Mj1SJTQDYgylgf3nlV8GCxxc87AlWXoLQghuZurP9G0S5O5Zti0uZQ4k/kI3+8zgxBhLU04QclCdj+5w4CmUCYfGz/YWXVx4rwyKwA8safpyy64JTO8RQrp760zycuF1wON0iQ0IrAX0kL9YvClgYyyuvw3Z3+8o8shQ/Ps3FIdFNpGcr0Xr61ItQuyZd7Qc3WolKCLQS61QEVnPZlbez/t19dNZW0Q1TH2eoEp0SRU89vMHcjsH+bKw6BLW6D0PnA7JXfemPAREUoXXRAr5dRXvs+FySpVhZQD0107QFiO0U8qvYb+I8TZnkQni16LfcEnVfV8Hb8x2DUVMKl3RQQ==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-18f16.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: eb077742-8f66-4ce5-5e48-08d9ad02e1d3
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 15:23:34.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1716
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

clock_nanosleep is default now.
There is no need to use -s with -n.

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index dcae5b8..1cc72e6 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -137,7 +137,7 @@ Check clock resolution, calling clock_gettime() many times. List of lock_gettime
 align thread wakeups to the next full second and apply the optional offset.
 .TP
 .B \-s, \-\-system
-Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s in combination with \-n uses the nanosleep syscall and is not restricted to one thread.
+Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s uses the nanosleep syscall and is not restricted to one thread.
 .TP
 .B \\-S, \-\-smp
 Set options for standard testing on SMP systems. Equivalent to using
-- 
2.25.1

