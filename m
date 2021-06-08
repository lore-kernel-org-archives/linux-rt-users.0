Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73AC4743E
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6E76124B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhFHEkl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:41 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:12786 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhFHEkh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:37 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15H014935;
        Mon, 7 Jun 2021 21:38:03 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1UY2WfjPo1Ax1F8Vor8BRyUn651do+hRlN0/bh8VoT77nOajLdhTJjIWxcwBw3VqOcYuIex4vLQvhJEefdlAIGhybvjLHrIcoHqCMBiadYj/HlHcboRxYfUmJVSDjYgaBxEYkyfQsR5jZ4chKWs8zWI6aefM4Hrf1GqAOTQkzRvqvxtwZpwEbZgA2kaWLOPjGru+3MmINZ6cH+oFCPbNUJQVCYGvC1zZ40Dn4L4jTlZSz7icdEQstLgBzCNxG1AmVQpWN+WsrXaWuuUIztk3Dcg34O/I2gvk/uLFN4qi3Lx5UbYwFQx2F6LXLdfBPUMHslZbEP4SKojZWQBDh1IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4j1NLFO0Yj7ALuv5f3qToeegywIBCerMO2tvK43/DU=;
 b=bIMf81Ddew+xJG01IhI9JZ9Gz98MZZyBPKsY6lhorhG7jRa+lrYLwzUiHaiF3e5sm/uW3c9ALrUpNoVODkRgdWal3hILl3KAalHX0k02ut9+wK8lAC9tmwf3yXTXGRZnsJkSkGyD1mItYd3wnlgHzRc/NIdey0jdLOdW46BWVwQBv5FikwNEhFhXJvPOspnPnaLRyeVVpJhKpXblNORJRzgVFfsgRrEUp4Ob++ZkES63qyc/AKA2BsYpmeEDnZvkbIGlLfb/RqrVQ7MbSqRymdMUkuuQ6d1Sn5yDCGzywXr27HpRrGx7mMAy8Vrw7Smo1J0ZA8ndHib5DwmMLxabpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4j1NLFO0Yj7ALuv5f3qToeegywIBCerMO2tvK43/DU=;
 b=O5qxn20v06xL5F2BLa6phL7NRMinNdm44rAK42ISJnHQ298hfgaP2ssh4RVmMQPFlWnl9w13odWWZ3qXTWFfUH8jtDfFJ9Izz2RbfaNILkgV16+hU4QZzFRO1HhQwkXMMn1t4OfdC3Y6kO0GMqWiUhxLaTop4G8NoWovfF1PQxc=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2828.namprd11.prod.outlook.com (2603:10b6:5:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 04:38:00 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:38:00 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 5/7] sched: Fix affine_move_task() self-concurrency
Date:   Tue,  8 Jun 2021 00:37:34 -0400
Message-Id: <20210608043736.1102914-6-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27 via Frontend Transport; Tue, 8 Jun 2021 04:38:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1238567e-c02b-4d1f-c350-08d92a373270
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB28281857D09D2FF0067001EB83379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EL0KTxBuAnbOyIqyHZFC0/FzYDBXVour3Hh5yCZdENO0DEFp+k2DvASJqE+rtoRAnmuQWOUDxzlm2W36+FkBMAbj0qJR/RW/CK5QCoVFF6BYCxLI3tQTLWHi22pj9qWiCuvTjTDcUYukqlMlPjXMdEW9S0qpulbbGTsMwiv1kAvaPFygXlT48dKbuvolWJPQ6Sl40xYLrjSW1eFVxkZQ5jvBvqAvYnY8ZmOHtUQGS7HXPVEGJnkNQaM8a08pFGUnhXCuvM7Y3BGH6kmM53kzN21MFriHHKEpx1vvgPeo23XmMsBNZJEcMLrvTKehjO35I786L4xEFTISyt4XMUK/sdNUFwInJlDUeR1gS2RgUfVLd/KyFlqEbHWHaPZyKl0mSINTtjx7vnz+VpjYmys1S59CaTBhZJ1Zw/mZCoZ69PWZpS2/uTcvzZUwSF/8xArDtN0GIz21QDqwn9vJzzllMLOoxt+51/0hLP8DG5wgK7EWvjjnHXpB8eLhD4lTldBfXyIolnOXykPpyJvioCC+Lg9rlO1OjGS2kIAyyqkStcAl1zer/+HrEcA/gSo3DhsWz7iNueuPkmE0Dh3PuldTWf8cB1TXEOXy5kFk0v/nlPQsaIfzpAJ/mflM4iFpkpazZiiPRbdKRPAwoEoEdCIE575aQEkdvvZLpmObQQ3b9HmG4UmHeV1C67JIs8WWma7CfMWpNJ9/8G7XM3PH8mTRThP1iIeDNxu1950jMACSh2ZI/GkP7WrFW5rFSveTK3NBgD1cJswCiwkHoGb4qhKnow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8RCw0ydXpL3w2Sucd1aRYIZeRGQVa4B6AC51dZrhgyRnyOQNUT77lsAXfwDX?=
 =?us-ascii?Q?hSBK+krG60AbDSWbf/SHYZf0o9ANEugunC5mjWvDv1uw9Gu0ME3Ce62YZqse?=
 =?us-ascii?Q?1RzFRxF3d+cY/U2lcwzYe8uv1bzXVu5MLR5RzZKIzXSA7mVQZIEakDa8Fagy?=
 =?us-ascii?Q?dwcIPCBcNgl93oQQbrW5p9wgJDfWwoScAxVomIvcQ8atIADi3RWVbBb/eoG6?=
 =?us-ascii?Q?LCpu74JGK+f76D7vq8DTlrBK+aHLMp3tLbef1mJnR20jtpPSQiUvxLCDNRC9?=
 =?us-ascii?Q?+aiT80RrQ0Y1m+0GPTySYRuh2bczln20ix5QY/uZW/i7VmdjzwYHE2TNIkvY?=
 =?us-ascii?Q?E9S3b5xLBgTNq3A6+1uJQDIkfghpwRK/MU+fyQZczUCfY3boLK3tzlK6nw9T?=
 =?us-ascii?Q?N/2+CJaoBqx86O1JNuVyUe+/yf6quZZhPiUM1o5BCAj6CLZO5ld/JBqYXrdo?=
 =?us-ascii?Q?Ps313l2xFIGHKDfdPISaPRVtCJulifJq3USMBa3SPqABr28pMAFmZSGebmy+?=
 =?us-ascii?Q?WZc4fWQir9YALwn4C+CEzQZG5Oj/mZb3Hjzi2czM/Y3fvHXHBhLzDJfLPOFM?=
 =?us-ascii?Q?U0YfONfbEXoI3u1eH84fvEJQ+O1AjYg31gUHAmSuPb2avQLBB52ZlpcD929w?=
 =?us-ascii?Q?htdjHgg5I6IIV0sJNdvLuyGDHCXLDC+cCpExJoWiwcHCnTgkdp1GbgkXuwbE?=
 =?us-ascii?Q?rbQBVfjgcD9DofoyYKhk2/WJggDzRIJ9zT8lDdY/xomGvT1EhAEh4Jp5tCZO?=
 =?us-ascii?Q?DZhnp9GICcT7TgfXp8pBdyeDgGE8Xxer06JtnllkSztA45YCpMl8dcPXeGLl?=
 =?us-ascii?Q?dmBaKV28FLU8VouCdfvwFKdS/n09/MjFxCOM/dqLkfGWTrABKHfK1RkzCfN5?=
 =?us-ascii?Q?kVhfsjJVy/1X408L6OegCUbG3q8AreEExpSFKVv28+jtW44yKh5//R5KtjeS?=
 =?us-ascii?Q?PsSYtd91EMCkZ/BwDQeUKf4lJqbWhcMFktqWbbfkJpdFs3aE1bta/T5ikLO5?=
 =?us-ascii?Q?CZF7Fa+z3gFTuLglmdhlr005OnPBja+OYs/ECF1p8mba1UJQyl1ReooVXpkl?=
 =?us-ascii?Q?c6Rdmn6Z+1lhSG1MGr30YNmeNQIMV4LkM5UVZZ/uWiuXJjn6xgjbvMCKN8x0?=
 =?us-ascii?Q?RgmxoJk8vVqXnx5aWZFi47e5I7OGUMKgSeWMsg4W7KgtE5vjQk3Gc+PCZ/fo?=
 =?us-ascii?Q?XiHPUkbx9VUH33YD6ZL/ap1gBwZKjLkiAUwIp33iYcr5dyoYwC5rQGDBEWds?=
 =?us-ascii?Q?RJrowdwND4kbEqZsVpPV2VMeA4vKzdwWC48xMgJSPg549E2+qH2LXddbi45/?=
 =?us-ascii?Q?KwQEKIHSUZgID3Q5G3oNKNgX?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1238567e-c02b-4d1f-c350-08d92a373270
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:38:00.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l6ntA3cqbuG4hI2PxqEoMrPfTtohliw8t0yNg6SWvJdkONqcgZ70b2yXDrZdPzaZqKnPuzuqpMna/iJxyG33UryDol6vLkDyggyn9EbIq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: PYVsbm0IPxznY-sEBZQQVFmD93vE3Lv7
X-Proofpoint-ORIG-GUID: PYVsbm0IPxznY-sEBZQQVFmD93vE3Lv7
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

commit 9e81889c7648d48dd5fe13f41cbc99f3c362484a upstream.

Consider:

   sched_setaffinity(p, X);		sched_setaffinity(p, Y);

Then the first will install p->migration_pending = &my_pending; and
issue stop_one_cpu_nowait(pending); and the second one will read
p->migration_pending and _also_ issue: stop_one_cpu_nowait(pending),
the _SAME_ @pending.

This causes stopper list corruption.

Add set_affinity_pending::stop_pending, to indicate if a stopper is in
progress.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.649146419@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9cbe12d8c5bd..20588a59300d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1900,6 +1900,7 @@ struct migration_arg {
 
 struct set_affinity_pending {
 	refcount_t		refs;
+	unsigned int		stop_pending;
 	struct completion	done;
 	struct cpu_stop_work	stop_work;
 	struct migration_arg	arg;
@@ -2018,12 +2019,15 @@ static int migration_cpu_stop(void *data)
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
+		WARN_ON_ONCE(!pending->stop_pending);
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		return 0;
 	}
 out:
+	if (pending)
+		pending->stop_pending = false;
 	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
@@ -2219,7 +2223,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	bool complete = false;
+	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
@@ -2292,14 +2296,19 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		 * anything else we cannot do is_migration_disabled(), punt
 		 * and have the stopper function handle it all race-free.
 		 */
+		stop_pending = pending->stop_pending;
+		if (!stop_pending)
+			pending->stop_pending = true;
 
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
+		if (!stop_pending) {
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		}
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
-- 
2.25.1

