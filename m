Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010013.outbound.protection.outlook.com [52.103.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8F8F40
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Sep 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964257; cv=fail; b=NKf6PYB1yMw+1P9qqZzsue3sts0vLB7qjnd5JiEeCrbEtKULQODJhYbePFbRQsk0P1B0hJTWt492mKW+DobbtCmOB6lklIOlqDLlQDv6YXQJY7qP8jynGz9YfSMB61XYhrFb0vfXKYs9XsMM7Y4jMwB/YGiCjBdyA0QDiuxA6/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964257; c=relaxed/simple;
	bh=/3RNC1t3RFj9EEHsqESzkf9crUPcFFcLMHGPZL0g9m0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=svNRRhb0PDWbSN25cjw7NWRv6Niy09H8Zc2N63IwQX6XoNDkzf49L+gHFfB9WASzEeeK19EIf34bcFYOKU4Pn/gIDJudCPkNU9dtmnyeyG594tE891hXPjh155s7XFdmIF/7lurkXVdpPHJeq8OE/dPUxHdxzVzne/skD7R4hfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SYPCzz9q; arc=fail smtp.client-ip=52.103.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SYPCzz9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhPXbk55mIYQ6TVlzPy/9tD5vt463bRGzmxc5giIaz3TzFQbruSWKnD+70spb46HsGF38ufLZgLMICCdpjQYWVyVN3IboJ8kt3J7O4Y0LWcBEErHT8OKfGncDkuBpZEIZPJ4Vt8tqNKhimfv/rWFrzhYp5SuJ8oWYpN1AxH9+//112jJ0Dc9TbHJLdefvJTRzRwlXMxzB1WpDkyEw4eFy9Ud+jWtf7K9GcK1K2XJmPYeYRFWPmSZ3gjKhycvepV92dB7b6MTj9BNT5bllQigaoxvTuB0TjCLVrTUlYbyk/D54kPKXDZg5NGR/nqsOWgt0N750KqUvO75a5PISAVkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mZrON8tY/LwRzHtWNLjIPJkKma3ELFEuL/cxPwFNwk=;
 b=AR/essL3FqnE+mwroZJTf0Lr7v+hBcavWIcfJQRzD8gwdnNIBpgCfom9nZmgPPWiDLtUL9I+5teYyAZ7b8aCHIWFVMB8NFugI6wkB0GoZ8DT6gqSHa42uC+mb9by2SCw7VlA2RUYXgi/GdtPj3U8QP4i2lPvrtqBputM4/mfX0SF2ehC33VPsSCBFU1alGIA5UTQnywxa4ohT8DBSGmrYVROMTGU2HW1RUuEVMj2gAdvxGgw0yEnWxyoxFftLq/+qLsud61dsebeRSuH3BQ8nzbtqKhrw0hwmkztkU8jKffPVrV19W7hyLc4t+syNtnvGW3AqrXoOgHpmu/PLg4PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mZrON8tY/LwRzHtWNLjIPJkKma3ELFEuL/cxPwFNwk=;
 b=SYPCzz9qOXRuSU/sNf/EHxU9RJWGJ6I/ErwnLEII5PKtzRfXugkkW7CwUdRzRqPPd5C9aexWAwCcxzBlTIEd7dGVWVQ+bhWc9rOD40Zf+RCpb8IJbtkxDylKKzezFoguzGnsOxqMSxognOVX2IuJaR9J32M8zAuAayxWxcahFQ+zDMdUYjZ9RRrsd9y/84s0MV2Q5EEr9Mbu08XEIwmNCm2ACGBQ2i3YG//ygQDQ9qx6nG1UYN84cRPgF+YugbkKbYNKbBVkDoufRTsPeiij8FgDnprhXNYMBgpReIQ4R5J5lhAcCZtfbHkZ8uQJ2Ne1Nsb95MXoNh1yhzBh5DlI+A==
Received: from TY4PR01MB13887.jpnprd01.prod.outlook.com (2603:1096:405:1fa::9)
 by TYYPR01MB14292.jpnprd01.prod.outlook.com (2603:1096:405:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 05:37:33 +0000
Received: from TY4PR01MB13887.jpnprd01.prod.outlook.com
 ([fe80::e124:5d3e:8cd:f532]) by TY4PR01MB13887.jpnprd01.prod.outlook.com
 ([fe80::e124:5d3e:8cd:f532%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 05:37:33 +0000
From: literal <literalkernel@outlook.com>
To: linux-rt-users@vger.kernel.org
Cc: Haoran Yu <literalkernel@outlook.com>
Subject: [PATCH] tuna: Update tuna.desktop for cli change
Date: Thu,  4 Sep 2025 13:37:12 +0800
Message-ID:
 <TY4PR01MB1388736EE1A868A4D7F4A5A98AC00A@TY4PR01MB13887.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::14) To TY4PR01MB13887.jpnprd01.prod.outlook.com
 (2603:1096:405:1fa::9)
X-Microsoft-Original-Message-ID:
 <20250904053712.10540-1-literalkernel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB13887:EE_|TYYPR01MB14292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5e21c7-e861-4b30-a679-08ddeb752478
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|461199028|23021999003|15080799012|21061999006|19110799012|5062599005|5072599009|8060799015|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5iLqCKWDSfyXaHhgDjgQTY6h6dgyxxLCgvz7yRkg+7PVNWuncWTOIGHcyjYw?=
 =?us-ascii?Q?RdzLXz2KyE6GCrGD3Hlb164UsNrnYfBuJNoJJ3w480lPWDl5ETvrJNEk510l?=
 =?us-ascii?Q?tB1JvYWxMHp61P3MxD9tYqO6ofYxurTvgefwjn8OP/wkEJy0e74Ycx/HtK9+?=
 =?us-ascii?Q?6G55nV+Lk6/T+ne16BhCp7dUgfzscZl5T4o5/BHXyad5NVqmvaAWgSMrUIsy?=
 =?us-ascii?Q?nAF6jYb5nMo4FIrXehmQCCHn+GR/Jy1lYVHz549sYI1qUPQvou011usPecBb?=
 =?us-ascii?Q?xeX9CO20b7HaHrLpqaQsxbFD93et1MANI+nR4L40MEORvYYg02dMxQ5Ij1o/?=
 =?us-ascii?Q?aF3EC1KABlQHWRebnqtY79CmlHg9r/lErmgTl1V4lVB4btv2kNY1B1q2VKZb?=
 =?us-ascii?Q?b2R9yJjk3ABQa4C4OefU4Bv5jnAuwkAcNRUUnXcnmYGniv/wtxkdYBUyoB00?=
 =?us-ascii?Q?RfoVdVpFSEUfNWGPd5o2u0/XI6e0w1RtvLRnEaqUqyKumfWGBkI6j1CWRrID?=
 =?us-ascii?Q?GkJc4pIMi4L0zK2ZgsaIr+sGq8znnFKUi0Omx/qHy5Plypa0SCaEyn3M7gdI?=
 =?us-ascii?Q?vUAjD3uDUj5X1Of0ngI0k0z2Y7V5yD3jgkUIyUAb8uxJH83Dy8JytOnc9Zbb?=
 =?us-ascii?Q?VvmQ7RYf6MUcBmXhpTwyaJ72o4JevdP5J0OMAegCZ1oTdOQYYOxCShY0ggjn?=
 =?us-ascii?Q?aNp4pvr27OlDiWcZj9whrZBXdlXzuXik5NwhM1Q7sjitu1wql7gaw5JC6u7w?=
 =?us-ascii?Q?rxVCcaLw3jaZso4Zm+qvoo6XxUnqHKOuOoNO8OblEG6iaQ3dD57a+QzGEBXw?=
 =?us-ascii?Q?hm57dxNJuR05ROpVIhIlMHKEbohFiUqJJrwkrfvGspOfQV9QV70jKHzXzpaE?=
 =?us-ascii?Q?qeVpVjUVklWT1T7aedeYARn164E8lDgAoSKGg1sN9nwK/v7TvN+WldEK5go8?=
 =?us-ascii?Q?lZ9hD8l2OwQaK1D/09qZLiCNkmDxREOx4IrbTM2V8rIcmIsuT4lfbNgHj+zl?=
 =?us-ascii?Q?tqgceK+Az/pbkRSPyyjp+Ki9EpZpaoRtxWxrouv+40ZuKpjfrgTexYUmevBY?=
 =?us-ascii?Q?2qht9nCoQqJ7grU/wbyMqo5mzZ/CoV8G45jH1AtNETqWv2+7daiQRRw4nMzY?=
 =?us-ascii?Q?u2Z2Ew+kp6znfDIotWJL8OzP0weHpDbBfQbrV5PWQBBHkPcxTEBajtEi3M5+?=
 =?us-ascii?Q?XGOusZPO0NQe8hSp6QH1wL9WaziP4UFj1khmAnu1Exj9M+LJWSthhKhDbRs?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lvksKLJIudXegJYhxveARhsjjUskbCrVsR9D9p3NL60ctScF8DrRx7qr0il4?=
 =?us-ascii?Q?ohES1+HkN/LtLMC70dme7B1TMPyqKKecAuSM9RlWrqlnlmLk3i1eGwvW+ram?=
 =?us-ascii?Q?IVAH09n7YGYMlDR66rpZ+LNbtE8nrufVy9WoXjAZ8DSw+VHarrqkD4xXq7Fq?=
 =?us-ascii?Q?OQQc6KU36+n2I3ISJTPQEr98fi0uLCINxQg+PPpPWtGtMjgVODMMBleax5Vb?=
 =?us-ascii?Q?V4Y7Z0C3s0MuSsIj8lkTvX5qc49KlQO84qs/ywQB2P0XzFDukFpOa80jvOMc?=
 =?us-ascii?Q?HswdeTHGzCw5A9wV6/8aOpZ+5ZBPcJZxv45lDqMeo7wFYGj6YbuEJ4FUyHK/?=
 =?us-ascii?Q?31cFQWEOmuE4kFP6qltlq3+mJ8g3iQvYVSj8sOdxZweyl8abB4SAN6vrxoJN?=
 =?us-ascii?Q?TWQgn0THP8TLAAVg66xyC6P84gSA6xJuyrfDf+ICdABqj1NHDjsPvhmLUFvE?=
 =?us-ascii?Q?56SOAd9koGDz4yHebQzyMcmFQVH8TwtC3TKU3wKqXCw/RX2CXIjVIycmUs4U?=
 =?us-ascii?Q?aWrgiCB60u/BJpUVqvY/7eG5P4ZRLewm09+eGOd26ZdTeErKOnkwnGNVVico?=
 =?us-ascii?Q?WiTAiGcGiybgU6TJLaxlYNR6MJec2rhtVGAAtHfs9rfsgTmAV9iWdJxIj2tV?=
 =?us-ascii?Q?vqnfh7VBIBtd14b+UR6am5DfYU/D3ahaFlQP1mkj6ELvu0W44VAEy0Xjhrfc?=
 =?us-ascii?Q?GYkW135kPYTGfDlFewAogZXRhLiTnve460QLiJg8nztQFG5Oowmlfbhb5F4a?=
 =?us-ascii?Q?SNjjNL0jgyJb7JsYRlzyMN3Wpl/BQVUc6ISD8uhN12EBYlAqsf64f1KpdcGx?=
 =?us-ascii?Q?YcpsmdqloP36/tAVupOZGfvKyTIS3cAroCl0//kKQHbUejr8tSxfkaEXPdOG?=
 =?us-ascii?Q?4MJu3Hv84ttI4OTvpIMI5g49iA3cZ4+XqXGdNuwcZi5T95RVojuKb14sF2M1?=
 =?us-ascii?Q?POlt+usbbgffzsrr6mZOcynyl/t31I1YnQdEi9AzA1HJzf/z/CfijOBaaxs8?=
 =?us-ascii?Q?OLPPmomQ7fU3HugJ1W2UFbxn7StkTZCYFUtnlWvsbpJUdPcispwtph3MO43S?=
 =?us-ascii?Q?zWD3U32blSkSegiIFNwyEAp1k9/HhS3eupK+tVJ5J9Nna148IVeQYmFIHvGI?=
 =?us-ascii?Q?QX7bvhdP9hQYzHWvwfvyIuitP8kPdj1kZM5FJ43hzhT0wvBPnTDfSsERokjC?=
 =?us-ascii?Q?aU9PuWVJNRYoWGhj41OL4aKSp3DHnc9HqmxtCUBtUlweVDRgxPLMwMfI+235?=
 =?us-ascii?Q?iDd1vsNZh4t82AwuhHFEEbreH7sM/5J0B5nDheNIH6Y3COpBu+EdZ8AdTV3I?=
 =?us-ascii?Q?spk701348vDxW8s4hCeq1TqD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5e21c7-e861-4b30-a679-08ddeb752478
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13887.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 05:37:33.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14292

From: Haoran Yu <literalkernel@outlook.com>

commit eba1333c50f8a5eebb12b523c30faffac33681b3
changed command-line interface.
This patch going to synchronize with the previous changes.

Signed-off-by: Haoran Yu <literalkernel@outlook.com>
---
 tuna.desktop | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tuna.desktop b/tuna.desktop
index 87ca3a3..b5edfe4 100644
--- a/tuna.desktop
+++ b/tuna.desktop
@@ -2,7 +2,7 @@
 [Desktop Entry]
 Name=tuna
 GenericName=Application Tuner
-Exec=tuna --gui
+Exec=tuna gui
 Type=Application
 Terminal=false
 Comment=Thread and IRQ attribute management
-- 
2.51.0

