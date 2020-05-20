Return-Path: <SRS0=RNtb=7C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402E2C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF14120671
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 15:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="5Hg2acOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETPQX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 May 2020 11:16:23 -0400
Received: from mail-co1nam11on2110.outbound.protection.outlook.com ([40.107.220.110]:25237
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgETPQX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 May 2020 11:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STXCqklWEZ/1bgjQl38s3h4YLp4cBpp3F5/lCQaagUgOapNEvJsmj9+nkY2XtF9ELPP3ohdblNRgAr80yQXpnnKoM1Pcjg36isM7CC+DePksaLd4OL4GMekz4jF5moexWSUetPs2zw+JSBBvvGvBmoAkLxxyxt/IVyPKtD1O9mQrkWnRm8luyQ8wOk5Rn3Vv6+tc3xi4SPd4N/SrG5NHvBTLdyYIFHVp3APEkoe579ebljT/2OpEvVeELK4kvk7L3r/M9N5LDa++QjxUPs/uepeI9pGPlVZZjnHXWBhSj7SYohacEVsqKphwTn4ihP4u+PYU9BeqxJXTjxQL/Ui2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJfYBStTACbtDDkpFFDCOlpe16E6aBEuVGQ+s6lxEPU=;
 b=EiPmJrrXr1HJw+6s0pvar6Ij12PZwVpxoFpFdIivLeVXDs4t10/JghKW+vJNFCNta3PY7s6peEFqxyEH6By/a6lYM34Yzfe+H9oyCICpHz+2UuCQZX1OMw28oZDdAxm6cGYrG3ZNGD91Mn68BiAUwpBHo5NfyGNzsO0KVMWQA+9qq3Sln+vyhIgBVW54PPYtBBgnyky33tX6X43btEqhdpXFh+TJce0KdRN2/jh8VRVYBTO4Sx8XrGSYjbfnZu2AYsqJeb8wDkc4GoPgW4KnVq8ephQtPrOXAnFUGK/hAd8gvw8Nga93HFh55mAxJojtO7oTdBapQ53PSEEPHZOb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJfYBStTACbtDDkpFFDCOlpe16E6aBEuVGQ+s6lxEPU=;
 b=5Hg2acOsW9NmNiEILu6sNPdRPIDDIrJnZtOE6zl6VI5+zODrkB4CvGXmzNG0eI3xhPJ/30EigrRl08PIR/BjpWrW90b9GgQ97l/KcPaePVdjl8x+23Wsl0RPjwj9yJv8RLfltfX+iVrfz72GXgVwtkCrdBsZwUcMlh8TE7aBGnc=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 by BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 15:16:18 +0000
Received: from BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557]) by BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557%5]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 15:16:18 +0000
Date:   Wed, 20 May 2020 11:16:14 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: [5.4-rt] kdb: push 'bt' command output to console immediately.
Message-ID: <20200520151613.GA54006@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:404:10a::33) To BYAPR11MB3398.namprd11.prod.outlook.com
 (2603:10b6:a03:19::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR13CA0023.namprd13.prod.outlook.com (2603:10b6:404:10a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.13 via Frontend Transport; Wed, 20 May 2020 15:16:17 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78a2e99-a9c1-4fa0-ea13-08d7fcd0beb0
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:
X-Microsoft-Antispam-PRVS: <BYAPR11MB30625692B93C3ABA5E44908FA0B60@BYAPR11MB3062.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHumKHI0JTIpx4ZmRoiTbA4Q81Yf0Kw6NCyf8AJAAikkhJaQ9OTG7dGCIgy+9QEx+I9n9Rrfm+1cTVHrJVn/ZL5JyweJLmTuSDS/6o9LKXTRMK/gMym5b9W0RjnNNBpRNn/AHNRKoTyhF07jdoAr/BpRHY8yMLDkAQf8pf+QJfGJKfyIJME7vgPerCAyL7GwbjhNOYFHRhaYBl6RhyhK0WiQ+9JbiH+QiV8//AukeL0LaHZB4kt61xQPlscU0TF29EHfCgIwgFO/Vryo7+pEn1PUsti7rXflRLZHPpleeeehkZ7F1fLYkrdlu9sCGPQYSGt6MqzvMoR7296Q2+3Znj+6fxvg/iIHf89gaZ+8D4BzV3+dN/B4YcKgeELTY5PXfU598sB8hjKG1bRKURGhhctMxyCO14CWmjGwziSK4cp2wyB7Ut4OwJiKB8Eq1aT0KGCqGdCREKCeHJprff21Jvufok1LXYBDVICjEXoYGBDVOpyHsbng5hU8hEUzHnss
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3398.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(39840400004)(136003)(376002)(2906002)(6916009)(956004)(86362001)(4326008)(66556008)(66476007)(33656002)(508600001)(66946007)(3450700001)(7696005)(6666004)(1076003)(44832011)(316002)(26005)(8676002)(52116002)(16526019)(55016002)(186003)(8936002)(5660300002)(14773001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jmj9zvFV0MovM1c6yjYdUXalnuQC6OlcVz14IujyetMeMHrdwe5XqQmEJ7RL9ohMa/PYWBGbTkeH/0nI08eE2nleec/JmP7N4lqg4nDDHTwI2Hta+qT+zG3KxKmZqLcInMoKj4B0gPP11YZZpalRvvdHz6UiJXm+60szM8nZv39xmg1b89AXwVzWv1pJmYkqOopr9M8RP8+T6pmqwVCItfmhCzdGjczon47rr8aQ2qdUPOwQQHzKBzE9GgNYLXskNbvfhoRewsgd2MAi9d3mwUtgzBMUK4CqOK5jZDCI7FyOzqNJhAKcQYyqyxrCvdDfqjlnaDUiBh6YrRYGmcwcL2fC3Jx5kSdNlPa0tHgXikUPt8I3UXDTRPl4eLjP0h4NXovpWSxgKd2R/O/tIwa1luRrgLKtpQN2leaJPfat9xPMKX5WptHemAIrNQWCLlC67W0ntBIuAodusOyGAfas8AAsXkzkqeZMzCV7ORxQxQk=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78a2e99-a9c1-4fa0-ea13-08d7fcd0beb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:16:18.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGOptbxPOeN39TsP/Ue4EhzU4UsCcIaoDp/pTjkJt/c86iQcgp+/w/dF0LGrA4PmSW9Z9p9qFIFQysNabaVn1m3SFruWaZg9ZOkpzspnJNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3062
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[5.4-rt] kdb: push 'bt' command output to console immediately.

The rt patch for 5.4 and 5.2 broke kdb slightly.  The kdb
'bt' command now prints a single line then returns to the
kdb prompt.  There is no stack trace being shown.

The missing stack trace is in fact being generated, but
is instead being spooled into an internal buffer.

On kdb return-to-kernel (ie, the 'go' command), the spooled
output is displayed.

This behavour occurs because kdb calls a non-kdb function,
stack_dump(), to decode and dump the stack.  That function
uses printk's.  In an NMI handler (of which kgdb/kdb is an
example), printk spools all output generated, and prints
that spooled output once the handler exits.

To fix this, mainline has long had a tap in printk that
forces it to divert to kdb_printf whenever kdb invokes
some out-of-kdb function.  That tap, in 5.4-rt, is for some
reason no longer functional.  This might have something to
do with the printk subsystem partial rewrite now present
in the rt patch.

Here is my test sequence.  This example assumes one is
using a serial console not a KVM.

   echo ttyS0 > /sys/module/kgdboc/parameters/kgdboc
   echo g > /proc/sysrq-trigger
   bt
   go

Here are the kernels I ran the above test on:

   4.19.120-rt52 -- Pass
   5.0.21-rt16   -- Pass (*)
   5.2.21-rt15   -- Fail
   5.4.40-rt24   -- Fail

* - Passed on 2nd boot.  First boot locked the system up
    on the 'echo g'.  No oops.

I have attached a small patch that Seems To Work.  It
taps earlier into printk than the official tap does.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/kernel/printk/printk.c
===================================================================
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2054,7 +2054,10 @@ asmlinkage __visible int printk(const ch
 	int r;
 
 	va_start(args, fmt);
-	r = vprintk_func(fmt, args);
+	if (kdb_trap_printk)
+		r = vkdb_printf(KDB_MSGSRC_INTERNAL, fmt, args);
+	else
+		r = vprintk_func(fmt, args);
 	va_end(args);
 
 	return r;
