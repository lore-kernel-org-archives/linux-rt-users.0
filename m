Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56ACC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Apr 2022 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348694AbiDKQwX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Apr 2022 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbiDKQwW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Apr 2022 12:52:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2013.outbound.protection.outlook.com [40.92.99.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EA2DD74
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Apr 2022 09:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb6EFt0q37Z/cygOA2HV0XNbFRe1kq+/lHdlNcrkpNrrrqUmHXbMnUIlNYanj+Sxow/jtXhTvyf3hJUHzZzHbQxlfxOCKreOVy8+RLrNlKMH2ZSTtnfgzOVoD4XIic+tU4Gb+OB89P8xlc5Zxhq9NeztoPSYvobHim0SNI9+l5MV7P739V6Jxq3W7WrD2QzDpfrWanwh9mUnYxe36AqrYmUvcTXiGaWpWioj2gqUf5+Nud1BwTlcnzdgPYU9eQZfHxzICeLmZtyX1hlUc2s4sI6xC3r+pjEPkqzbw5rDyzAooIedu5cknNYFolTnSxoHGReZkDD63AHq2lnhDyhKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vj9kFkq7ygBvTHJ7U0IaKgA1toXWw4m9vN1x7UT4tQ=;
 b=fzbhKQXCCTDNrllrzkc2CQoys8HdpQ87lN33YvhFc6t/VLh3cL9mPL0HcjBUwrqdpwAmafhSBP1Fs3qohBnLxYiGQPhgABVa2+3OOFSM4Xm27aKtHl4grxBpaaY9WCXjEBm+lWDYayqMwf3emIEgO9sv6AdeTcKtA38yYpQlqJGyIIzWDjgq+WqPkwBbzkgpg8M7Z6fS5auTPTmbb8bePvcmNxo7WHs+FHWO/UCsEpMoxhTgcAvLAmLvsAQRNs1fpqUDfQLbBcguQS97+M8po8ecCPlLXm1LPYF3kgpa1dE//lQwjaQOo7jxhXZY85X0dzocOSVw686tJA+d0o+03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB1410.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:50:02 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bcb9:b9b1:d444:d264]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bcb9:b9b1:d444:d264%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:50:02 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] rt-tests: hwlatdetect: Add option to specify cpumask
Date:   Tue, 12 Apr 2022 00:49:01 +0800
Message-ID: <TYCP286MB1913F333CCBD550E845C4CFDA1EA9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [p1mPWe/jj9J1toD9FwilaDCiRq4yTqM1]
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220411164901.8203-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20e390ba-6d2d-4aa8-6db6-08da1bdb528d
X-MS-TrafficTypeDiagnostic: TYCP286MB1410:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vY6zumQHfdAYVrTfaFPS1DwIz0gde9sLPbi7PFCrwxXO7JzYUfqjEv5XUde4UnSeZYKBKfVP5+MYD655FIQLWIpskJVFZzBHteqSIYo9zSF+UeVjEfeqIkUlVQ9F5bBMQ6YCQp9zqlxEwSESrOfZZkWFlQjGxRIE6U7+eDVR6Rrwcmoyw2UcBeTwSv4/A9xnddD20j5MlG00R6vVYE/QZ9/aT9zBZWf/veCNXKyuTER28kLx8sLApK7hlEjyN6904mUd37BjUmDjEn6V7otD3orMgEOGVfTmu87GE91BrJUFX6poSZ5474dORgxaYo6Zld2GkWx9Nri4XJYLFqhO72QDcU6dR46u/VxekMs3utNcM06asZe4LVFLtJHKxIkTMU/2OQba6sqoTwmLG6CSlKaUAI9t0rjiJcDy5VtmEBG1szvY+nbLFYyxZ24dMESJ8IN3ej88NtPWo/Q9gT7pZRB3MgF3KlS0CZ3wI4U2zu3mkMiuZAYvMlgjSsgsGuH3hB4X9lFWs3DCw6KKbAIBvz9NHcv/NKXVCLaF1Y1e5j72DAegzAKc8AHejvVOlrIfMGuNY9TckIWgb8d7gblR6ywDTQeRbSWaFfj0QuMdEGn+jUlw44Df9l6/woBWrwga
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ApWPWOuzAQa7U2vxDyiuHHJF8xJtd6x907xRf4Aoc3o8vN0RKwZNiBOf8AC?=
 =?us-ascii?Q?8oeHPY2uJmqWcrdjjcLwYxIEN5WKYdryVQWy/f12YLWWZ2rBB7f832tdLZm0?=
 =?us-ascii?Q?42rIZ8r7XqxOOtetBBdAGplDSi46RLl9cSa1nEI1nhQX8PgNdyLDZsZhbny0?=
 =?us-ascii?Q?wDdnJEwhPX6DV3f2yLln7dt22Y2kKYoUsqZkNHB+glaQLTxE8iR1R3Ie6caZ?=
 =?us-ascii?Q?rHMdI+wOLssdHT28nNvRLkwQyFeb8uqlJrOEO5ovyQR5g1/qMcrUdbdDsA+s?=
 =?us-ascii?Q?2vR4AsPABc+Xxbt0B7HlYNHM0g1BYPYpYFFBxBhQ1xp4g94fzuczieRsTvpu?=
 =?us-ascii?Q?M/CyD4XOzgn9sQRPTaetMqoTTdsidIu0ONhRS2OJqcUtV7OndCmbAuh8ZESW?=
 =?us-ascii?Q?bJQBZ9/UDQPuxwIYaqagp6rO6Wyk2+Pu1Y6DX/mnkGu5ACGPlayJy5o6HrEN?=
 =?us-ascii?Q?n1zGPiF+C914M7kxrrhBQEX5HtRaXC9yYIGBazg7YQZdogaNIFbIZWlSKlC/?=
 =?us-ascii?Q?UnuNNELOPJNnwhURuR01xRq8WeCMprwGPG5cr+Qhe/HxtluWTIsAWtAoDdBs?=
 =?us-ascii?Q?8j2OBGiuYkjOaKrEJ7VnFx9uBmEbfTIojtJp1HzJF7UZUZ7sbixD+T+Aw5Ss?=
 =?us-ascii?Q?BrFDASElECe9m//Ltj+wOJyl7iuKenQ4P423W0T1j5Ck2Ick0O3lRT2OE+Lm?=
 =?us-ascii?Q?JVrAsCEc33eV4T2YaZd2zIt2tZRql1Hv0YWzUYJZLKKCqYQYaEGEQK9eHydf?=
 =?us-ascii?Q?+dFrIQthuvVEy7g7GjYdl6K36UrZNEaYRBeMP38W/yod3QZ4jVvcomHUZwR+?=
 =?us-ascii?Q?+clPjKjJ0DZuqG/lQ2EUCIZAaCPqv5I/3ruWqfsWXFAL1ACYASng7uJa7IQo?=
 =?us-ascii?Q?tPsp+DK3bfYctSOtbqt1zUnVxQPIqnhVEjxioC6kOQ73Xrf8+401/0V8dwtf?=
 =?us-ascii?Q?/YBDzIAbAPTb12jM6CIqiwmg73cujUZfEbkNdFEggxKd7muFTSOJkV8a03qJ?=
 =?us-ascii?Q?Dwg/7KFz5sIvWpffQff9SiQMfrC0zO8fXbMGjMNUI0Ii9nB8k55YVjgdUMtM?=
 =?us-ascii?Q?y9IhM5nZvQiRYvKVRp3GHP70xGtLXVWmy/DfldJR9ovLPHHjxc8XAtUletFY?=
 =?us-ascii?Q?RfiYCWEwQPCfoBpGLRI+BrtdHG2er+kbBpjBauJ4T08Xb1ZvalRWtOD/Zt9R?=
 =?us-ascii?Q?d6m38PPrWEd5cFAwzpYBEMCJC1mFaq7SsXjkAdHCauJ1uc2HaY0648uGtmTA?=
 =?us-ascii?Q?TsFRECximlsszhwxkPZ/BYKw2jJ2ihZiFPrTwIwxUHbVCp68cTW1COR6p73f?=
 =?us-ascii?Q?lJLYyouwa/dRuxc2+SK9w5hpBPrE1xkpfADLKMGixKA2W6SmEKBqx2W0m29E?=
 =?us-ascii?Q?cK0M7UZcGemJKsQk8jSqsCLboW8wwaCG6CiybXGnMdx7agDqsUP+uHv4+5dR?=
 =?us-ascii?Q?mhIWnwsHNTg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e390ba-6d2d-4aa8-6db6-08da1bdb528d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:50:02.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1410
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The hwlat tracer can be configured to run on a set of cpus via
tracing_cpumask [1].

Add a new option cpu-list to support the configuration of
tracing_cpumask in the format of cpu list.

For example, if we want the thread to run on CPU 1,2,3 and 5,
we can specify the cpu list to 1-3,5

The value to pass to hwlatdetect is:

    $ hwlatdetect --cpu-list=1-3,5

[1]: https://docs.kernel.org/trace/hwlat_detector.html

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 src/hwlatdetect/hwlatdetect.8  |  3 +++
 src/hwlatdetect/hwlatdetect.py | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index df33180..21d0fe4 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -88,6 +88,9 @@ actually sampling. Must be less than the \-\-window value.
 Specify the output filename of the detector report. Default
 behavior is to print to standard output
 .TP
+.B \-\-cpu-list=CPU-LIST
+Specify the CPUs for hwlat thread to move across.
+.TP
 .B \-\-debug
 Turn on debug prints
 .TP
diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 27c2b8a..9ef50f8 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -232,6 +232,7 @@ class Tracer(Detector):
         'window'    : "hwlat_detector/window",
         'enable'    : "tracing_on",
         'threshold' : "tracing_thresh",
+        'cpumask'   : "tracing_cpumask",
     }
 
     class Sample:
@@ -410,6 +411,10 @@ if __name__ == '__main__':
                         dest="report",
                         help="filename for sample data")
 
+    parser.add_argument("--cpu-list", default=None,
+                        dest="cpulist",
+                        help="the CPUs for hwlat thread to move across")
+
     parser.add_argument("--debug", action="store_true", default=False,
                         dest="debug",
                         help="turn on debugging prints")
@@ -476,9 +481,23 @@ if __name__ == '__main__':
 
     reportfile = args.report
 
+    if args.cpulist:
+        cpumask = 0
+        for c in args.cpulist.split(','):
+            l, r = 0, 0
+            if '-' in c:
+                l, r = map(int, c.split('-'))
+            else:
+                l, r = map(int, [c, c])
+            for i in range(l, r + 1):
+                cpumask |= (1 << i)
+        debug("set tracing_cpumask to %x" % cpumask)
+        detect.set("cpumask", "%x" % cpumask)
+
     info("hwlatdetect:  test duration %d seconds" % detect.testduration)
     info("   detector: %s" % detect.type)
     info("   parameters:")
+    info("        CPU list:          %s"   % args.cpulist)
     info("        Latency threshold: %dus" % int(detect.get("threshold")))
     info("        Sample window:     %dus" % int(detect.get("window")))
     info("        Sample width:      %dus" % int(detect.get("width")))
-- 
2.25.1

