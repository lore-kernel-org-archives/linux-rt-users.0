Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66370C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403E4610E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhINNpy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:45:54 -0400
Received: from mail-eopbgr1410074.outbound.protection.outlook.com ([40.107.141.74]:64787
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232079AbhINNpy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 09:45:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9uNy3QgSwnW4LCq2E8w9ixdX4jMiziz0k4kgpUI+MEa7Q5Q8Uf2+CIDmsEr3vb8rFhkqjbSiGatOtehduSXPWfhsbmuWM2oGFQpcnRyV3L/y/rnt7snIn34EqGrjDG4kHDzems9qjQeNAszm+FW4SWyPcG+78kKom1Z4LLtBqQ7EFKUiIT5pUphUffhT5xeGfWzsu1cPw8EOYuvGjCQmpWRshEG5eykeuRNOdeqx2SczDqxL25gzR6fs6afnVe4LJN6J2ocn4Rykkn6AEdfUpHFd8Ao+bAkn000OUVSgkuS2EJ7RpAscy38+OoueT84RfEJDwlZdOKaMO+pJJG8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LOtZLNJkyBt6d+cH7U7xVERKpZit4KvkJZjgOT4ncyA=;
 b=RpweM6d7ASwemyRn6wS1HyL6V51+TwpjdN41e1Lgor80FCnvJV3Sgt+4tmV+30MdH8f3lEgi7+1tnukHY30VPf/yPl+hrSf48ZXT0cXjL+BR3H4vK96U2Idachd86LpGTrF2qi82ve27k+XQcE31Nh21GVqFrBnZKGfQA2yr2+2TCSL77JQehb3zm91xItRa/GypVxF1yg4WyQ4W2iIetPi/BPdet48X+nTydPBOp32R7bEjIWClx7AwYKFUVXBmJwx5AleLugB85TOyMLQAlbjBaWPpmKbXtwWq/R7fu5tgNpzXGMr3wXNxY0dNzvuPdxV2nLaSMGv761i8U/pDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOtZLNJkyBt6d+cH7U7xVERKpZit4KvkJZjgOT4ncyA=;
 b=RQsUCPO0z9QObrnAowQy7TQwJ+zm4+lIjiz/qQVAUDZfkuuJrbhHOJ3nIayRABb2uFiosrxL8FS0CHrO0zGzPeZ+miiI3afzAIOBBGU3/VayuzZZ4hZ3gCRWAYgYZKVuYUUJqwxBEWD0qpE3mBuzSbg4u4TcwpWJSooNkD5Areo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSAPR01MB2195.jpnprd01.prod.outlook.com (2603:1096:603:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 13:44:35 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330%8]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 13:44:35 +0000
Date:   Tue, 14 Sep 2021 22:44:34 +0900 (JST)
Message-Id: <20210914.224434.2229368055920483816.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [rteval PATCH] rteval: stressng.py: Fix --taskset argument on
 multi node systems
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:404:a::24) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR01CA0012.jpnprd01.prod.outlook.com (2603:1096:404:a::24) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 13:44:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 321db7e2-73d7-4033-73f5-08d97785c9fb
X-MS-TrafficTypeDiagnostic: OSAPR01MB2195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSAPR01MB2195C9402DB6E4E186ECDBCABBDA9@OSAPR01MB2195.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAsCtw1bxWQ1spFYlXhQyGzg9uIpQN8vTFf+YbxCU8DRooTp20rtAAIAyGrt7x4fWpzzkjZXu3TGZlSgwI8FM+gdgCxUMUgp3rT0eyvzbCOVYo7nsZqZ/BZWlfXYaQApnlUDkNlrr/vXIuts/Z4ZxQs1z+WdZEHsKophgd5LRZ/cksNy+JDTdJ2uQyo0Sp656hIPs9q4Ha2f+O1n1ptl45XttBf0qJFju8T3J14c50OZeLVoj1tJy5RgbUyihI/P6bdgU8WhzWkbbofJ4u9bxUNygfC9p+GzyLJNNI9oA9be093xi/CKQkP8NO3B03NK8yjTtRW6qI8s4JQIYDJ0N4KdwCYFfJbM7WqPRSgC6l7H8+7tt7AblfhRrbC8Kig3DVcWIf6dm8YXor04kykivKO/xoX13K2RMMdkp7fHP/729atD73qkT9UdOKULwQ/xxXbGZCsaBP8TUbNYQF8azoKSApEtH6dNSBASZL4bEA3yERkk17hdBdSOavOMs1qjuylXyO57X+lg3XVM+jKPe1zw+fltMGO5vKz+SLxHHvgWNvnEu0UgjCrdhofMDYVrKol/EhFB1fClkUC3mdhIJwHQp0XLyKkcEF3tjX5gs/Sj6VVeGG5eINfjgIZ4385U/cPAS/RSEA8Y21b+mZwa5oQZcWZUyEUOR5bD3f+ap0hxws3ADpyrMeDdiUqXEkQtgDGHunerZ1PlAEKlxGuGO2jzJ1Ok/JBN5MQMrs6y/Eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39850400004)(136003)(366004)(376002)(8936002)(478600001)(2616005)(38350700002)(26005)(52116002)(83380400001)(186003)(38100700002)(44832011)(6486002)(6916009)(6496006)(5660300002)(956004)(8676002)(103116003)(36756003)(2906002)(86362001)(66476007)(66556008)(66946007)(4744005)(316002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzkrZrGnRxyBgvZyO87Kd0A/LwN89rkx3LRMc0z8V/4q0FJYPB+8UZict0Sh?=
 =?us-ascii?Q?6I8TUE/TUI1OOE43R5DsHfgq+fr/6QhfiVzyCOlhWC0iddreJIUWlldrnqYR?=
 =?us-ascii?Q?JvApotIxwIPyS7x9l9vLlo/kUfouQf/A7VpSn2c4YXZbGYFqUpHxINmnGahY?=
 =?us-ascii?Q?+rbMGuXas/pQxCBtkS1aFEa4Nt2LDbEDMJcHR2Ly4LJ6eFwP10NVnsS6tbeX?=
 =?us-ascii?Q?rfronQlZjxPtWPl7rmrSRMsS1uKJIeclDpJYnYqd3ulKLtjHhxOrGshY89vw?=
 =?us-ascii?Q?jmORNfNrZIhbpTq7QMA8cbsQqAvwnRbCCt/jNmu3WGjqHIqmF6NWsUK2BsOe?=
 =?us-ascii?Q?mjXm5dX7tjsVjPxKTmFDQEsqp9vmk0zWs4nG9wUF22phqjfa64Ekw6f387qS?=
 =?us-ascii?Q?JCSLAch2yCqE8XmAHqBJw0ipUA/IAA5tX61j278YRok6KSSCTnPInCT7Wg6P?=
 =?us-ascii?Q?GA6D3e2MAXT33ejSHSJBbAWbmvtt7wDjJBB+0HoUyssXBNViZ9SPQM50Edrh?=
 =?us-ascii?Q?hL+jNLHlOJISVR80IajzkOHTX3gEz7m63qhvBLRxWxucZ0XzqjXrrSID03l6?=
 =?us-ascii?Q?yXIMALHYdKurQ6tOKvb/KCpRcZ7c5OJS8IcAonrptyYdC9CS3+HDws44JuiL?=
 =?us-ascii?Q?bOAGeMuKfDm3UaiBHXbOTcTvk4/QdsPCiDPGzdJHlOVyItQ0iZRHkS5lbEE7?=
 =?us-ascii?Q?mxuFHTA2R4nvu3ugSMb7xMIHcp95NQOQmCaOpJ4KgJkhBh+qrofj5hW7EylJ?=
 =?us-ascii?Q?Luas2b+GrO4Jv1ZW2C+NPMqRri7IM83zyr00/+B5dfX1VfPzFCGWk9zXUL/a?=
 =?us-ascii?Q?iupEV2U9CR21Yzpwj20JkuLOnEjnFQx7xig5zpwNg6o3BUetSIbLZpRBnUYb?=
 =?us-ascii?Q?Y+ME6VEP1JYQjKrecroOGHNJmt271iZw0u3gqSUGgmuZM/sXTlSHHANQC4Fr?=
 =?us-ascii?Q?w7tB8AZ/lxiNAI4k+mRYuq+uEEUrYMi0DXA87F5dtoHjADbKM/KifYxqS1Di?=
 =?us-ascii?Q?HfwZGhDSlLDDM04vzF7N82KkNUo57mM9+2hkB/t3gUguiW4SVvjwe/nPUJIN?=
 =?us-ascii?Q?3MGiiGoUqI2IJE2wQX7p8wPqlkZAK6qJfKMTwjKSOPmgtBupqc046rlGYaS0?=
 =?us-ascii?Q?XaZH9WJi9+VTdHu1VJLDtDGV79/Jx/81PEbq35CwJfnWSHbrKD76YCd8ujHw?=
 =?us-ascii?Q?XzLrZ4IzNFN61xEgD/np4gHlFRWeUrZwz8vm+CcijeucCAhADnJi4MoZLMjg?=
 =?us-ascii?Q?Yl+brAyOIuOuHo3jL6JTeAYgx28m8IHEWfUQDCL4OKzenYosNrNGdwzxUnxm?=
 =?us-ascii?Q?UlauHaBohGGumsuDDyl1wloA?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 321db7e2-73d7-4033-73f5-08d97785c9fb
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 13:44:35.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwkLPidZ4Rf4CmKXiOGlaAymT/mb1ybwP6vjh28uy/xfczMB+eQ4xjcuzKDEtTNT/59Ph3Su5BVTFeQ0y8aHVj8c1E7ERBVP2qFzoWzcOGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2195
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Without this fix, multiple '--taskset xxx' options are passed to
the stress-ng.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 rteval/modules/loads/stressng.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 926de38..f677956 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -72,9 +72,8 @@ class Stressng(CommandLineLoad):
                 nodes.remove(node)
                 self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
         if self.cpulist:
-            for node in nodes:
-                cpulist = ",".join([str(n) for n in cpus[node]])
-                self.args.append('--taskset %s' % cpulist)
+            cpulist = ",".join([str(n) for node in nodes for n in cpus[node]])
+            self.args.extend(['--taskset', cpulist])
 
     def _WorkloadTask(self):
         """ Kick of the workload here """
-- 
2.11.0

