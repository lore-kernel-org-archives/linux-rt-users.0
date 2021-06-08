Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0375C47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE5861249
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFHEkj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:39 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11514 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhFHEkf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:35 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15I014935;
        Mon, 7 Jun 2021 21:38:03 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfGfJhyESEFjiHX5O3kYHUQFjR4S9ZKKf37hnYNYyQWypmLiiYbjc/xDbpdCGA2TmD+aowhmlfEXVqfxV+vM+301WwCBkP2e0O9hIVumSJS07wnJaiaJ7d5JPxrIJq/jssQ1zIAYUB/EJaGxBC34MoXlQK/6flbTWHQRrUxxtHxZTXkrc2RNojsuHeYR2WJif9uaXWtyPW6Af3C74wVWx4Ca6TUblPFgv5VAdUPV9WoyyXOStfMNpLWeFqx0vXwOd088z8LyCtmtkjFiwNgjJ/Vw8aob4uM0VOCx+9fZS1GeQ9EDS5yUD8opsshE4dxnVcr10XH2pQOUe9TXSbbBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKtS/gquwVzOfv7el/kv8NfVqxraegnBDDMsHOYrGQA=;
 b=kNtOw6glhZEhdc1iunDnrTDj1Yjn/rwGhE94Igk3rHxMe8+m56gcws/OqmkKAT88Tmpb0WA/P8YUTZk9AWc1K9aO3FhU/iBG3uhNGrp8W5/HMlLCVNjgXncVjHdEijkmgEl7KvRwg8lqOTwGpQLknQSFvFWFyPhORhX1u1eQflt9LcjgvnwD6FUrAZCDSKbBZOZWc2ybQOKaLgQfdXfZ098oQgkkIS7HbbwmpnWSr8h1xB3GMSx8yIJJSUO5gxuozRHl80n4wUfygpLz8L3F4IxD3j1bI72XaSmm62YjrhY7ViDLS6BRV5RRT/H1yLlmmFSd92ffzZS5G+xDXMNvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKtS/gquwVzOfv7el/kv8NfVqxraegnBDDMsHOYrGQA=;
 b=QztcPeaZrWm2Tc2ORcNmu/+tZvMSH6+f08hPCwap9MR+lMFzHCZVWa0PuT6BWV/FimuMX/WGTdkFghfGYg6eStR4PD12HsiYY5O+DAkJKmXoQz0yZe8dZ6A1FavzKiv9NiXmwtNkrjbhFeV8xElzTeWejQSuudCIFGgSH2mixm0=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2828.namprd11.prod.outlook.com (2603:10b6:5:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 04:38:01 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:38:01 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 6/7] sched: Simplify set_affinity_pending refcounts
Date:   Tue,  8 Jun 2021 00:37:35 -0400
Message-Id: <20210608043736.1102914-7-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608043736.1102914-1-paul.gortmaker@windriver.com>
References: <20210608043736.1102914-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27 via Frontend Transport; Tue, 8 Jun 2021 04:38:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad40ccea-d7e8-4d6e-8903-08d92a3732c5
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB28285B9C934616C00708F3EB83379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZX7fIPyhfoWe3x3Opdux5j7i3m2RdphT4AeEDcS2RAXUAWtK2DBaw8AfR8k2FUVZAm9Ws5mJqNOMoxNpsmaQ5RbcZyBoZXsBZgjTlC2b7CtrSbhQvjYiXqS08wOxm162V37r5+PQQAk7M0sgmj6tlc8skIQ/u8JRh77+TBlDJpKh3xuaHZ7UM4ynVOySeqkeu7iZorG9EHRONrpiFB2hyuVHIV7Fp7+/3/40idjyvvx/nwCI8zj3NIQ+EAVQwDcw5Z48yL7b7vqUvuCTj1G7NPO9rsS8EupnfJVqA6uwVKZBMw87eC1ULFAo1Nk1+YwTMF1YHtd2cVUEuUnarx+HdWi5FB+DXHlbgHxJ4XhRbR83VVz8p1k59g2dMQscH6Dpp5PGiC1Inkwomq1pvOT3xdONlrV8JwV5CkGpDuL5ze99fxcspvN3LGXYjv2/SU7YM9yl8n8ZnQmbdColLRtpjBRYUs/qJnYeFhYYXOQppsik1ljV/yJThCbz2gGMOhsqkR7pzn+9mF9MMznSY/mle8J7EzMj7wwaRBYGHfL6NktCwrq+rsCLPZgaxLsPdfJu/HQJGMotQ30GWj/J0BH4lzZ3hIyiZcDWP701VmvJDS2pmyW+iHzS+aztY/WVS7/JlNPTntE3fMimILHUQr4oe/D5hsq1CZU2k5wNbNZKGvYqQWTbmwfEvKI/+XB8VuKp6GIR+3Q/FCZdSldfMZGri7mJn4Nt+37+2BKPYRdfxeAEI4jf0wKlS00F7xkG1L4/8VVWgs0vmRSo6z/7KyihVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?En0SRwkApf2/8Ajy8aWSB9FoJqBvvmBjAjekrhlMBhtcU1/uDqyk1JDEJwbX?=
 =?us-ascii?Q?vGR+OHyaoFWhB/kJWe/+EvNl7FNa3okHsoq/iCxAJSOd09VB4KtAa3crUF1N?=
 =?us-ascii?Q?IcB3T4q2BKE2Fmh3qV5mwlyODQZOvAQC+ooBYPU9GXwcqbBNbm3Qy8+1GhzU?=
 =?us-ascii?Q?xsKEeI7X882PxJuFPwc4Of4lyzvgMglbyzjgfM/BrGADAyZOrgGbrTbOq0vz?=
 =?us-ascii?Q?O9R7xY2tpcUNqh9XIjQgwXmbmZq1OUWxVc8qDoam1pl4+4fWjmolp/4XRF88?=
 =?us-ascii?Q?xW3AyOwmdhmSCCRcoJjY0YSsKrKZg6ILzag63hBkIL2eVTQHzDwyeL0zYchS?=
 =?us-ascii?Q?mfmfeZ1OSKLF/QCqO6uF6kAlphHGVNXFbdeUerhaPtVCv2aYrLfkMJC6HVII?=
 =?us-ascii?Q?pAw9NcCuzpV928ARAVHjeVar40gjvYMM6DfifCdkkwA8V9l2g0Qltf6rg8cO?=
 =?us-ascii?Q?9nm4X/VJkr/8rbUOGDJ1y5EvodcnB1WeGR+VezCXiDA9JP0K4tBH0XB81QnH?=
 =?us-ascii?Q?G27msG51I0tGvxYT/cRF8cvUw38/fZWE8mx+H6lMMFA9AkjZXky3W2j6M5jR?=
 =?us-ascii?Q?c36peVvylbq+xLa9MymGocEliXAI6MofLaiYUyob7hn/Z9mZpitLsHY5cs9X?=
 =?us-ascii?Q?EqKO7fjtTinhOkqXBWlzHKXEsLqjfow1kV/1E30ueEjoa53Lmzt+d9kFqN3M?=
 =?us-ascii?Q?lzTBvMX6/2NDIh/CGmKIGLE5ecWh3I6y7rHVjbLYZa1mVKHskJmPwcUq6rUU?=
 =?us-ascii?Q?xGJ4TmZYsBHnAHpRgNlc6UvGqgOkQfcshYVe0lMAxJcxXe4GUDopauNUhxPQ?=
 =?us-ascii?Q?4RVeYbnQ+INPpVUbtV8c2LJEq+CneeuA0Y2EEkZ+gv3QGJsqYTAoTZg8oDOr?=
 =?us-ascii?Q?z6ZVM1mKVHpx66sc20CaqCKy+Cpf5vS9bajyOUQTDwHHgdtLwRfqrfHr90zI?=
 =?us-ascii?Q?e09pxrT1HDDohyPLx+jf9C5TonQsrluvk2YnLzmolQUPTvETlMONrCCnPE7y?=
 =?us-ascii?Q?6qW7RjLNnz2iucMWeYH1Cw6VHyqAQ4E9lKrjOyOcWTI4CRlb06NRAMzQ1T+x?=
 =?us-ascii?Q?wbyeFOfeQKuSLySPGVhs9ljlW/V+SFCnh0y7z91aAyNJtWkh/+/EEojAsQuu?=
 =?us-ascii?Q?OYwy4QG3lsaBROSbLByNWzzv6m/WZ2MGxdq5dsUxHS3IZ5DzHZN2nVTO7s5S?=
 =?us-ascii?Q?4ktKj0uXpsy8nNjXyYrGyKsgwI1FPx6NkbY4UURSHE1XAF0yilphsFnfU4OE?=
 =?us-ascii?Q?kFBzzh+cAtM7UsYZIfGnr6qVgU8up64w75IBE6WZ9RgMA1PxYqpOKdHrGmdz?=
 =?us-ascii?Q?zOgsZ7YjX9oamBalOq3E1+C4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad40ccea-d7e8-4d6e-8903-08d92a3732c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:38:01.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmFo/wsjFr3Y7Qn9Y5W7HH2UTP1EsQaIVS+zTftvU0RbfdWrs0Ll8BYep5VwW/RE0GT7SHEg81Hyd9niZvUjOjduclhaLOHlnCq4mkyrUYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: f443S2OBtOb0CfpCoTg33Sb6v9SswIdz
X-Proofpoint-ORIG-GUID: f443S2OBtOb0CfpCoTg33Sb6v9SswIdz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080030
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 50caf9c14b1498c90cf808dbba2ca29bd32ccba4 upstream.

Now that we have set_affinity_pending::stop_pending to indicate if a
stopper is in progress, and we have the guarantee that if that stopper
exists, it will (eventually) complete our @pending we can simplify the
refcount scheme by no longer counting the stopper thread.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.724130207@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20588a59300d..35d8b80d7cb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1898,6 +1898,10 @@ struct migration_arg {
 	struct set_affinity_pending	*pending;
 };
 
+/*
+ * @refs: number of wait_for_completion()
+ * @stop_pending: is @stop_work in use
+ */
 struct set_affinity_pending {
 	refcount_t		refs;
 	unsigned int		stop_pending;
@@ -2033,10 +2037,6 @@ static int migration_cpu_stop(void *data)
 	if (complete)
 		complete_all(&pending->done);
 
-	/* For pending->{arg,stop_work} */
-	if (pending && refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
-
 	return 0;
 }
 
@@ -2235,12 +2235,16 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			push_task = get_task_struct(p);
 		}
 
+		/*
+		 * If there are pending waiters, but no pending stop_work,
+		 * then complete now.
+		 */
 		pending = p->migration_pending;
-		if (pending) {
-			refcount_inc(&pending->refs);
+		if (pending && !pending->stop_pending) {
 			p->migration_pending = NULL;
 			complete = true;
 		}
+
 		task_rq_unlock(rq, p, rf);
 
 		if (push_task) {
@@ -2249,7 +2253,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}
 
 		if (complete)
-			goto do_complete;
+			complete_all(&pending->done);
 
 		return 0;
 	}
@@ -2300,9 +2304,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		if (!stop_pending)
 			pending->stop_pending = true;
 
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
+
 		task_rq_unlock(rq, p, rf);
 
 		if (!stop_pending) {
@@ -2318,12 +2322,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
-			p->migration_pending = NULL;
-			complete = true;
+			if (!pending->stop_pending) {
+				p->migration_pending = NULL;
+				complete = true;
+			}
 		}
 		task_rq_unlock(rq, p, rf);
 
-do_complete:
 		if (complete)
 			complete_all(&pending->done);
 	}
@@ -2331,7 +2336,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	wait_for_completion(&pending->done);
 
 	if (refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
+		wake_up_var(&pending->refs); /* No UaF, just an address */
 
 	/*
 	 * Block the original owner of &pending until all subsequent callers
@@ -2339,6 +2344,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
+	/* ARGH */
+	WARN_ON_ONCE(my_pending.stop_pending);
+
 	return 0;
 }
 
-- 
2.25.1

