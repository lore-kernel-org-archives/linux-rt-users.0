Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFC477E38
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Sep 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256017; cv=fail; b=uZx1OTAF8sNCDjntggppVimMe5zJTUgJ7dLZq+nxJUjzQ9i772GSaKER18dk7l736P4yabwgBvW6HwwRLGPG6PCYXUbvTH+4eXcikmRZGs069Z6DPgjoEWdDsZTmesABIhc02+IpQqk7kgn1nOcrzz89LNQHKQZKQQsbXRrDF8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256017; c=relaxed/simple;
	bh=R0RL8FZjwd3KVRJ+shehKYDE/USKI4QgmPiBqPNZJBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PNZlzFoOQewglArwPgJTgMGGu6rUKRghXs/ibgEH9NKlAhmnzH3OPvlzzae0aAdb4/rHksmbjeeZ61cmNS/zi2cPsWt4XSJendKRwNmjvvHPjzzXxaoLG9q/cIKoG/ibstIZSNgKqhrHuD1bIyY5EjsyJhZusz+TNZUShEssxrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EtBHvJEH; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EtBHvJEH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4QWxToFLpiVVg8XnvBRpIhQm+1uYuKTuMBwZp7/P0xJHo4j5bXGW7KNZ2aOpptrgK+LwihnXmaBU9yxcMTf0lTxn7zFEPDO5Reeou0l/InUaa0Z7a1LywtfjgiuZ6yfKVmVO99qaHrWNuPZG1G2uV31FxY3o9WgNITALuwsJkDpa7aDOOE6bgrL+H1i8rN5jv06E3VM5GKcD+k7lvELuNplRe0HYNi03AK3Bm/WTxSzU5IPDczxhig2kLxNEqBNhIlE0GMH1BjPYHuP6gwZMgMV2GE3nX/lo8NUA/Bf3lb5TKUyF4swoCDXrgpDoyeu0E4mxL4ZiQbAqNpVhyx1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z+97s+KYI0139Rxk4+POdmEWNxpIRgjBOzgixtGSjw=;
 b=EuyIwovvG0bX0pS0WK+keSgT018yxRRRTZStCae0rMNNpBOmqlcWSY6owKX4lYrUUd9AjvyfZiSS4VHCYbfzdYPg+mSIvfOfxy5Lumd8ix0g1p8weQEgpcM1xCvWQ9zZ3yaZV3jBnlRB2F+387a7FRjURGvc+Mj86BPrY+qCj3mKWcRMj683AAsi+SyhM+qIVo4nlNEB8m2UP75qbi4XDMQoLK0+xCvCGtHOfEGx7XTfYacGzcXy9lS/Zc3UV+upZwUhGUX/VfQRcCq1ZjBHvtu/r3X8zCSqzLuJI/9tA9cHbR6q4wz0QZoy0nzwWZHMBgmyNiGbqVfH80Cwi5dZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z+97s+KYI0139Rxk4+POdmEWNxpIRgjBOzgixtGSjw=;
 b=EtBHvJEHejsfMDu7ZgIAS4i8qvIVspRNdmP9VBhE6MtqwldD4s02DB0mexayNXqNyP0h3n9ADJnmcm/KxLVQ/pQp4SIfSOdFLxdeGL8b92guTkf8YnDPOyGVQQAJS4BWqZxIsT/xDW36QENNJbnD/u4wn3EkYTrsME97cC0OXhg=
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:46:50 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9a) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:46:50 +0000
Received: from BLRSUNEETHD2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:46:48 -0500
From: Suneeth D <Suneeth.D@amd.com>
To: <linux-rt-users@vger.kernel.org>
CC: <williams@redhat.com>, <jkacur@redhat.com>, <bigeasy@linutronix.de>,
	Suneeth D <Suneeth.D@amd.com>
Subject: [PATCH v1] cyclictest: Fix BUILD failure for GCC_VER < 14
Date: Tue, 1 Sep 2026 09:46:35 +0000
Message-ID: <20260901094635.2173-1-Suneeth.D@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a8a824-29ae-45ba-7327-08df080df25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wneUD7ExIoL7kiV9HV4kkH6j+KA8hZa/AmDKz03VbyTbT7RUyEe+Bue/C7MT5QoiM+M8iLrSazXRdsFbdbFqmrqh/xm4dv9qtsOXHxmO48TqC7Dklu50X91ZJxgtq7P5iReGG2H4KHriqAano4AiZyua4dftoeOCkfNMkVz7Dhgf/9nCn3t+Hr8U1rO9xk0AzME6TW648jchmpftYlOIIW99651Rh7dg0UP4WM2fpo3D5BXcfZF70+jK+8lNGPRqloclotdFZF9zb07hDD83g9JlnCBhI0rsvQR633eVl4DyfwuWo+3hJeqGkz5kAt9Yv+JizDljI8kDhLJFg/zhHONOsykCGxOaPlyjEz1OdiUA3No99KX8FGNIxLI/NyJYJkR5N0BANHfR/A018jRWXTj9Zqn5q5TkwAlT4sj4+gnymTKnO5evTeLLzfKJfHF2q8h2abydyebXyN8IpPW1xGRLyApTF+E5s13b00p2u3zg0BLl5kYjOWgYPM91Finw2Lg/HWBCjGxX+ECGrB7JwxxCB3NrCE3gHmmqI/lo7RCYQFgp9DQKTSnAX1Glguqm8n/qEBs3MYgJFUQ8RV4i92yKj6jTK1p/88fRpGoGhpBP7dBR9ZIE0alLsEuHbNRkg2Dltp3waUk8wJXOG7zkOwRmtBPx+ODYIUQVAuqeYsqsEy2xbBroh1mP8LjZhVdCVYOjgaXwLUryAPu+KdoULg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QEt/6WEBr1exDJ4TXrwSTtXWQmcYq33r3uyXn5dRM6HTSf073f7BYrHWouNSUOE6MJcXsJU7/43ZpbIbp2XhVr0ObmBwhInt/oWfQnrbhFRhQqjDd4fjXz7q9p54i02EHrW7pymVo/jFqBUhPMyCPYfkhzBS54nUqpUAf3uir4gMYSXGilUw4Wwnab1UruW/JtKLd07uP7NrafVQowCxykelGt+iGaVzjtmoWaFb0WxELdZ56tj1HZyXZ2XSNKWeRdLGeRCZ/oZMMgWB3BRrc45UuPeGFYtiqf2XNbvEBIMdd4BPNuWfY1duFWfCsSDXY8HlMtKZJNx7VDfcaLjS3R2BshoVwI3rTyYF5n+UYSVT3M8MXtRAkLE7CH0WO9Nj3NmKtOvgsR7jBgYLP/1Wiq7y418PI6n4/JjFDwM7idYdM0nGFMb+ngFSUHOTmP5+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:46:50.3273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a8a824-29ae-45ba-7327-08df080df25d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

timerthread() uses bool, which fails to compile under -Werror
when stdbool.h is not included.

Fixes: 98fcd661ac59 (cyclictest: Acquire a lock before invoking pthread_cond_signal())
Closes: https://lore.kernel.org/linux-rt-users/4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com/
Signed-off-by: Suneeth D <Suneeth.D@amd.com>
---

Based on: fd45df830803dd7f26d2ca8bdcf05fd7e0d62ae8 (rt-tests/main)

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

