Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E38C47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4206124B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFHEkn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:43 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:12904 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhFHEki (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:38 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15D014935;
        Mon, 7 Jun 2021 21:38:01 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKPtgXV8FhxGQB8PKirZME0AkJd5L382jSeeMeX2eYzHnNJQ+9jw7AQ42zVXRL4IV2w23Q13yd6spVV6WADFuBhcOzKTV3GQMy3ET7yQ7RMFJdcSEMJDubmW8CfdLXNrOW8KaPrmH0FBFBHuU+aK/iKnKj+O6DDFsU5+qWcsha5mzN0GL+zjjwEuf4gOgiyhfBhLF+meL5QxWONTwe8AS8R1azXK2T+KMjZU/IiGJJF/BsVal4kM+IDAXebkbVEqo6/ys8YP9Xe/1oHG1Q0lFKzOn4gJm2CKW/Zf7yGEmY7d7NpQSzftZ6Nqndjkv8Ea+XKyQ+Q+YbApe2k6xymh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++N9btg6zFAD8SjGnV0CwZh+aAJIkFIUu3QlgoOY9VE=;
 b=Nnrm0l3sgttw8oEscGwZ8WsXTq2Y6lQf6g3nMlnisi/bJRswxNmnnHrryMRRDLKHAX0jotmQvvMOrdu6f8aHkQoodV6eLITCiL1viEn0LgVDyzfAFwTVPyfh4Tan+hkev3JCKk1CyLKmH9hYWSJS9K30fuEcCDpgm3Anf5nlwrLBWvYFjbVirzIFDhXBPoJUA3nhOWdivNyWgW4KjEhn5TKFDfS72ZaTCpxj9G8Iw6bzrHaYDQ333pFKvMDAfpO50bIDfKMijJGNx2HJYxlFnp/G7fmhZn90fZhoa2ufZGK17IYYl7tMBQsbC9EahuyOVAdMoFDmd4/69CCX43/HzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++N9btg6zFAD8SjGnV0CwZh+aAJIkFIUu3QlgoOY9VE=;
 b=fLEGT9kl/Bqur86ZTKlvqLDc9PlQK94NDijiyXrshSNzIpWj8loqk5DHMw7FIiwO1irs5HS+sW8aSeEoRAx2DbwU1Bse3r6YvBd22u55o9rn+jpqzbQQ8TVWJtIVIBV0oBR/ivl4uW9ld9g6wNKSGWdES6MKLGPzLKM+zxucSPU=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2828.namprd11.prod.outlook.com (2603:10b6:5:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 04:37:59 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:37:59 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 2/7] sched: Simplify migration_cpu_stop()
Date:   Tue,  8 Jun 2021 00:37:31 -0400
Message-Id: <20210608043736.1102914-3-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27 via Frontend Transport; Tue, 8 Jun 2021 04:37:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8d7e1d-67ab-4141-3728-08d92a373160
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2828988AE2AF89E9CCE7CF2883379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpNVrMT5f8da1bElBEREK3MmIeHiX8KUNkGRjTIDZGWpnC/nN0an+CxjQobQrXAj7A4wO7YNRVKbZR2j3Pw31+qWvZ86Wtt0ykoEwV20Ja9odEgno4YH/hC7EDBb56BT09wyMmN1bDNwchHIaBvFO699tfiQ8UZrFA7VIVAJcCluu/qVpAGTSr6dnDWI0wguM1a6gUkPi2PmM4FEEsMjYy3elJXZQTyMGdVSaOjssE+H8yhNU1FxYNRNWauWf8zGjUUKqFu3p42/695ssHym3ePFmkaGIqX/JNyH5D621s0DhiXKNVlO7pHzQ6aICZPHx4MWcVqVGmedaNcUq26ztbEV1az6qeHSDRB49NOIYpE4DWomhoirIbkF1K8iM9JOlOdCLpd1BwfZ5rrPFkXVH8Au3AOIDoVYYUkMPeDJvjTehWcEBFF2MpUVuDGQZmUN0rMGpJ9MO2YTRR6TonGG+6fW7xxZG2Oy/mwK8HsLgN+ZN8nocPtuP39kA1cQ1X2eRiHnwgM/gQrrDBJX2w5Gj0t6jenay8Ypks+NxwuaIfb6ceDAWMxC1mAZ/ZkFj4hVty8UUEm52dL4JhntyExWXrhG+EZm/q/0GznQqMomecx8KDcW6jbcrapR9q5R+infXhniX+HDBiiAMfreLOYIkUJgXU9PmVfzOsnt1U3gzGdM4bqYG4xdoqLafIHiZJayGXWpHX40oCclFlOMG6yLJB3VmL3TQ6W+t6s4B6kmOgTeWbPzuRz2DT6H2Z8L7/RlvFhbYO/vwWxaocZrDfCOZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0DPtCvTxnFn7pLbuCrY9O1+RT8DgPCSL7jRQY2TqmxGEUI2hXMgwWloe6ks?=
 =?us-ascii?Q?hzWZ+5kSuRaZ76aNS39SFI1BKxuqsNg/F9fu/ylpsvR8ZxuGp+afawC1Lvm+?=
 =?us-ascii?Q?n4f/kC/qd4kJQ7aNVhv+KFmp4j3HLhD6FNf571OV1p3eB2WRedJZY/Igz3aL?=
 =?us-ascii?Q?18txKPfRIxV89B9qTioLcJb6y4HyikU6OYZWNobH+qHWS0IOfhn7iELfVSa5?=
 =?us-ascii?Q?BeNJDC/IObHOjMdagjrd3F1/7OwQoD4om1N6oe9A9DOGyywp6oEQXFR2RoJL?=
 =?us-ascii?Q?MWkf+3kAyAvIJT6AroN/ifVj7TFpHKzT587NOgQUGDftOMOwIHUmfEsihSi9?=
 =?us-ascii?Q?RlCy4zidfoVDB2qLzsUeVMtOf6PXax1DDZOcfrw9N8dId//3ENgV+G/jR2PS?=
 =?us-ascii?Q?pEdafJXvhvtTIO9OueTIzY3AEqNPi6QTV1DREE2i8HMo9/2TipYbIC5oo2wI?=
 =?us-ascii?Q?kPN/u9pw3JiFwI77f4T+DNT2ZI8ANUuogjAImad/gfqkaF4ZyC/xi1nDaf8o?=
 =?us-ascii?Q?Z9iSRMXFu6kbDgRg3XJ+Iowzkx7g3ef3NPtdlDrB3B9QzzvWTIPhLzJkB2z4?=
 =?us-ascii?Q?bzIoitcigUa67s5lU8Syp0zg2WGXPqOQ/bw6+gDwf/kPTmSiss7sc7GKm2jy?=
 =?us-ascii?Q?VaXcfiyjnaebARgo60kMZWW7s912DyXyotEbuG+b27uTh4iJN8TVrahu6wZO?=
 =?us-ascii?Q?N++c5vdK3eiOMbX9QrYwttxcDKL2ds+uwk72VsZDuRNhLk+c9FAHCl/J5cDK?=
 =?us-ascii?Q?OAkzRC8+eRyEtXvbz23Ey3LONVkWVSmPSWqtLatKOFRsO4puqvAoZ5SIiAcr?=
 =?us-ascii?Q?3q6xmo5upKRUju7SZLSeVlPQhkTPnqq+Y+PPVRUtQCTU5+/TtLDcDK5ES3Az?=
 =?us-ascii?Q?1HNbZ5JSgP//nZ6jstntWoInyGqcNEWy6PsFyY18WrQvTOrq0UKqtqkGaRdR?=
 =?us-ascii?Q?mjVfsVS7/oA1WxtG39jxPSXHxqfiBkqpVeVdtp/sEs3f6ohS3lUrKDGj3i/O?=
 =?us-ascii?Q?9H8Vh0ZRGkXeKMqEatRuSvMBZkCZFzjZvLE+B3QfFfmnwZ1isPkRY4h9amWI?=
 =?us-ascii?Q?Kozd8LVRalrufWAysEYL7GM9vL7u8pZ4IsUvyjvXtygwu/ci8I3WJfGiy8kX?=
 =?us-ascii?Q?gpDkyEHezir9R+IBa1QSEyqpSNYENoM391sgEPMeV1wJ8On8Tr83zxtP//bU?=
 =?us-ascii?Q?lor5oecnxjmKZ5g9K85HCOKomW5oDVRutGk/6SsIGoJVVU2JtM9csSeT/QkF?=
 =?us-ascii?Q?TE/a/ZpZ4P4Aj94EbHzhhqmkPqv81f1MkV8u80LQzw0Pcd9/ToXkWP4TnI8K?=
 =?us-ascii?Q?kIUTj7NljzgwuCt5pzAd+2PB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d7e1d-67ab-4141-3728-08d92a373160
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:37:59.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYpQHX/iT5vOyrKmlAKar/6jxnlG2Yd+DqcwJ+LmJObLi16OQmMFgFL0uLd1+Om/n27XnVJuL4r3XY+FB5QQ9v0jhnXyCXA7Fo+9RO8bRc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: juDy4ApEu0CHDHUKyi2iRGLk1ylPPyaX
X-Proofpoint-ORIG-GUID: juDy4ApEu0CHDHUKyi2iRGLk1ylPPyaX
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

commit c20cf065d4a619d394d23290093b1002e27dff86 upstream.

When affine_move_task() issues a migration_cpu_stop(), the purpose of
that function is to complete that @pending, not any random other
p->migration_pending that might have gotten installed since.

This realization much simplifies migration_cpu_stop() and allows
further necessary steps to fix all this as it provides the guarantee
that @pending's stopper will complete @pending (and not some random
other @pending).

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.430014682@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 56 +++++++--------------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a3dea38f410a..d497b13efb53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1934,8 +1934,8 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
-	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
+	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
 	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
@@ -1957,25 +1957,6 @@ static int migration_cpu_stop(void *data)
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	pending = p->migration_pending;
-	if (pending && !arg->pending) {
-		/*
-		 * This happens from sched_exec() and migrate_task_to(),
-		 * neither of them care about pending and just want a task to
-		 * maybe move about.
-		 *
-		 * Even if there is a pending, we can ignore it, since
-		 * affine_move_task() will have it's own stop_work's in flight
-		 * which will manage the completion.
-		 *
-		 * Notably, pending doesn't need to match arg->pending. This can
-		 * happen when tripple concurrent affine_move_task() first sets
-		 * pending, then clears pending and eventually sets another
-		 * pending.
-		 */
-		pending = NULL;
-	}
-
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1986,31 +1967,20 @@ static int migration_cpu_stop(void *data)
 			goto out;
 
 		if (pending) {
-			p->migration_pending = NULL;
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 		}
 
-		/* migrate_enable() --  we must not race against SCA */
-		if (dest_cpu < 0) {
-			/*
-			 * When this was migrate_enable() but we no longer
-			 * have a @pending, a concurrent SCA 'fixed' things
-			 * and we should be valid again. Nothing to do.
-			 */
-			if (!pending) {
-				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-				goto out;
-			}
-
+		if (dest_cpu < 0)
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
-		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0 || pending) {
+	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -2025,22 +1995,13 @@ static int migration_cpu_stop(void *data)
 		 * ->pi_lock, so the allowed mask is stable - if it got
 		 * somewhere allowed, we're done.
 		 */
-		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			p->migration_pending = NULL;
+		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
 
-		/*
-		 * When this was migrate_enable() but we no longer have an
-		 * @pending, a concurrent SCA 'fixed' things and we should be
-		 * valid again. Nothing to do.
-		 */
-		if (!pending) {
-			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-			goto out;
-		}
-
 		/*
 		 * When migrate_enable() hits a rq mis-match we can't reliably
 		 * determine is_migration_disabled() and so have to chase after
@@ -2058,7 +2019,6 @@ static int migration_cpu_stop(void *data)
 		complete_all(&pending->done);
 
 	/* For pending->{arg,stop_work} */
-	pending = arg->pending;
 	if (pending && refcount_dec_and_test(&pending->refs))
 		wake_up_var(&pending->refs);
 
-- 
2.25.1

