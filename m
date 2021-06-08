Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A5C4743D
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C33C61263
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFHEki (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:38 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:10732 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhFHEke (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:34 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15F014935;
        Mon, 7 Jun 2021 21:38:02 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pvy2lB4qOds/ce0DZRfmkbVyth99C0CW3MJe2wwNG++4Mp/1vl43bOnN85T921dbVCYWpsMhUYe1miAOFU7LfXummKtuP+pd4QRfRU5AuoeJV3w1WmCxJkIyGKUWMtpJqTNLdIea7OCD5bfW/vYf9IppRHzjWJRRYP32ujeXoyWWtGN+abMTVXZzKgpiDt9Xdi1mm3n0v/2ckEVRmSW4IN/nmKrZRXPWXvHR7SleVCGdX/yLq3JezohEkXT4TqWah6z6W7woOm5TC8zbgXjN5QYAaIKYZwKKwX6zlXDnlE3mVFihar70Otq8paDB6eGDhHg0oMufpoC6CbZoRvrOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/ht2QhqKMdEi9HJHy5gWuGe6JLZQYHZdVFKn1WOWQ=;
 b=mDvedx1Unr6erRw87s8//TpQ8nAVHvg7OQKh3keEJfcA5MW1UYZ6ONz9pp0sO/ti558O4VFlxqqj9rQaaibg7Rfe0xKyBWXjxgO6B5Tm+OJ8VN66ULAW7z7SLxu45eZsTFhhbgEMBbHKTB/wzOA1sJM1ZF8zL4Q80dsYXEcPApx8pSkKRjrE3rV4fVYhL+dn/kafbtZQ4A1KzH5fatQ4JK96s7W/+MGz4v70C+6xAXjvuiNe8CDQ0PJKlnVQD46viMoXAhcwCNOtQeIYBsQQIwY7lrhY5I/ijYpPBK9WHmdNmIc8SAUgNafMfxMxWuu+5Mv4lbDFDyat9IO8+gtoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/ht2QhqKMdEi9HJHy5gWuGe6JLZQYHZdVFKn1WOWQ=;
 b=hV99FggQDHv9TxJVzJOvqApcQtunbi5cC0OnR0E//at5Cu8CORBV0vNVEYhC9i/QsAFb9de1EkedNdt2skNIKMbOUEy+26pT7e4v+BI8OrEWzO4K9h70Pd02XIWhmubXWxSv6zu+1t72nIYbk71ucjd+QuQACDsrWPmueYYJmaI=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2828.namprd11.prod.outlook.com (2603:10b6:5:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 04:37:58 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:37:58 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 1/7] sched: Fix migration_cpu_stop() requeueing
Date:   Tue,  8 Jun 2021 00:37:30 -0400
Message-Id: <20210608043736.1102914-2-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: d992c95b-f7f2-49ab-0622-08d92a373102
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB282829CB2029ED12E795759D83379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pShztJ2znM9bk3EWwBmeGUFG0mG2AGMJ//8RiLrSaEnw9RNMaqRB6W5Xt1H3xleJS8uvKRMrx5RRdw4PRBiDaflqz9PkPH7GbhO4pISFWYkxkiZ+ev+JQvrkzDOzBDfnSZUYHg5HGeBSZJqVhMe8lRGNMy0HpTjtIP0SErWHm+fu9RviNKOlpfNwv2hu6TU2xP7rsKRmallRM9oeMqaGB+qye5pTEG6XEwWb2vRK4dTLHp7X1Z/BL2UDSsxBg6EmDlw2thT9PZiX6FqsUPxNcRXUJKaNPimzQDBZgn2A9B//vlgQcHhz4Yu47DfPxJlapQeZww7yqRoHVG8mEcavp9FGtPdmyfiAkje1fcFRrpubiVNlhTrQem3tjhGnxCiXYp0cTkuSi+EpKNmDi/iwn0TKDbQetWUPgM9c9km/IV+BS7x0ZCkHAwWd6GIhZueeCSMvaVZ0gLUszZvUvy/el/O/LEmqX96IWdvzF6S4D5c7z6DChtzrCKSwM2Tksk+Ihw3hPVCcn9fYcQ/fnLO4ogc6Rs2akS2Kku+YSqcry2jTSTHJLBpE+9ZoxcaHkzdpSO4CidA2gwrdO67excap7bJJggqQu2X+5xmx6X7aaFEiVCA/OUsuNIgRrcVHgqwW8QJFgRToQlVoYdW96gIQ550nhBE6jLz2ZNpUtolAX1jhiaDBKWWRQfMQujveMGOVgVIiPc23LkezFL7evWHzSLNoiz0opcz6MuCwum+0h34HpbsWgv351vVniW46DMzs9la8D1sVgJ0rdCL4etsSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YL2yNO01xfbl0SYVmmBvUev4stAd22AuTWwJMabwVwZK7fKNTGcwmKHq15de?=
 =?us-ascii?Q?pdRreHkthK91QmAvPRcMsi3MCWYCFkEkNfDRpNAUE1DwCOpay+zX5bckIYQm?=
 =?us-ascii?Q?lP48wHffVTJqTQBeDO7GPQG7i6/Me0IIzKZtOCsjl2/kZicruojmYv1Xe+bE?=
 =?us-ascii?Q?G/2s4UY/5CsP2J8I0p9+eoC2hZ/p//5pA06OTu8aXKeWGbCvShHjKtCXPdjO?=
 =?us-ascii?Q?2KU+jas7hByctQRcmBJcR9ru9p4ayD/lHR4ktdu00TPFCZl98NKap7Fsh5Kv?=
 =?us-ascii?Q?CoUWIgZdqKUITK3VsseJGe8QOOuZjgt+7EpA9ftePzEUdGJi6FCvW6CUZLbr?=
 =?us-ascii?Q?4RjMIOPPP/7z0WSt/mv9uABfRPBm3oZ6iidPh09fvQUv9hAvfwYDZuyYpnfO?=
 =?us-ascii?Q?iNfU7b1LOgghOAM3NR8EIcv4PiiAQGwXIHeIq0inXemkaC8/1xGGRIvNXG7S?=
 =?us-ascii?Q?1wHWb5Z1FsF8JRu6s+qWwLL35+2ddYZvcMvoGmjB460m+P9f6EgIujKZJDLo?=
 =?us-ascii?Q?CHfzSvC0QFjRuerVwn+KUH/x2PB4aJbfs3b2rgeWa/BW0tq5Q6IgKk/rl7Ls?=
 =?us-ascii?Q?enfAPCkIdhXqASsj3WaM/J58Bkp/VNdVqtfGmt8HAuH4AZxUKMFBnVQSaMnE?=
 =?us-ascii?Q?I4bDYztZ0cd2X4HAIovwQMucn13Oi7ushjqS1lzt4r5ox+BpjpXYpkZGttI9?=
 =?us-ascii?Q?CzRPEUGPxHh+aJE8r81Pohi133ughFqqk85TmGqakJzgMo5IliEszlygs9cN?=
 =?us-ascii?Q?aVfyNLoSQVPhYhgtYc9oqDP4GxO0LcdvSgdSCOTfg+XH77UGaaEpr/gYmTac?=
 =?us-ascii?Q?l/Ckf8iCMamD3lgV0mvqZL2ZJDnnyxfOZr+QtteUSu7K1CYC6SnBdEEieB6O?=
 =?us-ascii?Q?CLcWZxIs79/9Hc4oO2Ix2DQAkyJU6hMJwkcr5lFWm324BeO5OJnYzDv1F0zf?=
 =?us-ascii?Q?vBXtpvgHk55YuGvq/HqakaELAcATD+XNXvNG6w9Ew29ioeyoyCc60v51o614?=
 =?us-ascii?Q?3DBIKChvwHRJT87G8I7HkVdilQL8j42cWTlUhdvYaLUi4AD6MfH86FE1itor?=
 =?us-ascii?Q?lIUY2KmF4nvtPfj95+XDQ/kyiAkWuf/QHFHqiN5nHfnQMDbs1SyFZ/QWUMpL?=
 =?us-ascii?Q?wyrNYWYsRRRTYzjG9he2UapbOLaZIycW+x+PZ6WLU38N0T+F5/IFT0dCio4Q?=
 =?us-ascii?Q?aE++B1mrWMs/UYyZu+wpaP+HI5issgj1VcJtvKgvyp58ipOqXozIwMt+Pqho?=
 =?us-ascii?Q?ykT4lH3Fe4GKLNdmpzFf8EZOoV9jLJGcR+Pxq7wHLdQXbOIcMAEPCjIoyP3O?=
 =?us-ascii?Q?ahUxprYTBPAMklE2xfCTRkBH?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d992c95b-f7f2-49ab-0622-08d92a373102
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:37:58.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qmkKVhlMViHBvtdwFmw3wz5/v5IWhRM7HXu/BHAqg5gc4m07dMUG26wJAtBd00SMiuDknMqwP2dvImhk+LGySoBgLvc+9NZh0mniMrVc9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: YwNq0V_5h9ojvjULbrSJNo6D8ksjnvzZ
X-Proofpoint-ORIG-GUID: YwNq0V_5h9ojvjULbrSJNo6D8ksjnvzZ
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

commit 8a6edb5257e2a84720fe78cb179eca58ba76126f upstream.

When affine_move_task(p) is called on a running task @p, which is not
otherwise already changing affinity, we'll first set
p->migration_pending and then do:

	 stop_one_cpu(cpu_of_rq(rq), migration_cpu_stop, &arg);

This then gets us to migration_cpu_stop() running on the CPU that was
previously running our victim task @p.

If we find that our task is no longer on that runqueue (this can
happen because of a concurrent migration due to load-balance etc.),
then we'll end up at the:

	} else if (dest_cpu < 1 || pending) {

branch. Which we'll take because we set pending earlier. Here we first
check if the task @p has already satisfied the affinity constraints,
if so we bail early [A]. Otherwise we'll reissue migration_cpu_stop()
onto the CPU that is now hosting our task @p:

	stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
			    &pending->arg, &pending->stop_work);

Except, we've never initialized pending->arg, which will be all 0s.

This then results in running migration_cpu_stop() on the next CPU with
arg->p == NULL, which gives the by now obvious result of fireworks.

The cure is to change affine_move_task() to always use pending->arg,
furthermore we can use the exact same pattern as the
SCA_MIGRATE_ENABLE case, since we'll block on the pending->done
completion anyway, no point in adding yet another completion in
stop_one_cpu().

This then gives a clear distinction between the two
migration_cpu_stop() use cases:

  - sched_exec() / migrate_task_to() : arg->pending == NULL
  - affine_move_task() : arg->pending != NULL;

And we can have it ignore p->migration_pending when !arg->pending. Any
stop work from sched_exec() / migrate_task_to() is in addition to stop
works from affine_move_task(), which will be sufficient to issue the
completion.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.357743989@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d3aa9db1548..a3dea38f410a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1958,6 +1958,24 @@ static int migration_cpu_stop(void *data)
 	rq_lock(rq, &rf);
 
 	pending = p->migration_pending;
+	if (pending && !arg->pending) {
+		/*
+		 * This happens from sched_exec() and migrate_task_to(),
+		 * neither of them care about pending and just want a task to
+		 * maybe move about.
+		 *
+		 * Even if there is a pending, we can ignore it, since
+		 * affine_move_task() will have it's own stop_work's in flight
+		 * which will manage the completion.
+		 *
+		 * Notably, pending doesn't need to match arg->pending. This can
+		 * happen when tripple concurrent affine_move_task() first sets
+		 * pending, then clears pending and eventually sets another
+		 * pending.
+		 */
+		pending = NULL;
+	}
+
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -2230,10 +2248,6 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	struct migration_arg arg = {
-		.task = p,
-		.dest_cpu = dest_cpu,
-	};
 	bool complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
@@ -2271,6 +2285,12 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
+			my_pending.arg = (struct migration_arg) {
+				.task = p,
+				.dest_cpu = -1,		/* any */
+				.pending = &my_pending,
+			};
+
 			p->migration_pending = &my_pending;
 		} else {
 			pending = p->migration_pending;
@@ -2301,12 +2321,6 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		pending->arg = (struct migration_arg) {
-			.task = p,
-			.dest_cpu = -1,
-			.pending = pending,
-		};
-
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
@@ -2319,8 +2333,11 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		 * is_migration_disabled(p) checks to the stopper, which will
 		 * run on the same CPU as said p.
 		 */
+		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		task_rq_unlock(rq, p, rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
 
 	} else {
 
-- 
2.25.1

