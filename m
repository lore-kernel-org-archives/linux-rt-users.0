Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB142C4FA
	for <linux-rt-users@vger.kernel.org>; Wed,  2 Sep 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343106; cv=fail; b=bqOVVyjCX55wRaeMvc7ZrH+z9N3eEoHD+OO2sJlJ/4lK908A4EAA5QA6ZEgmbCB/3adILM0V229IEyDlJX2tnF//WMBopvxKfSasD/SH6pbOaSXTUTRx4njhmowpL7OK5MC/HrNulxOPVimV7x255RYgU1QB/S+iS3p4/G/rRuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343106; c=relaxed/simple;
	bh=uMaT6WPPDmiKTQaJoQMyA2gUJImjdAjAZIAsx6Uu8lQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxNxEuDubfclqhoHpiaRizSXuBMJJkDIniJQoeEuo7trUc4vM9j3xXAj7X8IlYH3KsxTgIjRPBlNXVCZcpv/bNn8KhD5ZBIk+PK4l7yUxSDPDdRjPYxUnDG8LR50W3l/F4aq/xTsp8YAhPLN9Y02agRutr4Prslyoqm7s9vI6Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDhFdcIr; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDhFdcIr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN17iqn6blxRbvH5XZOB0Z1oMdbKVT+Fd8XsxFZflLbDUDEBAXyEKxuIz0QkwZyOkY2zRm5u6WRTNYKEi5MrGVIlG+kDDyicU2LVKkb78nU/ioc9PSSpD28zz3sr4hQaR2BmZ+oKkZtf1FUqW2E57JDW24wbrK9Zn/EpsrAyiU/9LGa+hbuJKSL8et8b01tglhZIj16rm4kXQ3+EXdOWsH4WuZg9gTDoii1uCSuYM5+ZvpzcgWlGytDRl1srB0g8WvbkvkdwYTkumwqyqaHObrZsH40umuyr6t+RtKAEmZK/0dVDjzF0DwH7KeqIut9CMZsm+bCOkdNgmcWPsNtngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gda47dLAp9h3X7Dr9WJHinFoEbfo7Vp7Y09d7AswHVY=;
 b=sGz1GyPGGcdhFkLEky43D1Ir/+e1Lj8+Tq4ryi/4Ui6vMu7NtvWwQtreoh+6DQI+3fsB2VKuODe1n9j2eGBpc+Sq8E+vfdMNKiAsYHZvQ8WIeCmGB3rwrV0qtEpi6xn3i9g14s07iazAqrN+81qXpZUxODg60fCcSuBbEclvGCmCOC+P0pp3z5AnFRdQH7TJwwm2vVGmjYVPQlpQehJxhyb+tEcc98/hk1QgnFYFMB3rI+WHVfXIws0nxGlEd7xq8mV009Jo1nyJGaTy2qifNkRTVYtRDNFk+4IB7p/UpcT2yzVqMfWKfHlBYTiJBn41DMxzgZGQFI/2w0YvRPRuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gda47dLAp9h3X7Dr9WJHinFoEbfo7Vp7Y09d7AswHVY=;
 b=IDhFdcIrr10HwubYgaiIwAoTMPMpC8ZEywV71GMWhxOpLZir7pPWPodVJfjSSN8KLc7rPHOvBJ5EXDJvY2bYkoAMUMWONFbTeiyyxIix2Tspki8nkdjAlVePrGBhe0BRlEBwGvK0pDo+Nv3qmF6C8EIehi98sm7IcB40WBiTAzE=
Received: from BN9PR03CA0151.namprd03.prod.outlook.com (2603:10b6:408:f4::6)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:58:21 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::3c) by BN9PR03CA0151.outlook.office365.com
 (2603:10b6:408:f4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 09:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:58:21 +0000
Received: from BLRSUNEETHD2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 04:58:18 -0500
From: Suneeth D <Suneeth.D@amd.com>
To: <linux-rt-users@vger.kernel.org>
CC: <williams@redhat.com>, <jkacur@redhat.com>, <bigeasy@linutronix.de>,
	Suneeth D <Suneeth.D@amd.com>
Subject: [PATCH v2] cyclictest: Fix BUILD failure for GCC_VER < 14
Date: Wed, 2 Sep 2026 09:58:07 +0000
Message-ID: <20260902095807.3531-1-Suneeth.D@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: b64e9df8-7d42-489b-0eea-08df08d8b881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|13003099007|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VGTKqVKz/ZXQSkdO6SQ3g6ijaMU8mh01J2KWp8J51FgUhiYhChvQW81Cfe9kyoJhNHsF281x/X4nfbzS4s7wFMSk/DaKgL6dVLTlxfOtxFiC7VZd+teiMHXjRnqO/Tp6r3Ecwew8CYYHguU+SFKoYNW6zzG7rAfzds1bJ5Z3CGWl7DiRjSLAsqE9H3uKt9tgJwJKS2AeupDA5rXkf8z3gUQUX00hv7PZnKsgINBuro7l/kU2QKQTSjIhI+NQuZv8EbqVCdNaP8p4VFFmqCM8tKeaDRIaEdCxQ/k+hVCEC/tXvVFBxugnxlx/M7PbDG8SSHhpQ7SmyI8CyX/9qesiytsMqLPIo82F9twBkWNKmWsK+t6/D0K+/FZ18udq+HvqReC3sTeNXgsxCBCwb6405aU6pZBG7HkFimHak7bDHYnBL7VPaVr7xrZ9s+MAbnppIrjLzjPVof63G05k4APCaHNRISvnqMWGQy7Qfz0dm1bv9Qdj/AjNLFTe2ypub22o6dwnmGkobEF6SgxqAy+TgClMt9CPYaXw5g42dTkEHaSuhy0hqnPWwWt26+59GXgODFZjiC73X0oDpT59D79oeu2ULhJGZEmU7p8Em45mo67CvF43Q6DNOSgiL3zl7sKc3a+EOzvEFWwaW1FlKtf/7MTtINa8KkVQBpcK+0zXDPgR4ltjCPl+kxzUjdcFOmGHTcoipNC8JeesZdOB1DTv6A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M37lH8wKCCBBjkx4LGrki+fW60C5vRhE0DaDRWidHStfY8KqngYTChV2Bu0bcAxP/YND7MAgqlLvi9vf4WlZ5vQVLOKYYo1/d55B6kSRaOGE+qx8vKKGbUlC5GN7JUMS3Jm9F7F7O3X5SiaRAf36iEgzvSkMHFeFDmm9kMuXRovvdFhh1I87gj67WefJ2w+CU2m4CxJJXg6uisLfNn1PJcLCIVZmfQWwfqiogl1rcTCVNnLDpYfRbdPXWW54onjcA247B44n4F6tdnVCqT/UAmKIaVfVXJyTJSGSJ8FIIkDkrBxNCk9fAcIWXXjsu+3vJhVFa/f7NiLmzE1R2clSPNydWtOtjIqb7lNi7fkLzVBJ1HX1CX5iApckZWIGgNhY6XOJ3Mht28GAvxthl4U8VJmMkJKBPSKs3uh8hYY0kNgRuXFpEkaAu2pMyfjEtyB0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:58:21.0885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64e9df8-7d42-489b-0eea-08df08d8b881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

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

