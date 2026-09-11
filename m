Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7730568B
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789104591; cv=fail; b=EvYFEriwfgQU4cIL+RH7dU7bjZht4k1vbuwYYDzX5CLCNzw7E/b8q/UxLPdriPHrrIbfg8bmHauOiNzDAoKEXSzWd1NGKCeRNN0VCexBwAEtvil4cQPLoFmCuczRPJK87Bx0ZY/a+uADKwbLMyP+2RVNvMOr0wnHepUVhc236/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789104591; c=relaxed/simple;
	bh=uMaT6WPPDmiKTQaJoQMyA2gUJImjdAjAZIAsx6Uu8lQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MTnEdvRuZxlfQ5MjARLaL1AuboXw+3fzP3NHmDFV5E1QCnF5vMdUXBd0IRBAhrkc10KoyerqZs4Ppt81ggPLyka2HuldexvocoVWHMFQgDWUxsFscReOfioWu1iY3L1SxxSNZ8iUJ7l9P9DskySh/XT+439oskRnnMfa2ffQONQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QtnFNDcL; arc=fail smtp.client-ip=40.107.200.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QtnFNDcL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjP7EqeHkj4gj2DRM7psb1VUpsdQQFPZrv99MrTrdkzAtiFkHoGOeX4CvsbJAkyepJxSeRJXnAqTwMfBMyQfwWcVPP/bUofbWGnU9MrALmjMRr8yF+r5grCIQVPG1ejhmZyuTfyEBeRtZ1tLYsDPGAbUNOmxD/wzzqACXiSqXROJfBTvng0uOe3ttjhKGtjW9g/8VPDbhMfZtYcaTCRrLcgptQxo61V85axi4dUcgLqQsHCXRLoXlqxoI4duqufULSqG4cvyPHryArMKo4JFn20s4j9PjO6HyAIl7lLobwDF+YHI25AU1C7fuRtBjlmYaQn2NGh1r2FYjt5PqPKrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gda47dLAp9h3X7Dr9WJHinFoEbfo7Vp7Y09d7AswHVY=;
 b=vKjNJ5YIolvd3+0fC7KUNa+MGPtrVzyUMvUrTEZxXpZ7dQZnmchzAcTjxbDmUxPfJyaU0OwLj3wNSSbm60U+IaMXsxrgGD4U/FkaOiIseVVhlnyH5SdiK9el33OyMJkknqEK0EVQ+JFOrwh11YzZLE5mFp2KVPywN0Y/MI09DCItMcCRrzbAEtUeN53lj7zpUbUsJUd/MJ+8JLFjgh7g2sPCWd1xVnnTdhbmpohQoRLR7xJbXrEWZgMUjIObQemJwH40D0Dm1EfFu0zA/phKjctcagz7WzpqCp/pYpoE/720e74gtHom4t1etMz7+4p6wT99kA8aZklITOzgMjumxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gda47dLAp9h3X7Dr9WJHinFoEbfo7Vp7Y09d7AswHVY=;
 b=QtnFNDcLublPe9dpQdNVjKioHMxbCCMh+7r2YZtCA0vv4n52rVR3fTVjAeRlFPTRk4WQuMHF/+jAHHn8i4qHQnBa3xwI8utxEJk1Eptr5rMdgHhbDRqW4at1j24cczDBz2Tw5MlNDusBxoaAXTcpXCjPaGOr2c6uyGMlEsJgnZg=
Received: from PH8PR21CA0012.namprd21.prod.outlook.com (2603:10b6:510:2ce::6)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:29:44 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::27) by PH8PR21CA0012.outlook.office365.com
 (2603:10b6:510:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Fri, 11
 Sep 2026 05:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 05:29:43 +0000
Received: from BLRSUNEETHD2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 00:29:41 -0500
From: Suneeth D <Suneeth.D@amd.com>
To: <linux-rt-users@vger.kernel.org>
CC: <williams@redhat.com>, <jkacur@redhat.com>, <bigeasy@linutronix.de>,
	Suneeth D <Suneeth.D@amd.com>
Subject: [PATCH v2] cyclictest: Fix BUILD failure for GCC_VER < 14
Date: Fri, 11 Sep 2026 05:29:29 +0000
Message-ID: <20260911052929.2565-1-Suneeth.D@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 798554bb-7f5a-477c-b36e-08df0fc5af81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fmfB0DW8XwBCtreb/1ZjHlptC3hqvlegkF7u5hr7Ho70P0crpgmorJ6feL2ztD6A2Jkj+T0BhRDC6y1PItZNCKSrpltIl4GIC5yI0XvYH0ijqFp7K6dVb0bki7dVqO1ZuZYtiyVtroB8+4UhiST7e4AC6D2Cgel3FTKOpVOIvXVuXxn0JmH+G0VbmoBRrGVLntxydHMaOp7+0iEZYm2SS4SeJ1AxPBVOuT7NWPDPyyxprOZqCekXqljv6dx7m1i6cIci46+6M0dIT7xTXpk4nj7MtSpU0yitglZ7EqFzV2wY1CMU09ue7a/fLz5rt67DsXimz3Nx/p3D4QEHkU6AngopqamuhUPUuhXE3GhQ+nXYRjvuIDYIloG6UN0TQJ+6cpXC6IEitmz63rxqF25fl1irA0B5uyH1leWv22YCBSgrSKyK2xD29ZLsnRbFqMMpJOZ+vZt0cBpu0abuzBzDFshjKkpxJY/60I3s1QS/KmBAS1j6d0+51zWZQcqQ/uHoGEH0d/jKZsiFBE4tVX1Ox33UTke51416XuDIHWOGOcXuH+v9YpZrsGI7XnZAWAdjDSGi0G2+3jp6uq0VXDQWZZEw+BmHmYTQ9hC6LLYlJQkJsBR71aKnS8K36s94xN3nchmkkokO1RDWlz+oh+55RDjgqgex5UMUlPTgy2ldiSyQgWnwbcLfVHdIwN2PASlKSyz2iwsKBnII1tg7FzHOOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f8IHupjDmR7PI/8JX3KD1A0wr2vVb1wrhzcZFZQX2W8ZpAwop5A6pvZrk+KpI7Uu9OR7JyD39AQQXz81mYlzvkFWSK8NDOA9MRVNRql+N8XraUcF0uz1RatKhZpuIANatTi8ILunDhnHNWgCD1mu3V7eF/Sj4WYkx73CJU2W1ftiRcqTW4UcSd+3WuILnm5jo2h5XyW64DeSsBE/ZxHc0+AL6eL/9Sdfu7nhml/tbbmJ779G7dFuOSazTLqGuyIlG0dX+kOtczBpLGKKM9Y89NWvX6PxhyjU3jNrQEQ4m+ENMj+y7Gie0hAsuXkvemnPAPx1Cj3+N4yFEPwf8HawqPVpYpxpfMj7CiW4fsnRQI9H56eC8k6yW+KtjXT84CKrWUQtM9m5hO22NKf0QyxgWXtIAjTAj06/NqLH3l00Pj3v8/q2uVUpd+UtTg3ql+Qw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:29:43.6726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 798554bb-7f5a-477c-b36e-08df0fc5af81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

timerthread() uses bool, true, and false. Those are keywords in C23,
which became GCC's default in GCC 15 (-std=gnu23), so the file compiles
there without stdbool.h. With the earlier versions of GCC the default is gnu17,
where they are provided by <stdbool.h>, and the build fails without it.

Fixes: 98fcd661ac59 (cyclictest: Acquire a lock before invoking pthread_cond_signal())
Closes: https://lore.kernel.org/linux-rt-users/4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com/
Signed-off-by: Suneeth D <Suneeth.D@amd.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Changes since v1 ---> v2:

 * Modify commit message to include Tomas Glozar's note on default
   changes happened since GCC 15.

based on: fd45df830803dd7f26d2ca8bdcf05fd7e0d62ae8 (rt-tests/main)

 src/cyclictest/cyclictest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 99194378f946..58b56bcede0f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <getopt.h>
-- 
2.43.0

