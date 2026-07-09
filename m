Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49439A7F2;
	Thu,  9 Jul 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616404; cv=fail; b=QfH1/oDxRIpN7kmH7pMtdqVboL6Nc58PMgp5WOX0m/cEjHG+3D4WaSmj5G+94CtSYSk0BrFtBHjaOZ3wd6ev9QesJKnFRegjad/5sqDevViqznV3MLATkE6Xb7Ka17AQsWWoDDdW/CTPahuRJgGMH088CHJtSj7eiE12Zr2TP4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616404; c=relaxed/simple;
	bh=QsiFh5yjAe1NKU9Zuhl1Gq3HHWike4Oz1EYjs+xAfFI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PZr5qNngkTOq2MlAteBlUVPSa1VgxaQarKZCELWbvJ0EbyK8zywmiNwpFMfQKKdZfz+JlzvJIlCi4grfqmjh5Wv3Y7/hJCV85WP5ciQPhXlYulOHKPfIJrFF6ztMZqivW8Xkpy4luahONQjUnwcfrIdgsru324cLCfBYSzdA3Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=L0LpJ6wf; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="L0LpJ6wf"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669GppKi2815177;
	Thu, 9 Jul 2026 16:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=seu/Vk2gg
	DbIJThTkDbOELX08YPGlGKivzWKR8DzRVk=; b=L0LpJ6wfmqKi0tDeb3IV8USlt
	4Muy3KUQ/niR483kuMHiv/kDZKzUvZ+OYH8Bhb4GgDENIUD2VW7ZQXse9iZFMEKW
	T/1d1eTUiQNciFhUEpPWnH0YffBGeaxKCY8pu0VFnNlPl1lMDEqC6CBxVUi6f5pn
	La8pg0McBgNC+6E1qt/EdKuPFKJwy+PXIjsF7eJcxY0d9kUtWBwKfTvmgbwM29am
	acujDBY3rJ/wFXkJbgb7pH7jlpcre9FQjUycVp1Q6E/MFn9+f/TCiUxA0Wh0jJne
	BCbUH6jMSklhF1C1BgR/GsC7xvP60892xblFiHARcz+d87Lp2elB346o7uvQw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1aq9a29-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 16:59:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI8w/L6SBI3ytlff5UKfN7B3Y5+aOjkJuLny9/T8Z3r44a5fZzaiLyZ5ujcK4Nk7qIv9F9msY7ixaciScdgsO4DQKGeYsFAeHlfU5GaH3aZH4yktkfOEhugiCXEdwRLjtdH6ag9tAniR3nFo5I8NBvKGiTrmCN2DRyHrAPvEGew/h4wts50SumGJ4mp4KwXI4H92mhHto/xW/wrAuVkEraowLfc7HBYPkrbzqCtmllAnA+pm+VsG7jiODmo7nykILUT4Ii2l17I1F6HM97laWokCMhz75x6uOld0vxjnIstua0TRfKBmEVDfX7CiwvAgUD+EdBlK/cCoU/MEkBgt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seu/Vk2ggDbIJThTkDbOELX08YPGlGKivzWKR8DzRVk=;
 b=ewPw6og91Vd/HpHOHsy/8pEYdoA9S6PR7hLJMxrQyKOzeAy7fWwcxF85lb48sB47Hn5V8VO6jQ85WykrOLII3X/giTtpr1VSdfGLiiFU9XhI8b/rOfgG03I3Aos9vg4CA0wJAOyYFuVEc4xtTRwzLZXwpBqg/q12lkGuYCSP0rQ/y6W4U04Qfii3JoRebqnurOgBbtlp7bB1J0NTlUOU2PAxwXZvMo6vm70u5Hkrj2FS5CIQq9jjg1cpHDPhiviC8wr7UdITuHOgGryvFDJgK95KFzRZD/c136zYMi7od/w4hAVyGFS2AVK89IMQOsKJZuVwWQC1gAJ7wTwG3Q/i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 16:59:21 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 16:59:21 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: peterz@infradead.org, juri.lelli@redhat.com, bristot@kernel.org
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ionut.nechita@windriver.com
Subject: [REGRESSION 6.12 -> 6.18] fair (dl-)server delivers no bandwidth to CFS under a CPU-bound RT task on a nohz_full isolated core
Date: Thu,  9 Jul 2026 19:59:12 +0300
Message-ID: <20260709165912.518175-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0027.eurprd09.prod.outlook.com
 (2603:10a6:802:1::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 08793fa8-90ec-4e6b-3121-08dedddb6b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|23010399003|376014|18002099003|56012099006|5023799004|11063799006|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FJM0+xta/RKkGXGKi+ssPWUnys1UG2KBi/powsL754A/0INlH8qXnHFKRHtkkNMiwy3nZ12HFhIBBllv2qE96NeLB+OjsgDFI0aOvIlPKcXSLy4kIAnO9/TRWPzH7vBXtwtSmZGVGGk+pmC60JrHQWVF1gsaxbCEHJNJ2G+63Xuyah6Ea2pOoQyP1To9CUwitVIXQkEdOOEJ7Z9zpxYOeZGjGtj4aSeLRoymf6U80BIUMKRfmUvGSdVsgbrx1hDdiRwlefbxRdv43Yl4bnTq83B9iEEIxUlwIQXz/uWxOjtIKopkqKjvkxyerfwcQ97OOhS4obeSIYGrUZpWj8qB9PrEZR6vJfc+shTTc7BSqvEioDFuxkn0ya/HxTYvxLf+ua5pIOEiu4RQhn36LEFZiEDZGd8uEyifggKJrAZZ6DXz9miELAnO0FPgMT8m+ZWWONZoNklICqI6RerqDXJ5r5p2NRKRMjjXATsjcHHg70rFr3ZCw7mzrHxC7spzgTMfdSHoSp3d3sWpm3iqb0MGHZgUkJJpTSfco4wOC9O8JY2QlmdVxheRO9mfQ44u/+1t2Ub0s6OwFLyvf0X7w3Y7CzO2hQUq8euf/b0Fd16FrjLsG7ivQAs8dTdg3RaFto+iNWYeOK9pZaqMocDrZ6g4eGyQ6KtYK7PuJsXa8Wc1fpdy2O5T5klefpR0O7hXgrPPg+ufJRBIh9R1SlF6McRcTGYd2Zf4aQ/xH4DZdVEJ//I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(23010399003)(376014)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ug0rwLLoXnaFnD9NBYFARMCJfShuc7MALCO1Y5lNlC7/VUfHRMEmN7Gl+Llm?=
 =?us-ascii?Q?gqNdJA3S8ZHGUpp77Y6+yZK6PZWa8XGheiy9QD5c0vPOi8uWU57C8T3r573f?=
 =?us-ascii?Q?QULaJXy/ppTLXFuUpOGd/5x20GOhXV+mejHnQFUl9ZyKVqTjXUDvJnP6oqHq?=
 =?us-ascii?Q?dQRO9k0JOmfm0Zm9xwBtrGbVhnr5oJ9cID72Q15p+mUM0XxGl+m1HQ0WlJoZ?=
 =?us-ascii?Q?BqsvfxaLgVYDips3+zl1vTL30eN1pC0GNT+6Yah0SKe/Y0Tw2Rxpf83W4h0C?=
 =?us-ascii?Q?bUx6e4bVnvZvYpYhtBO1u5IbA7MuU5zlrK2YjvVyPBETmaBsf7nrjHl7unv3?=
 =?us-ascii?Q?1JJ8JqnkTOrGd7DXqK+4Ot8C+cHqM4+dQE9J6Ogafv5m3fu5vDOYPBkJ5KiJ?=
 =?us-ascii?Q?s+ZaK80GlkCIApxDhpv7eoUXmAtHH+EwftFrYTRBCSXL5mNiUzJ2Up4OGMcv?=
 =?us-ascii?Q?GsHn3Jpa2kogGRtjDfCqz33AJ3td4OhB5Zrj8Dxe4F7njA2IN4ExYbwgeNSB?=
 =?us-ascii?Q?sDgTi4kbYdTd7BhGW1vslG+OefSD4+LwgmRyI9PIM0knEuOVFIw5YS7uNAaC?=
 =?us-ascii?Q?hMhtpL4ZwWj0ZG3Y3hzHa6FTveWoJEppFu5S+L7W+Lk/cxohQdM6I/8wkm4o?=
 =?us-ascii?Q?54IggAIHKkwA+kONHi9WnS/3py15zCzHaNcAwyxWAvYiODzgexw8pYKUa72p?=
 =?us-ascii?Q?zzj98ltEJh8FJLzXi33T0cVP750sAWBmSVcf2TGHSPpm280ua79WHF2XHHg8?=
 =?us-ascii?Q?T5NhoQag+n9jDXSqxtW6xD1c4kOqAffU4nombf7DAbSBzzMfnNvTgPSZMy96?=
 =?us-ascii?Q?fVGaYsbehjlxvVd6xK4S2I7iWAdiWZa4QJFAKHH20YCKR5XgzOFe1JdA4Msl?=
 =?us-ascii?Q?yAs0C6CS/sxzJCrKqPlUiIMoLAZGK2+mQRX98kS5pr2LV3YPeNXuXGBnu+4E?=
 =?us-ascii?Q?Z9upTn2Bm3wYWNCheCBXWrRx3Y9aOSaymhJFPaRq9A82qI4dBu6jKn///57i?=
 =?us-ascii?Q?aqDmxhWZvU0+zc2C1UtwZgOVx8W5VeygKqNJ0uz7jdF5zYfDUQK7kUwDm5hr?=
 =?us-ascii?Q?EQGEAtklTdKZHzvu4MPtQCukjsclS3SkAbxa5XWXBR8HNLzacaJp5xm8yyzU?=
 =?us-ascii?Q?ii3npn1Rz0GLPO1VnOD5SCDgNqwv/sM2bwGidZTo29DPgBqRq6FxDJPMoMdr?=
 =?us-ascii?Q?qrpOz/1WiGUXGx/X0a8+bTqljNqD/fiBq2deTB0YZlTEIz7QV59A9Fqm9VL7?=
 =?us-ascii?Q?GlVmVHUoqIsWNHhdHUYODG6VKWsnGYy/r7nY9rhCgPfwUlcLOe2xBZboqwHg?=
 =?us-ascii?Q?7WNAfpdt8t+AEXNqoyw/7MebmeHweASLEIGlNltsf0iCogAG6LrPCOGhLeZi?=
 =?us-ascii?Q?xynJCfgyWdsOKHSWDLOf1yIcnl5sWUjO+A6OMqoj6uP6zHFWPEBgUBJk3oIY?=
 =?us-ascii?Q?uRyCxCzigXIHQPpLSDCbLeL/6Gh+vGXNt8r8YIZHLyf0piHLwN84to3R6da9?=
 =?us-ascii?Q?bJSYGwEGBwJFf/9Rh3+LGSMHVtH5zeBn3zHHuTrQDWfmm3IPbllv1KDOsEDR?=
 =?us-ascii?Q?3Fc4ycOepodVyzopvvM3ZojaoYG+8mD14eYOZgdPHmcwLyZYkfJGX+dzvhso?=
 =?us-ascii?Q?4wSSFmbza34S4C3qHVXIbyDEhcCNF3F+RSLxLe2riECkPKOttaHoeMWgQsCY?=
 =?us-ascii?Q?yx/kdGO2teLjKcgCcJbK24vTijbj7CYnFlj/ilEnlhgIuG+sw4KOme1glco8?=
 =?us-ascii?Q?t8pRwQ7HI7YgeZfBUk3BR5sztFwSv1Q=3D?=
X-Exchange-RoutingPolicyChecked:
	FKnMqqfXBAfnXeAaTQX0C2BBZzK3jOd1Kt/fu5nTHHoxt1J36acMI2u5hjodQHasDd1pBrhq428OO/uDicvAtjTnX1XmOtZPGzxm5olVAz5xYjZtkxPfviIq5y8I8Z+CnC/hZiSTxc8jeqh/WjadYg8uofiHxlTjVS8dsGEGfLjDVHsaWdXHjgM06kVwcbBsij24+9aZX9UBC91LtyyELpyhsKDWEYIhTbLOsM2gd3cObJ/XayNPkIYAe9zfQKcIHNPn7quWyxV64oldjzU2WdQwqNmnIZ7MG9D+IZ/DsvwB7DFiETEl7B+NrNT3C1E3+8xcizc9RhLGfTV/i/zNaA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08793fa8-90ec-4e6b-3121-08dedddb6b7f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 16:59:21.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oNZXJp6W2ZdTjgYXq1STXXZ2fnaR3YQsez0s3l7+gNnDYim+ipp97yvtU852LU9oF4RguI4wL/0bGY+a2s3xTxjCbv19w8ojJQCGeNE/ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-Proofpoint-ORIG-GUID: 3XmB8N-N0mv3mhp6JLdaZI9CFu2Hm4FC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2NiBTYWx0ZWRfX+Yz98C8sXiMb
 2z+CIYcbQ9Fz6VDckMX0h00MGWcRawko60thH2+Enp+e4BLWTeG25A2DwY4yhTMhKaF57DB5KxG
 2ap8UgvHvFt0cqCuPIkpexLHl/9ZOanDErlI5uY8htq1CJjTk8cA
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a4fd36c cx=c_pps
 a=YpUwD7Le0KImUpHpM7zjfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=a0mjLQLFN5PECchzGagA:9
X-Proofpoint-GUID: 3XmB8N-N0mv3mhp6JLdaZI9CFu2Hm4FC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2NiBTYWx0ZWRfX29QnzFc3H/EJ
 7gDi6B2libC9sCVHZH44KdFar1+B7nTAi8pHTyS+dEJpQyAwYArEdJ95PW1sp8ClRh2Hx9M2vm7
 TmZAkL1yPVVsL3kyukvUMQr1jHNhpgKF5r+wpO9fL1wM7e91AhJ2CHe7IH2Tp/qdsUNkBtgO9iH
 lZW9ZGMhqdp9CMCwYtwLJqCnciDjE8Pk3PBogYK18LB03Dx5PQoQ8G8WxHhbEnE3vY+1y1/cO/3
 zPcVGJ0MA7Vt8+Qj4UvXz8lI/m0gAOQlNrnSVoIM87L1kbfl5B9h3uoa7oTq34KzHjviME9Gj/H
 r1jQIdJOOPntXMwUSTIqQgTVEuQg9I0rz9TSyCDame3ewQb4g4e0ICJrUQ9sZ+wvCnKohVKAzKm
 ExFNBaGFcyJSwkNmEfxHVrNiCSriLAxVnveLOpQEph9U4UFcfvcNonB2l5fG9FpfmjHqzManGAD
 2nwCy008d28KidAuyHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090166

Hi,

I'm chasing what looks like a fair (dl-)server regression between 6.12 and
6.18 and wanted to ask whether this behaviour is known/expected before I
spend build cycles on a full bisect.

Question in one line: on a nohz_full isolated core, with a CPU-bound
SCHED_RR task pinned to it, should the fair_server still guarantee its
50ms/1s (5%) to a co-scheduled SCHED_OTHER task? On 6.12 it does; on 6.18
it delivers essentially nothing (~0.2%).

## Environment

  - Intel Xeon Gold 6338N @ 2.20 GHz, Ice Lake-SP (family 6, model 106)
    64 logical CPUs (32 cores, 2 threads/core, 1 socket, 1 NUMA node)
    HT enabled; test CPU (cpu5) is in the isolated set
  - Debian-packaged kernels, CONFIG_PREEMPT_RT=y, CONFIG_PREEMPT_LAZY=y
  - Boot cmdline (relevant parts):
      nohz_full=2-28,34-60
      isolcpus=nohz,domain,managed_irq,2-28,34-60
      rcu_nocbs=2-31,34-63
      kthread_cpus=0-1,32-33
      irqaffinity=29-31,61-63
      skew_tick=1 rcutree.kthread_prio=21
      intel_pstate=none nopti nospectre_v2 nospectre_v1
  - CONFIG_RT_GROUP_SCHED is NOT set
  - CONFIG_FAIR_GROUP_SCHED=y, CONFIG_CFS_BANDWIDTH=y, HZ=1000
  - kernel.sched_rt_runtime_us = -1  (RT throttling disabled;
    consequently dl_rq: dl_bw->bw = -1)
  - fair_server: runtime=50000000 period=1000000000 (defaults)

The two kernels compared use an otherwise identical scheduler config
(RT_GROUP_SCHED off, NO_HZ_FULL, CFS_BANDWIDTH, HZ, preempt model). The
only sched-relevant Kconfig delta is CONFIG_GROUP_SCHED_BANDWIDTH=y on
6.18 (absent on 6.12).

## Reproducer

On an isolated CPU $C, run a CFS hog and an RT hog pinned to the same CPU,
then measure how much on-CPU time the CFS task accrues over 6s via
/proc/PID/schedstat field 1:

  taskset -c $C cat /dev/zero >/dev/null & CFS=$!
  chrt -r 25 taskset -c $C cat /dev/zero >/dev/null & RT=$!
  ( sleep 10; kill -9 $CFS $RT 2>/dev/null ) &
  sleep 6
  awk '{printf "CFS ms/s = %d\n", $1/6000000}' /proc/$CFS/schedstat
  kill -9 $CFS $RT 2>/dev/null

## Results (same config, same test)

  Kernel                     CFS bandwidth delivered   local-timer ticks / 6s
  -------------------------  ------------------------  -----------------------
  6.12.57-rt (good)          ~50 ms/s  (5%, expected)  ~360  (tick mostly off)
  6.18.15-rt (bad)           ~2  ms/s  (0.2%)          ~10000 (tick kept on)

So on 6.12 the fair_server delivers the full 5% to CFS even though the
tick on the isolated CPU is (correctly) mostly stopped. On 6.18 the CFS
task is effectively starved by the RR task, even though the tick is
running at HZ on that CPU.

dl_rq snapshot on the isolated CPU under load (same test, both kernels):

  6.12.57-rt (good):  dl_nr_running = 0 ; dl_bw->bw = -1 ; dl_bw->total_bw = 0
  6.18.15-rt (bad):   dl_nr_running = 0 ; dl_bw->bw = -1 ; dl_bw->total_bw = 2831112

The interesting delta is dl_bw->total_bw: it is 0 on 6.12 but non-zero on
6.18 (looks like the sum of the per-CPU fair_server reservations). On 6.18
the fair_server bandwidth is reserved in dl_bw yet the deferred server
never actually runs; on 6.12 nothing is reserved and CFS gets its share.
This makes me suspect the dl_server bandwidth accounting/reservation change
(combined with dl_bw->bw = -1 from disabled RT throttling) as the trigger.

## What I suspect (not yet bisected)

I have not been able to bisect yet. Scanning v6.12..v6.18 for dl_server
changes, the one whose intent matches the symptom ("server delivers less")
is:

  cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
                v6.17-rc1

followed by a train of follow-up fixes in the same area:

  fc975cfb36393 v6.16-rc5  Fix dl_server runtime calculation formula
  421fc59cf58c6 v6.17-rc4  Fix RT task potential starvation when expiry ...
  4717432dfd99b v6.17-rc4  Fix dl_server_stopped()
  4ae8d9aa9f9dc v6.17      Fix dl_server getting stuck
  a3a70caf79067 v6.17      Fix dl_server behaviour
  36370892e3111 v6.18.9    Fix 'stuck' dl_server
  909131ad0a006 v6.18.14   Clear the defer params

Note 909131ad0a006 is already present in the 6.18.15 I tested, and the
starvation persists, so whatever changed is not addressed by the latest
defer-params fix in my tree.

## Questions

  1. Is CFS getting ~0% (rather than the 5% fair_server guarantee) under a
     same-core CPU-bound RR task on a nohz_full/isolated CPU a known
     regression, or is it now considered expected with the deferred
     server + sched_rt_runtime_us=-1?
  2. Is the deferred fair_server expected to run at all when RT throttling
     is disabled (dl_bw = -1)?
  3. Is cccb45d7c4295 a plausible first-bad candidate here, or should I
     look elsewhere in the 6.17 window?

I'm happy to run a full bisect and/or targeted traces (sched_switch,
dl_server events) if that helps narrow it down.

Thanks,
Ionut Nechita
