Received: from mx0a-000e8d01.pphosted.com (mx0a-000e8d01.pphosted.com [148.163.147.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C11EEF9;
	Thu, 26 Dec 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735241504; cv=fail; b=c2HlcTNWngL+1JAHZIT++uossL50193trN2yHW5+A+RhEtp3I0rCedU49Tde4key4XwtK/CmLeUGCnMgtNfsL4UpsGHBJhZFWPdab6Jeh9wx5WyBIUq3jZ1C61YPMxAA8zgy+BsgrsItNDRn6k6D26IwDsqmuUitbY0tJvXT4zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735241504; c=relaxed/simple;
	bh=llxxqd7B7MvDfUDr/kLNUs0XXtuzqWARI+Lgv2KorHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QwIcO1L/Zz664xtt0Emecm0yXbZBj1074V+P96D11S9/FfaZKLEvOqmZkKuBflu+RGZ3cdEoXDwLMyclffp4eXjsJQ2sS/ordR35JJ++g/VFrH/gxz4Wnq35I9dZdaxpbhuoSlH/h8fcgtXhyt5qZ9saMnYQxIEHbqzdqt7oniw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=pEW28YQQ; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=Gr/Pdt+O; arc=fail smtp.client-ip=148.163.147.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="pEW28YQQ";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="Gr/Pdt+O"
Received: from pps.filterd (m0136169.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQIQPC0010936;
	Thu, 26 Dec 2024 11:13:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=sel1; bh=2ofvxikVs8zP7YauVO7a7Ww19vZ
	JxGcbLnazC28dRKo=; b=pEW28YQQpEZYaNGQL/9kCcDWVvLq5NnZmbL1PBb+MAe
	gL8Rrc/Mzs6GOVlV1OW/BLu4dJnWgS1yB0zyQnmmV1FsIDEIIJUWZcQYIFEXMyaQ
	W3mjvpo0fnSQzky8ekV8UmvYt/bV34pxlLxCBuJMUoNB4C7ZpQD5+ijY79F3uYJt
	gWai3n+0uAJibIBdEy4nH/MbX0+8xl9VQ9MdANb3JjFRK8XYZYZK8WbuA9nBRPFy
	KYqgVKW7NwWh9PdcoN4KIdgmqaeZnUqhO4s90ZIMZle22nrLS+xSrpmUgpwz8qlO
	hqClFhs4R0WtgDPdV6BUdqNgqixjt9oWJWGxGIbYA9w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 43sa3703ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Dec 2024 11:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPXV/hXjMgJl0cv1I8cYwCozPuhiWCeIlo+bJNFKKCX5keyvUl77vV1xd4s+ZqZAwITjGO4VkqGa74gZqDpIyMTzopz31YShMzdHMj1BP01NrL0995roLcqeSGnFlS3UH4Zcxv5bWFcORqMhz23zWA/Jzflk5uYXJsoJSP/zoWEVLMmx0GCAPcL51akZTLFSJKQHXJcQk25TznPMYzyn5ZLNKwie4U4uJ7OGs9sdRPgvsBsDaPowkvqNTJbJiK9U/eC9w4krDZd/s9jWaoqvRyK2+eAqXmmnZctTkv0/Gobj0eGCD4FcNnolWTuxQMtbkb6VHuXmKt0o35UyIbINaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ofvxikVs8zP7YauVO7a7Ww19vZJxGcbLnazC28dRKo=;
 b=vV42Lxvy35h6aDhymnzYgoL4vMEiY54NV4g6+DutrQT/4g9dY1DFAKtSnHSIRRNESiXCEfMWrvATpK06EtIQQzG/tp0MUXXhcvXo2lkASR4zgQ4Ln9L0bjyUJ7T+VosJhDqaRlaz8+TCBxSRDcz2qLmcWTHOCpdxJxvvGFgb1f0zvZlGkiH19wXRP4ya5+Of54jRlBWvogOO9HECZ6i8Fg9Ob+BVjJHXBfI0kdBdtEvk4TGKZ0JCXjL70k6ob6p1zvc4jhTxLyWKiXMSh6iUXY8X4O3DmK5RxkVugH50vD3BRZUSttxm7mAAhQhYDXdvEiIBzzrKh/DHZhGB3VKndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ofvxikVs8zP7YauVO7a7Ww19vZJxGcbLnazC28dRKo=;
 b=Gr/Pdt+Ol7BrMNO656xJiZa3AOkHtOtVq8IAA892jPpdEJRQgUfOj842wpRMeX9BpUploXaBtbQjPmpB+X5I5U4jHV0PqMwul/3OfpHXc+pk7K1dlYpILR1ZskI6nBf+vYswh7ZN7vbKoXyFN4EFOUUBGFnOHCdjI8yGCtf7Dyb+eBulhrTKMoKNdBla37qMNLrDslX9Q078c8wz2nyMM3HxIrzLvmoAUBjgb8zUNRXBHdpxX2nbM/y2UG2vykMde4sQTJWYpujjnqQmjbFDOsyl1cDe3/zyU0uAW6k9bxPIkKFcgY9sp/uE4TPwTb33mBZcQ8BLi+mam/JAefm8ig==
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by SA1PR22MB5654.namprd22.prod.outlook.com (2603:10b6:806:3e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 19:13:25 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::1a) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Thu,
 26 Dec 2024 19:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Thu, 26 Dec 2024 19:13:24 +0000
Received: from robejoslpc2.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.24) with Microsoft SMTP Server id
 15.2.1544.13; Thu, 26 Dec 2024 11:13:24 -0800
From: Robert Joslyn <robert_joslyn@selinc.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-rt-users@vger.kernel.org>, <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <rostedt@goodmis.org>,
        Robert Joslyn
	<robert_joslyn@selinc.com>
Subject: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Date: Thu, 26 Dec 2024 11:12:38 -0800
Message-ID: <20241226191238.2559880-1-robert_joslyn@selinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA1PR22MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: f440c57e-a247-4f86-c007-08dd25e15efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZWggLmiOu/RlPyL2jLvSNXtnM8dXoyBYFY4GRBKgAtYgJvwPHymWowmJLqW?=
 =?us-ascii?Q?2fBP0E9K8XDKqwLBS+FCHvtBguE8BgSirDbdxb/R/zNWu7RaR8tMjVkemti2?=
 =?us-ascii?Q?rJd1sdfd45ccI4NY3SJgBD5g3Kfnjd+4KpmHSyJvF3CGhcGXG+o9AA9nSK7P?=
 =?us-ascii?Q?A/dF1uVKXBPhXZHxDnuiaF8NN/UZ+6C8ZwUSeJqyPx4YVUMJJ8uYdXImDDsz?=
 =?us-ascii?Q?664szJ3xSW+XkMiT0sQhA3zGdaLxRquFUWdqe0wnOlPT7W3IvgJsArYAqB/k?=
 =?us-ascii?Q?VooTuNPfyJsXoNcN4Cg1OKBNibcF6y5gJ5dTirvVYCsM6h8DvKYMLCNO0jo8?=
 =?us-ascii?Q?aKfSxsMijLkM4eiA8PA4Spp5dsNHduK4VtJxzdD/dMiiw7oqDa0FOQZbPbcE?=
 =?us-ascii?Q?QZ8wgBi60LOpVSaGgt93djFdA7Xh3sO38YBqLH4/M9a+Gk+5SQweY/GTruEf?=
 =?us-ascii?Q?LmBiYCzLDEdlrqgYh1N4yD/jlfGJafuvmV0NHGsBuF/jUPe2yF7onjwVgqI5?=
 =?us-ascii?Q?E4GTwyJZnxsNUxASCJ8ta7vUhgS3GLUdIjKRRYCX0xYuprBVbYzh7oH+kerN?=
 =?us-ascii?Q?9krj6B36gJGJQEhBurRoDP5DXMXiP4I1823EzoEKE7FNxF6CSlIX0VBirBly?=
 =?us-ascii?Q?jR6qJUsCAWiJ+4ztRJP9EAf1r2crN6UJjNTaaDiDIOBrrYfle0t0xjV/IXds?=
 =?us-ascii?Q?duMQ/2ldXVh8MIZspGXH0zMqwzHmW+NWW8x4HAoM198opbTaf8faW86SrJN4?=
 =?us-ascii?Q?5Z9+7v4lw5jYKSxBExp+vX8XWU+0vEB8yvJpwKA9ZOXn2lIiKJA3jwI45oTk?=
 =?us-ascii?Q?fPzYo9r+kH+xsKEX88G900IVyBx2DDInGC1c9nzh8QEEv8VmZNhzltxQ0j4B?=
 =?us-ascii?Q?79xHOvLAD53WRTDhQCtXCMp8FGG7stMGzZ1GStK2vKohRsrc993orAXOPUNv?=
 =?us-ascii?Q?5DtA7p4auUkaLN/LCZnkO+jjWZD4moMmnqTfPDEahm5MFnMX7rUL0+5dFGyO?=
 =?us-ascii?Q?w0Al2++s/tLMdgghNpIG7IenOGU/fNhxlPFBSsXqr+X/TBpKjaVPjxpn8n7w?=
 =?us-ascii?Q?Q7NlxVPRDEKfa9yoaUvwMiSA8nR6mJ6XswqnTNZxbojh5dKZDKkNQLRUfut9?=
 =?us-ascii?Q?eUTUpMzAsVi8RhWEEUlBlVOqteKxoir11aqVqJLYUIAs1NAF6poSXmhik4Er?=
 =?us-ascii?Q?WygGOk9srADk05+yvXYKm5nKZ5vjG+koTlNQ3W+kiDx6xvC3eRwxEXGp6UBU?=
 =?us-ascii?Q?naVyR97M8z52TKdYTkPSPXRgMSSrqI6D9OwOe7DpvZ+bK2tiN+AUyHpJCgow?=
 =?us-ascii?Q?QzXEX7wDEEWCnl2hC6wZ9J6Dhps87tHrdvg5e2wr/+QsawAqHkxg4exrKC2p?=
 =?us-ascii?Q?BHnXUWBfYnEFmXQ11BYsLGFuuXtwvkV828BymCYxeQM7g0++z4kpBoKZlTDX?=
 =?us-ascii?Q?oIClpyqk/g2Ai8eTqCMwLSZ6V530QselrcdvvkSJUz5Wl/PBmH/KQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:74.117.212.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:email.selinc.com;PTR:wpul-exchange1.selinc.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 19:13:24.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f440c57e-a247-4f86-c007-08dd25e15efb
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec;Ip=[74.117.212.83];Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5654
X-Proofpoint-GUID: xGrujx23pEjmoVgA7Rt-XO0DnIucSH6n
X-Proofpoint-ORIG-GUID: xGrujx23pEjmoVgA7Rt-XO0DnIucSH6n
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=425
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412260171

This branch is needed to allow preemptible IRQs to be scheduled,
otherwise the kernel hangs during boot on my e300 based platforms.
This branch is needed for both CONFIG_PREEMPT and CONFIG_PREEMPT_RT,
so broaden the check to CONFIG_PREEMPTION, which is selected by both.

This was previously set to CONFIG_PREEMPTION, but was reverted as part
of removing LAZY_PREEMPT support.

Fixes: b33022a48c79
Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index af62ec974b97..970039af8e92 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPT)) {
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
-- 
2.45.2

