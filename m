Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D94C47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BDB6124B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFHEkh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:37 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:10480 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhFHEke (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:34 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584c15G014935;
        Mon, 7 Jun 2021 21:38:02 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVLAtspecV+CjgWMmZt9N5RmFDbNwIHmMoLX95ErTfsgd5CctSuzM35qozvjEAm6G2txbIoy5A06O8bc/HXWmr5eAJ929fAoHvqQOZbTsTXPzzdsu9f2Ias6LIeqeE32sw8X8aiGpXaXKWNAN6uRNZatBsXV3W3NxgOdZexyWgbPZ0ngqNOgNu4FCka3p5kIGnYgfbpKuB1dSBfuELl0D243mpfi0fMVtxaAOzel5o206aEn5cpK6M9A3/uNCfDwk4cAdrDnkE1cklUNSqmuLZaDd9Bc8krR19YpvuEMfACYFU+/CyIc1pXJWrkWNdB9HhEJlneEylNM49/Q1PCyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6IYIwm38uS/csBlWHE2OHPTENVFzWGKWOBMemxzhMU=;
 b=g27yHkR3u08FRmQZMg/Cqu3jP9fP8mEEhcLu8Vnz0Ka7EdLXc6djXkPwD/iSRywDhuukc2t/q9/cMJ8C5ZkpFK3YQQRORKFbWrQIPzgLAtKq6GT/XmRAISzn8bMVAyYWnAEhh6LCGXGxpLI+Y6wwxbgCyr8yJv+GnaHQfKhPkQ1mk4K2kJhowPKLkk9jCxv1cMWmFdt/dqa22VEV+oQXq1J7dJ+vzFJJNy7VFG5uOp93iqLhoaIlcm2VM2AyfEDp+k2Tc6fkd5PDx8uaV2Ntd7e5UiEEVjDRwu8oQ4uBcCEwE+muxeuAed7GZdpZ3VuDhEYTBL+YDVbCDC0O5bmFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6IYIwm38uS/csBlWHE2OHPTENVFzWGKWOBMemxzhMU=;
 b=nlhkWeMx17QY7QFdNlw/x6LHmvTnfAbItEKB2urGByCyZd2RCT7xLy9hBEMicYfUgRc1+WlJNpKfZtCWgxJYNtju3u6MlZ+37p7zY7D3O3Fytg3F8FiH4c7s6YH5YYFsipNp09tVmdY8jh8ApjQkIeTV/DcISQCyM7BLGRS27mc=
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
Subject: [PATCH 4/7] sched: Optimize migration_cpu_stop()
Date:   Tue,  8 Jun 2021 00:37:33 -0400
Message-Id: <20210608043736.1102914-5-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42dd5bb1-7d61-444a-fa2c-08d92a373216
X-MS-TrafficTypeDiagnostic: DM6PR11MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR11MB282838514B7CE77913B15A2B83379@DM6PR11MB2828.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcKkyFQ/ZuMQE6SN9do5XMiSmMb4dPd7j5ZW8mi4WPZ7W/0XCVDA3dM8nu3FvizSZ2vy0Vfw/+ECznqVG+eqJqk/4QRkr1mkM9iECoQ7HnAiSXOamTzxPqlsOgyoRMzIL1sGadISc4lup7lNLEUXhFMKiGpJDi/XkIDOHqKZhiLMLNlye5OpnQ3Hu01EV7mCGQ9cpsfF874TTA4fhcrtoKk8vOwlCLCl12K95uAAbW0JLojmst3VvrHmii8AJBnYr0+gJzJgwl/giMlfekWBpnfr+QvHPiVDyUdTKoFrgyTM4ow0wjAAMF3x4PJTVy2rzTdjHwEtdN/szlftApdwNhq/QaqhE0TlhuGdwU7EGHPD+nakhMxocc+xEw69bC2Ly9tbZtLVkLdw3JrGXsAxoQWVy3IO6zS2OZDXQJ6D4w+U9I9qHSzHF5XKwkCmN/pXelGOW1InbAy5CTkSFp8MMJ7MJrT1ieeR2w1M42PsdxkBrUO61wyIEA8ioNIh+eGf4Ka6Xh3bV1fWkHXZgPD0vE2xAts2JjRODa9LOJfSyhxXv/6F5QVCOdeFWpuaCN4FZjobbaaumfumweko6LkCzHRBpQIRgQ9EgDc6+AMdd8HDVFwzpAOwNoVwKLM7PBmrkeqedjmiuZoVDeuU4OcVtQLzP7C3WHSzqeZcF0RrWZKqgEBZ5ssEuLbkKHrfRglyJSaYfBHfCvpen7jAqO7w/hMfYuX349chaY9O+HW0x+FV8toq26tSkVxfwIP3MXT/HJe/e5iIoxTOadnpsQw55baa2+s1GTKhq1rB6ZcnY6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(316002)(54906003)(38350700002)(1076003)(6506007)(478600001)(26005)(4326008)(36756003)(6486002)(66556008)(966005)(8676002)(110136005)(6512007)(66946007)(5660300002)(86362001)(44832011)(16526019)(83380400001)(2616005)(52116002)(956004)(186003)(38100700002)(8936002)(2906002)(6666004)(66476007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3jOCIG5g9TaxG8F7m2V6dMqH0Uze6LB8lSYJs+DlYIIb+k4O+/edBH/zWB2?=
 =?us-ascii?Q?A56aU2THc3pTqRMshIq6ZlJfgio33RRByqkzf1OyWk4dcdS6brkWtem3RHrE?=
 =?us-ascii?Q?EAKTFJF1fzCRflEe5Bddv+Gr1gsqqSmSwNiohcj1e6NXY9Pp2E4UYxLX9cGR?=
 =?us-ascii?Q?bZF3QFB71VuDeYrSM8b7PYCbnK6hp7z7SSP+FaTr6iHW6Odu4mBvSFRcx4Zk?=
 =?us-ascii?Q?JC8YTTgBibkCChA78/KqmNQiqPJUXwOQmZxlvlzR7jfpIvzaiumCigYUCM/c?=
 =?us-ascii?Q?BmjMsYSilWDWk0+apVCgLavSYXhZpx6G7wNeECpJFR29jrOAlSfVXK3KGn1d?=
 =?us-ascii?Q?3zETqPmrJOaDV92fHY859cjrcP94i7ChBF2vttvjDioKdhTv6SpCwpIHVJ//?=
 =?us-ascii?Q?EPm6GenXOGnmwJHweLOA6mf3OLDLRfN237az4NQ7hPo3dPw/QSCDk43T0AO1?=
 =?us-ascii?Q?R2YYx+5cPlqWx7JQAJkqLCjmZAJYdBns2OQzCrQdJYKWoL3hF9XkNV4v4nU/?=
 =?us-ascii?Q?mqjFS0U/vFNCZrbfUqr7PhSUk1rAWhREjP4CXkuHGkmgmCgO0WJlm1EcIi9w?=
 =?us-ascii?Q?+brMGD3lLy1MrrcxCpcKILvKXww2ouARVPyf/SggBY/469QpHsbmNywpcXED?=
 =?us-ascii?Q?MkEypKZ60t5mQdOeamOd9p3whCQtLmoCGbu+x+ZNbYQCbMWxT5y6jAL/RTPs?=
 =?us-ascii?Q?aD8NNyjhD4fBTRoseL2sIQnBhezSbA3Px4sxIIMBKhjlrE1nyLbVOlYyMuhu?=
 =?us-ascii?Q?0wJnIAv5rP4j4HEH2B44ItZs5JZeD3KY6GvI9MPOLHg1SuVGUpkRRH6nCu4/?=
 =?us-ascii?Q?KLjhNB4xmARwPlB58AVZyR/qOgXmsAsi1K1oYw8MYnorD8xsL3S8AxloSDLz?=
 =?us-ascii?Q?Pi//KwctGmyIr8BQagkfjPHAsHRHl66F3F2k2OyGcM93RRcOJOVfeoVSlVno?=
 =?us-ascii?Q?pkkLiE+jNuO9VJAOU+bBSOff1YZP801mQLMV5gxDwn2nQRekDUtJZVlsj2Om?=
 =?us-ascii?Q?m0ci2NYI+Eaeh17xxH719Ymmusm0NOH+kIGc2RWWzeglwsZOYrkGSQ2kRxiC?=
 =?us-ascii?Q?6mZpfA4ltTayBpFADbii95L2p8NA21vaB0NMxnl2bUyhFPL1OdIpLnYEP38e?=
 =?us-ascii?Q?p28wO5GWVr3WP1kvin41g9CzuRCVnOwpli6now7/WDbqw7+qSy4hSX7v31R8?=
 =?us-ascii?Q?u4KZaNSDRehoEFboulKV7XCQliCC7Y3cdr0SmWuN4IWj4JnsMyAlF+/9Ewdw?=
 =?us-ascii?Q?OGxMvSb+STVqFT6jl114GU8kwF4r/8laqwN8QJLGMPOKEFp0koAERtHxdRJn?=
 =?us-ascii?Q?LqUYLhjiku5XVg5B5iwV5oB5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dd5bb1-7d61-444a-fa2c-08d92a373216
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:38:00.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRJlb+SHrO7GmCPywMONpUAaqujwUFH9KTh0QILX7OogXvNHS9FsM1xBfCcv4q7v9bRyRm0ncDTobeSASvxpDoS9P5mTLWFkWznDQQ4YUkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2828
X-Proofpoint-GUID: dKOhaqGaQKabT8R1-WXiC-be7ZdeUfD8
X-Proofpoint-ORIG-GUID: dKOhaqGaQKabT8R1-WXiC-be7ZdeUfD8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=692 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080030
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 3f1bc119cd7fc987c8ed25ffb717f99403bb308c upstream.

When the purpose of migration_cpu_stop() is to migrate the task to
'any' valid CPU, don't migrate the task when it's already running on a
valid CPU.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.569238629@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6880c300c624..9cbe12d8c5bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1972,14 +1972,25 @@ static int migration_cpu_stop(void *data)
 			complete = true;
 		}
 
-		if (dest_cpu < 0)
+		if (dest_cpu < 0) {
+			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
+				goto out;
+
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
+		/*
+		 * XXX __migrate_task() can fail, at which point we might end
+		 * up running on a dodgy CPU, AFAICT this can only happen
+		 * during CPU hotplug, at which point we'll get pushed out
+		 * anyway, so it's probably not a big deal.
+		 */
+
 	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
-- 
2.25.1

