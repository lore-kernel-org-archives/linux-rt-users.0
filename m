Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DBC4743D
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DB26124B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFHEkl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:41 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11566 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhFHEkf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:35 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15J014935;
        Mon, 7 Jun 2021 21:38:04 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGsPGapgz+KqlN7/2U7yjPkV4oBQNdnIpSujco/3oWQbt/PO889j61NkqBhoo49OjcUfZFTSxnpswWL2X1FV9Jei2QDVhagh3fqKrl1Y1Zx9PTWd5Gi639tNxk2xKEZLu5y3lE8OSpGV4UU93daRDUT1XRY95mfYgPIkG87BCmZ8FOd0mXB5BDf1xMVhjFwE1SK5erUtEXCOZHo98513qyb71KgjcpypGj9CLe3vGKn5ICZX3iBMRBO09i4uUI+dyLph4N7MaMWTbLk0Z4Ah8/hXTyOEjKzGf1exLEhc3L+Pbb12do2F8YHPFuer9ty+h1E3Dd+DHlTcWuUwabMDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlcaOOylX1RuHOEcFjVnFwYJhJISwxivRum+qTLX0gk=;
 b=FlocoN7OEoPecwoZrNXMLD6DxoMNrT+4LcRNRUcSfN9VMb+sRQAtQtb2d2MEjPhJZJsAljCTP0Hd8WKj1fyH74rZ679xnwU5dCt+e2tetVYmXba1Zvdqgn48JLUp7fh/jMxalRedVldoo4eRxe4nJEyLqw1KrG18FTTTSbdrpSyKLUs1MbMBJe0QyEiHngkxIsHu/75he/9xsSoSXDwp97YWBxX/sVO3NE/mNBjmYvd/GMxHrX9J0k8aE9z2imjgPcsWa+XEKCBpb6f0/BVLNSHbfKoGpBe8GeamapQp0NnawTUhJzPzWCTXt7ur7xh/SM4+bDpxaDt1Q2efROKfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlcaOOylX1RuHOEcFjVnFwYJhJISwxivRum+qTLX0gk=;
 b=Y8pwy+B4sswfKa/akiwZ/bAjW2vUDyRpJ7rh7Qq7OC8xucvD62WbjXTw8eadQqfDw2FldyxssOY2Oj0V8cQjN+mYQE5pr9dR5J1eDHK5s0tTOYODtSotvtcPxxYEukKsz+0ukYftfGbJ07HM93YiXm0E2XUQ0x7jJksYPfWD5e4=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2828.namprd11.prod.outlook.com (2603:10b6:5:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 04:38:02 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:38:02 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 7/7] sched: Don't defer CPU pick to migration_cpu_stop()
Date:   Tue,  8 Jun 2021 00:37:36 -0400
Message-Id: <20210608043736.1102914-8-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8a4add3-2433-4294-a65b-08d92a37331d
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB282847E45CAA97ACA908DD4183379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTVioMqKvtpEIrfmvZghOO5vKV9Tqik/c5wPvq/nJxgH3rTbpykC/UmL1/6atsMdw8ipnQ2iGWPqvobKVaseig8oGWmMC6q06hksOoreWoBt/WEtaJYcCXNXhpZEje8wQke3euF0apxiyHjYUaEiZHpzwYZ+tHRzJZ7v+uD4ZMiMcEWJ40MLfKgClKb7gzZGbNSbW3HRMwBMhHRSfBKT3MW/cJMZO/Bb4Ry0BLRDGeGfnPJUj9jhT5CyDAI11MIxUXjWsAFIL2JpSKKP0qAJg4WxCznlA0+r2KASxPUE38SMxeFXYEblIIH18Da+576pjaXFYl1Z0caQyigSdXq9Agp6B8PEMxyEcZPl0oBXWAVsfRZH+JxZQt18QsmLXk6F8eYWcmvScudAGXTKWHsssEYJzcbEfSHGy3YkEJuPJc7yBVo9vgcTarokKAK1d7YFR5B2hSpLKvG3udFLpg9ChUJi8ydJZ+2C+CFiPAFZ1cGDeAOXEauCfiP79p+O5nRBEPGBwj03o18svQ1y5A5McbVMyBCk/t7iJY2zhQPKlVCRNvgbJj97YtyVi5sxhS8h50PCx85+iJFjSpYFdNqDtLm3jFyEjUDBFrh8tgS/uJIn5uDy3MG0GZWCTergGBiZpVKX3yPRSXOPynkuiiDuok1Cm+lXF2ZQKSLeRPxY8ZvgAOj06fthaAHYPz0crnRRznDFuDIOdCNEUm/vH1eZ6p5GZ66FCWZGkvfPs5Yoh96n/c3S4+dgkG360VqPCwhaEgE27RHtH+Lt3mzXuqCWxzAwS4W/jg6XVrwjyuQ7RQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hph+zRNCUdnk+h5PAn0PRSpw0WbGj+xOuNiCaL3ayAsg437MCVYKG5hQSSyB?=
 =?us-ascii?Q?c0P3NI2DgaGfvRhkNwi4HEl/G0JF3mbxS2wOwLH3/Qawa2aaBGctoorhVKsM?=
 =?us-ascii?Q?Iyz+XfeUUg66885PGn7VJ/oys/vyVWv1Yo3TwEhLopI8CCuSOivpI1JxNrvH?=
 =?us-ascii?Q?RK8wPQOw4vLLRWt/1UDIbibcgeqPeB3anWbtkHa9U+oLVpm+tE0VQqNU9irC?=
 =?us-ascii?Q?gk6ng6GEWNKlQwAYQo+Gpa+2EzoExcoUHZP5GrUKsVkquS3GhJLExAaad5aB?=
 =?us-ascii?Q?JymCiYZFnWfAn69K1yJl/ekM0cG46f1y3vAg+i1Vl+qhPBflxuVdFxNM+GJJ?=
 =?us-ascii?Q?XvYcSJ/aViME9s+NrDsWZnwZdsxMSWo0BQu4Bum+r01v3ZzRFMpcT88eyzts?=
 =?us-ascii?Q?/BJ7teyHW6xr05fB4cSggk0C+l04tqS4mK0SHAG8LH8ddTuWqfjG0ATBWuo2?=
 =?us-ascii?Q?zJe78iaHYufKRgCDCnUAHSJfJ9/Vbt/Xx4fKB55sC3Wg+Q/5m6AiRq7OKWFM?=
 =?us-ascii?Q?9X6BtJYMlMP9jFP2ku0uZYbosZfMXynaOT0aqZdlJr2xZy3KTIQ8roaqwQrh?=
 =?us-ascii?Q?y3155buWVR+91P2WyyszE1usrhLzGg9A45mJ9u1GujJUHSrialqUVZ1e6Ve9?=
 =?us-ascii?Q?IW0Sa2cfaUncOBdF7mZ8xdOG9hnnzM7W/lezDQcd+dVtWiCevjLWNCBgJZiu?=
 =?us-ascii?Q?GsK61Vq6JmN+Z1qS4O6E0Vlp4wOuvFLsxIyCdQ1JProQKq/lRXxDBaePCk+Y?=
 =?us-ascii?Q?rbIYAN6/XC0cgPbVQ2wkGjwJ6D9AVESjdgELPJcNX5dqhlGrk/cp7LhVUgcN?=
 =?us-ascii?Q?R8EdjWho8aYNm8P4cg1RdrU7qHZ1IY7H/bltq5GBkzG0aj4yZlL1yrAGyqjj?=
 =?us-ascii?Q?8GYrSkbupJ3HfRyRf4eRVhYZsPM0Yl2bSBszdwT5kMQtoE+HD2qkm3VtEhmi?=
 =?us-ascii?Q?s2RTejZJ32lmQpykCmMfkpiVIsRxcck5I6ipdVtLzUVnZgVf1Llft9GMPpWG?=
 =?us-ascii?Q?VmVuJv6khJ0X9bgWN+nhMHcKAg0kGA7Bnz89sGwL+9ZMD21WHdZ8aYDvZ6yd?=
 =?us-ascii?Q?M+Pj74qLdnZsgxDA3bZXct04ynpe/j46EnOmUu351Ce1mGKG711wJJFVickF?=
 =?us-ascii?Q?7e2zW6Y723FT/UC0bO3xgU6MMEi36IFPr4HGlc2/tWAZwY2qLQ+kzjwGNH6W?=
 =?us-ascii?Q?hJLonJHJJEWDGGnL9P3xGp5ft6u8VwA1zo+l9Wx5deQsNik4Z2gi8pdxDEp+?=
 =?us-ascii?Q?jmoTZLd+nIvu03lIne3jrbwxPEBt9N3XNV3Vh8zKTzS8ZhWIK+3GonYpGxaO?=
 =?us-ascii?Q?e1AtST2s5zNtZAhByTzw6YSc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a4add3-2433-4294-a65b-08d92a37331d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:38:01.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxhLOTSZKn9ZCm93Ra9SZVfSJ1b/OnAj9owEGMiXuxrsRtfCbAh8vs6k2xIxsqspGLh39ejGtavuKWBESU8T8Z6934BZf9l9OSooinOIgKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: sHJfLBXgafWSWSL4i1WFEA---F0KtsXt
X-Proofpoint-ORIG-GUID: sHJfLBXgafWSWSL4i1WFEA---F0KtsXt
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

From: Valentin Schneider <valentin.schneider@arm.com>

commit 475ea6c60279e9f2ddf7e4cf2648cd8ae0608361 upstream.

Will reported that the 'XXX __migrate_task() can fail' in migration_cpu_stop()
can happen, and it *is* sort of a big deal. Looking at it some more, one
will note there is a glaring hole in the deferred CPU selection:

  (w/ CONFIG_CPUSET=n, so that the affinity mask passed via taskset doesn't
  get AND'd with cpu_online_mask)

  $ taskset -pc 0-2 $PID
  # offline CPUs 3-4
  $ taskset -pc 3-5 $PID
    `\
      $PID may stay on 0-2 due to the cpumask_any_distribute() picking an
      offline CPU and __migrate_task() refusing to do anything due to
      cpu_is_allowed().

set_cpus_allowed_ptr() goes to some length to pick a dest_cpu that matches
the right constraints vs affinity and the online/active state of the
CPUs. Reuse that instead of discarding it in the affine_move_task() case.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210526205751.842360-2-valentin.schneider@arm.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 35d8b80d7cb8..b1e87f304ade 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1942,7 +1942,6 @@ static int migration_cpu_stop(void *data)
 	struct migration_arg *arg = data;
 	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
-	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -1975,19 +1974,15 @@ static int migration_cpu_stop(void *data)
 			if (p->migration_pending == pending)
 				p->migration_pending = NULL;
 			complete = true;
-		}
 
-		if (dest_cpu < 0) {
 			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
 				goto out;
-
-			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
 		}
 
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, dest_cpu);
+			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
-			p->wake_cpu = dest_cpu;
+			p->wake_cpu = arg->dest_cpu;
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
@@ -2266,7 +2261,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			init_completion(&my_pending.done);
 			my_pending.arg = (struct migration_arg) {
 				.task = p,
-				.dest_cpu = -1,		/* any */
+				.dest_cpu = dest_cpu,
 				.pending = &my_pending,
 			};
 
@@ -2274,6 +2269,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		} else {
 			pending = p->migration_pending;
 			refcount_inc(&pending->refs);
+			/*
+			 * Affinity has changed, but we've already installed a
+			 * pending. migration_cpu_stop() *must* see this, else
+			 * we risk a completion of the pending despite having a
+			 * task on a disallowed CPU.
+			 *
+			 * Serialized by p->pi_lock, so this is safe.
+			 */
+			pending->arg.dest_cpu = dest_cpu;
 		}
 	}
 	pending = p->migration_pending;
-- 
2.25.1

