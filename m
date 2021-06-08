Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C3C48BCD
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BFE61278
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFHEkk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:40 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11466 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhFHEkf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:35 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15E014935;
        Mon, 7 Jun 2021 21:38:01 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/+eE473RDhvuk6eYVxJ/gOUeGKE8vWgLKLBYa9vtVgWKqHYst8ShOOCGn9+Olwevbklq3rcS6snGNmG6iA5ryAAS6kSxUM+oQ8nFtnJ51eYavukCISf+Mo5kZSK1GGV26fmbsrKYOuNlK5qwc4cVucMAdXwdGDwOXl7NytTpCje96rx42/hgmRS9ao8EMw3lgdMhE+WqlHbUlWfXBHthA+U5On7RMWZ8927iKZegs9QMMAEX/ih/AK8wNK14rTIMXkQknXxKQlycalcWwPtKsmTaeGELvf8B8Js38CUXOXTcIvi5D8wv31BV3gjKVZL9BxPfsyQqLVAR/ZdbDvb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5BBARzenFNC9YLzUdXR++8SV8RSF/Qqyv0hfZrDqvg=;
 b=W7e/qJr3TUmQ7IoKTYBZN0r/NZOOkb+GIRyOZ3p8mauIhVljLUH+hU4JUYXgAofZb076Qv/Sseq8Ch2IKwLKH6NA0gtvnxq8QP14ss5KukSBzuaAUUIujXoqPlPeSOeMsbe5uaj+lpnVgBsvx+DonX7H4YlUxhxfqlgjU2Ch9alKn7tOUi1bV+J3jDCrkJR1LTeq9P0qvV2u23mVHkYepMY98Tm6Nz50fYa+qQlAzRlCzGDd+7vzR3A9QhAH21rhxhkuTqFwFKGIvxO+veJb2A8xyDXB5xTnOGO/gRfu5ml4eh+kl9NrwX5h50Uxjsh28oYAQo24TSJyDbTHuwXkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5BBARzenFNC9YLzUdXR++8SV8RSF/Qqyv0hfZrDqvg=;
 b=ZQ06/sO0apjdtfsLt0f+XHk4T7wjrJW/m0lZfdaGZDsnKXKg5JKZHt5MtrQpCymnfg9yXfYF1VLAszpwRLd1HPex5Gh0zHBkkNfIzh8w5pN9002iaI5aJ+7RL50z9d7bu1iXDJPx4441WZq3IEq2YO0svCV/UrIn7x1kinDv1yU=
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
Subject: [PATCH 3/7] sched: Collate affine_move_task() stoppers
Date:   Tue,  8 Jun 2021 00:37:32 -0400
Message-Id: <20210608043736.1102914-4-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27 via Frontend Transport; Tue, 8 Jun 2021 04:37:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 056602d8-fd99-4d76-414d-08d92a3731be
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2828BB9F8D9445B904A552C683379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeffILRR5BTkmL1noWjSSUlCsj3cKA6ecfe36+b2Pju2VTyedqbv+Jc6f7FkMSusx549ZRcmwMx2PogPnvsUzSeeXG1Eq0LP3UiTFvnlzeFXqt/syI8up0o31ktI85d1wqZJO/Kw/xDPpDCk/DAil8JYkrNjAa4dfcECMYO4AL+vrHOYH94qtlS2rrdnqNEIccOGCyUga1KdY99YRDSIa4cvTiQNENS0jcjUrmI5uXyNDENiXcQ9AGutg3gMQ1kda8HKpU/QvlkK1mX3qU4kKFwIaAIDDPUi0EHgpt4kdsDZxahIg6r95Fxcr2nNEV505LAEyBsU8ktJex6ehxzTukmgDg9v71UDvKZJXep0ZOKx3gJKI0z3TCoOYDo8OzEFeizzQAtzVOKBr2sUjVbHCBnW215I22emQgvPeGFOxBVuBD0IlmqByABtk9k3JFw8RdW94w1SqwKr3vV2WYCXcKCg6IyKr0IV6ktB6ERVLx/moFn5rs7DYtIO8kVrd4JKw0EukUKJvWtqqrvKmS2rQRrkBAXRHmwggyxEzz4TsCtHWDc4pp4hPgNjmNYGTH0p4vYCl+4UvYcYwNUu9Rg/Rmp+749JLAayfVR/GnZBbPEaVUVOmp0fUB2c+fJzskqTaKeL8L3IIkcLMmd4cP8CFWwfGI8b5B94fTrvgvRbYqX/CK7+YwXH4+T7Lew9CV9GTXt9LQUYBE+rPnQH5zlc+YSjTYwK1q1x8ul4Aj7n4+PJilY70WizlwxT+fxxrdFIYRqr1hS6QSskcvj35fhEpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXU4hiUVI5Jxn0GcyRXOb66z5rjaZNuSDBfapono8Bem1gDikU++Ud0HFDjp?=
 =?us-ascii?Q?YD50QJXico1AAkKs9R3I19JT+1ZfpkHOgt+Bn3aYSYQPBKt7p/VBVGNs0olP?=
 =?us-ascii?Q?Ix7WaWFtg18Yino+Jz3V7sj+OZ+eOBSDURjny5FyjxJ18miZtnrNk1oDMcGm?=
 =?us-ascii?Q?f2BDAsNmGWI8ey01W97Y7ydqVXQM7P2FQ+lg5+cUFwOBeg1YvQ2fyjqOauAo?=
 =?us-ascii?Q?MFtHVxnWNNgdJUxazbYBUx8S5WJkuCpWbVxT0xgCDpWHHPDIGhuCcSLtU0kq?=
 =?us-ascii?Q?N0QLTr8a+LeHuzVpJKKmOEuRG5RkfsX7qtE7k7JAmjBvqLBK14EhrW3m/2Lg?=
 =?us-ascii?Q?07aTij/s8vG4fxgHMTwn+zxh/Wv9hUNJfZDrUM7316Huy5r0MX3MHcLPVWso?=
 =?us-ascii?Q?aF4g04+2+Hv8IrHlmwZRpfNEt6+eo9Zg82Hg/l2CMcxx9JN3s+/OLzWNBXJX?=
 =?us-ascii?Q?ea5mvYcoYrbTgQJKWFS4wEACsBLSn0RakPdyYGx8c/Iv1HEHiRhieS3qGulM?=
 =?us-ascii?Q?opIV0UMSXNqetAgwOkdoEuKJt8rliQiHSEctz3x5jFRbasCzv+tCElWdrPYD?=
 =?us-ascii?Q?cXZWUGl/Zum9O14e+dgoqLedYNSxkJqmeXlOuxqPtZEcfu2XmRdtmL6kQusm?=
 =?us-ascii?Q?wc+JPfjYDMQfhG+eHTQ9LZ7YlreLdZj0r6ajv4WgMDcKQy/j5Ncjj1IDCa2Y?=
 =?us-ascii?Q?L4uJgMv2PgkTvwJ4y5oRZ76vNNqx1SfTdzTv6NJzphQAWB71GRTrUEGuXgBI?=
 =?us-ascii?Q?19cWHb09Rt/hRXFMQEKJlkfn1U/BwIILc0NdhGEqKS+Jz2oXudVPf+lU/7vD?=
 =?us-ascii?Q?STkKubNqQUJikfke/zGLw6prZ1r1UNdy4X0jm9naH5EPjArIrLzmOKS6nYSG?=
 =?us-ascii?Q?RSdL+HXMu4gatndBqWkLwbxncZrq1E3ccztrxYSdBRhROONrt2xubZH3ERML?=
 =?us-ascii?Q?2cLbAr1x5oa9ZAyneDWZgZH9NzoKKHMMyMkZnTTAYz1fPzWBVsZqZ55sjTxw?=
 =?us-ascii?Q?nAlWz7J3Jf6V7i+KUlyCXRKGzwZt9bB9ybYRB50pngbL1dXZAqmvUCuigtrY?=
 =?us-ascii?Q?OHE659JY1AQ84j5jfdlJnbk01vY660XEkCTs0cpdztheeLkPYrmn8oO+WNum?=
 =?us-ascii?Q?OjRAdJ0uJj3JvGniB5F6rCj6ghUtWokRs3a33ydKUP2dLg1Joz8fS9Wt1o4o?=
 =?us-ascii?Q?GXy4c8RmBtCqIlD1Ln81iJi9IHtQgTZrd6qOLUtbVVtwh9d1b7aMnZLyE+Ln?=
 =?us-ascii?Q?z283W6in/Y2dsMRNgQ31LbkgD8J541JVsUzzo95+0PWorH6kxmOb+0QK3WVh?=
 =?us-ascii?Q?r46cfeQjYHh2WO05y450aM9x?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056602d8-fd99-4d76-414d-08d92a3731be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:37:59.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoULl9n+PT6WVDfJLJD5NpXcD/+1EuVtNpfIEo0DGLOsMBJaHM944+WazKbmoh59BSSsuJEifl/oDnRmjQaW8C3INDu8357zqzTYtBSiHZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: kX44MNoO1hALsnwzwfamglSvZsPzaFdt
X-Proofpoint-ORIG-GUID: kX44MNoO1hALsnwzwfamglSvZsPzaFdt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=449 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080030
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 58b1a45086b5f80f2b2842aa7ed0da51a64a302b upstream.

The SCA_MIGRATE_ENABLE and task_running() cases are almost identical,
collapse them to avoid further duplication.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.500108964@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d497b13efb53..6880c300c624 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2275,30 +2275,23 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (flags & SCA_MIGRATE_ENABLE) {
-
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
-		p->migration_flags &= ~MDF_PUSH;
-		task_rq_unlock(rq, p, rf);
-
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
-
-		return 0;
-	}
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		/*
-		 * Lessen races (and headaches) by delegating
-		 * is_migration_disabled(p) checks to the stopper, which will
-		 * run on the same CPU as said p.
+		 * MIGRATE_ENABLE gets here because 'p == current', but for
+		 * anything else we cannot do is_migration_disabled(), punt
+		 * and have the stopper function handle it all race-free.
 		 */
+
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		if (flags & SCA_MIGRATE_ENABLE)
+			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
+		if (flags & SCA_MIGRATE_ENABLE)
+			return 0;
 	} else {
 
 		if (!is_migration_disabled(p)) {
-- 
2.25.1

