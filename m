Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674FAC433C1
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 02:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3768C6193A
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 02:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC2Cuo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:50:44 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:31126
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbhC2Cui (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 28 Mar 2021 22:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8Zoq158uDN3Ljp0yPRroZTvz3KND9rLmILD2MdOvnPOLuPUl35e9zs6cV5NEDgGLguyl4DaBITFCoUp5wqa6BykP6uRwSZr3yAnwLDTuwu68I6GVDHqHODQmLZczVWHWgZdv+sQkwgfCO7Dv+IiyLmOXYDijOKqoFJ9o+ouASE9VrGGt6ssXSCsCrTHCtBqPLnuel7NcIyfh21DH4j1oV+KeSHa/Q49RakmdR4PNoIS64FF0biQ48HUdKoi29J7a0eplZmhr0Mz1Lm5aH6IZMSR2rbfVmPyGz9koY1w5DDOMnJea4eFOm4839QgLdBHrdTRrkrVxXmE6ZVBnzbDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo7xW/6iNUMkE0P1KBeI2xw91KPLHJQmTJY2lqHiKPs=;
 b=OQpKUtNigQhYEZ5L39rQlyn3gJkopyvN+V0GBwEgNrrSuqPw94Dz4c5xjZNimNlYiOPShwk2ccHuZaZs8xXQLrGIHUWXzYr7e64Rc3Ea0lTZ6xbYW/xqPFlQVL5IMav28xxGkOsDxdmIsIq92yww+R4htKkAkkiKfImst5/mfZ8m5vWhUdBPNIdUDD58O+2SMYuMmrr2CaNefRlNmbWY+WZSVV8wlgz36nnXmPgN2Q/CTmEjxYHwY0Sc1uzfDfGt7QpMKqCGalZMGDXMTM/i+ssUUVnVUzPi3zBUC8ht4n6T76fAsieiJT61KkzG4yDwK8wcawUJPuJ9lZMpfKwtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo7xW/6iNUMkE0P1KBeI2xw91KPLHJQmTJY2lqHiKPs=;
 b=TJP8DItm/96r7y3/wHexBiv1GHRn5Yu/ZlAoeL/j3UFZvZkG1qbZQ8S/qWz4gXQcpPuI4en8pLrBsuZ9WjN0Qx3sAfDEu7NbhqEH6KkG1FOcYV2879hx+qUeypL8/xBfjHTq+6yEVchSPKkxNfkNOMQcTeYYdIVGaW+QKKIl7l0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM8PR04MB7234.eurprd04.prod.outlook.com (2603:10a6:20b:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 02:50:35 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::ddd5:6125:75c8:e3c0]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::ddd5:6125:75c8:e3c0%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 02:50:35 +0000
From:   Jiafei Pan <Jiafei.Pan@nxp.com>
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, jiafei.pan@nxp.com,
        Jiafei Pan <Jiafei.Pan@nxp.com>
Subject: [PATCH v2] rt-tests: pi_stress: fix testing threads' smp affinity
Date:   Mon, 29 Mar 2021 11:00:15 +0800
Message-Id: <20210329030015.7697-1-Jiafei.Pan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR02CA0153.apcprd02.prod.outlook.com
 (2603:1096:201:1f::13) To AM0PR04MB4772.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR02CA0153.apcprd02.prod.outlook.com (2603:1096:201:1f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 02:50:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68d2c100-fc4b-4347-9936-08d8f25d6d62
X-MS-TrafficTypeDiagnostic: AM8PR04MB7234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB72345A6C872257CB2B733DE08A7E9@AM8PR04MB7234.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Z/scEv43zgAj7txn8B1jKJcBGLj7qk3KuSafD8+JDD2BT2HJ4hQ/A4ZotpVEWztlhAXckJSMVIssXOfQrxT+OZo5Ruuh2pn+kItGKstDdCeA9sQxjAb8YciZ5faZi21/pzmmAnguQO9+vz0OQBd8I2I9Y3Mhj5s2UU6Mqq4ENeVyFfZ0eUYf+FcIYkMLNdQALBC1/lFJzlZrQCYYwIEgMZkSooXotIz0FTHAPTaFSKRz2SOwmvNUUgzOavG1w6oP34VKpVkpeCmALGCK9E9EOGzn5CUtxosaMGC83YUjlOVlHA5j/1fbxNGczz+mC0hv3ZTsL0qqFHRGWIG8OYDrlNwR1mqaaE+dZD/IVbkxdO48r041OafpJLE3KOGfNg5skcQuMXBnU2ojuHMerUXT5siPrsUvsU2oq2cMqocPq5rdbvNVOJXC/ldWvpUm4y2guou2KOPFaKykCKGoes41nrYBkn0BoLgGWiDFSW2voPAhVnZvImhOk4+6c9dNXkuCZCbcU51rOIeWTqL1ISxoE3wV55KwzH5BrdOSAudu5EdtFpFAcmA9G0ybAWSPfanDhgUcsAIAtJZamGF6Rlr9kahbSrydPpnZNwvNGcMrfc9S5OCSeOz3Ownnk6gCDA99Rw9jHVeYSiWnrnPqQXa5jWMsc1emAxZWYncm6CqxBIVE20TqYJIqMoMaOjHkA/t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(366004)(346002)(136003)(1076003)(956004)(2616005)(6486002)(52116002)(5660300002)(6506007)(4326008)(86362001)(26005)(16526019)(316002)(186003)(478600001)(36756003)(66476007)(66946007)(66556008)(8676002)(8936002)(6512007)(83380400001)(69590400012)(6666004)(2906002)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l1XE5AE/3wKB0gCIKdGgyoqxtBfNSlrgmPCCcW55h6vX8mcm60J97jV85ee4?=
 =?us-ascii?Q?K3j3GV99vJO4GKyJ6p+8CowgHFjb7NF59G/n9fjLux9ozszMsXuzZP//WuhR?=
 =?us-ascii?Q?FwPzFQb34iUM9/cLlSunbhcpA8QVVTawogf3uF6TO8pXk3OEuR3p6ciwG96d?=
 =?us-ascii?Q?fbn+XHGHmfgu5pnnXD9IxRoJBmfV5uAp2BfFn4IZZh7acSwFPZ3MIs0asXBD?=
 =?us-ascii?Q?Im/6GqI4pMi7k7d74VlSi7vUCZH+pwDooncT5gklS9IYb7aIScdxYNxd5JQ6?=
 =?us-ascii?Q?egS9V0gr6uyxLxQyI++gc68D1eGgnCgKTHcZPkciwgr2LEF3ZQV95DoPy9hp?=
 =?us-ascii?Q?Ixq7t+GBu/xPFNTZAEqGB5Xac6GYfnwOrKxbx5i/YKdaANAGZ62rf4x/CnTF?=
 =?us-ascii?Q?G8w/tyXDjELuw8B/UuQXKVDJOMsDZ1LfYVOlX8pQ9ilJo/kW/B2/QIM2V63H?=
 =?us-ascii?Q?+UiST740J7UKKE7Ixd0Xw6WnYkYk0+N5jjsGV9kgNo+tzGeP2fN8wGvMTw76?=
 =?us-ascii?Q?/YTDpTVD7mH+PSTjSuYNNz8fULsxSZ1NhZXW784OnvOToAxPtIPQyU1DAwxs?=
 =?us-ascii?Q?5CjTUYgRN/eOlV61pbAG6xPAEyQSosAl5HnWAKHt8jM1gTXxfDvb858iIAtA?=
 =?us-ascii?Q?xeuzLUqM2zHuXOA5wZGp0+a0FWxn1OLuWXVtj+Sv4+uxCTgkldy50STPt1kk?=
 =?us-ascii?Q?ovGqvk3wkJa1DSNJLCNfCY+9O5W+xxXfl9ouFrJPZBNx2CCBqFHhfT7Vfs7A?=
 =?us-ascii?Q?dkBLJpIlly0h0OWso2kM05u+wEYUaF5ENBsOHc3u2MxK5za5EBmCNg/3zirt?=
 =?us-ascii?Q?HzWD93Rf9GeqKrDefFxDbsqQQpNhMN/dnKGfaGvacza1VZm9zUikk0DNWx5C?=
 =?us-ascii?Q?aFMxF7oWL/kP7pBtZ65kIHKdkaAUG/SVMPOeLIsigsykoa+Y+UB9JI8HdVeV?=
 =?us-ascii?Q?k/CMVA9zlU5DID1/ts3cuOybDbYcF2UJ/X1CibWQwggrv0HviMZa8EARXW4Z?=
 =?us-ascii?Q?ure3c8EAgeQrpE6ulNAWUmD+dlGq9B0s9i847rQW5IJXoIYi1UgtoM65x1wa?=
 =?us-ascii?Q?9v+J1Xku8FiSA9XyOp7WA+tzEiV2FsLrMVP2IGyHy1xHTwmMyK898rqI3JcI?=
 =?us-ascii?Q?tBfGLBeTPLxRW7fwgkr5xmjmMxiJrei/2xDoCvPDVfIuv6BbQ+zyi7dvypai?=
 =?us-ascii?Q?3P/SO9AHqidWs91NHnHXfFgHjB3PM6p95L+GQd7dIt4cnIF8lqwVj/2iw/aH?=
 =?us-ascii?Q?rLaF07Sl7d8JhdCPWHOrtexbjKRQKpu8eM1O5S6n/Rv56Qpr20bDRTWJVq6v?=
 =?us-ascii?Q?Xxa/8t1fGN7a1Cf+ibcuC1qd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d2c100-fc4b-4347-9936-08d8f25d6d62
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 02:50:35.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAJ+paqSUDWwgvZ+MWMm3W1YD383dqtqjIEL6mhdoqPgz4/Xf7Yjxs1uFMelIPdWpScl/Psm4A+IDuYXx11tSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7234
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch include the following modifications:
1. Make sure test threads and admin threads don't run on the same CPU
   Core if uniprocessor is not set or not on single Core platform to
   avoid starvation of admin threads.
2. Force to use SCHED_RR if more than one Group running on a CPU
   Core to avoid test failure because threads in different Groups
   are using the same priority, SCHED_FIFO which is default policy
   and it maybe trigger deadlock of testing threads.

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>

Changes for v2:
	fix some typo.

---
 src/pi_tests/pi_stress.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 49f89b7..e8925e3 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -237,6 +237,13 @@ int main(int argc, char **argv)
 	/* process command line arguments */
 	process_command_line(argc, argv);
 
+	if (ngroups > (num_processors - 1)) {
+		printf("Warning: Administor thread will run on one CPU Core, and test thread Groups should run on the other CPU Cores,\n");
+		printf("\t it will run more than one Group on one Core and force to use SCHED_RR policy because\n");
+		printf("\t (groups > num_of_processors -1), or please change number of groups to be lower than processor numbers %ld \n", num_processors);
+		policy = SCHED_RR;
+	}
+
 	/* set default sched attributes */
 	setup_sched_config(policy);
 
@@ -285,9 +292,17 @@ int main(int argc, char **argv)
 			break;
 	for (i = 0; i < ngroups; i++) {
 		groups[i].id = i;
-		groups[i].cpu = core++;
-		if (core >= num_processors)
-			core = 0;
+		if (num_processors == 1 || uniprocessor) {
+			groups[i].cpu = 0;
+		} else {
+			groups[i].cpu = core;
+			/* Find next non-admin Core */
+			do {
+				core++;
+				if (core >= num_processors)
+					core = 0;
+			} while (CPU_ISSET(core, &admin_cpu_mask));
+		}
 		if (create_group(&groups[i]) != SUCCESS)
 			return FAILURE;
 	}
@@ -1143,7 +1158,7 @@ int create_group(struct group_parameters *group)
 	CPU_ZERO(&mask);
 	CPU_SET(group->cpu, &mask);
 
-	pi_debug("group %d bound to cpu %ld\n", group->id, group->cpu);
+	printf("group %d bound to cpu %ld\n", group->id, group->cpu);
 
 	/* start the low priority thread */
 	pi_debug("creating low priority thread\n");
-- 
2.17.1

