Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495221474A9;
	Thu,  9 Jan 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411017; cv=fail; b=jMZde2q4za3uvy0763eNyBYN8awuqfHw6gsFE590zBywPyRL94pSQUbmGShb5HSxgv1ehUuFv9FMdNbZXkvBv+v36yv6KDApU8LNiu9rdApo42vdQGj7OSgB+gqTASH+ehmtn88dVg79epHv1pKTCBjQBYkxIprGkpKzSMpCi7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411017; c=relaxed/simple;
	bh=RUY+pQOgi/tkmc65XRaegrAUs2Liru6xBV37VBEbshQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bB+oGyiUmHsXYpp1wH/njSFH7DGg2hrfLfuIZvPCeX+IfFMGtmD/GT10D06PPKevfqF3H0JSnjmlrHLrp10r8ouL0I8TrsUdTs+rW7azvK2kPagdes54sM1fqde0WzvGeWrA3JMns6A0dZCrqoUJpHtitoN+CR6BnqA6tS/23Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=rDU7toHI; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="rDU7toHI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCRYvRZbgtXEEyuxP06x07nKpxQwE9vNpnAHZDYcZmwc4nZLIH06yXskV3XVabyAZJpLHWEHJq8UfYiyAsKKMuVVfkqMxCP9isgghdSO4vQLMg9UIg1MsERoHO3mj+M3AFxmHuvwwsIjdw7lwTWfsMbFTezz/vy25zTmOcKMuModpj1xlQeGJz6nVIeOFMAWr3IR7YFBiAqF1hhib+9wyG/d/Dr80k3AbfkcCYIf1I5tXuuQR1OPzYYio47DrAFxoNO0IGGD2sgpWFEJeMRNy579j+pTtA7yI3X7K41GJcdN/Nhhlk28wFShW7jeE+2/dWsE+b/JX7JzbvSwM1pW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUY+pQOgi/tkmc65XRaegrAUs2Liru6xBV37VBEbshQ=;
 b=dlDa3qF2+/mszJhLaPQxwXh4EAvT8j+xF6sFRJn/Y2UJj7w+QuBDvzsO7F0RH0YmdUoI8xnU4dtL/Px80uRC4IPlH236o6FF38sG1xJBMrUR0ue8yZfQaWhzyuh+plZ0XS/G9h36mXeWpvor0ULeXNCn33soqqZScC3EDrx6754MPivLyWcQUdviSY1uXiShKsKoCuZJUeCW3BRoNvSiMIu4QOuDIcDFNOZxHcGoEEq+kU7w79Wb6NaQyWbnSJUZcJfxa1UwznP+DcWx8eiVsLTSw5+tbZRS8FFg5cuahBf4ATkXcajmOzoBieK83Cs7geY2zUltL+gbBFTDiejUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUY+pQOgi/tkmc65XRaegrAUs2Liru6xBV37VBEbshQ=;
 b=rDU7toHINv7VMovpiDpMOw80FAHRv32oQKW+igZ9lUEGwaz9RJH78oPbm5pmTouBc8RViqM7vJicsKB4vukEzqlj8HSositsvx8Y9zCXNYz095F6Q04uuVkwskI+rMX2vLMZhTRjh2AB1ntvk+/9UmqadLtshbVmY6iu3kcDbfE=
Received: from DUZP191CA0035.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::27)
 by AS8PR07MB7240.eurprd07.prod.outlook.com (2603:10a6:20b:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Thu, 9 Jan
 2025 08:23:24 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::b8) by DUZP191CA0035.outlook.office365.com
 (2603:10a6:10:4f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Thu,
 9 Jan 2025 08:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 08:23:24 +0000
Received: from n9w6sw14.localnet (10.30.4.249) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 9 Jan
 2025 09:23:23 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-rt-users@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [RT] v6.12-rt stable branch?
Date: Thu, 9 Jan 2025 09:23:23 +0100
Message-ID: <2732654.vuYhMxLoTh@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|AS8PR07MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: bc97725e-1d34-48fa-56a2-08dd3086e2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0CBTibI2R9aT6QhOEgvBvrRmW/MyCCv2KaCJBbzxUuPCzghyPBLh8o8YhTih?=
 =?us-ascii?Q?aMUETNCuUYAwlX++7fUCnlqlhKEG+K1I450e/5OtEsZXjgQn8p2IzvOT/veI?=
 =?us-ascii?Q?69zD8cuvOHe3I9TVX83l+wSzfQSbcStw4R5mnkorwZM7Z0WPHFxkLoyDjNvR?=
 =?us-ascii?Q?cyza44PfU1sh1+ATvTAymb2qum1lIrn6BRAG069dyBC6E1KdfovPDzNRmNgf?=
 =?us-ascii?Q?lMzU/fCcE/Lbybo8nWHeG1M7STKZIPDeTv9eP+5rj/MFrGZbaQOTow8Dt8j7?=
 =?us-ascii?Q?GXh3IIoKaZGHgroHZRnJ9MONDhrW0F73U2xGOBAM7uwhOvTB1vBXCpYKZKuD?=
 =?us-ascii?Q?/9kaEBa/P7xss4GqT+i/G58svRbUZR/gq6l2t+Yf70g9hNXp385XD/twTwgM?=
 =?us-ascii?Q?fCSBKfLNCh/82uWWosEm7hnAJNpmiRlPsoOOAdlRNzHfUlpxBTCADShGFbhg?=
 =?us-ascii?Q?b11tWJrakJSL8CRkZJDv/v3Hn0aN0bgKTs944mGAA8abmIOwpxKiGZYxbCcr?=
 =?us-ascii?Q?oHJAfCa0hQ3JxrnGezFm0albVT+vpPpri2Fmur0JM7DA2lkEuO4iI7xpUcvc?=
 =?us-ascii?Q?3IKJffOk8sLVRJoI1gqMPSXrpzaKFH6HcVW0MfTbvRhEtlbuF/d80BnJjYNd?=
 =?us-ascii?Q?vdcO9vkvn6x+0ZoRhQH1aWT4tmmH+srJjfXKTB5TSDM1CtI4YjGz3iemo3Yp?=
 =?us-ascii?Q?+R3w8fdh6GQruC8U2Jhffgd3S41U/aP4EAhlLN74/r6AuRX31IFQdJooCGsi?=
 =?us-ascii?Q?BsyLdeLpblHEtMxXRBxv+XKELRI7/zMoBK0oWJsgkVN5B35iv4OUO/rS1g9G?=
 =?us-ascii?Q?4F7eLE7rT4NpM6YZ6HoKcXTivcs5qHsC6LVx74abDCrUcx+VOlfFpTITTbZh?=
 =?us-ascii?Q?BBCLAvLmbBwj9eg6gf5lSweQMYzoLiW5VhyHnbUcZJneThEkV2cb5lCpqZjd?=
 =?us-ascii?Q?E1qETemybnt94UuThoG2vFIIy0kmv91iDfUBphg66ktDDIwlimxuGhsoY7ye?=
 =?us-ascii?Q?cwxaAnUAibyK2W4AyuUTcoLY1mOoWfK+VLKg07hZWT8qXXK19lxDms9k+RMe?=
 =?us-ascii?Q?fJ6DSF4XlHIDkyfb3uylS8/Rj2zCCflUM34Z2cDoEyVLaq5EmFkpSKJinZ1K?=
 =?us-ascii?Q?aGsInS1F+6ax9IcR24dfSEAqDNgFUbW2DymmPPN32dQ360x6+jGfdM5PpSqi?=
 =?us-ascii?Q?KodEOXD3j7LVyg3p1+N+pRUdCajB3O0HK9u9or6BPYVjr3Wl1nH6C3m+28TX?=
 =?us-ascii?Q?9YkVfixWXNXaqE/J/l8WFEB0CU8FZEAdKNttNPJhvy4CSS3/SJwLSuIuJ8N0?=
 =?us-ascii?Q?9GM+VcF8Z2g/ndUv3E9dIulShJoREr7QhpntqL3jbSuLKWZOU8a1FWiMNXaq?=
 =?us-ascii?Q?myx88Iex8huJQP2hhCK2IeB3FYocqhp7XFTIlrQ/W25a4DeZXOONnxe//++P?=
 =?us-ascii?Q?xWMo7bnt8aJPPyBGlzFGf5Wezw/c+pzcZcYctCIcUpPyAHrRTjZQsUlcrxRU?=
 =?us-ascii?Q?Hten5PBWpdW1jns=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 08:23:24.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc97725e-1d34-48fa-56a2-08dd3086e2d2
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7240

Although most of the remaining RT stuff has been merged into linux-6.12, there
seems to be still no out-of-the box support for RT on ARM 32 bit platforms.

Are there any plans to release (and maintain) a v6.12-rt stable branch? Or shall
I pickup the necessary patches into my local branch myself?

regards,
Christian



