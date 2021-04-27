Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123FC433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Apr 2021 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E6C613FC
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Apr 2021 22:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhD0WLf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Apr 2021 18:11:35 -0400
Received: from mail-bn8nam11on2104.outbound.protection.outlook.com ([40.107.236.104]:10593
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235382AbhD0WLe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Apr 2021 18:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYSKtGFO4iESZ20tNT9TXvYVzfSUqNfF1aM/fL3HgrSfmpaKxaHzDwNTRSidBHQvZ+5+6Btk485tf0GtmvF1Ajv5pn9wl4yg81bopodxy6LlISjyX/x7K8vng0Kr2RLKA6m0FDdl80RUFIUVuvJ0qs6OxhYgsxlTflnjasfZd5nlvQgJkIr28GFAbXxSy+syeRs05M7vCHgeXA6lZn6xd3Fs743Ju4HTxmPHnSKg+rZdpxAfXrpr928QwF5g1PKmoJWtlFNalvICPs3LvqURmC8vlGlmXSc8CCJJZD21FGm+QIaXO153az+wLiyr4eFEGe7uwR7u7QecllBp7BoQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNu9mjYlKzMFYnOih8uQxKy2dZORb/M2DjY5N82SvZI=;
 b=N9jbaA68OAvNvS344tfYUrbfze0QKyntPiRukSibiefCB9rALtd57+RVZ6BNkpnYMOwaaARwYO90DEsax+1Yb55UXGVpaTrD2Luj/Phz84akEXrx1b8N8ULSbzJVgNVkR2VVDeMpC5DdHlR3/N533/cPeK0/ldk9Ts9dGT9SGTnXDHhvsiWDh/rKyS1OLBkQ6EmjSdUe3B3EdXLVR+kmE9Wr8tISbhbtrtygN9F3462nWITUb9HPC/Ov4gqrq5WhyWMgR+pfesbbo8OQMDEvmlxM+VuLOTEN0l1XfUeH+TNjm74tiGvOd/MtfaTrLkdctUhUv6oeL6uUPWiZowXkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNu9mjYlKzMFYnOih8uQxKy2dZORb/M2DjY5N82SvZI=;
 b=4olxBRo2XudhxoxeHPY06Ba/rDtYAk6Ezr4v/VBZtN2lJB42yjEH3HaTDPTx68el4TW0V9NIyMvGmq50dM1gVoDhSMeCVXwmap1BqagRsJfhcr3Z7sf0rkCvpcRN8pAFsEV5a+2zMz/p6ug9h0XsSSMojPLLUxJMBgZq67QvBB0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR1101MB2102.namprd11.prod.outlook.com (2603:10b6:910:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 22:10:49 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::4568:97b:a1ed:184b]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::4568:97b:a1ed:184b%12]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 22:10:49 +0000
Date:   Tue, 27 Apr 2021 18:10:09 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH] 4.9.263-rt177: Balance local_irq_{disable,enable} in
 irq_forced_thread_fn
Message-ID: <20210427221009.GA23708@zipoli.concurrrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN6PR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:404:4b::24) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrrent-rt.com (12.220.59.2) by BN6PR11CA0038.namprd11.prod.outlook.com (2603:10b6:404:4b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 22:10:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d4b6d0-7fdb-462d-1c0f-08d909c9501e
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2102:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB210233938E546B50B904B94DA0419@CY4PR1101MB2102.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzko4wpFwcNm83zZKJjE0A+65j2JVyaL2C6/owllC3LSfHSrzahBZpGbdInHpIqQZTdzVHiwuk1xmGryBeCgJZd58gkzMScZWJmQXXkblOG0WqmImLtzzFYXXlN+ctDLdk+PQGWpLqPG4FvNrEEEah2xmP5hJJutwwEBA3R85jYk9SEoMPMNd3vuSmw8p4k2mq1iXUKUurNq0yIZDGMgYQkUEVZZ50pnuK/awHGzDH2XKufFUZ3qYTPbzjks2DdyLhBHYf7ZSK5RibMsLJuyGrOKXYKyZPjJDmbcyHT0XRX+U84Vpjp2tBZiYuWNgE7hW4QGj5LOZ3Ez0wFpApflbbWZUWLz/sPmFXr5EEebDeIO68Y6CencHXHJ0NoQzgjX+9OkKC5yf/d6Trs3Qi/fFzAfATNO8pEQtGoffQSBOqEtGdGLvermXejKL9r/qbrhvId/KFIv2O8kgrXO9uyjBdyvi8J8LBUJTcJEgTQ/v01XFCaHJjhD0nL3FQEmnNx3pcs1PgjDF/7Lfx9T8I86y3NG8BI0dYfuYbH2s/QMlz1ItBPSpNM17skbru0aZGDXLCIGxD8czFFJwYuzEi7cUz+ikjvLa+M7s+klK4B+CBT1+qX1U1VhI7JiNSIIeqzDdXu7QXWY2v11zt9CU1A9e/wJ97m+L44GdUBUIB3ciZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39840400004)(186003)(1076003)(16526019)(478600001)(26005)(7696005)(86362001)(3450700001)(38350700002)(6506007)(44832011)(5660300002)(6666004)(52116002)(8676002)(316002)(4326008)(83380400001)(8936002)(54906003)(66476007)(38100700002)(6916009)(55016002)(33656002)(956004)(66946007)(9686003)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Nfu9ySREAjxAoHMPrSXLSqXRY2sgVVfg22y3BGibXzHhq6hN+8AokS+o9Jo?=
 =?us-ascii?Q?LHSGYfX/dCcROp6xA6Gvag6+wEyTff4VaaNSyDXeL8ffoJc0zQaxsGqKVm07?=
 =?us-ascii?Q?Ye5Vqbkmu407KChJ0Yp/ySuj6sLc22BS2JqiLqGXtft3CFhQMwRU+6WPmI61?=
 =?us-ascii?Q?HLWR+DCq9BL94IUhCL+0pCRJnS5nFeGuZFTaA7ZNSG9LXTfOy2r1Ibsr9R4E?=
 =?us-ascii?Q?GNyhhMKxMFfbpCtL5F3lfE+ABHQ9y8DFm4bUdW5VEyi50GXnyv3yswqfbg7W?=
 =?us-ascii?Q?BQ4tdVrZnIiiTYv7a0AM4i5dwR/JNBrto87a170wHOg2YLLmMttflFbqwkWB?=
 =?us-ascii?Q?ZG3RRoTSt5MhRwdnUk/G9Ec5sRltbiBg4AJhmaYQJsW02udi2QlIA58MUn2q?=
 =?us-ascii?Q?T2iH/o2s/w+woxKDIVHYGMxi8V/sxL4iPOX0uL1hcGYHEADK7toVmmQlozIN?=
 =?us-ascii?Q?uXaS+T4vFiyG3cK+atsp4F7dwMFGlD9JK7ASuvk8qKPeXlhTc2QfI7P8dQmj?=
 =?us-ascii?Q?rakMJ/tqM8mUDKPfjI+jklxdnh1FDYOwT3B6SvWrnm5qCYyQxR9Q1+iJLZ7A?=
 =?us-ascii?Q?7mcclBIF+pmT+tJkWSAhLuYS6j7AUWLII6khwF0E28bPGoVvkQnxmhlzpcap?=
 =?us-ascii?Q?CWiXHsLiHz9k89Ax7JPzZMvwQ9fipshQkEKjMuamnbbhYoxkrpxjaKkRmQy0?=
 =?us-ascii?Q?5cNMIPTnnCJDg/OyzsLMk6a0KA29wisFDSkhRbrem7BlvX39fh5TCmMf+QO1?=
 =?us-ascii?Q?2ZnAEI9iYxFkoXyqlM2eLN+b36uj6RC8rwUqds7HX4NxvqolorfuIQHBXoKd?=
 =?us-ascii?Q?fOU8ESq/pHdVt66C3TMB0JHysdJrh5HHlrrIZvhuv3KwEYfWQVjaalxCgzRj?=
 =?us-ascii?Q?X4H+9QYXmjALZfaBuQq85aJZlszrhYgrQeYsj7XUJZvFYD/jYwnVgG72oLzZ?=
 =?us-ascii?Q?q7XkPN/TDdWPZasT/k0YIgLmOPfnLPSyynBR+ZPe2ocRIlvoYj8uFrjCDaYu?=
 =?us-ascii?Q?csOK8JRl+t3DnK3FKkQJU1z9IbBz0duB1fAgQKX24Ae6ggyNf09iPxfvcWff?=
 =?us-ascii?Q?QQp57k5lg7cGM4/9AAQhL9lQI6vGD88QoLbahGyAHlpyJ/1iUVeRZlR+l+T2?=
 =?us-ascii?Q?BoTI90AlBWeww2PJjrOmA4wR8kGjcIjrSwGDHtDS3/PNqkGr5zoFIsvAd/wm?=
 =?us-ascii?Q?00DTbRPok8p7C/We0CKAVhSJhqs+owixxCs2xpdnxa3j0gOYX2wYv29o1yuj?=
 =?us-ascii?Q?ZK+eNBdnzQImEwiT8v74guIMK9dDNLWwn0rdUdsOBlCzWPInBgiKmZ8O9EFj?=
 =?us-ascii?Q?l9UIlce8uMsczs2s8BgzJe8o?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d4b6d0-7fdb-462d-1c0f-08d909c9501e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 22:10:48.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soFBjbCHITFZ1/SI2gWvCB5jk5S5uXwMNRHwHLVVjiVXetqi0M3D56j1r9UjhvzXOWqtSHLoaDPMqrnLciSDp41HPzqVpDASHXzGYSPwJNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2102
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Balance local_irq_{disable,enable} usage in irq_forced_thread_fn

Re: 0152-genirq-Allow-disabling-of-softirq-processing-in-irq-.patch

In 4.9.263-rt177, irq_forced_thread_fn has potentially unbalanced calls to
local_irq_disable ... local_irq_enable.  This is probably not intentional.

I am not absolutely sure what the proper fix is.  Attached is an example
of what that might look like.

[ Issue detected via compiler warning, using a sufficiently advanced gcc ]

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/kernel/irq/manage.c
===================================================================
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1035,6 +1035,9 @@ irq_forced_thread_fn(struct irq_desc *de
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
+		local_irq_enable();
 	/*
 	 * Interrupts which have real time requirements can be set up
 	 * to avoid softirq processing in the thread handler. This is
@@ -1043,8 +1046,6 @@ irq_forced_thread_fn(struct irq_desc *de
 	if (irq_settings_no_softirq_call(desc))
 		_local_bh_enable();
 	else
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
-			local_irq_enable();
 		local_bh_enable();
 	return ret;
 }
