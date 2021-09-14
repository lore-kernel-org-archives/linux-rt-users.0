Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36AEC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C35E61107
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhINNrH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:47:07 -0400
Received: from mail-eopbgr1400070.outbound.protection.outlook.com ([40.107.140.70]:17536
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232079AbhINNrF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 09:47:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdgimbtFTsNw1EcjPzGSqXUkJTnXslsrkpC+SnQD4pHkuUnljjaOjM/UO+p37sTbSc9NRkrYikQIVkpFaNBOYS7xWYOJtWBh2l50fkZ7EASGo4ndQ/PniobUwIkr6CG5njWVdckJk4lhF9W4YTuTheMzL5hSHs37AHin4LHjjlN+Z3dUXUOk/st+mABpkF0LDNHsH5RZok6NFqxbPx9XYnRyW1SJi4ZHQzH272tMPG2sf8O6nAKfjWePvi8MkAAKztuE81VP72syIh1NQmwnRccVcELhOQ+NJqtswspkVb9w4/bk09eUEd0lx9tp9eMtPoQecePTsM6zXCYO/vu2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y06Otp7ZpJ44ZRrgm2ilbw8Pd8YgSoBwYPMVVUZOevk=;
 b=cFyt2He627Rau1ythrh/CTL2YHIm6ofb46DQjuVZUcjHa6EbkaX+uL1+OBKXrgYzcBL8aqiEPlAign0N4sy3PhmOXMg7mpRvG6SccZCnW1efrmZLSAFomi3B4EGoAHGw0246tzbuUSdDXjVgORXxyBwz4n3AcKslNpgTc0n4z4oEjOzPD++a+hapN4icGaB94nrblyMLX0kCwi2PjMkVU0IfguZ7AayLFRtBfkhBnS3VushAg9hlJVQ+e/gRlRvT+6C8/nmcBHG8HQGWEvn4fXaJdOuZqK02Sm1iMti76Fk7wwtw/H5GiTaAXf33yGRorFpqGBTgUFxuPepi+xjNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y06Otp7ZpJ44ZRrgm2ilbw8Pd8YgSoBwYPMVVUZOevk=;
 b=Et5IMOHAx596mLT09KN55+1HBbObmEsR5ZvXO2MdqmiHyeGAaG0aGOkdA6PdhBb6DPs3tG6GSw72NXxPikCBxaetYMkA9gTUdYBZCBLHH7i7Qj80VhN8QD1uoVR1dzc1rulsUY79ByXVkZiTg7/TFVNtIhkQWiG/19Dfn79XQ68=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSBPR01MB2647.jpnprd01.prod.outlook.com (2603:1096:604:19::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 13:45:45 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330%8]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 13:45:45 +0000
Date:   Tue, 14 Sep 2021 22:45:45 +0900 (JST)
Message-Id: <20210914.224545.406981314952467276.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [rteval PATCH] rteval: stressng.py: Fix arguments for Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:404:a6::33) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:404:a6::33) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 13:45:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce5e227b-95b9-4707-3bb9-08d97785f3fa
X-MS-TrafficTypeDiagnostic: OSBPR01MB2647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSBPR01MB264773970DD8ECBBCC8E199FBBDA9@OSBPR01MB2647.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8PPPCbkwZ4e6DWVNbqgCPsOSZgnD7Iv8O+Dc99LBfGuksU02GKp25h2UfqNo8NXofu1tG8KZ08NgvjTEkEKl+VBrdmXo7aeqqINMQpDkW9K026U6zeGkegx0zg9LJcpBk49ALtwiOESA7cJXenVvDiNBx8LntW8HlmtXnaQeP5HGc3hG5stnjaTW9asoNhVPlLHF5IlAzcAwctObAurM/Os5TxOtvHpH3qIdqLTA3wLCxWVzb0LRSsBN6pJ25zerq9OeNtTqegj0FkzEUV5PDxg2xOyMM1KpwrSFTNs3LzfcoglcSNzCA+VVRfoPBTOLd2iFCzM/YQkOWmgIohbS6IQs3qklWZG75GK7hbxtgHva4GZqL0/QyCvJyGSjohzXzReLXRmoxQ98noe7GBry/vjMYONpahTXCnm3ZrVypphtxZEqFEXZuDdQV41le61U6tVeE4aO9LWznVlxe0ShvOnjmNOpvgl9bzwWcuOy+hqQ6ITOLTdEMAxs+8oD7W0RM/cfW0GUBfv2/kGO5rpSFtQp7c73SvzgDAWbwOGD5/2NGK+gDhx7pLA/V5lfW/y3sCVLg36rf8vcAXIKQSBm6RnFLuz0lgfwvoR494CgOnoaiOGqF42vV5KCGKZJSJJEiqGvrnfPlMVxz2m8xKsUjvxWCF9NWgYnoj7qdG0icCumxqZm5JMOtZT6OA3YK2+f/mpbEIn/VpnIiTSKI66jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39850400004)(376002)(136003)(366004)(86362001)(52116002)(103116003)(6496006)(8936002)(66946007)(316002)(5660300002)(66556008)(66476007)(2616005)(83380400001)(2906002)(44832011)(26005)(6916009)(36756003)(6486002)(186003)(478600001)(8676002)(956004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gxz2DNSuLZ0HaNhTYrwiheAzRPpUezteCJLZVCi4UFbOCdZezbamkJjUqKuL?=
 =?us-ascii?Q?zuvTytJDmE9fdpzHrk2GGkxnE3Avf++Uc5okLHM11xakNQngs+aLn3+6UzdD?=
 =?us-ascii?Q?CrenTiwM/AxKI6XNklhEZjulik8oQVCEWdHvQZMvvpf2TlURjORQJ0J9wJlR?=
 =?us-ascii?Q?9pa4lEJE+kyNWg7JHuUv9fxEwJe3vgaZVOcaqSXz7vrjzdycA554xUnbpxcT?=
 =?us-ascii?Q?ph+UL4okCtVMEQSRwRtfdF2VYpj3Wn9Hq/TECbDp5GLww3Dn29Eh+k2QMwu9?=
 =?us-ascii?Q?D4seIcDuRUORVwOkungMG7P2FM/qqaqHsKODB8+KsDL788Wrxqo+tzpXop1g?=
 =?us-ascii?Q?hLhqXan5jLZogmjRfP3kD7d5JMlgZ6mQwjUbdJ2/DrRqKSDzEWnA7WFmQV3g?=
 =?us-ascii?Q?Iwq1riXTE216I78a7aI8kBuArom38VLEI1HfQZhVgc3qiGP+CddYR1p54xG7?=
 =?us-ascii?Q?ojtLkSpRbRqyUE+wuaIOmjvO5Hf77XRUuPIFyQib/bu2PD1fwMPhaF4mFfXU?=
 =?us-ascii?Q?Duu32X78FtHZqfrM9oDgkOtAjB5QvsXJswaRoiv29UdqZcvRnHKaYeTskaDG?=
 =?us-ascii?Q?7a+duxXClsa5eNTrahvUvQ1PBqmiq70qciDC9FjQqy7S1z8UCdWNrDH79oub?=
 =?us-ascii?Q?Vj0m5hDiDnokEyc87ax5RKuDnZXjoYBFAKnipQ4bvL6i8A0PUFOAAIEZ3xV/?=
 =?us-ascii?Q?G/ewM7t0zxp+KVxW9hETnYJBnBokBVII9SHqJurx42dypSqcALrqLumPs/4x?=
 =?us-ascii?Q?hgtTbEhve6hxtvibyeUKfIv/LHs/WKCuBouFXq4oHdO+a7z7LwJMdIX0YXVF?=
 =?us-ascii?Q?edZUq7vW2EVkjYMl524fGy2ioJ8eYc6Spw40muXF1Kpt0MfdXyW9ku2HHsKk?=
 =?us-ascii?Q?8pxSoNgPvoRyUADYrHn159z/HtfJ6+XuMoMOKEgH2cDG423l8rHBdOJd1zpM?=
 =?us-ascii?Q?TfWZF1tXFw42wWteYZXE2w73WbExMLXuhGqXXeMVy2zOqbHw6B5UHd+g/IXO?=
 =?us-ascii?Q?BOg3zGNlO9Kt1y0pzqJABVDWzER1h7yU8JKXU5B+7sftD+NFoxZ+eRplA/5b?=
 =?us-ascii?Q?D6Tk6KRkuSjeU0aS0NUcU82cX/ixz3/9OnM769ZxMsPEZgE/d8UX1fu86Hta?=
 =?us-ascii?Q?RSItkVQP0DXSAXJwWkkT+6l29NwxFGHJCpibGz1EiCd8ayqeF6ymg5DECeKN?=
 =?us-ascii?Q?Eon5EnE+n9Nv9xUvBnIDV+CsPWlFiFcAphtd83iZ9Y9+/h203DTEcAAaLUPc?=
 =?us-ascii?Q?+hx8c/IMuW+KX1/0qCHjE6e5384j+LO+uRazBLT9/3D55LXUMOAw6/gprLAJ?=
 =?us-ascii?Q?YBURG2WlyAfulf+/G1c6BJ/G?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5e227b-95b9-4707-3bb9-08d97785f3fa
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 13:45:45.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tyuP9VVExGTzvzdgouAuhv2zRMexRgHrrtRikWeB7ud+jK5f2apLIgqQ76HcXqdLHGCDrq6itO1Wfy6XiWgRlDWl17aj2GWx+kRBe9PAyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2647
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make each element of self.args contains only one argument.
This makes '--stressng-timeout' option work as expected,
and makes '--stressng-arg' usable for multiple options:
i.e. '--stressng-arg="8 --memcpy-method=libc"'

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
change from previous version: split out fix for --taskset, update commit log.
---
 rteval/modules/loads/stressng.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index f677956..3edfed7 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -50,9 +50,9 @@ class Stressng(CommandLineLoad):
         self.args = ['stress-ng']
         self.args.append('--%s' % str(self.cfg.option))
         if self.cfg.arg is not None:
-            self.args.append(self.cfg.arg)
+            self.args.extend(self.cfg.arg.split())
         if self.cfg.timeout is not None:
-            self.args.append('--timeout %s' % str(self.cfg.timeout))
+            self.args.extend(['--timeout', str(self.cfg.timeout)])
 
         systop = SysTopology()
         # get the number of nodes
-- 
2.11.0

