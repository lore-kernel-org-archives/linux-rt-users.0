Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42557C43460
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 05:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297AF611BF
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 05:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbhESFi0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 01:38:26 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:36528 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242569AbhESFgX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 01:36:23 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 01:36:23 EDT
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J5RVLV014966
        for <linux-rt-users@vger.kernel.org>; Wed, 19 May 2021 05:27:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0064b401.pphosted.com with ESMTP id 38muc700w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 19 May 2021 05:27:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnQ7klWGeHtVpXdYwJv27pSx0epl8fz/U7LUweUR5R32kzeR8Vs+2I2XvUYQwPgdncJPRzyso5hLr6YXfFpDiK0oVG4Ou8MyZHgTvGF+81C+TLgwgg0XYIeGsEHzyxJushjA7HcwSvdwAK4N0/hXA7uilajp/oaWnF7HOtpkLtnXFL5KWJVoA/hNeH9KGpXVVAQyViYk2DQ7qnI0XIhwOsnCbfSv4UR5MFl1YsL/SsI7Cea6gJJvvf+YSWxlC2OTQC8nVcmSCo6wlqmAefg7u+vIDkbDx6ikR5d1QnYmaW+6hroFwssP74tmI9UBF9MK+ptI8D55pYBYTYUfHM+hoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUXRiBF/lZXyes80ccqb6lFQ5A9pIavY4o6Ve7lkyns=;
 b=GTA+uLql4uKXs3IF4AI38vP+g338Zo9yQd4dOKFDunGcA1M1RuoEQGN2iRz5C9QNI+RCmv3Tnc+zH+IY2gwK7pWu3DvQMpIUtYzg+44ybfjj6c2vJ+CleAHY+79GJa1qZ+AQXKD4+ckqkg7/NWqPncjtsSM/O/y0BLxHjiG/KD2EAePC9q9suoC8qWnIjbdnI32H8QRrnyrXnDW3kJdbuEUYZ4lhrd3xij43zOcVYgh9xRU7CTLoK5VlYbvhHgTnX7gznx4/bMQeA5Gfd8DbiYWeiSbiiE3BbA6b0uC6LweDajzEeWwNWdWHC2b8KOZpje86rYbkqZK1955PPHqqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUXRiBF/lZXyes80ccqb6lFQ5A9pIavY4o6Ve7lkyns=;
 b=KkYH2JIi8kYkimAmSznPz5YJYF/NbJUaYUqX4Re2xNG3G1da79gGjxpevPIP+fWhWUsap4lz/68pVjZ9OC8qTx2IQ7tZZ4Mwa0MKJTLr5Zfq8j9E6KG60KE4XaZPJuRLLn3neCJK8aMrwSnmOc9RlfPzueK6ojFPT1Yb4PVxKE4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB3435.namprd11.prod.outlook.com (2603:10b6:5:68::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Wed, 19 May 2021 05:27:28 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::d56:1d8a:865c:86cc]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::d56:1d8a:865c:86cc%7]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 05:27:28 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     linux-rt-users@vger.kernel.org
Subject: [PATCH][linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts enabled
Date:   Wed, 19 May 2021 13:27:14 +0800
Message-Id: <20210519052714.1462533-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK0PR01CA0054.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 05:27:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc434b1c-a2d0-4f71-e412-08d91a86cae9
X-MS-TrafficTypeDiagnostic: DM6PR11MB3435:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3435AD5674525DD8A8162CCC8E2B9@DM6PR11MB3435.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMtsdeUqflfZhaFHYFCo7ZbKltZyF7HW9iSL+cmJ/60ra+n5aXvJfcKIKWQd0CGabVfq3UC86YXKLfpJV1TuaIbRbwP/3yTn/fAwPP1HxlmgeHFi8XfX6yo01qDyONnTGMr89hVR8j/3f8dZKVKVxZjFsIpg6/bol5fkXIqAkBJfnMrSorebkKtG70AuQsKy8GMx77Ud1T9bDyZqCf0vqxiLp7hWBCvoJ5J3j7iMkzkQlNw6hELVH+dDVTgOBiP3OkZdhgjzQz69gfJDh2zDOEiGzlhc1NxTRKHEtnbai95PVdExCBe3p2tXUX3/rJVTYMMrlOFgfSNJVRTFdIhvwC5vMvJ/866Xmh39JO2vAWBbs2R5S5sBMev1re/YBbXU2JkyaJ2kXZwxyzRoWkHKb7WVtFtGkwUbIF/0EYsBlFpabj5s3p9IUKPykFEsnaGonMp32cFZgZQo24eXWsRse1jVP68CcqldqQAqzSmCy0Nut/2zDW3UnzyX2OvcRFtk1SQNspr3Nd30Sfq/jpdzjL3XfKAkvXsu5x9uNIC207KZeB92PHzggDblGhPPUzUsECYTtmpFP9nSK23j02XyOZfQTIFTaqd9tCTC+/vufWAOiYRuVPFPwb2NplbeP9BRTlkg5q4No2ll5KH4XCUTNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(376002)(396003)(346002)(6506007)(6666004)(66556008)(26005)(66946007)(66476007)(5660300002)(36756003)(6486002)(38100700002)(44832011)(1076003)(2906002)(316002)(83380400001)(52116002)(478600001)(16526019)(8936002)(2616005)(38350700002)(86362001)(186003)(8676002)(6916009)(6512007)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0ymcxKSqzDoGTvttym1WBT2Sx1za1s353YKEDoaYsyeoIifCX/m8wr3u4MQ4?=
 =?us-ascii?Q?7mpZo3Ow/rcT9AQzmW2zcQFpdXttZUBtuLaPN5dvcaRJgPxXy+9kWJ9Mu8wF?=
 =?us-ascii?Q?qb2+DvF/c0bffQmrHYQSToSbVdiIB+87kOyxJIoS1LHo8m2VTQ8yytcJV5US?=
 =?us-ascii?Q?if+BKDoIrUYURwpu9BYcAEtfG2vr+AN5qpF7Ixmyu3iALIPdI8CDmDOatdKF?=
 =?us-ascii?Q?iFg17T0QDuwExyj1ufHXXwJ9WcAUwvoso4bORfipRaaydpqdLsT84/C4Jhzn?=
 =?us-ascii?Q?35cG8YCyAsq6lr+rGOP6HfDNSCQUKZj0dXvYgG93tocFonUYIC3hKqqVZ148?=
 =?us-ascii?Q?S0SWYqQteoSq+D1jkhkHFWru7mlgkLUgmxhCw6fRlepy7MCxBULuxEbeWNN4?=
 =?us-ascii?Q?0zMcdqx+sqoF088VNhV/nhxWjL4CCMt4HhiZR4VzsPaNB3w/UVNbJ99wPBvK?=
 =?us-ascii?Q?QEY29aub7+8AMT9tGvUmx9ctPTHS9xjNk3FYe4sh3wuWC2CsgOZV61127lA6?=
 =?us-ascii?Q?pSGugrZeuTT3Sr/cb39fGM5+bcq43zB09UrW6IDeJzG7oWSDZaLnONBNa/1a?=
 =?us-ascii?Q?4yvZ7hofJUlLgU+9Sd1RIiel2Xsj4uFlco2wkjwyBAb7jckb5LN9yle5Puy9?=
 =?us-ascii?Q?Rm1C3HcIn2s+BbcAKeuOOoV9ifFq9x5IINAMvAe752X098ebcCrlzcl5/CJ5?=
 =?us-ascii?Q?BJ24PYI8I7Du0d15BPDbEhpATwQOjK89yuyQQ1/cpkVdvqfBH1EkG+0zlmqL?=
 =?us-ascii?Q?EQreWpHvqWVqe9/x7y+SWjaqTtrG+eaEn0c6KQR9B1jtkUqE42E58xMB6P1e?=
 =?us-ascii?Q?xdKLILkzJAfGGOt1CPZ4qkQ1tlIG9kxbm6TobQ3+CBTIpU3BL6q7CXogWaKY?=
 =?us-ascii?Q?bs7vfg+oVLIRjGyTffliZZBkTONkddKiB9rS7MEMcpEW0dYYqde6DELxmeoI?=
 =?us-ascii?Q?goulw7MsHRNdAPC3ikT3TUxHv/HAZpmBhzcgYnrzrs9/7Clq2sUXMf1I2afS?=
 =?us-ascii?Q?W8WKbQkFBzTxz58DQQlD45CC0znLmOPHG9QeqjU6XsYeG5Aw2oRmxCLPsJMr?=
 =?us-ascii?Q?D1DXPhV2RPOmpGe5L9GHWT8tIoGTKIy1xzboAzMOen1tDJGseT+JZNguMx1Z?=
 =?us-ascii?Q?RouHJT6b+i0zLgQ0CMdIx3BvYIAk3Ha0JS/hi0lywNpiLbMAIxE4SjZN34IA?=
 =?us-ascii?Q?Rwd7JdyiGpmGyXXrgsHTw9K+FUnZxGwRtP4LArDsIERlBSP7v2PsAeiLPTBy?=
 =?us-ascii?Q?60Mc1QtcVCUS0mc+ujGbf1drFOM5osQ0sMpvKHBiz3VjAroBb0nvnkkgzh50?=
 =?us-ascii?Q?2iAg149PB25RbOBcoUMT0OYN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc434b1c-a2d0-4f71-e412-08d91a86cae9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:27:28.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DDeV17fnpv09ObYh4HMOQQnQ/wu1UEy4MnCck5tdek3Pk1+jzXWKlEf6AhqXB4EslqhN3at7T5vNhfd8XRL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3435
X-Proofpoint-ORIG-GUID: -H2-tOnorQmfmlN4aTIA7r9mokUlhsYn
X-Proofpoint-GUID: -H2-tOnorQmfmlN4aTIA7r9mokUlhsYn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_01:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190041
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Don`t simplely disable local interrupt delivery of CPU hardware irq, should race
the region inside signal_irq_work, include intel_breadcrumbs_disarm_irq/intel_breadcrumbs_arm_irq.

RT complains about might sleep inside signal_irq_work() because spin_lock will
be invoked after disabling interrupts.

BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
  #0: ffff89c4c00ca970 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1cf/0x6d0
  #1: ffffa433c1f53e60 ((work_completion)(&engine->retire_work)){+.+.}-{0:0}, at: process_one_work+0x1cf 0x6d
  #2: ffff89c4ccb0a0a8 (kernel_context){+.+.}-{0:0}, at: engine_retire+0x62/0x110 [i915]
  #3: ffff89c4cf682300 (wakeref.mutex#3){+.+.}-{0:0}, at: __intel_wakeref_put_last+0x20/0x60 [i915]
  #4: ffff89c4ccb08398 (&b->irq_lock){+.+.}-{0:0}, at: intel_breadcrumbs_disarm_irq+0x20/0xd0 [i915]
 irq event stamp: 2126
 hardirqs last  enabled at (2125): [<ffffffffbb134739>] cancel_delayed_work+0xa9/0xc0
 hardirqs last disabled at (2126): [<ffffffffc0507fe6>] __intel_breadcrumbs_park+0x76/0x80 [i915]
 softirqs last  enabled at (0): [<ffffffffbb1099ce>] copy_process+0x63e/0x1630
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 CPU: 3 PID: 281 Comm: kworker/3:3 Not tainted 5.10.27-rt34-yocto-preempt-rt #1
 Hardware name: Intel(R) Client Systems NUC7i5DNKE/NUC7i5DNB, BIOS DNKBLi5v.86A.0064.2019.0523.1933 05/23 2019
 Workqueue: events engine_retire [i915]
 Call Trace:
  show_stack+0x52/0x58
  dump_stack+0x7d/0x9f
  ___might_sleep.cold+0xe3/0xf4
  rt_spin_lock+0x3f/0xc0
  ? intel_breadcrumbs_disarm_irq+0x20/0xd0 [i915]
  intel_breadcrumbs_disarm_irq+0x20/0xd0 [i915]
  signal_irq_work+0x241/0x660 [i915]
  ? __this_cpu_preempt_check+0x13/0x20
  ? lockdep_hardirqs_off+0x106/0x120
  __intel_breadcrumbs_park+0x3f/0x80 [i915]
  __engine_park+0xbd/0xe0 [i915]
  ____intel_wakeref_put_last+0x22/0x60 [i915]
  __intel_wakeref_put_last+0x50/0x60 [i915]
  intel_context_exit_engine+0x5f/0x70 [i915]
  i915_request_retire+0x139/0x2d0 [i915]
  engine_retire+0xb0/0x110 [i915]
  process_one_work+0x26d/0x6d0
  worker_thread+0x53/0x330
  kthread+0x1b0/0x1d0
  ? process_one_work+0x6d0/0x6d0
  ? __kthread_parkme+0xc0/0xc0
  ret_from_fork+0x22/0x30

Fixes: 9d5612ca165a ("drm/i915/gt: Defer enabling the breadcrumb interrupt to after submission")
Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index 34a645d..01eb18e 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -82,13 +82,15 @@ static void __intel_breadcrumbs_arm_irq(struct intel_breadcrumbs *b)
 
 static void intel_breadcrumbs_arm_irq(struct intel_breadcrumbs *b)
 {
+	unsigned long flags;
+
 	if (!b->irq_engine)
 		return;
 
-	spin_lock(&b->irq_lock);
+	spin_lock_irqsave(&b->irq_lock, flags);
 	if (!b->irq_armed)
 		__intel_breadcrumbs_arm_irq(b);
-	spin_unlock(&b->irq_lock);
+	spin_unlock_irqrestore(&b->irq_lock, flags);
 }
 
 static void __intel_breadcrumbs_disarm_irq(struct intel_breadcrumbs *b)
@@ -103,10 +105,12 @@ static void __intel_breadcrumbs_disarm_irq(struct intel_breadcrumbs *b)
 
 static void intel_breadcrumbs_disarm_irq(struct intel_breadcrumbs *b)
 {
-	spin_lock(&b->irq_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&b->irq_lock, flags);
 	if (b->irq_armed)
 		__intel_breadcrumbs_disarm_irq(b);
-	spin_unlock(&b->irq_lock);
+	spin_unlock_irqrestore(&b->irq_lock, flags);
 }
 
 static void add_signaling_context(struct intel_breadcrumbs *b,
@@ -200,6 +204,7 @@ static void signal_irq_work(struct irq_work *work)
 	const ktime_t timestamp = ktime_get();
 	struct llist_node *signal, *sn;
 	struct intel_context *ce;
+	unsigned long flags;
 
 	signal = NULL;
 	if (unlikely(!llist_empty(&b->signaled_requests)))
@@ -278,11 +283,11 @@ static void signal_irq_work(struct irq_work *work)
 			llist_entry(signal, typeof(*rq), signal_node);
 		struct list_head cb_list;
 
-		spin_lock(&rq->lock);
+		spin_lock_irqsave(&rq->lock, flags);
 		list_replace(&rq->fence.cb_list, &cb_list);
 		__dma_fence_signal__timestamp(&rq->fence, timestamp);
 		__dma_fence_signal__notify(&rq->fence, &cb_list);
-		spin_unlock(&rq->lock);
+		spin_unlock_irqrestore(&rq->lock, flags);
 
 		i915_request_put(rq);
 	}
@@ -337,9 +342,7 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 	/* Kick the work once more to drain the signalers, and disarm the irq */
 	irq_work_sync(&b->irq_work);
 	while (READ_ONCE(b->irq_armed) && !atomic_read(&b->active)) {
-		local_irq_disable();
 		signal_irq_work(&b->irq_work);
-		local_irq_enable();
 		cond_resched();
 	}
 }
-- 
2.7.4

