Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155862210F0
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944331; cv=fail; b=CEq0kI5AfLlXaCXfFUPolom8WmcBFzEQRoRmKwzRk2rXzt8+9NBIZVvZ1t1q+exw6ESmL8qvO8hgqgwG3zod2hjUxURGhnpjzJHj5KejPJm9SnLoIxXRgh4De75YOLcOspz4jylzisEsTifSnyTCz/IvB8eTh445L9xttZGnzJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944331; c=relaxed/simple;
	bh=3E0N1iU+gg1IONFSLaCZ9cxR1PLW+ncgj0Y0fP1/iHw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iPrC8H6ue2bclyyn858w+yamt9M9yWVN63BuCtgGJVpa7WGCz8b0FHmhkY599Ry4KdV+D9Fr+eQ3Sba7wNar9vU81AsyZUBvwwK8V8DV069/M+nKie0PT7o/FDQZrk0X3hihZx0bUVXHteJC39oNIcpZ6jCuOYjgfyz7+i/qcDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9jDNZFjAxhOtiShtuyhgVqsAL29P4GEWiTnCppyZuEYXRntokzfHT0QdDLEDchaRh0lGDktcJOI/FKuYSeMpjViu3AkTSy+5t79V+8/bp454JCKAmnPatLgA9BUldWD2BxtgCIWQkBwlA/oVCnsqnhLjo52vc7rFJcFs2assptAT+zHDWQFe+dNwYSlND6mUbeoM5ZLkw5VKc8pU3YuXpQrBHqA5r3bwRLtQP5rbE7KWHO+lglH068lyqSwzOHlVTgjFmh5zKYxeO0UVMc37MFl7aiJEWgBsxMnhj4AKeJ9Uo4o/LNmgjuVrNGtGH2Kvp7dffkWjyHVmqPuHg1KVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L73yJhyC2WEivOXqXmWDAouUwkZUPWgID2wPdnf2788=;
 b=XaBttsdAs7xufYQj7nKMa1IuWaQfwhj/cvQzFE36lVI5nHZYh/KASkJh6YVNWOYjobEfuVO7GxANF21Ju66UrYGbkVMtbvSUVMtAHfHnM4LGq+e+1bO6x+M25KFBwFcFI02vO6inBNO02Ge5XAkD+BY+xlXhRhc8mlvplWE1M0H0x49bH8HOV3qXZV3YBo/vylMjSKk8b+sjM8vo12v6t4hLocDWhGehlUnYe9Li8ZIbguyHMzEciPm+sUJq52O1vUPMt8/73JfHispS+ZugrBEVV8xyUP9NIEN7zvWQa0VIKfs5bkhpwRRAxqMszJkW0nDXuYsDkn5PnakV4ZWusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB0985.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Wed, 11 Dec
 2024 17:39:09 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%5]) with mapi id 15.20.8230.000; Wed, 11 Dec 2024
 17:39:09 +0000
From: ende.tan@starfivetech.com
To: linux-rt-users@vger.kernel.org,
	mtosatti@redhat.com
Cc: williams@redhat.com,
	jkacur@redhat.com,
	leyfoon.tan@starfivetech.com,
	endeneer@gmail.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [1/1] rt-tests: oslat: Add riscv support
Date: Thu, 12 Dec 2024 01:38:32 +0800
Message-Id: <20241211173832.1517196-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn (10.2.8.14)
 To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn (10.2.8.231)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_|NTZPR01MB0985:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aefcfc-4638-4888-13bb-08dd1a0ab7d3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	zNj29FPDdRrtTx9aHxtu5I/l5a/hSeBLIxmtuTd6tXGNZ01e8DZT6VOqAtOu9MuTaaEFqeh6qhQ+W91jTBk7FrphHyPJA2hpT/VBdH+RgJB9qihK2nU1LudCbVNDy2A1JP9M5NMyrYgQWLTSCXHrum+tSC4tc/Qt/kJl7J+g3Fm5VcLtU0HTPnJ2zibkHpJ5J6LxQBzxC9kO64abPslwoRC/raK6OqgYuRqoA5zexwRYwuaiBVgNfOzov1R6BIMyoiacnh+LVuBchVD85UEzY/RaoKpmBc9Y2i1tWMx08YTAF63EVVLoKBby1X9Q2g8foO6aWL/dt0Zd6WxlNptPM4/jKktHieT2CF+JKKuxi4RseudEUNmCFANRfJI/t7nDI004uh48C/Z0iX2bxAAOs7V/YfNeNwm4nFbvdTWCgGCHL0OTSKXTyeppzOHlMnkZZlElfULjrJAgsCvKCT2EExC9OcfrkSEwhqQp8JwBdrW9ia/WzyeECnw5+zXYiJEqs7aPozhZAx4EUSMjnxnaF0r1G8AsC+Fih/uzp811FzGLTigOpPxMEW/qm4NVD21ZAWw4d3Prrv9YNE6RD5eC+ddvGoCkFegfGMN45CUU7DCI3PwE1qed0kn2mMZJZ1YS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUaYc9G66VxTRNX+x1n01ZZ2twKht/6nhP+ylGYLpVUour9ZP+khuSTsX63M?=
 =?us-ascii?Q?t0Exhz+7NVaipMs2XNrFa8bRzUkClQRJSXNEdxg5uV5+QuhCxwSfJ5tGphvx?=
 =?us-ascii?Q?4zbzLqnAmXoowIulU/jgTaQvTvptF1i0ex7mKYve0/+x0mWCnfgQxNfW6d29?=
 =?us-ascii?Q?FWEvVfgKwwG8IZwNOD2IqkcCSIbURWXPfNsW7tgORsmV2+sWJ+Mjim6v2N9d?=
 =?us-ascii?Q?qsJmawMXIB5ybCiul4QAdJ1WX81bpBKqwhjiffiDYqtqiZxd9UausmVSa0vK?=
 =?us-ascii?Q?su+FbOzWf+f4nnH2hiSmwLdFUGdMdLPEcJXMWmO5fWoIHjsLXeYcWQGiaqAH?=
 =?us-ascii?Q?MWTss8UM9LStora0F2f+eRgXaEQySWz7yaiIxb7vwjgztQeJmU4biW2gkrlA?=
 =?us-ascii?Q?BLxEa+3JtqNShmZ6A8SqRQq2OYJAoeIOsDT1DbIovylbpphA9HRJ1rUutl8t?=
 =?us-ascii?Q?84B92zOiJLpy2ENvf56/djDWCIuVGyg4zHCHmFxuJYcn75NWF16h2Gddl5xL?=
 =?us-ascii?Q?1FeTa+t/zTM2nnWjGwTZrEGQ34we1MNbImvkmt0dVq8U1zIoAxeiEqvDPnIE?=
 =?us-ascii?Q?B+JgoYl/PD041SA0TPFO/BBRumIf/ManedyE9MEg9BP7BG/JbiCeH1P7Z7LG?=
 =?us-ascii?Q?ExAqxTQKMap3k/D7G90XtpRlABRza31sgse+ZvFlbX3tP+aErzzmMdLHybgv?=
 =?us-ascii?Q?4+a6dDP1ZZeigSEdF4ZnwQBWxZbmsZ9auQV1fZzy/KX197v09l9EllQK03IH?=
 =?us-ascii?Q?6+3bonh8iIj9A+OA4h6/CLbrQdgyGlJ2+PdAk7whzVInbXWoOBjROqG2WlKU?=
 =?us-ascii?Q?HCHvRLaNg0ddQChYoYTDNC94OmNG8k1jiu9Jhxqm5nfOVCQT4zH7YdRyiF5b?=
 =?us-ascii?Q?OsfNCVrU4Rmeq8/J1q1qgXouIuwiokttBC7Wug6T1vhgmxReYC3UY9zYZrF7?=
 =?us-ascii?Q?RCzb6VOkvwpNiR4JvNjp9Yr4Bo0xydAlNC5qocly2TWOeyfXsdHVWw+aqzmL?=
 =?us-ascii?Q?GLT+z3UOhHDOBInAYAsuDJaZocJz75VQpeh4WxC9cR8vtEfFxuthipa7BtsV?=
 =?us-ascii?Q?b30X/ngZByUFrwU3iEXUIkO7TtH/aqp4UYSRhEBaILQyjDbi+LIW/YOr4n/Y?=
 =?us-ascii?Q?zYewdqEDZxrH+3I+f9Ch+1TjVY9pxVtPWI64W6iP//8omJs+98Ozm1KPel02?=
 =?us-ascii?Q?mC2BvKKfr9oT75nt9w0/DppEqV8tVsoie3Ovj3CkvaF6LIjY2mk8Oi7MgJbU?=
 =?us-ascii?Q?qZN09kOoEgteDXyEriVOgxFnd0w2kTTpFXduDf5BIYXbL3yantpF+zWnpdTw?=
 =?us-ascii?Q?UpDSIYobO3WrRkd8PJEVcxWcibArT4cF+Zz3266bWN3UZHBerF2amplSKYlL?=
 =?us-ascii?Q?DHD8Spc6yVmvJ3hdkI9dxTTeHSkaTAnrdPYTIVii4zg+ngvHbs6aP46h30I+?=
 =?us-ascii?Q?sf8DII/fE4IJdOPxGtgYuH4DwPRg0Z9fVR1oLJShCpH/FL0puT854YZ994hk?=
 =?us-ascii?Q?ocXPBp45MXRpAKzzHZpwdb+METEQTYCvi1gDWGDLluHQTZFmEW4UspGN3fzl?=
 =?us-ascii?Q?G5LeDhMn28K/zynaa1M4QftIPh5i4G0E2JHJn/lFdVBzgkmU0XHq0q24gHk2?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aefcfc-4638-4888-13bb-08dd1a0ab7d3
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:39:09.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R+EfyWSUsjtSi0Y/8WHMRcbhKdSHwm8b4E+cptvqEVHV6SoV/E1uEeS3cEe6Hoobt0EC7lyUVGAiskc7KLClYwaZtFuU7qXzGZWp847TU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0985

From: Tan En De <ende.tan@starfivetech.com>

This commit is to support running oslat on riscv.
Ported frc() to use rdcycle instruction to get CPU cycles.

NOTE: Run this before running oslat on riscv.
echo 2 > /proc/sys/kernel/perf_user_access

See https://docs.kernel.org/admin-guide/sysctl/kernel.html#riscv

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 src/oslat/oslat.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 0863297..460f102 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -43,6 +43,11 @@
 
 #include <linux/unistd.h>
 
+#ifdef __riscv
+#include <linux/perf_event.h>
+#include <sys/ioctl.h>
+#endif
+
 #include "rt-utils.h"
 #include "rt-numa.h"
 #include "rt-error.h"
@@ -101,6 +106,24 @@ static inline void frc(uint64_t *pval)
 	__asm__ __volatile__("isb" : : : "memory");
 
 }
+#elif defined(__riscv)
+#define relax()          __asm__ __volatile__("nop")
+
+static long perf_event_open(struct perf_event_attr *attr, pid_t pid, int cpu,
+		int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+/*
+ * NOTE: Due to the use of rdcycle instruction, before running oslat,
+ * Please run this command first:
+ * echo 2 > /proc/sys/kernel/perf_user_access
+ */
+static inline void frc(uint64_t *pval)
+{
+	asm volatile("rdcycle %0" : "=r" (*pval));
+}
 # else
 #  define relax()          do { } while (0)
 #  define frc(x)
@@ -176,6 +199,11 @@ struct thread {
 
 	/* These variables are calculated after the test */
 	double               average;
+
+#ifdef __riscv
+	/* File descriptor for cycles perf event */
+	int		     fd_cycles;
+#endif
 };
 
 struct global {
@@ -299,6 +327,26 @@ static unsigned int measure_counter_mhz(void)
 
 static void thread_init(struct thread *t)
 {
+#ifdef __riscv
+	struct perf_event_attr pe_cycles;
+	int fd_cycles;
+
+	memset(&pe_cycles, 0, sizeof(pe_cycles));
+	pe_cycles.type = PERF_TYPE_HARDWARE;
+	pe_cycles.size = sizeof(pe_cycles);
+	pe_cycles.config = PERF_COUNT_HW_CPU_CYCLES;
+	pe_cycles.disabled = 1;
+
+	fd_cycles = perf_event_open(&pe_cycles, 0, -1, -1, 0);
+	if (fd_cycles == -1) {
+		fprintf(stderr, "Error opening leader %#llx\n", pe_cycles.config);
+		exit(EXIT_FAILURE);
+	}
+	t->fd_cycles = fd_cycles;
+
+	ioctl(fd_cycles, PERF_EVENT_IOC_ENABLE, 0);
+#endif
+
 	t->counter_mhz = measure_counter_mhz();
 	t->maxlat = 0;
 	t->overflow_sum = 0;
@@ -449,6 +497,11 @@ static void *thread_main(void *arg)
 	while (g.n_threads_finished != g.n_threads)
 		relax();
 
+#ifdef __riscv
+	ioctl(t->fd_cycles, PERF_EVENT_IOC_DISABLE, 0);
+	close(t->fd_cycles);
+#endif
+
 	return NULL;
 }
 
-- 
2.34.1

