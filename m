Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCB35F180
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789104752; cv=fail; b=Q58fv7caZmZfa5HAVxCvDbPsvkLWKd966kYi6QtLCMfWxgQ1b2k0qbKlNRLP6TSzIDcA9j3qrm317wJ2+ChrMOjc5V30hue56BD/tfWkGZ5/qXaiHS5pcUpM5/Uk/oiKw6uvIgPjRTydEZ0avs2NdoXek1x+2A0woOiBq1jvXMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789104752; c=relaxed/simple;
	bh=bwNBKfI8p90+8xURaDUvGzEw4LyJQhDchVfTrYX6ekQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wj1lUdsuB4tcV8iLs/8mnaG6QxsEv3u9nZGikQMcWkRt3idYrQxxarNt4UJDpTyl8sBgqCLTlTYOehZ06UAJLEL3urqcRcwsRTu0D1BSwTb2MpZx6YgxeAoGNknLU50ux8jNgOk9GqslP3tyrtEgV3ECbtzHMg7AvJO+eXiUV+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HIQLQoX4; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HIQLQoX4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPw9DN0GoPVoEKBdr1oQOfcxMZXDCZNSKLjhQ/VRKfhKPlCBNcBKcVcxz9Cutc38T52iC7AOgZn2r6eesCAVbkb6lH9K+CfiLM7ZEWXlJhFWnUCgXvP45/7GrFNbcq51+HdFhjxGniDFCVTZYHkO4urawK70EvYtxcDWE44pC1NzVxpz+VzAAjRgLAHYhIbnV+S5rsSaiNkME6+MbJdU0saXEC4dgRaLvH3xKFXNb3sWvVsbQqIn7ODLQsr1eYcgn/2fDvk3lAyd0MmZr/c4APx/z/Gm8R4+yu0WDpusuGj/f8PeiZvX5B2qCFiJ5skV8LZTd4fjfHNCmjIg/qFykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64NIM+jc3/dsk5lW9pFbpeNDyoC4zvV3epPkfMYxsVo=;
 b=m1mF3a7UIdwzzIkY3Ua9JMS0EyTR4+YKuhzASoFa8oFqvBqxCjJbQLCLQ3cvX17595eTBktWEWdLhsLeBXQQfiuqXyjITfiuQRlJOXbLWDnRYz3ViI0zdj/Tn07Qxgbwe3LIgk7ZEwRqiAqoTodFMI8G5sNiMRzdoTzgf0oaVPwqw3Y0uawbNc4CY5mIXyfHFn9+AaJZ63Ft7nG3HIg8R/LkdUmmTuboFWA06i87/w1/CUITB+AGMseMVZfX24j/QXwwxltmkdYy4UetgL2EO+byRGjYTbvqNEyMuqPA1EMjy1LGqp6X/0LYU9SmmgbRMd2YyA4ZkUuwcZlTSo/qEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64NIM+jc3/dsk5lW9pFbpeNDyoC4zvV3epPkfMYxsVo=;
 b=HIQLQoX4aLuWwn1QBkTXcv6XfhrzNhVckU4Z/7Nl/8FYFlnyeWLnyXCN0cJNrjUtY8Fb834OWtlUfNDcbAssIbWXiEOPgursnOvdEJJuvR0U+Qg5xMXpi+L3uyllNuFsqIteNrfRwG2fwWD1tYplW4rxQ0SPBlkVdzYQm9CLcAQ=
Received: from PH0PR07CA0095.namprd07.prod.outlook.com (2603:10b6:510:4::10)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 05:32:27 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::c) by PH0PR07CA0095.outlook.office365.com
 (2603:10b6:510:4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 05:32:27 +0000
Received: from BLRSUNEETHD2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 00:32:25 -0500
From: Suneeth D <Suneeth.D@amd.com>
To: <linux-rt-users@vger.kernel.org>
CC: <williams@redhat.com>, <jkacur@redhat.com>, <bigeasy@linutronix.de>,
	Suneeth D <Suneeth.D@amd.com>
Subject: [PATCH v3] cyclictest: Fix BUILD failure for GCC_VER < 15
Date: Fri, 11 Sep 2026 05:32:16 +0000
Message-ID: <20260911053216.2601-1-Suneeth.D@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a0772d-7478-4906-d6ae-08df0fc610ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|10067099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	Bmby1hM1Ae7VJaxUdsRYsTVKNO+ZDJojDC4tj1CqkQUVTvI3znQ0C6PCaLV14obSbPdMA29Ix5hAGsY56mGUTuwOxXicoZoGrBsCH42TBVGZBn9IxR/5TJIV4vGOCOoJ09DohhwW4Z4wNdsKL4NXEFg+rpGxcYEq8uWHomRU1ayxlUCQ00Dn6s/8WwyGsjE4kDGZsPh7GW+H/EYSN9dBLb2/rI4oYyWKvOJdHHvn5vh+7ti68NZXk8ugHWWD5Wdx7c/neTvXaS5pgf8dw8a4l7mtf3VLKGCkPSDk/kgggxwo7w2/KP91WgKPOMLwWmX8hLBSh4F0NLZAld1RFUFr7xbmPH3pWha1Em57fAf97pjLCU3CYvu0ZBhzd3sEskGckC2Vy29MkDcVkYuZMAnsw7ToB4X+A9o8tK+SEUl+q0d/ClgVdMc61CIUdBy5SS6gf0xe5/Nr27NhWuH8O7T++shMDSeJ2jkz9Zxiz/75XrOz7ISaHHzHLUTZ0zlj2GNMpJ+1hoWEwIAJH3UXyCMwOg++5hGdunGk+KlLIfs8Eb3PZgF4lhh8A6fTBqMJenYKDTuTxS2ZT7TXTQDa6rFKvVgJkzUJO+BPZG9nVu6HP516b/TuzbV3Fc4zllmescCH7oWvp9cBiw6zxKDSxyt2XBt8a54TnpJCXwJA7Bugc/W5YD7Z5GsCF+x19f6S+gZwssyEEAm35g/RY0E28enMqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(10067099003)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nqeKXTDbAvbPz7VE7UEQ20/xS+IY8lW204IDkWFMxUpAGgfpFdLTdhWpMH98OQVEE1NpDyEpo8IsVbCrOw2T2fyUi5z+p080zkXRinC3oF4M4UN6N1AHEEUcYLBOs3x2w8tNJyHUHT6suppKv0ZXQZXIkI/MGUUdSUjgfTEsUxdOImhUcvdkcVRuSfWR9nqmeoRynl48QNwdQXKYJepadWyq6LgABVI3BEcWTUQic7uqd1iJ/+DIbCqcrjfaux5uPkMuGBXFW7uw7sSr2mszCVmIPBrYrhQ5HM5jo+UVQl6eNV6vn7b5VpUM0oZU8f1hRvqLWU9cjWp8Be1Ot9ZLFlLYPnFiopAC0teCpR5rjdkVRTynac5zjHGpYXN7YqS09HDxBAjrHBysgZ+4eSS1uJyynVBtRqTPJhuRotnw9fHX6cLtZBt83x4SP3HqYIeH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:32:27.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a0772d-7478-4906-d6ae-08df0fc610ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

timerthread() uses bool, true, and false. Those are keywords in C23,
which became GCC's default in GCC 15 (-std=gnu23), so the file compiles
there without stdbool.h. With GCC 14 and earlier the default is gnu17,
where they are provided by <stdbool.h>, and the build fails without it.

Fixes: 98fcd661ac59 (cyclictest: Acquire a lock before invoking pthread_cond_signal())
Closes: https://lore.kernel.org/linux-rt-users/4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com/
Signed-off-by: Suneeth D <Suneeth.D@amd.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Please ignore the previously sent v2. Sorry for the noise.

Changes since v2 ---> v3:

 * Add Signed-off tag by John Kacur

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

