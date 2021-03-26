Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DBCC433E1
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Mar 2021 09:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCD861A4A
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Mar 2021 09:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhCZJfE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:35:04 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:48414
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229984AbhCZJei (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Mar 2021 05:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6VEnSafpVAd3TUx8dWVQAuacnzB550GqnbffXjLONzzgWpGvW0K1+en21n7CRPAGx3LyAWPMxMVqQ1ljplEWjSYXCNM7FfrwRtrQtt4uo6/31sn97aszgV38mBqWA5V9fo04UH4s9jBSVeVUMzwaGRwTvJJaHyqhQidj4jRwkIezltViiU8+XZl3vpc+ItFAfuHNHoHTD2ZK2P3vTQMA+13mHngAbqt5gRSvLyMJc6EsREBmSQIoT+JhGdBM+uLQqdmiD15P4JHwjp29M+/X3ukG6MJ1ZIGX13tpmzEVnTl7IMGMOJ86eIGzmDiKF3RB8cnexCvdZ4GyUErZjl9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oq/4zBpDzGmbBykvk64EDGR0Fdjm9bfjmwPD8vcm7E=;
 b=ntRYXJECloRDPCd0R83s09qMYK7Z0aTeVD6f7s1Iau57/roVeYi5mPpb8TLQJcgCtvObLlH4rhdCj88UhqIztaXWl+1NsjlDg9lTvZX29beunPyPePo3/w3AMB5OMsCtyrOPK5p0FlTmTkKiI0/HZvAigjNQFCf3AO166D3cdEfeJsA9rQaie1qnjKBs4J9QcPvAydi1KDVZZt5T8rNMm5/azNEIClqYzomS5BDngFSxevDqg4MzV6t+0JWMo6W8KZUBsmock+y+V9hmk73bfnb3tY/E6TeZrNcbNM3jKJ4C36KrYWphJwJceeR731flq739GdoFrm0a5PZV5qnXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oq/4zBpDzGmbBykvk64EDGR0Fdjm9bfjmwPD8vcm7E=;
 b=Za05eJtdkpw6Aqess1pgXn+YUt4TuMghT1pAxCqsWH3zQepqJ7QqNDE9i/NWSRkwlRO+kgavAK0f3pjY3ai5vNKul0NGb729ayBBdb/le8nrfcmWHeF3rqXgwIWavPEQmxTEe8X2jQPlPT1AQRUizXWzGfiuseoOcRqDbIQ7LQ8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR04MB6068.eurprd04.prod.outlook.com (2603:10a6:208:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 09:34:36 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::ddd5:6125:75c8:e3c0]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::ddd5:6125:75c8:e3c0%7]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 09:34:36 +0000
From:   Jiafei Pan <Jiafei.Pan@nxp.com>
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, jiafei.pan@nxp.com,
        Jiafei Pan <Jiafei.Pan@nxp.com>
Subject: [PATCH] rt-tests: pi_stress: fix testing threads' smp affinity
Date:   Fri, 26 Mar 2021 17:44:04 +0800
Message-Id: <20210326094404.18110-1-Jiafei.Pan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR0302CA0011.apcprd03.prod.outlook.com
 (2603:1096:202::21) To AM0PR04MB4772.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR0302CA0011.apcprd03.prod.outlook.com (2603:1096:202::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Fri, 26 Mar 2021 09:34:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a66eef8d-ea15-4c7b-f837-08d8f03a5eaf
X-MS-TrafficTypeDiagnostic: AM0PR04MB6068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB60683AD80F8D88EA8B269C098A619@AM0PR04MB6068.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEgqWr0n02NGiQW5g6J6VErGh3sbRVCy2xhjti3hqtkuXcOn4a3E1pLnsOy8/D5kWu1H+9xDXTONjwrnqMp5gTM14i0xLe2qAK6wHS+9ZfoCTowIk2wmP8/GKZchFwDFyg1RDlsYTf9zG3aRrYqBjN136U97wLxURbeKBIApvhewQuivGKeubIBEOGabBYVM3yAb76P1769NC0hInJ6jheY2UmRnmAXdyBasykuE4Kr/iOlBtbr8mG0BiQqL69wPiVJSeawiWw/s+yiC3f2B+BW3RaTkFfASd5s61HrCKV8pLAAmmiBn8oho7ReOLn/8aTZI4bVMNrabL0zj2glkSMzQ2vuPjE5oMDvH5R73zsFheO7TT+0EqeAS4fEwogATAoje9fde+D+8q4AbYmzNIU3YRF1SIuGfCp3JTherRHM/ZhzouYxMp3YTciqwEmXIVm3y4hkA7+qlxwTTDdu6z8OPBdVSYMR3Kh65vwL5jrdDtpgiHHF19z25Dm1wKSAb+vGcgbTaSqIoivNt4D9vGhm3KwElgn4P/Z6zdTvGh9K7ZwI9kXrLO8JJh2vtJSpnJpMsc74FcwMnRpXeJNag+srz3F+vBlkRak7hRBUxuKAMN0wLs94dSUiJANIZL8E5iyPUt/mu3/pfCy1ykUISfZ6P7rZaF03yoLC6f/cIGS1xps6/553kl5BAhMyEbGAq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(66556008)(5660300002)(83380400001)(66476007)(36756003)(6666004)(2616005)(1076003)(86362001)(38100700001)(66946007)(478600001)(956004)(316002)(69590400012)(8936002)(26005)(2906002)(4326008)(186003)(52116002)(6486002)(8676002)(16526019)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FzlvqSSWYJZaDFecmLg+Vr6UkcOfKvY8JxPlD11jt1JTfOvYE1IC5zR1t7ND?=
 =?us-ascii?Q?64GQj9wY/CRQW0rxb9lpNMbPjGS5qTHir3yPqM8cEv8dC7y8VoTFp6B75IkW?=
 =?us-ascii?Q?TwHrQm6uLs2u6cof0SM+P09NmaZq2URJIleZ45ObIk3sx70n68z3VL8ztDm8?=
 =?us-ascii?Q?Pj0xTAtlykjDXgGp5i94TY6ppSYcJKwx/vgYeWz0Surj7Z+Jlb4s9wvcVcSb?=
 =?us-ascii?Q?FnD5fiK/zk+bLyv/SjGcZJfLjRA4UD3bODxUgY+6UUHf7YjZ2aU2BEKaKVbh?=
 =?us-ascii?Q?uGjSaIoS4jDX1ZS09xT1nopTifAXLDih4pRmoqFwZZOk0kxqwQCJF/2lW4hO?=
 =?us-ascii?Q?XFe/8lNyE2xKAg3BEBQ/yuFB43F0b1tHNBSZidvKaK08f50L4VjvzkgyjeZK?=
 =?us-ascii?Q?Pi2KCLn/zYbV1byOlzGS4D1LL0L9SShGm3kqBSmd6IkXzwQ79dutjLABdYy9?=
 =?us-ascii?Q?YRJXz5K6zeSPlWapA+6pyIuuHRa2AMSsP0pGrTE0TomH3d6w/1m3BQ/pNItN?=
 =?us-ascii?Q?TRJK9fdy6gde4kts3PE4E6NdJsk8VOex5MNDVXBBm/93SOjrC6U9/3Tz6Lod?=
 =?us-ascii?Q?82Dp0fVzyYanx5gBJLwetEbKGcJwMa0jTrxdFa/Peyljys+IzYs5qMqn1BrY?=
 =?us-ascii?Q?UhxIOQLvF3CNTXCwCCIFumOB5HdR0bgT/DZQj/GPsWX1wAoV3NFvFU0FF+0J?=
 =?us-ascii?Q?HUozk0F1b05qqgTzcSY8xyNFqFqKMdq4kI/4im/+hu0UBbwP1zQTiy/h9ENX?=
 =?us-ascii?Q?q3NRJAs30rKZekjsCh2/CxdLyMDu7GUaxvNBF5J3uhQa9e5Gxyv7FfO1uB0s?=
 =?us-ascii?Q?nO9EnJfdAQV+/UgOHVzSaMAz5UL/X+zfjDT91vuQz8/DcGcF2Es+CyYMJ2js?=
 =?us-ascii?Q?OuVdT1Bl0Ftr0QyQLgqnq6gpy1N7DYlx3tHq6brTro4seP1bIf8GWl3UhFcT?=
 =?us-ascii?Q?Z7Ia5pfWjo0xoNxee8EdIwvtaBGHzYmEVXTR4ObHVcnwuleZ4gbK5pn0Owil?=
 =?us-ascii?Q?X/jewXXOmjyQSuM16rjYv1OxCza5oq/Ck61gVAce1TXQGqh5enrYH+SGyqiS?=
 =?us-ascii?Q?+2YSEB/clk6BSM3W1CeP+6FeFOJyrBq3hZIW88maCyFu7JryQ6GXv9fTJvL1?=
 =?us-ascii?Q?OzjEBmDb+qFL4uQEqHgkER2If+S16qOUlM6kACg2aanSlCpoBwvbvD3wtS8V?=
 =?us-ascii?Q?Cka3NtxO2u9kPpluCyfigo8/6mFC763DSLT3C5GIp+6g27rndemDNVXhOH1V?=
 =?us-ascii?Q?uhXdfHy+uEUAuNJxcCtCPCA/mC67FLU4dQe07VBptVj5IOcdqUiBv+7wBQbf?=
 =?us-ascii?Q?ib6wlkYYI9SAk2tV5OL+17KX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66eef8d-ea15-4c7b-f837-08d8f03a5eaf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 09:34:36.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dej+J88rrXudoehVCI3yoFCCBFTCQP9uwvOsO7ZpggZZKyNdwckqJr+gQHhZVxB/yKSOYyWroZzM8/nuBQOI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6068
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch includes the following modification:
1. Make sure test threads and admin threads don't run on the same CPU
   Core if uniprocessor is not set or not on single Core platform to
   avoid starve admin threads.
2. Force to use SCHED_RR if more than one Groups running one a CPU
   Core to avoid test failure because threads in different Groups
   are using the same priority, SCHED_FIFO which is default policy
   and it maybe trigger deadlock of testing threads.

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
---
 src/pi_tests/pi_stress.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 49f89b7..8795908 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -237,6 +237,13 @@ int main(int argc, char **argv)
 	/* process command line arguments */
 	process_command_line(argc, argv);
 
+	if (ngroups > (num_processors - 1)) {
+		printf("Warning: One Core will used for administor thread, the other CPU Core will run test thread,\n");
+		printf("\t it will running more than one Group on one Core (groups > num_of_processors -1),\n");
+		printf("\t it will force to use SCHED_RR, or change groups number to be lower than %ld \n", num_processors);
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

