Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42837BE94;
	Thu, 26 Mar 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544298; cv=fail; b=G81iYqxpAbxAfrZyNNHP3ESbp5QZl1IwDt2Asw48JfW0AlKX/J1m7T5gH7erT+8Lf+wPhLRyI4sHQjxzFvyV5R1iJpoeo0pK0PP5FZw2ywuaC+qH5m5Pzd7YF0Q8HnjGKU0EFDhllgSB7mv3Ph3s4IZSp0NAkIJMIzLn+KKzdtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544298; c=relaxed/simple;
	bh=6DRzPvshNGuYrcpzoiIwaB/qGTe+hu2yjY+7hDlQfUc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mnqfDZUcnVf6YZvPTDh6Uc6FDklFCqVFvR1OJnLjw6db5qOKl1rLf75/wlj/OODeHyWSZSDhHuiXym8LEUbUQIatT+n+yuZoffWdUQ8l6PZ8LJtvSRoWRUTCEEWwAdsf+fWh0wh9UvLcsIxlVyqwb2SjMUr/ZjfW/ME412T391M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=M9R2NSK7; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="M9R2NSK7"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFh6qG3112880;
	Thu, 26 Mar 2026 16:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Y9XZ7wNl6
	Hsx2OHlixZENVQbX09uV7tuc4/8/aER5Ag=; b=M9R2NSK71VEHCSiOWci1Bbpji
	HmPCWTC+RqxtxGHBDFX57/3rZ40cKAlcmeR1/bCRHOebJTSTtnD/p3b/qJQkvL5d
	L5bB4+LebVtJlZ1oGcaMkAgtnj0uaTAc5QF7vE7LfKz/tXvQOa45UUZwoTHm+tqk
	1mnKLfvkAXD73tVJaok93kvgAiytJD+++GPIiWTqI0T57FPso6Pi42Sp9hVN6U/+
	Ja/zhLKGPhGPiF6lYSMSu25Qor+3lU4UGUEPaRjg0t+Ymq/1vDg/oZCVrUvcTfjU
	/Sgb3uDltA8V/vyjO1b5QrJsHyxY/xIIxjVeY5i4eDEKycXYtdPVC3p777b2Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj86w7t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:57:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmMIIvElIOBEc8eM67/1WWwG7HNfpdyYAnHbToF85+1sh49C2syLkI/+33PlFXSc3+w4ZmULm2tzMYqcI3dxTWQSKTV+IwQt9O/fWe9eIZVzMZni/+To3Dov/Fp35jCYm04NeWOBfCI7zBrGW5Irjuu1GpMIUHO4RU8x+jAUpG91AzF/Qo2qEDFdhZTaAtBdquOVJqPFF4PLDvCZYJhmrFnKl8/kjDIUOeBCKFkHG0SGq33Pt3TCy/atvufOrXaMgjfShYpedmp9nwYL35tnh2FrmGmMkOEgDXA7fvPFy+OF7liK73pm/SplL7yZ4e2AFqxzYZlwjEfw1QpBuomAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9XZ7wNl6Hsx2OHlixZENVQbX09uV7tuc4/8/aER5Ag=;
 b=QV2stYzXFBQAg9Od1RAH6UZlOqSpTKlfBfgpyNhjMoh/gL55F2Fjr61hNZClXOgqVY89lHG84+Mrc7CkgLEUXvM+V7F4p5lp//m7AtKXpSKQplhLM0tXD5dJRjsKoEwYjps2g3VK3kCUJ6Ns4Ee3KXrqb6WSuDz+nPH8r8x1ciTvktLcMtRrP8obcEHHH5pPTjdiGBREtObB9gAZJuEoagjLZrQ9uMebqt+fcAy9QebS1Uoaxya2/A/xleW/y1ZbbJxRt742XXagyNPw7SWCLzejGjBct0jT0wWNlh2i2HAJ8ZIZWR7zV8cqsa+NZnkHXuaAeTxfeZGQvfu2/Oubkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB8540.namprd11.prod.outlook.com (2603:10b6:a03:574::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 16:57:47 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 16:57:47 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: fweisbec@gmail.com, tglx@linutronix.de
Cc: anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, frederic@kernel.org, vschneid@redhat.com,
        chris.friesen@windriver.com, viorel-catalin.rapiteanu@windriver.com,
        ionut_n2001@yahoo.com
Subject: NO_HZ_FULL vs NO_HZ_IDLE: ~300ns cyclictest latency regression from context tracking overhead
Date: Thu, 26 Mar 2026 18:57:25 +0200
Message-ID: <20260326165725.451127-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ2PR11MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb9e841-e574-405b-d192-08de8b58cdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UPEM6M08AczEG9uqcYTXYxzLi6+PhrPxG4BN5LwOjasUeYAQKQOI06pNotv8sjLKEHY/z2aJyzOD7MKHRLzgA23whj+DsLxzx43Q+A7erv7QyjKBIASQ6pmVaxUcSviERE5QPgOI4/nQ098QK8Sh3eRr+tO2bY/aSUYseNAC0FNr60hvrECiSZJeuTK3C7FFqMgRy/iLBNulhShGccW3PHxwm491Aj8ibdTZGp/DR8Ou9wWABMtYRyPs/MXrXitD+vabbYGjNi2q0rrc7wWmONwpqXHOPn5miAfZZD/4Sbj7K14jtBb5HwRqSwqAl2Vien2s95sYzHfYwbz/jsjvQRYcwx5i+X4QzKoEPy035IZZS9qXro3Kj0GUFRJaXYnqwqxw43Pwek5t4jMjpYNKZDiemV95/rkQjDBvuQQVyPRVrvC4auUTTvHB8dw02oXRgLaRHyIEtPhw/Ul82tXORh/JFR01cEsR+rmzsuyX/FSPw2si5EEbMxemXM8SEF7CDB505Lzit/fG4kPoUJeIL4l5zYX5505n9jWxuc97bjZpNbldpQ9cpqtADt1Ao9lPnHOxSCqnAyPqAsTSRxDVzQ9VJCIzM6h8j2rjkePiRKdnwk63FAcBxSNDBLKRUoRWnOUBHnHclQnOw92TeUDr514Kz6J0CZLa2xx/dMT9DUC3zgbcxoMT/kOuzP+hEgSwMLwJ4I2ZIpYsdgLsL2T2ZQU/pHNFZ1RLalpDiOKN5vhr/mRDJ6dqjlbZ+mnRdcHbdy0XQAcThHEy4vfrO+0ZVe9fWogF4IaFOSW2gq3b76E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muC+u+A+i3uWPp++1KGC8luhNOxFC8fCsnWjukJTTWhObsRtRdf4nmg/Jlvr?=
 =?us-ascii?Q?BhbEYBM5Hpc44Wd2l3oDGSNIZmDi95MR+MJZwNBrY+IGboFOkagjxhlzAFRa?=
 =?us-ascii?Q?yU6/Y9kSsHtNU+5svg05oK7OvZjntf8Loo2umCB7gZ7SOM5xS7CqQYB8AVL1?=
 =?us-ascii?Q?riYGpU+XWihCBc0XW+mSTGOWeXf2Icwu/qyumREGu5swIV64+CH8kA+TG7dO?=
 =?us-ascii?Q?ye2yxcHa6iEUQgCtlteLh7sG5aEaNDjWgEHy54ZiLYRqWN++8lG1JJPnkj9x?=
 =?us-ascii?Q?b2VImnpAieXTKvVzGfYQ6Cb/yo9jkN6K1mTg2QQe87rlLtPyjlewug8EbWkU?=
 =?us-ascii?Q?3w2gANp1Plj4z2tDqNtQeoZCxskwxTg8qY0/CJKZKTRxG8YVPkxkpH3bq7VH?=
 =?us-ascii?Q?DtXyfNh+Dfrx4YPsyEyq7+1c4fPyJRtro17IpI+ZXtvKndbNsKlyMeT5mNcI?=
 =?us-ascii?Q?9hvqL6El7OI/4am3mTjBzJ5udK72Dzn0q6x8cHuIvf/KVrJ5xSOSsnci9CMR?=
 =?us-ascii?Q?i33JeoKSyDnrnf5Ok8FLi4hAcQ5Sjl4DfbuNyUVKkgDykQewbynkGCmWSIRS?=
 =?us-ascii?Q?HwzQDpJ7L4MwbinP4SAn4ZIRK0IDC2A02kuiSabhQh8IJDnl6prPcCzcYl6/?=
 =?us-ascii?Q?+ZUQZiVEcyt2HtraMn2wxbnqSIHZmzHIE4gtkJTpesgo9wDtSRpX2R0qx4vk?=
 =?us-ascii?Q?LNXKiCOvrOBNNT6ftGDlD08PgNuYo9rv1xe/lmDV+0MIt7oKJVZ0snedfEGk?=
 =?us-ascii?Q?XQj4LPfp6/GiKNtZVpgkr2P+tFdS5VQznLVkKAeVPNx3tXbK9cHlUmLoacvU?=
 =?us-ascii?Q?awnwo2xeLmuq5jQJpEnkHTH4Nz/MqkEpF1p7A/2bRj7weyTnE5DZACRRtRik?=
 =?us-ascii?Q?NWDHKqLvkwfaYuozBRmSlC2H1UqYO6t24ZQMWtXihkqCQEYGcEZqIc/E5AcZ?=
 =?us-ascii?Q?pJGrA7d2l7YDeC3aMfDC51KFJKg3Dim5pGd25xFSXnymzLPzjnIAkW8WnTQ6?=
 =?us-ascii?Q?NLiUyH8IAql0rz8X8f5RLU3H8A/GZKiPdqMbVLp/S3e8MWamejuNg4foGZSX?=
 =?us-ascii?Q?lsO8ihTQqvnWSBCm8EA/VL64099WoWZZbIo453i/r2qQWn9Zoh27DPqPWcNC?=
 =?us-ascii?Q?adXm++MJTr3ZRSeT4YmiGqwymsdU4CeVSPh8tCZR7fNWsiE6pbINVjWugWeC?=
 =?us-ascii?Q?4k793UEG7jODahaz/n772q5mU7qZgLElkicTNf4Jlfz340FZze3pq+jM4HzC?=
 =?us-ascii?Q?TVrubeilIK75oMtKZQMPdrb9I6nqH70gr4CU1s9sHKok4w4kzrA+1vX1NZdD?=
 =?us-ascii?Q?4qyTZTQBq8vxNebeExNX/USmRF4gWjAuvV2krwpsTsLUzRRQoSFWEfxsLXuC?=
 =?us-ascii?Q?idlM2fDguisKFDpPiMwuWA/LIgSeJQcwNGNOeSDdzh+pXkx4bgT19nLp3Daf?=
 =?us-ascii?Q?u6yh2SsFm4Hjs0VL7OizNqTE7/m9pS/VYYlqdRXgsFUHPL8Jfd8Lzu31xCiQ?=
 =?us-ascii?Q?pcxz9bSKdMkT90Wkuhg7lOUOI+biJQd88VC0PcqIm4f5ChfUPRyJuRdScdjI?=
 =?us-ascii?Q?36YQi8zs1oMAsxbkasdAZzjwu0sxcIiqB+4UjKqFgZCXakstFQ/yhBTrC2S7?=
 =?us-ascii?Q?PZ+OsSCo3p2L13tPs1WzA950S7RiJtDsVJt+85y2ibvKlffWFtDpOiejcOLJ?=
 =?us-ascii?Q?z06m4XT3vYcNQg7GQn7t5oqWUzhRu4Sia0gUMzmEule1JUr3hnh4RLkw6CLm?=
 =?us-ascii?Q?7k/K3KRR2S3GiCXDWdKHi0OGnqcBjnc=3D?=
X-Exchange-RoutingPolicyChecked:
	D2mSWji87hZGG0r3bJj6LSHT/6dDe0nr165A08Ew3stKTvW41eQ2yH6eFk458gSoih+MRfBc8fzpmrJit5nZww+0nNMIY5JBSLFJ/IbU2mEuIIK4n0OTMRpbll7rAMSWzYkZV5+uGofVoL/nrcl6/JsA81IYJmCR31nF8I4+AgDYiot9V9luuC8es9W8rj+xco8WiwXpwTH5tYKZM1+JgZrMidj0CaHLb5vIpYZlMFjU21Gu9vjzdC1/OMaCqavgWROusdZ+mlHH6sLwINt5fu4cLQIIPMadJhxPR4HiaBsNcrip2GpjAW/vdXcFep2tpZ1TqvGSSqt3iw7uHshoiQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb9e841-e574-405b-d192-08de8b58cdf2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:57:46.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meqTMOMNMpJVW+hYUjkI717933RBMLPHkqZKW51W1/GokKrjYVHyGW2+she3uxE213oeUaE52AMgtlGB7RPRGF2LGZEO520z6sazWm0iNDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8540
X-Proofpoint-ORIG-GUID: 3SlUtAjnHmo23b6lN1b6kdr0ZEW8IpZI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMCBTYWx0ZWRfX4llIzFRxnZWn
 mJv1q2FY0X/qa3vyeSfJ2wfYWOyEpzIkeerTlvEdD39UEMtUTc37TqPJyf4oyP75Kwxa2Px+Se3
 zKfYbguz2kc3gy3uMrAINDf/vT0V1Kl64ukYY+0SifHMxU2tZDxCxxgU1Vyx832ZZ+V3iDz/2AH
 XqIqvvTiRrGkMz0Q66A72r6lYBYtFa1k4OBY8yKs6JB8DrwFzgKQO4J7ToIIa0HIsGuKFuUd2BO
 BSVXmJBxGxTfIg41MCfdV/yIdCz9oam1QFaiRNFIhh6duytYu+d6E/cDK9XFBL8/Nwg/wyE3NtE
 RriYjokMOOR5HJftb9NZyRI6bbZ+NvNfVJf4bv6PxD1Y5P6ZOIUuSSTNWh/7b/E1mXlvCvmyFdH
 baR4xJH1Kg0QtalqaA2IbExrvb0Y+gFm9Y4+lmP+RZ9GHEN2Ka3JATOChUdcNSDKF1ugmeFuBPM
 v7XdFxrem7mQbo/V/FQ==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c5658f cx=c_pps
 a=3N2sgJzBBlSYHYMa9BBQhQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=p-FtzWOsfKGaIJninQsA:9
X-Proofpoint-GUID: 3SlUtAjnHmo23b6lN1b6kdr0ZEW8IpZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260120

Hi,

I'm seeing a consistent ~300ns average latency increase in cyclictest when
switching from CONFIG_NO_HZ_IDLE=y to CONFIG_NO_HZ_FULL=y on a PREEMPT_RT
kernel. I'd like to understand whether this is expected behavior or if there's
room for improvement in the context tracking overhead on x86.

Hardware:
  - Intel Xeon Gold 6338N @ 2.20GHz (Ice Lake SP)
  - 32 cores / 64 threads, single socket
  - L3 cache: 48 MiB

Kernel: 6.12.78-rt (PREEMPT_RT)

Boot parameters (identical for both tests except nohz_full/isolcpus):
  nohz_full=1-16,33-48 isolcpus=nohz,domain,managed_irq,1-16,33-48
  rcu_nocbs=1-31,33-63 kthread_cpus=0,32 irqaffinity=17-31,49-63
  intel_pstate=none nopti nospectre_v2 nospectre_v1 psi=0

Cyclictest command:
  cyclictest --priority 95 --nsecs --histofall 40000 --smi \
    --duration 7200 --affinity 1-15,33-47 --threads 30 --mainaffinity 0

Config difference:
  NO_HZ_IDLE build:
    CONFIG_NO_HZ_IDLE=y
    # CONFIG_NO_HZ_FULL is not set
    # CONFIG_TICK_CPU_ACCOUNTING is not set

  NO_HZ_FULL build:
    CONFIG_NO_HZ_FULL=y
    CONFIG_VIRT_CPU_ACCOUNTING=y
    CONFIG_VIRT_CPU_ACCOUNTING_GEN=y

Results summary (30 threads, 2-hour run, values in nanoseconds):

                    NO_HZ_IDLE          NO_HZ_FULL
  Min (range):      1697 - 1783         2026 - 2182
  Avg (range):      1876 - 2000         2131 - 2333
  Max (range):      2017 - 14491        6832 - 11539
  SMI:              0                   0

The average latency shifts from ~1930ns to ~2270ns, a consistent ~300-350ns
increase across all 30 threads. The minimum latency floor also rises by
roughly 400ns.

My understanding is that CONFIG_NO_HZ_FULL forces
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y on x86, which adds context tracking overhead
on every kernel entry/exit. Since cyclictest does a clock_nanosleep() syscall
every 1ms, this overhead is hit on every cycle.

Questions:
  1. Is ~300ns of additional overhead from context tracking considered
     acceptable/expected on Ice Lake with PREEMPT_RT?
  2. Has there been any work on reducing the context tracking cost on x86,
     or making VIRT_CPU_ACCOUNTING optional with NO_HZ_FULL?
  3. For RT workloads that do periodic syscalls (not pure userspace polling),
     is the recommendation to simply stay on NO_HZ_IDLE?

I can provide full histogram data or run additional tests if helpful.

Thanks,
Ionut
