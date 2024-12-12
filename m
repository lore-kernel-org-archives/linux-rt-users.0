Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2130.outbound.protection.partner.outlook.cn [139.219.17.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE587E1
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2024 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060780; cv=fail; b=drf/8K8Z5pXzMYZshRsFJUHWbnEAijot3ROvEu9hZ2qd2FRictzZcGZ+lhQJ6ACS59yoLOHJnKg7HJZovIgN29qQZ2peycD+tsAg/MPKExSzYjp+lwHMFcRZ1R/iW53g7u+mKja7W5xFMCCzLOBfm1aAci6Sha71pdfDt2SD+oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060780; c=relaxed/simple;
	bh=hHdxVKcR8mh023h70CNCw0m6kLl0CmofAyVBk+glPYE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i/G1AQZQP8P+9zO0eVosCV6tbzrA1z1kZjVS2NX/6f7+uFLak/y0P0XjxUpm3FZyggZO7EqgFbHhISkloR8i6wKVKYg284D2x7xp67Sn75EDJ8jFNkfCAE03cYRFRM//zT5gqEw5B/7Rf0X9qPy7pMb3vJMr2ZmIPPrdoR69N+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from NTZPR01MB1114.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::8) by ZQ0PR01MB1112.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 03:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTzxD2eAgqm+hhZ38eQM7BdDe/qgboATEaesdqpaYOYz0HLBmjqw9OEKJIjwpZbydijDQbHHPH5TLb8BLDBp6w1h4/9KxUwQ1CCWxqcg3nNTmYcCqEvIwDn2kPsQYKB2oCGtJ6LwR+ET9UkRKz3TqUfKvjyj7JAyik7qxw5tptE3TxwBE/p+u+4xqq+AdqVg5Bdx4uSpe4v4KmRkVJNzmo6SUhGWERrd2jiGux3rUdobtJylmYo0nlG7L3ZMB3j7mOmZ1hxm3kgWdqrNt7jd5i4Qm3hnuD9d/2OBacyGcHJwo5QRjZVhkA8gkmhAYRX9HZRQFi7n7DHHQa0eX3Sd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOgoEzYtfLq8dzh4I2ZP+hrE2sXjAiRFQr1yTiYjJ9U=;
 b=OiL3IkmAlEBKw4bK+PT8mM6aT+EnpNcTbZvgGKzZ5tRFEmYDCBROL3hHMM00/Kr+p41te7oaV1Fzy+JYh+kWjfPda2wiCZyXesM8IUVoNu43dWAtUFOYpBF6BoeRKc1TLy1gsgKRT9lWBDWopTpMDcOYjXjynNUgyXzj8xvXkjigtlBGs0PkMA5AriRPVmlm6IMgN/o/dap93thKHEXOAEqU9SHzo+OBOAgP7FRaUhxTGDLboo7bCREqzH+dy3VwUN1UjraT28/O0J7OoCDRbSTL+OZLo4vu3IOLz0UYi6ll4uPbeMug2QmMP8RoaEbHJnDh5or7dCZPtJOellxWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1114.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 16:25:37 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 16:25:37 +0000
From: ende.tan@starfivetech.com
To: linux-rt-users@vger.kernel.org,
	mtosatti@redhat.com
Cc: williams@redhat.com,
	jkacur@redhat.com,
	leyfoon.tan@starfivetech.com,
	endeneer@gmail.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
Date: Fri, 13 Dec 2024 00:24:53 +0800
Message-Id: <20241212162453.2618945-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	NTZPR01MB1018:EE_|NTZPR01MB1114:EE_|ZQ0PR01MB1112:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddab952-65aa-4172-d1b8-08dd1ac99cba
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 Mfn96nkyhfaHmqLPbqL4VawHJGNRbWRTpI4czILAhMmIWtX8+fr0PpGFh6qbZaCVLzx+wv14AScJLSEWTjTDF6Kcd890NhjCeSKcXh8YaJCJZBN2vHkiOtVQQ2Mvq8dh4qXup2XEE29YBb71WSCPPPBnUqZAAS7WQ3fd3uB7TCVZUjJgMDBGd477B4T6K/YcHIn/OVx8Q4nYznQCiCcKpSkYvKu2rrrtWPNoA/lGarZi6odmJimYc1C7st0r0DubY8Cjoh7y5kYfZIdrzhbu5X2GREC6z2KZSvbxyN5G0kkiW03jozxcWhSoDPjCgn8Ix6uwMCdcGOzW9IvKKmv/SfyGjv4FII/OvsagVTAL7WoXr+fBS1gEgypSzYgjL818xJ4+0dUZcjPF205ipPdH8ZPafR/Mmeh3pu1B22GaKcXgo72phzHGlotf2LT9pwxaw9qCTootFWRN8Lr9t9mmTikgZPZBQ4l80c6Iu3IFxyPj37easWv0XGMB85KFZAKqFdWI64wrgE0IGrbHtmHcPzsrmDM63p8zCjJ7l9X1A47Tl0Yvk/GtF3OLDamWdE+O/1k2r+y6UV++Gi4eQZtfMaqqa6O5KtPjEzVk3Pf/ZVQByOLQkGMiQP1UsWPKzcFZ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?TaJK1rk6h1+MivMObwdNIJWqiNW5apC33Tm+vJXaXxGINOeZcGms+MooqnVA?=
 =?us-ascii?Q?m5UDS18jv4yTKGY7Jty02cgY4H7nHjybO1NDUrUQceXXNjRCqaMyLfWvJlWV?=
 =?us-ascii?Q?sy28NTbk01TN448qzEI7U/LB6TefkLPKZLJS99lG5eTQC5ufmF2IQOPllE2S?=
 =?us-ascii?Q?D4Gm97eNKt/sH1Lbj7Ap2NocrBbR1ytuS39Ly0ots2k4F5vWyjNL2ruJCNcv?=
 =?us-ascii?Q?1CrQ1ubhRkuplrf6V3cSPFpvMOO4h+u+3GOYvqglQrOqO76fk/xtR/mofYTb?=
 =?us-ascii?Q?AHSIvpw0PWb/2xTVA4kD1XHw38gKwvvUFxQa+D2wCdy8HVAjRe2Meg2GOqmU?=
 =?us-ascii?Q?Vbw3UEKE1YutazEvThWq2mQXUAHfete/Xym7SfK6jtrM8e9Z6ziJZopICJ8d?=
 =?us-ascii?Q?NJx9q0gKwxHtV8Hb74F4gg2GD5+90LYNY2I4MITTNiALbZNkVZdpWFCHUlSG?=
 =?us-ascii?Q?B+5dbkYgmb94eUJcRg060qTAnCYHEziOMjiNbXcDANC5W9yMdtazrdmp7Yfr?=
 =?us-ascii?Q?VctzsIJ5Z6hxf0u8yLDPHBpkoOAni1Dp0XYpKUEj0n3RPPGc7aKTqg8FSHe7?=
 =?us-ascii?Q?beK3Q5ezagDL5xQCc1ogO1DQA1BdYtniIH1H+/Izuu9MrMFt38BecX8QY2y4?=
 =?us-ascii?Q?O7eU3reJzmlr2pQsdK/W/6WsBbM9a2g3nDUthgmbcywfP8NygkxyPpsmWdkZ?=
 =?us-ascii?Q?fpF20wwn10zC6nsgLmO8px2R0695tRTbK0cNblkK8r5/ciJ55rweWpnT0JkV?=
 =?us-ascii?Q?YEAnQyD3UYtEqiw1JLRXaeNLSWNKWfULyXqW1izB1Ifx7rqh0ALhVrStCxxM?=
 =?us-ascii?Q?RcdzknOVXanAUam8zzVC3bZGFaTfjJOvMyC/3IS7Mcj+BZI0BTlYwhyHf99j?=
 =?us-ascii?Q?Fitnfhr0kfbT/W7JglevHx+3jnbOvtsHOlDPFpkX9HNPyPO29eV8vKOJlhyZ?=
 =?us-ascii?Q?Puuph9e1TfVPhgNskKbM6WTFjquw4iOGstgbpFIR0pg3KbNEVkGDakDarOGM?=
 =?us-ascii?Q?FlOAnTxj8zBZ5CtEdMMBzluiZ4czcPR+gTa7W85oq0NJCJPhtnB4/0Q5Ctki?=
 =?us-ascii?Q?WjoUUDVTfQhZ4uzqppjcVOzdYOKvpYSI64Gd1P51ZRyUWDg4d4GzerthXvV0?=
 =?us-ascii?Q?qo4K7o+D/4xFQODR4LUxHZAv5Ynb5syq5KstgZ3hXZaf6Q1XU9c6avEaRQal?=
 =?us-ascii?Q?23z5lmrB306FEff27FhpWPgyZj42dRaRuH8ZMK57G2hXdiXJVu2DTkUbIO4F?=
 =?us-ascii?Q?XAj01IU/z+yaeiPScWa65/CZGGLLMqVNSk4Xz3aJqbH9XLAlD5H1iNTFvxjI?=
 =?us-ascii?Q?qKp0kC7HFGsadPttYfqcXj7FUpxYze1mDRxKn1BWcVora8TJKKJ9E00K3VPk?=
 =?us-ascii?Q?QrInk/VgCiHf6cq1KpiA0cbW729iCPwxI/kgQMvtiCHzGvkgeo1oaTlix7zY?=
 =?us-ascii?Q?CrL/kdpDYrtNvJaWFrpCAk6xtBR9IkXcqnKg6nsb1IVasaEuQPmZ/S3/yxei?=
 =?us-ascii?Q?7fYFIXPz8BoW8lHlCM7EdBKSz1997nrXA/LW0drFeOe5X6dZ4RlmBlJkPXZh?=
 =?us-ascii?Q?vmWWcPBKgssS0JbTyK2ddACM7flu09vh2Ui8STJqYhM/PdQuyUcxxAPuz8Kx?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddab952-65aa-4172-d1b8-08dd1ac99cba
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:25:37.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+UfTDt3Dx21+EPnZst0QMEiZSiPB0heqph8rI+q6dXtr95waKhThAcV77KZ5M7OVsoCrZjpAhARqz1THx8NhchtH6c3ZoFdSI52VhknLqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1114
X-OriginatorOrg: starfivetech.com

From: Tan En De <ende.tan@starfivetech.com>

Mark unused parameters with `__attribute__((unused))`.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b1f8420..f2db5e4 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -603,12 +603,12 @@ static int has_smi_counter(void)
 	return 1;
 }
 #else
-static int open_msr_file(int cpu)
+static int open_msr_file(int cpu __attribute__((unused)))
 {
 	return -1;
 }
 
-static int get_smi_counter(int fd, unsigned long *counter)
+static int get_smi_counter(int fd __attribute__((unused)), unsigned long *counter __attribute__((unused)))
 {
 	return 1;
 }
-- 
2.34.1

