Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050ACC83008
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B0F206C0
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 14:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="ZemtuMp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgD1Okp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:40:45 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com ([40.107.7.122]:6036
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726868AbgD1Okp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 10:40:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPtJhHaelu07F4GA+vvFsb0F57Uy4OIDSNt5f3jgNBSmeeNhYP3Y5x0oQCa2RMidDL+TvQaBRDnfyKllIiK0g5UVKdh1A7ToHCpbfDhjzpl5qLOO3k32x+mGJe7Od32eliut3GsclqaFtoXnei6pevPdxHZ0MxxJ4BCq0xLa89NS8+Mh7Sh2QmlkID7gB8avziTegqYkq2sM6jTThrbLl47zCkyDxZGgboQ9updeWNNU17YTi5l16aS1yB1w2DRLtjHrk2si4bVO3jHP0Q25K/nJISq2Ys2vAJk6mLRi9cv1HltIS1VTWfdL/izhf2dT/8h25gMDaX0YiF0xWMdiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d2y7luRn1v72GzDL9mwgX0KrSjvVkRiF56KGG4MaNA=;
 b=ngQy2u7x0uEVdlI0AWeJ7TN8NAlxUhVE2w+MFs+MielnWyljCF6M3QTUZpPI7BA1owP0DxcMg+A/hysmlq6AMwEeLLO7xvkhRCANPa4O6TY7PqCwhV6I+66V0hJHKO5U/8SNtHDBD39GNYXA6Ib5bU8ntC+LkAMkKKlodzl7vCqO8MGT9kI6E0f6zxgeZcX8GAwKVHfaJ+1Xwa+kKjfOqoAx+Hit/QNd5UXPNkfgUYqgb3F5+HqIArVnigsQLxnJQMoNyOpS/UZ8QvKuxR+NzRaFSC3buRH36WGiAAnNY5cIyQzXN1BgyYcYqcNJipcpyaq/XyJ00EeyUBoK/TbfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d2y7luRn1v72GzDL9mwgX0KrSjvVkRiF56KGG4MaNA=;
 b=ZemtuMp/Ld+RNS3nnW/pRxtJi0XxY0I0NwsK+uqWy9VGi/Q7KJJh42A+jXNEjPI36lAIpdc0NvPKvUlYf0KcorUAl3SQAF1pRXa8/QTRDNAVvUTjZCzBmRdwlZ5brSrRdN13bG03hGMfv8pA9e5X3gWvy1oRydVulxnAZDHmVdY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB2384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:7e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 14:40:40 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:40:40 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Daniel Wagner <wagi@monom.org>, John Kacur <jkacur@redhat.com>
Subject: [PATCH -rt] hrtimer: fix logic for when grabbing softirq_expiry_lock can be elided
Date:   Tue, 28 Apr 2020 16:40:26 +0200
Message-Id: <20200428144026.5882-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.23.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:206:1::49) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prevas-ravi.prevas.se (5.186.116.45) by AM5PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:206:1::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 14:40:39 +0000
X-Mailer: git-send-email 2.23.0
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d915df08-6303-4111-392f-08d7eb821f7d
X-MS-TrafficTypeDiagnostic: VI1PR10MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB238459551DAB47FDE7E5623093AC0@VI1PR10MB2384.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(366004)(39850400004)(136003)(8676002)(4326008)(5660300002)(6486002)(7416002)(186003)(6512007)(16526019)(1076003)(2616005)(956004)(44832011)(2906002)(478600001)(36756003)(8936002)(81156014)(6916009)(54906003)(8976002)(6666004)(316002)(52116002)(6506007)(86362001)(66946007)(26005)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/GBx6MILFARVnpTCNP55DjDJainaEpkqV5oUX3wT12ZI6U2APJQEI2QxWd7riib23kWhq/oAOcu6u5k99COA/YR0Dp3F4khrMGg0pdWv5TqwOhDX6a9DaBilJp7slpO2I7MjlV0bzIa/p6U7WLXHiT9+GUU8pSHXd7IHw6HWlRrzxYOh8BThBdG3BEDvxx/G9gtFRZjhIurJ2i2VAileOAzacP2LuE0LAkbtM8Hg46xvtog9PzSF6y7E1HcXs1CKQEO+nxvXSq5ojJxYMDWx9IJR3wz0QW/6fXPTSpVfxl337ORub9Lrw0UIvgVKxWJuUzNA4AyVoiXmHXizVCVKGuOhPlIhSrn+2OV7C2xaxJ6lOG1H1+EPzQeQwtsdFYL/Vz0/mRJr8ZvjGeAuofVx9mc05QoD0cdJU+GyJd++FinvuTa+tSrGzIhxDjbgcNW
X-MS-Exchange-AntiSpam-MessageData: sgmDzJProROkRL4GGLTGaHOsaAPSI8DfL3cdQgraclLQ6bMgJ4loOo4Jkb4dwVo2B5WkA93gj/hYg/9xtY9+qByZMHASn7hHuzNVCBkVghHLzCKE1v4Wn3q9r7Sq5kf7iK9qnW2T5vaHAjh9UfUOjD2CSFn7Jzy4+L6tQvY3jM4NdbtLzP7lWComjXlem+KJAKbIYrJswg9bkN1EEUIrCYRar99Ck8IYj5wnu37oZWZmJqvYBHMDUIdgIBqu5h9mRbHi3b+0GIusXEhLpsMBD+Wh2XuYQUatC1ypXnpCc25HnnoxZ9Hh4qb8FcjDOegCYpmkVUPS9Bv4VbSvrkxZ503LpL3JUcgmr/u8WL17YYXt8yCG6hyizIRdjy1f0ZFbsjhpC1w4rIgheHz/KSrJycanQf6RKbAxNHb2RAiD4Uq/Qp28gHwoqRiyQLqAxPy9yR0P+YiRXgvkMZuK/kSBzHZl3QaGFS4PPJXRDc6TVX4JwXNWpyJ/DgeeHxbTdC4JOgTalXTJk6VFeRmreVclQXA0XtEsVyTbvNxCZsitV4huMiDoJFpXiYjoZJbajC5HVj+D+6lDdq4I+++/y+MiQ+AXPTRLjL1+IExaY9g1FAso1emio6Csbgf/f2f5ossvIYfXYWyFegWuT58X+T/clpXHgHgAyfgL6TQFDlCrNcg/ScZ+c5eCFBVfZUEnvhBn0aYwi/kQKGyUYXLqjuDOO4opnX5XcXHF1HlatUewT98pRL9FggOKwPST/0KFlhVn4Pn+XDQMO/cuVhcvGUvI3UDrIsgKgMt2N8+t4qkauKI=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d915df08-6303-4111-392f-08d7eb821f7d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 14:40:40.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tANEQ83UaLj25zWskdagyUa7w1wnh2W4tgjty8qy3WYZdl6oY5JvNB2KXfeq5zzpbczYdrCymumVDFFDeWbIwp2yY/4YS9J5poTtlDeyjlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2384
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Commit

  hrtimer: Add a missing bracket and hide `migration_base' on !SMP

which is 47b6de0b7f22 in 5.2-rt and 40aae5708e7a in 4.19-rt,
inadvertently changed the logic from base != &migration_base to base
== &migration_base.

On !CONFIG_SMP, the effect was to effectively always elide this
lock/unlock pair (since is_migration_base() is unconditionally false),
which for me consistently causes lockups during reboot, and reportedly
also often causes a hang during boot.

Adding this logical negation (or, what is effectively the same thing
on !CONFIG_SMP, reverting the above commit as well as "hrtimer:
Prevent using hrtimer_grab_expiry_lock() on migration_base") fixes
that lockup.

Fixes: 40aae5708e7a (hrtimer: Add a missing bracket and hide `migration_base' on !SMP) # 4.19-rt
Fixes: 47b6de0b7f22 (hrtimer: Add a missing bracket and hide `migration_base' on !SMP) # 5.2-rt
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
Something like this? I wasn't sure what Fixes: tag(s) to include, if
any. It's quite possible the same fix is needed on earlier -rt
kernels, I didn't check.

 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e54a95de8b79..c3966c090246 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && is_migration_base(base)) {
+	if (timer->is_soft && !is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.23.0

