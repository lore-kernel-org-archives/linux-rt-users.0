Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB7EC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F1660FC2
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 11:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhG1LVR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:21:17 -0400
Received: from mail-eopbgr1400084.outbound.protection.outlook.com ([40.107.140.84]:47808
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231876AbhG1LVQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 07:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcMgPF/5JwSfPPu/Bi4SMn2FY18WS90scI3tnAdblgC/OAvBwfgAjvuSzwXvDiMgt7jCqCOtoABElvBx8Ww5YUg/SnVtBSrpRGyyxSEL2mq2TnMm0Azzi2NRbcms4bMFEjKATzVvXD8uLu9+psH+s2yN2qB0txxjulYNWyCKJQSibxJpEprk/kU71Ou8/s5wt2nnSq5Prj6M+V71j9tW+HLqwPxA/GqhbcegXIQZHdSDDHY45YRmvRF/BV71fshZs5YcndcWJH0ieDOSUcOismAIjq77rPEiWsxTC/9kswpEH9oGaoJT/K+Me38UeICn5uNJsLuNnPdQqbrTK2ExIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCa4wVhXIB8bxMc5p+31w+VddO7ijRuh6e3lmwAdc0s=;
 b=SfPz9sWBgrHkwrl2Gm9uIEjWRGO2FwtoF/PK2LC/bTpzVPg0KVSY2WWzU8q3jtXS0eo5nRA5lo/lRd7l+0A9PWFod5RCW22qTXhxUwmky2n0lhw76xZQ/VgdWmxjJdB6OAi2iiUrbsveFOB0SCI4P9+VRmMg4Vx2AxNezS91rl0BQOR/QAMo2Eh7M8ot1LCb9YD4S3N52oFTnAVnEPnggSvtQ+TceSx/4ayKTv5L4szAFtGOLcYXjzS/y7vii525jU6yGwdnlTVU4oFSrnCB3QyOph5ShK5aXd6OHMt9I4XWLraJbqdFReyegOy/f0WwXhkFhf2gqOWxXkaFfYbO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCa4wVhXIB8bxMc5p+31w+VddO7ijRuh6e3lmwAdc0s=;
 b=UrmCDYA3jMnv0fd0JHfVW1CSHjQup6Bl3WMIvdYDabt34Ez0pSgbqbDdS97CcGzdb9Do2HWijW2NH8OfWanglKxG5HLCyyzMeqB+qua+zVBgIIAw4yB4U1rbkBhH4jfimmZIgeE1ZA9yv4vGswS2nbUmJLlXlQNknbNjvJqJdTk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OS3PR01MB5862.jpnprd01.prod.outlook.com (2603:1096:604:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 11:21:11 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%6]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 11:21:11 +0000
Date:   Wed, 28 Jul 2021 20:21:10 +0900 (JST)
Message-Id: <20210728.202110.2259637121232602746.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [rteval PATCH] rteval: cyclictest.py: Fix config check
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::25) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR0101CA0039.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::25) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4331.21 via Frontend Transport; Wed, 28 Jul 2021 11:21:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95498e25-e95c-431a-5e3a-08d951b9cd93
X-MS-TrafficTypeDiagnostic: OS3PR01MB5862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OS3PR01MB58625B80FB15748CAAAFFA08BBEA9@OS3PR01MB5862.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8tUHnEjsGc3P+04mg89ZJ4L66HtAK4q9PacqYj++EQJgznX08MBjR/UZ/K5PjO6fRMeU1DGV/gPJlqJbBYr+0u8sFJNmu9HvE7FkohuWn9yeBwPpR+uFbGdNjnur2D+rwOlfE0h/I43+aK154X9hzKAgvibDi+JVuHgIy3KhNUCHj6A4x3N39GKbDQ/160ttSOkEDPrufH3UpNagVX0H4j7hTux5JMq1epl1SrZbRe/CEvygp4qJgngnfbpA3SWxBL24uM/Oi8AkUxj2d+K1P4ykhhnbYDvLDBfXHlcGs7aZO8NluGaHUzWe+PiUE93qlB5ZK81O2dQkyHW/ci0sfUPpbGTlkW2drq5uLGJEgjwh3NiuSuNz+ZOBFUF9WPRtDbj60dXnNEs1qT1POnA+B9o8VY77vr4jfNFJAkMAx5fce95o7aqnsR7F3hG5lOx8J8TFLt06LIWmTdPhEtnIVxWvF4ZSanUFy4+BuD0XhindroRHMPZriKmRAh+ZnIU54F4+3kL2pU7bwjmYnMu5Dy7ULf/ed71zAuw+WjyDTPf56wLIWFppz1jXf2EL1WEn02WdC6d6GFk3dFM4PTbLRhOvaJCxIu5awGKnKLr2v+yXu5OLYZS1j/huPMpsbhSK0dqpNldtEaFT37N3OQVdaMDeU2DHJWnCIuPXLsaCp9fDy5XzE53t6x/mYRZFJ5BxZhl7bc5IPnV08k7vRfl1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(8936002)(6916009)(36756003)(83380400001)(103116003)(86362001)(478600001)(2616005)(52116002)(956004)(66556008)(66476007)(6486002)(8676002)(6496006)(66946007)(44832011)(5660300002)(26005)(186003)(316002)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PB8bAr7O3rZaUc359fWeEnJFarKGI22tetR837r2jWmqbJw1o+BRSSGo27i?=
 =?us-ascii?Q?1Lfhm3jLqeBUdCmvDQUlbGkDMLkjvJxTtuy+FFYu+paCOp7tukW009ahU+dc?=
 =?us-ascii?Q?KGCzrtxR6O/gfBdFUgZhnlWV/H+keFi0jL2u1xTBw7+K8jmzK+zSASbXHL53?=
 =?us-ascii?Q?d0BHmu4XL+3goKFkkixvjjPTiQiwK9j2XT9ZIePymbA95La0FGmAJ5mDFmnA?=
 =?us-ascii?Q?mbZys3T3duvEcE1Vo8cgRo2x8XC0dKHe2tZihlNEB+MXpcExI/z2S6zhoD6h?=
 =?us-ascii?Q?qocGEFwfe/c/Q3li93B2vBZF1MKeypcdb70exEzuNgz6dXccgN+jXnApM3K8?=
 =?us-ascii?Q?qupVJtgElrS20amz1QxOgBMJFUEbaddYKmqxJpYwzMFqpZLRuL+L04D6Goza?=
 =?us-ascii?Q?EmKOySj/Ef2c6aJJQdpdAURsk4iWAPPanZC+5Zpw8AtsrEdv1014iex1CavQ?=
 =?us-ascii?Q?DhIRqMHgGnYja/g/kfZnQzOCLv/S2DusB2WGVScv/Ps3aowHqkB+yNKdGCxm?=
 =?us-ascii?Q?szFX75H+Vk0qOEB+jbCz63oCnMlMbcW9w+SQAmZwY6Ypk3XIgLnykmT/Q7yM?=
 =?us-ascii?Q?BSAQ1eTNPvf6ZRg/nK7c76tBi4M0CPwMd1o6F+3AYSDD1b4qgmCCGbdSilPl?=
 =?us-ascii?Q?NkoYQQ2kQBywwJFn1sJN1LzQivypwlA/a3Vdo+v3Gv8uDPjRLWLxCCrR/mlM?=
 =?us-ascii?Q?qpq5UxsuFJFXshM1xPHinqVyp2z9ed3rI2pxkhzKXddJX9/MNJDKyadRm8/g?=
 =?us-ascii?Q?acK2aVMur1Gk1UP+O7CxSQHKgEGjNBr9JCoVVuv5XquuDEBoAwb5nvSnlLyN?=
 =?us-ascii?Q?dztz2yPQ6szR7lllILX95T6zXGQKYlj5LlXL5eP/VKJXSY40jviAG2IDdGVL?=
 =?us-ascii?Q?koo+v0FFmtxJIQ8Ro6HJlvCPKZvD29S8m8wQX5owBcm35+uqaulJ1YO16Iqi?=
 =?us-ascii?Q?Wt5L4O8wPu07+2jYpdlqmOyH4oihpOIARGHh9WkJ1nAeEk3Ltkhvxpd3zIvF?=
 =?us-ascii?Q?bb9JIGJdlbVXdrtxP2LAa0gQpsvMkM3+7C2DhCdYy7G+leSs95ZjyDFFLlAv?=
 =?us-ascii?Q?5noWJvdPaVefW0LOW35bcNIqIpPu5iTTUdpNi/2j7YvpjJAmzHIDa7oKs05o?=
 =?us-ascii?Q?T4JPW0DXSkEjowt2GmEAfHxLCRcwZNqo917hnukBgkn8o+yb/3q/6qWzN0Kz?=
 =?us-ascii?Q?2Z/kVuskG62hrW82GZJSnUbzchwjRFjqEq1Jl9CiLY1dyqXwJaCBcdQZzlad?=
 =?us-ascii?Q?5kX9cO6h6YYEbBxo9bNh12x+jhDlGXEzwIbcFj96eI6hy8UbWzVKLG0Jrf9h?=
 =?us-ascii?Q?lmIJRfpJPj9YR75t34MT1NF+?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95498e25-e95c-431a-5e3a-08d951b9cd93
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:21:11.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKvVP9GXOHZ9O6fpgxZBSbjzJT36y2DQOC+QMm9TMx45DAV3RFFE+Ix1YaADSt7x3KClPobt0a+DXbEytnpAVeYFG9y96pYs2uSVkPwf7oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5862
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The self.__cfg itself is not a dictionary and "key in self.__cfg"
does not work as expected.
Use "key in self.__cfg.keys()" instead.

This bug was introduced by the commit fd3b732f714d ("rteval: 2to3
transformations")

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index b1755d4..8957dcb 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -265,7 +265,7 @@ class Cyclictest(rtevalModulePrototype):
 
 
     def _WorkloadPrepare(self):
-        self.__interval = 'interval' in self.__cfg and '-i%d' % int(self.__cfg.interval) or ""
+        self.__interval = 'interval' in self.__cfg.keys() and '-i%d' % int(self.__cfg.interval) or ""
 
         self.__cmd = ['cyclictest',
                       self.__interval,
@@ -280,10 +280,10 @@ class Cyclictest(rtevalModulePrototype):
             self.__cmd.append('-t')
             self.__cmd.append('-a')
 
-        if 'threads' in self.__cfg and self.__cfg.threads:
+        if 'threads' in self.__cfg.keys() and self.__cfg.threads:
             self.__cmd.append("-t%d" % int(self.__cfg.threads))
 
-        if 'breaktrace' in self.__cfg and self.__cfg.breaktrace:
+        if 'breaktrace' in self.__cfg.keys() and self.__cfg.breaktrace:
             self.__cmd.append("-b%d" % int(self.__cfg.breaktrace))
             self.__cmd.append("--tracemark")
 
@@ -300,7 +300,7 @@ class Cyclictest(rtevalModulePrototype):
         self.__nullfp = os.open('/dev/null', os.O_RDWR)
 
         debugdir = self.__get_debugfs_mount()
-        if 'breaktrace' in self.__cfg and self.__cfg.breaktrace and debugdir:
+        if 'breaktrace' in self.__cfg.keys() and self.__cfg.breaktrace and debugdir:
             # Ensure that the trace log is clean
             trace = os.path.join(debugdir, 'tracing', 'trace')
             fp = open(os.path.join(trace), "w")
-- 
2.11.0

