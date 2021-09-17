Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA92C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD3961029
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 10:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbhIQKZy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 06:25:54 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.5]:36637 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242123AbhIQKZx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 06:25:53 -0400
Received: from [100.112.195.149] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-west-1.aws.symcld.net id 8E/D2-01625-FDC64416; Fri, 17 Sep 2021 10:24:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsWi1/P8kO69HJd
  EgzctRhanJ/YwOzB6fN4kF8AYxZqZl5RfkcCaMefFQ9aClUIVPzesYG5gfMPfxcjJISSwklGi
  Y7Z5FyMXkL2ZUeLtjoNsIAk2AR2JY52TGEFsEQFXiRmP5jKB2MJA9tqXz5gg4l4SvffvsHQxc
  gDZehLzJ7CAhFkEVCVOnupjBgnzCjhKfGlJAQkzCshK9J04AjadWUBcYtOz76wgtoSAgMSSPe
  eZIWxRiZeP/7GCtEoIaEgsvewFEZaQ2Le7lw3CNpDYunQfC4QtLzF7xg2oOKdE97/HUON1JBb
  s/gRla0ssW/gabDyvgKDEyZlPWCYwis5CcsUsJC2zkLTMQtKygJFlFaN5UlFmekZJbmJmjq6h
  gYGuoaGRrqGlsa6xpV5ilW6iXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYBSlFBxU38H48
  fUHvUOMkhxMSqK82T4uiUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeDWzgXKCRanpqRVpmTnAiI
  ZJS3DwKInw3skASvMWFyTmFmemQ6ROMRpzTHg5dxEzx8Gj8xYxC7Hk5eelSonzNoNMEgApzSj
  NgxsESzSXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnztoFM4cnMK4Hb9wroFCagU47sdwA5
  pSQRISXVwKT66ufaBQsWbTKLXfd4s+K9tKPhqx2YXkfu+RreIxBkXXPHroo1akOFfP4N6QmGL
  xiUuSa/+LDl4J8Yrt0X365dnve2P/iE8v+9iZwyi9ZoXHXItgwMnljmvSolfttkbof1H0/qCS
  y/wK7T9d3ruImBgXWoxfWKa81dCgxGi57GGtX7B0xIYcjz4rS2y3pkVHabfbZynQW/2mvv3R5
  NObx/7WN0rSWN1vOfyD1sabZL38tz3am1c8Rce5REHnH2mG367bSI4we7z5XbF/WaWTRt3/Su
  1U/mXHhpNVuNzPaIh+vevn70sfpzUe8ZV/PS2my3s7Grfm3/a6Nu5Nx/Q8pl0460d7Exv7LSb
  2fvV2Ipzkg01GIuKk4EAIL8/JCvAwAA
X-Env-Sender: Walter.Stoll@duagon.com
X-Msg-Ref: server-19.tower-262.messagelabs.com!1631874270!446826!1
X-Originating-IP: [46.140.231.194]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32216 invoked from network); 17 Sep 2021 10:24:30 -0000
Received: from 46-140-231-194.static.upc.ch (HELO chdua14.duagon.ads) (46.140.231.194)
  by server-19.tower-262.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Sep 2021 10:24:30 -0000
Received: from chdua14.duagon.ads (172.16.90.14) by chdua14.duagon.ads
 (172.16.90.14) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 17 Sep
 2021 12:24:30 +0200
Received: from chdua14.duagon.ads ([fe80::4058:63e9:621d:cb5]) by
 chdua14.duagon.ads ([fe80::4058:63e9:621d:cb5%12]) with mapi id
 15.00.1497.023; Fri, 17 Sep 2021 12:24:30 +0200
From:   Walter Stoll <Walter.Stoll@duagon.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: [BUG] kernel/printk: RT-adaption of kmsg_dump breaks mtdoops
Thread-Topic: [BUG] kernel/printk: RT-adaption of kmsg_dump breaks mtdoops
Thread-Index: AderrfiLv1XFN2b0R32Idkomc0vbmw==
Date:   Fri, 17 Sep 2021 10:24:30 +0000
Message-ID: <c4b1a518b23c4507b3fc725cea005276@chdua14.duagon.ads>
Accept-Language: en-US, de-CH
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-codetwo-clientsignature-inserted: true
x-codetwoprocessed: true
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.17.0.41]
x-loop: 1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Effect observed
---------------

We want to store kernel oops logs on a NAND flash partition by means of the
MTD Oops/Panic console logger/driver. However, no log is generated.

We observed the effect with kernel version v5.4.138-rt62. However, we think
that the most recent kernel exhibits the same behavior because the structure of
the sources in question (see below) did not change.


Root cause
----------

Further investigations revealed, than the issue is due to the realtime adaption
of the kmsg_dump() function.

Non realtime version of kmsg_dump():
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk.c?h=linux-5.4.y#n3149

Realtime version of kmsg_dump():
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/tree/kernel/printk/printk.c?h=v5.4-rt#n2904

In our case, the the mtd_panic_write() function returns with error when the
kernel panics. As a result, no log is created. Call chain:
... panic() -> kmsg_dump() -> mtdoops_do_dump() -> mtdoops_write()
    mtd_panic_write()

Note that within the kmsg_dump() function, a locally create kmsg_dumper object
is passed to the dumper_local.dump(&dumper_local, reason) call. However the
callee mtdoops_do_dump() function expects this object being embedded in a
mtdoops_context object, see
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/tree/drivers/mtd/mtdoops.c?h=v5.4-rt#n272

This is obviously not the case, therefore the error. Note that this could even
led to a security issue.


Bug fix proposal
----------------

We fixed the bug locally by applying the patch below. Note that we did not
modify the kmsg_dump() function. Instead we modified the mtdoops_do_dump()
function which seems for us the cleaner way.


diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 774970bfcf85..317ecf47fce8 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -269,8 +269,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 			    enum kmsg_dump_reason reason)
 {
-	struct mtdoops_context *cxt = container_of(dumper,
-			struct mtdoops_context, dump);
+	struct mtdoops_context *cxt = &oops_cxt;
 
 	/* Only dump oopses if dump_oops is set */
 	if (reason == KMSG_DUMP_OOPS && !dump_oops)

