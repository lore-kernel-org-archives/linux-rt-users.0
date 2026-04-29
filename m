Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B63342CB0;
	Wed, 29 Apr 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480090; cv=fail; b=p0jg8NNa2C2lV/h20+MOnp/0dETnammr+MJBvl3k+ZXhIXDOiBYhTKru0oPZyovGlNGyQTAf3PV2nLsjdqhQplhA2fcMyipOqriS5rCTamiGJH88A/akdndpeV3+o9bi1OIYZeY87xNHmDGKCsdAdUTakz6HegJbZ0xKcmkKpjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480090; c=relaxed/simple;
	bh=lVY7NtOdPzSxi6OMdG7z7qM+v3zZms24IX8/7wWwpwA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u8p+NYLanfBeHnvFWFzJGNWgO3Naw0pLfRcLtpFiggVKg3Y6ksOOYXmW+SWDEXKaMPQd7FY9FatFiNMgnluyjH+u2BrEiUCdxJ3gVOsqFzf1rgiLtos5DBe+4UBGj2IdD1ij3Q0KsBI7LejvF/ui5K3vygOBkTRJIymM73xb5cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=q8WlE4TQ; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="q8WlE4TQ"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TAhq8s4156091;
	Wed, 29 Apr 2026 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=o12dCJ0Jp
	ri/4q1UcLP8eW60d9gyYB5QSu8XLd8yNW8=; b=q8WlE4TQDaAj4bGhDnXsAxmJ/
	9My7X+d9CAWcaCoogTm167dLzQbyhLwoeqrorxcs6hmcj0nFtcpzMmUu9dXj70Ai
	c/vpf7fU0lUMKlCG3qkn7jFGSRklx+ZlPhAnK+n9a0Gyd4lBObkdqXpu1gAkO5cd
	9RYmclyQa1Ot0bSlK9S3nbFgddKZNYyejG6WZz8t7V6ITp+haBR+bQSoeYe1JikP
	OwChp5E99UmgKqgTbr+zm4s8OxaXAGQMseqMxftPsANwwC/xBgn7ueARqwwejrrJ
	jhq6U6kAGwkNZj7xasJ0q/XTtLAAVMf+G57Avke2KjribfrdQRjmqskpdSdDA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drju0d93g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:27:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci4WCSTNRgtX/nVwbafk3Zhrsw0PqJ8IPhSUBXSjrER5KHg7ATln5o2xaf0yxnNZjGf6MERqefFOSR7Udz1u86sO1QkY1ZP2mRYQinkvMmAl/ayCCa0ImbpM3ZrKpJOev62crX4Jz8uXM8/DcF1gARFuFgez3p+7CZHxZ7AhmzMFMgCjuc7CgZNhF4DQl2JAjjlQTPEMG2vnenPNMXRrp7ZhOwESDadpfyEDO1SD9nQv5zZczzXd1CKu3A6Cpd7/mDnet2jB/lnhOvsU6Ik48uee5pdE4rYTfr5ysYpdXG38B8e0IurWxKmg3C/I5jzIzJnF6QCrhazs/gqxzgF/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o12dCJ0Jpri/4q1UcLP8eW60d9gyYB5QSu8XLd8yNW8=;
 b=Ke9z3lfecYLLvthIvfS0gpIU38UQVDZVtJkej1gcGNxTlfuHqhii0I5KANAEtid83ivtbvLQVWA3QVbTM7VEm0L3cHs8ZmuRVSZcM6fQrzS/gdjDjkU/Rn3B0hA9rKXDruTOnoYAVmRaO1R6B581cvXSwqqvtLVi4l3bKAuXWNXHJRtqhxx+UXM0fnvM5UaFZpKV6BlBZzhS2vv7O1g+3bTvnHUAJVaqavhvtHL4ngzsri738IfN6pGojk/OVAU7u+DdAsUSPzI9CMwiJTmFOCNmNejkf0qhPN9oey+ILKvKR22L/G5FVeTHLyFLtM9Nfq4Axc0KhYIoIrdSYEiXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA3PR11MB8023.namprd11.prod.outlook.com (2603:10b6:806:2ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 16:27:52 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 16:27:52 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users@vger.kernel.org, x86@kernel.org, mario.limonciello@amd.com
Subject: [Question] Core-to-core CAS latency spikes on AMD EPYC 8534P (Siena) cross-CCD
Date: Wed, 29 Apr 2026 19:27:36 +0300
Message-ID: <20260429162736.339322-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA3PR11MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e6d1dd-0a8b-4b26-3791-08dea60c42d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	oRndbOWqqoMKFXQEO4lwnXbwJY8YZwKpQLvOlypitpjboye5y8GQKHaZaK5m3n/Z/QZWKK+XII2noO3HEXpDckb+/mD72F/KNw6nxrWLDpP1jazQwlh0urAVsV2VvNYoa9PxLr33Dr/iuv1SZGP34q73Vr4AD6TfrTIkimjDLwJlU3uLDEEVQ/pMPKNcIOlm6qMLyxHlopRp+uaJ/rDpZdHec09j8I8aPgrpGRabLGvTtR116rzOEjifxJ7R3E60ZAqnCNCdLkuKqUCGTxHHr2Te49UTjC/PqzaSlT/BGB8T3GlUr1/3mynap3xaZLk4Oz7QFhCUO3PRuY+9Wvk9nxg9uwQYtfkPe5VL7Tk/II0A5UDoVhvcum/tzMI8rMk8dlwUig0ZHQgyD8XLGNSoCYTF//sk9kEZlDs2brq5aGLdN1OXQnU0Bc25mJ2wRmRmv8DGQYczCGpPpW0mW3AA6Yqx760Xl14Q6USwwK4ME6qhIfJY5EjuWUvBd7osEAS7U+t5cw//0dNiPBAIggdPSV8+oKM+gEw2oaGTTjJeTf8ItSnqy05CKnKhK/4NuS0Ise9NiUClAjOG2UTD+gM/cR5EEwmPPcY9LzyaqvPi/UUkCMAkXaXc1aXoCzr7nkLBfJI6F0vjhCqm3BUeReL+CVPbgv1lQrS4HsUlQONn/BWbvAiODIBCWvTiGKgJoOPifaDmlq2iuUzoALPu1jax2i4Ha6NNGMIOCotxFsG+9f6/pKbBM/VA+EygLMWVLgjQQhNa5krd06Vgeh1sdoQ3NC0vXLPbRair7NwH/ccqap4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+5OoKjGFnWc+4G8P4eRcY1qQ46vqOZaWlLpdwsoVmVVDOZhik8B9CrV3539?=
 =?us-ascii?Q?L9BXEEWZWiy+oFR4ob0KxrGxU57Uc/6ZWmngQuiXSLNHSG60eli3jRUbpM8w?=
 =?us-ascii?Q?x9liXADoZLgxsJYmSiUQYFfQwiCnWkEELeupcjQdkD28Q7P8U+tnOOohJN+t?=
 =?us-ascii?Q?8QD/mtRJ72KqN1WTE2adijyRXtqqW7Imm3g8hAfQTg4/bA6VyTjpIXloalx2?=
 =?us-ascii?Q?YLX8oOckuh+qyr42CHG6ZytALN1MdtTIHetnQoudftJHWeaiGlw7cIKZtLQ1?=
 =?us-ascii?Q?Eey/W+ttvRs5WDqzM9IyDWI6pG7q9IvH9rFtRJbZdz3fwRLuTCbFg8K7C0As?=
 =?us-ascii?Q?FnjeCYilq0Gg3N7xG28/fD2+Q9BNJRR8Z9YThVyxU6lZ6Qh1GwDqC9hIq7Xn?=
 =?us-ascii?Q?JasjL4h2l9YCdsdVdIgDJkFKHKm+APqSkoVN++DjJJ/daGmmJqTyNjk57Rpu?=
 =?us-ascii?Q?fgd1TwR22gSF2oYSsrerI/frhouWm2zWlXH9n0V1iW6L73r52zazHbFcx0EH?=
 =?us-ascii?Q?NorSbrR/peDuzOvKq+PEU5mWZlHa5osL1X6/ywVl8UiX16hSfDsaAKyLQlEk?=
 =?us-ascii?Q?OWStjIrfG6DLiovIdT/fFvyOp6UUx5et4XdPXMptBXqJscPjmKS5GI6x2ATs?=
 =?us-ascii?Q?JLOy32lkjYeaoSEWpS7zDBakPPTvPswV2Z4oxayyDVDRBahmqxV+wsmxeJyv?=
 =?us-ascii?Q?c/vArJ3CJulR9eI6gXwHh2vSTAFT7NGOLla8VqlKuZCO4SUEuilOpAyPkHR0?=
 =?us-ascii?Q?bdimV98aIzNaq1aq6CGb0dHrSqPBkbgGNGtp+YxG3huAN9WIavv9590eomBz?=
 =?us-ascii?Q?hadxqdU7M5giDyvNkN5TJmj2Oa7/JjUV9EXnT4WDcMRbTWVDG7zVfCcd0dbp?=
 =?us-ascii?Q?EwUzsv45kgdPFATiaYf6BURJlhyjLvgn9TbcOHD5cNPCR6oVWP7Y7fz/heBw?=
 =?us-ascii?Q?MNVrYxmPZe39zWRx5OAywMyRx883pij/z+DIkBD/I93ETJR2WgFHXsEGGzu7?=
 =?us-ascii?Q?oxwz54+0Q5dHAw3M3eqh3m3+0r+ZQt8JLFGkjt0t6GxbCC2g7zMWkXa/+k/D?=
 =?us-ascii?Q?AtUo7mgVvfEzkqG4SI6tRjI/38CxeYeM8BWTdQRupxj7j7w43ecpnwK/3wgl?=
 =?us-ascii?Q?wer9CARKKZUOysMMcb3blEMOTmJRV8kkKB934E52bIHgo4zGcNAHyXcK46/r?=
 =?us-ascii?Q?IXWL8QDhVzsPE2CAzQHSJrrTFQCYNZT/39lCQAg+/dnVJ/w5tmmB1AMxwt0q?=
 =?us-ascii?Q?ZaHJfJKOW/3T9m6MvlBjXRDPPO7onGNQO4unv+8rURiP/5lL0/xW2yRLODNt?=
 =?us-ascii?Q?RExnmOkP3h8N/V3K4PVyz4nZ0RjBg4JH/ID1RysoiPqVGVKGuCTKTG4slnUK?=
 =?us-ascii?Q?XvgoFL3OGXnJ7tJexRHFFmR83L8p26fKfWlJkFKkYgC25ji7o+pmnlKlqMdb?=
 =?us-ascii?Q?EcCEPxwPcOAQ8R1WAhnQPZ2X3AUiKdPHrf3knmQG5edV1jbE/uI3OskNMsMl?=
 =?us-ascii?Q?H/4RFFnpT8kQvg40NwLoZ6LWNRdlOpZIFm9qhXFDUEsN3qY+/QOizPEGSkMT?=
 =?us-ascii?Q?0BMNtHr2nSufauf03ZaXVb0Zf8ae2BBesvrpYtsH+ZyFmf5l85jEPVFCpvk2?=
 =?us-ascii?Q?MfDzHWg+Rczl8ik4EsnPRvRhnh0HhMv8QzIoSHtPbWC8SclFq6uDd/E1M4Y5?=
 =?us-ascii?Q?moLq/JJ6etAFe08i40V0ilmyBndVIMABpU5Q21HqxomPP865tyhESOOzimLQ?=
 =?us-ascii?Q?YeNNUBN9PIXgQJoJsBaNUVFYA4zDW88=3D?=
X-Exchange-RoutingPolicyChecked:
	FTlyeVanXTB2Z92Zoydmi3a18fz3OZO4FeRAix8q+UIegFsYkWKztJiQBzfNb9HGkxOQgDaK0Qul8KyVW6YXWVKEeuww6r3k5y/YZtuma4+e3x73GJrGTbh9rIqzbqH7d0bDf/YB67+Pj+ww4/byOdY0IaP319kX5SN4MdEtniudcDE94CjrUpfbgscOZfDithWxW808Y0N2cOdgpT2mx+cyd1atvUUOoW7U1ljDdvge2yp1VSkgteB1mczOLB74Uos87ZhyiK9Xz3G3uLOAFYnFclEF3P50NdZptHqMCKGAlkAwu4Fa754n3Qv2ejuwPPB+g447jGCJndLLxM1BUQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e6d1dd-0a8b-4b26-3791-08dea60c42d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:27:52.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSFVcxea/7X0Nl7EBwBN2dLyBYjregdhyuiS5beCKiKTEJ5W76d+oSjbEIfvilJlp79jM/2RVGSS4ruXPDo2LjBrU8nZ1hoqHMdQmMEnABA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8023
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=69f2318d cx=c_pps
 a=oJa8ZcSO0M6ZbQlUw3N+2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8
 a=hHS1K96sCZnleqtEHnwA:9
X-Proofpoint-GUID: Az4uJeVKuzDBAp9kjFJXaoIJGCTQpcfp
X-Proofpoint-ORIG-GUID: Az4uJeVKuzDBAp9kjFJXaoIJGCTQpcfp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2NiBTYWx0ZWRfX5NvOwDnFt/lc
 gMRjYSePXXYG1cfZvvCIGAc7EVpsqM5jKF4Rv5IaOE+mra6bXRc2SnBcCN1SxqCpGR1GcHYW+XG
 GA5drqybRj2+W+5CggHLXcOk9WHg3tFcRiFnFkWh16CLJ1S6YJWzaZuQkPthniaAHPfzLn2gvkv
 JPaHCMOaFu3L9SEuTVp25ngo6kcxVxYFsKV5nhVTUUNEWcbZPa+mT++RSTaenDnJUh2ZKKaf5LW
 XPuXRkqHrf80AYBoFasUEpjqi81hVSQgfVv5zCQ93MotZlSjl+hiVuXSBqs3HvNnBbE1SNp0vnN
 h/CrkLEYZ0ZXMhvTo1f4SPlyYvYAxTpCa0+763aFPf7ytXcrfASIYUnL28gjWb1eGXMJTJW22eO
 Qn98w2ljRgjfYHxWNzLI1oSac0olcEN2J1apwk6qu5SR0YOpcygCu64Ws7REFTPzjTPSknN4RPJ
 6hcMRuQUx5suk9tR4LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290166

Hi all,

I'm evaluating core-to-core CAS latency on an AMD EPYC 8534P (Siena,
Zen 4c, 64 physical cores, 4 CCDs, single socket) for RT workload
planning and I'm observing sporadic latency spikes of 3-6us on
cross-CCD core pairs, while the baseline cross-CCD latency is
~250-280ns.

I'd like to understand whether this is expected Infinity Fabric behavior
under coherency contention, or if there's something on the software side
that could be contributing.

Hardware
========

  CPU:          AMD EPYC 8534P (Zen 4c, Siena)
  Cores:        64C/128T, single socket, SP6
  Topology:     4 CCDs, each with 2 CCXs of 8 cores
  L3 cache:     16 MB per CCX (128 MB total)
                shared_cpu_list per L3: 8 cores + 8 HT siblings
                (e.g., cpu0 L3 shared with cores 0-7,64-71)
  NUMA nodes:   4 (one per CCD)
    node0: cores 0-15, HT 64-79
    node1: cores 16-31, HT 80-95
    node2: cores 32-47, HT 96-111
    node3: cores 48-63, HT 112-127

Kernel
======

  Version:      6.12.57-1.stx.136 (PREEMPT_RT)
  cpuidle:      driver=none (idle uses mwait, C1 only)
  cpufreq:      acpi-cpufreq, performance governor, boost enabled (~3.1GHz)
  SMI count:    0 on all cores (verified via turbostat)
  cmdline:      nohz_full=1-63,65-127 rcu_nocbs=1-63,65-127
                kthread_cpus=0,64 irqaffinity=1-63,65-127
                iommu=pt nopti nospectre_v2 nospectre_v1

Test tool
=========

  core-to-core-latency (CAS on single shared cache line)
  https://github.com/nviennot/core-to-core-latency
  1000 iterations per sample, 300 samples

Results (all 128 threads active, taskset -c 0-127)
===================================================

  Intra-CCX (same 8-core cluster):   ~62-100ns
  Cross-CCX (same CCD, 16 cores):    ~230-270ns
  Cross-CCD (typical):               ~250-300ns
  Cross-CCD (sporadic spikes):       3000-6600ns

  Min latency: 19.4ns (HT sibling pair)
  Max latency: 3056ns (cross-CCD, cores 122,64)
  Mean: 254.8ns

Results (single CCD only, taskset -c 16-31)
============================================

  Intra-CCX:    ~62-96ns
  Cross-CCX:    ~230-262ns
  Max:          262ns
  No spikes above 270ns

For comparison, Intel Xeon 6338N (Ice Lake SP, 32 cores, mesh
interconnect) on the same test shows 51-147ns with no spikes above
150ns across three consecutive runs.

Key observations
================

  - Spikes only appear when all 4 CCDs are active simultaneously
  - Both cores in a measured pair are actively spinning (CAS loop),
    so this is not a wakeup-from-idle issue
  - cpuidle driver is "none", idle uses mwait (C1 equivalent)
  - No SMIs detected
  - Restricting to a single CCD eliminates all spikes

Questions
=========

1. Are multi-us latency spikes on cross-CCD atomic operations a known
   characteristic of Infinity Fabric under heavy coherency traffic
   from all CCDs simultaneously?

2. For RT workloads requiring cross-CCD communication, is there any
   kernel-side mitigation (scheduler hints, IF QoS, bandwidth
   partitioning via MBA/L3 CAT) beyond pinning to a single CCD?

3. Could this be related to snoop filter capacity on the IO die
   (given the 16MB L3 per CCX), or is IF arbitration the more likely
   bottleneck?

Not reporting a bug - looking for confirmation that this is expected
hardware behavior and any guidance for multi-CCD RT deployments on
EPYC Siena.

Thanks,
Ionut Nechita
