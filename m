Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF42F7AAB;
	Mon,  6 Apr 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775463969; cv=fail; b=LYtN7l4gvtyQewcyDQ1aLVJcoD+lytL0/o2G/cgGxZr6VpLxEy7ad8xNoAdgHfz2DqGSiFGLsxuFdT2aPr6pAitqcWOJAmSugg/BWI06GZmVU4qkcT8rG82IbJbsGszOB+odc4PDXAGbJgXtExZeuYoxO0J/47C81/eDq5uQhgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775463969; c=relaxed/simple;
	bh=0xEcg0XJBd3ElXhWz3JMcQW3Tgcd2S9caGIGj26WRSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXrGpZUhL4VEREsZc1bd/v3J7VwA80938COIZzaxlvlE0JPZwXnHtjauR7KiHkLhIOU/BAUXw+iRZnhDMng9m8VOzc2MngkmHdNNxSU7ufp2p43yE+lAQYpol/16bnxaKXrjWevb2Z1wSFIOwyDROo6A7aaseM+9FVvg8kIfzCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=a2zTRl1F; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="a2zTRl1F"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6367RlW01156615;
	Mon, 6 Apr 2026 01:25:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=CB9ZzCrxxXN66q42g8rT+JG9ucb2WzdSdez3vw8s8kk=; b=
	a2zTRl1FzkbRcwVckpxKWmzQn2/Vp84ZmKpF5J1DtU3wEZuaI0FNs/7q0e1RzHV6
	cdXH5ZQpbn9rM/pBxpxd7XVrvplxMkTevVt9ML7mdMQhfKZ41gtT2CNNxCZJd2oa
	RXSHdtolPXWKA2M455swE8jFF1IY81MqcBCH4m7es64h17GiPfCXkvPA2Q11lUGu
	Cbg/ZXThek33AHQk1WiyEk23uopEmUJqiuvzGwiQMemxfzJdkC5/UHqx5lI2VUb1
	ptQzpizPYyZ3I5PqcK82SE3EisJ16JyRLq8i0MP+sVhmBXWYWHg6Ep8lvhbuJEIE
	uGvGTAtGeQZeDeB4gLJlRQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dawwx9ah1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 01:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHFHo+T57zge/tgp1ZF4A7AJXuP7QbXQYd/jkJs4j0jve0AqdJ3BmcMSw2HpkloJz377iw4uEsj2gIUpVMxT4fwwsgjVTz+RBgCDhJnRd9bfrFE+4bkmUfXTrGJa8HwsI+lxK5q71YnMNuwBIJBK54oBi6a7sizWwZ492WbqKhRKbT9rgK/3vpkT1tS7rEKb7RCzmwX4V4JDhIxrdKiDpeEIDmitbXVQ4gQkAt1c6N2TW/LAAkR5xgUy0jYR8PUu78c3GUvv6pf5P1vRVMeKoR4EMnNMmA5epqUk6XhpxDUbYaqKqsRuXEQqvZ4xBlyoC8/zi3JTLvC5pBfI84kIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB9ZzCrxxXN66q42g8rT+JG9ucb2WzdSdez3vw8s8kk=;
 b=JliP52sGdOkCipkCFB/Ne5uPI+b0gVtw/FxHcpYil36C1y1l9muz+2ENqixo+9yb5rbDzx9K2+v+p42YnfKN2he3N0IJtvpdP93+cVGK2DDHNcbX6VK8cBOA8o8xCt4/2AU9jLyCQWktHm3rWOHgvoAHhJtsYF3AB7sKU9wn1UiebDPwN7dluXylBXPG5bbtwlkIqWDSLDRiDnFDSEqk8BzEejevqxMdfdmLtyIansdl/MJ8REZAa3vr7Zs+RUKNfJ8iIC2w5l5TK2UHPmpIgZVW2IbsdZB5JFC1h+MazqRGq90ni9GNwXg96cyLD70Kpp9PGNu7zYpeTgN2otcDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH3PPFCE69B97EC.namprd11.prod.outlook.com (2603:10b6:518:1::d4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 08:25:22 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 08:25:21 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: vschneid@redhat.com
Cc: fweisbec@gmail.com, tglx@linutronix.de, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org, chris.friesen@windriver.com,
        viorel-catalin.rapiteanu@windriver.com, ionut_n2001@yahoo.com
Subject: Re: NO_HZ_FULL vs NO_HZ_IDLE: ~300ns cyclictest latency regression from context tracking overhead
Date: Mon,  6 Apr 2026 11:25:03 +0300
Message-ID: <20260406082503.84479-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xhsmhpl4pfe3k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <xhsmhpl4pfe3k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:803:14::23) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH3PPFCE69B97EC:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa420ae-b7f5-4c7f-3aa6-08de93b60b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZlCyjDMD69lfDWbDbQpJoqekRVKQZlQsCEIHp8g0vxf9GIQxbznZC/d7BanA4w2IKbligmIkoliOltnOpstOdrlrJAERy5NZz7gTobEEzZTxlvmkNSsVQnNTmzL1uT6c7sZ/+ZnL7CNRnywu0Ujid1UuakMvJ1qWQn3aBr5x/p13YgQOleL0wtauzUn+EEGEbHiSt6QShpQDJ1jInUcTqb6z+5j63j8TocLZ963ZjlpqavAqpqipMJCNbiKY+qz9/SD2efcxRfpcwn06QwctmA0KgQPlDCq3Srw8/vRYYXFnxL6m6dHpAq31y6JZtUgbVy8Afn9rpfqfN+2fzzEvtE82uvniOdhe8eYSgff3AyYNGOFeYT1O0i9MRKkjR6Er2Gk2r2YPXPoLDCOAhdq3HS9acoy1f5frAJwY9qfnESaerU/qKyFGzIWjXQRky14HAwTkTJo3/fJWuak1fUC7rvzu11omllB47uybboCn6h3CTNcXijU8U5Ak5cgXWsPHgdFDjiKttOKMu21sKR3bi6iiaqADhmg0YPSYN6H2DgYAyJiA/TzLxdcm3WfN220zu3+1NKT5gehdflUOx4qrobzC4a5CHP/f16+qMi3ZYz1QIQKK9DvOYgtKP6A3UGLhu2VMvWLnxQEeLhDHVFXf6N/6FEfuOG2bm9J6cX/AKz3sXmEzLnzlrPDmOAti5KO5jxhO4gl7zH14iEtQG8I1UCwkGV47Jc6BQU1wEyv2aFfD3JDKWQC15GE+IvpVBJgZYtK4Tm5qfdaFJxqAUUNqph5tROZiXkoatQLXSf/VWvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bF3y9msPlg/FEuPWICtslD0AFt7jKsAiZQxeUnS5zliUF102LimX5+czG91v?=
 =?us-ascii?Q?rDQxUym0o9jFQkd1lBG31wToLJFVN39xFCFZxVP3pMRWzRJQmRuLywAzbSWS?=
 =?us-ascii?Q?h73ntFTjeUpjW4TpW8qEJzzWBA2jbXQedoz6h20zmgjT22jfmTZ+dWjaW60M?=
 =?us-ascii?Q?8V+erJXNatjw+39XMSuXpEhFR15hzeLUDZ0CCabL1znJ6E1zOHACexORuJeG?=
 =?us-ascii?Q?ZUf/CGJVcy5qomsvLr0OKKA8qkM7Kel7dloxHCk5yHrm2wI4bQzI+2b0VzNZ?=
 =?us-ascii?Q?/wr7CHsu95vYZmfE6y/Ug3mTi10jMEy7Q4qaj+rBL/FpZznFgVLI+n90qNFv?=
 =?us-ascii?Q?46+76zH/L7md707LfWfAw8ul1UZWiuW135+ADneZF8QT2HQ9T9FZc5WfN71R?=
 =?us-ascii?Q?VX4o6oEaLnExcwR8CrY2H2rTFelS+7MAgxFUan7KWTGk/Q9J3RIHRR/YbEtS?=
 =?us-ascii?Q?Imls9aiBgE7V//31UpazyafbhL4b2hVHXq2ah/HmozyLu9G8okRkJBATdUJv?=
 =?us-ascii?Q?bJnvjidatGROgtdbpy8DjsRqu8qTLSdim+ifiq7P3CXAWjWARKNSjMyi/ZCU?=
 =?us-ascii?Q?NKPV953j9bCs0gI2Si1CQXnctzKGxCanryKkp3xXgg0inib0Zk13nFHbeWVO?=
 =?us-ascii?Q?XFsUY2bt68OPgQc4IgpQxWNOdrOEKjL+y+6d8p22UBfq0/cCxpJuk8n4S4Ci?=
 =?us-ascii?Q?qgBslynjF79jnsmcynURgntdB/7UWGKLJ08OWyECM6vX8wYt5E9c1HyMilIP?=
 =?us-ascii?Q?WkdrVfUWCljpjR3ec9720tZ0Lgz1rupnFV6Xw2A8usluP8Xf5GQvcbfsn0+3?=
 =?us-ascii?Q?OYarM+rmhv218ly1NteNz1S1XfPAM0DjagKzLGI1F/E8SCNEWWhHaDx1amCM?=
 =?us-ascii?Q?3YwJS96pPn6O8AvDuknYTcxzP/bBjQQynNbeKevFvQsMulGrnQFvpfYp7JvJ?=
 =?us-ascii?Q?JpKhwjjoYgygEcN2I0u53KsoCWc2k6WSzlm6ihiptLZqvBUK2MYCUQ8MIdI/?=
 =?us-ascii?Q?EJHfJNE8Xc2FZeanWZpCJntgP2W81r/58e/QoQ2C/JH8J1+uyEPUdVWmZcnb?=
 =?us-ascii?Q?T52jhHXGdWtm87D7YxfK6KPMO495oRVobkQ0H/9MPcdpVJJWgbrc8huHEidb?=
 =?us-ascii?Q?4MA51D8XuwQHkmJtBYljT6XLqXyEUM7OE0PQl8XAqf1Lot1vORte+H0hUm05?=
 =?us-ascii?Q?VEjjlbRGkd3WT1X838kk2i4YdtUid/DRQkiaOG2UTqoLEEJl7yyhMaYtHOYN?=
 =?us-ascii?Q?qfP34G4YyOiNj13cVPZw0BBw+JELElXnt1duCPlPgwVpDCjAeHKzTD4zmR6J?=
 =?us-ascii?Q?B/9yMc0lMDdeKqnj7zGHaLNdVA3HcU8r6uUdJzeXopwqmRomlU+JpOk+F4OS?=
 =?us-ascii?Q?t6Yym8hPBsTjwe5mB658VJ8FSie7OIz8eiOfoKKJAPdddHREtf0cx5zWLdsW?=
 =?us-ascii?Q?fxoTWK93pQA5lOHhEK+uXPP+kgvPLliYXEpFFSfhXANJUAqKUF8wHw0CLRog?=
 =?us-ascii?Q?fYOjBo0h8+Zqo6WdUAi/R+BImfh2cHT47cxBS+MUbpputFKbo0bb0s2M6xzg?=
 =?us-ascii?Q?KbFqrXSbscIqS729VBzI9oM2RRE+p7Ruk2sXg2yZENs7M2co62KPmn/oGt++?=
 =?us-ascii?Q?8zYJJggxxQ+M7sGPswccVNjdvgZeKF5FxP4xEI892TJ1eg1QbCbVRTPN38Pi?=
 =?us-ascii?Q?zI8BwGhvp7IYyM/wMkJ2vDH3lqdLrxxa+GxRW42kUm42EFtKUJktefx74YQY?=
 =?us-ascii?Q?cXkNguf/OjNezDHlqJLx+aomuh7f3kM=3D?=
X-Exchange-RoutingPolicyChecked:
	S1kSTslNCRvn3jou8lafRm8h0ag4BKbt8tFVVWn2jC4WC2mBff6LOWkQTOTD2jFHki1H0JUb8/0IENOzu92GBmyNQFTZs2LQZJjaBNu6a7Z2EUP4zdPiBW8OZ6I704V/TXh7a3Aq0pNK+K0s/VyO9n67DU2/bTBV8lnjd9NBl8XapqPHgPRWfrlLaIlH8WodTMhmLD5IHZHav0YbvzkXrw2jPt38zwHypRikCQvszW8pEMCDi64HgB25b3isKLLQmIqChAo9GVOgkJxrwDrdy3vyCutNDyE26c0X/qJuqDQDgKzkwGVz97hb3LrO0yPtfIe+8KohyBwvPYMkJyWlYw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa420ae-b7f5-4c7f-3aa6-08de93b60b2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 08:25:21.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsCMwjn4ENZk/u9aPpSR26XZLnagi3sVifHqO8MATwhTQowv7cXdltL2fV2EKZGxznNP5NXcxXWja/jUiV2gnFpePS1MDsn+ES+Tu02hOKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCE69B97EC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA4MCBTYWx0ZWRfXwQm9UeIoTODN
 wxZrNQuABsVdSq4uzZPCGK6WWXnXl9r9gnk2jzpJjzVQ9AkpwstKROR8EkYXzbgLiL8hgC7bC66
 gLS3YD0CDSvV4+AESRlRoKT1F33BTYTYmsr7yt9zXIHyJB1zU2ECrCyTZHVTjRiTBn0bfvLx3YG
 Oi+kNjLds26Qs0FU7um6+o5kkpNgHJ3kEnirdUu+2BatLyl8qVTGHMiwc/KUbw6QZ18qdK3PPQg
 ozPOitaxgksmXGdnGlbVsDVdP3G9j0abUwmR4D7oyTxe5fRRqIEpdIsqvg+4Vn/8+8wLuUMuH3f
 kaI3LD5+O48XHUu4z+Th96Ia7b3s0BvUlHVbawdA+CDm7b4tF5alyau9J9uUI+Egw1C34FBD32H
 fl0ExeL5/icRkl0mwL0Qpc1Gy4dkOrytQaXbjAAyLVmV29qKlZfsq+ptZ7xchfjydta0NKoUfd6
 iGB6O3+RnEpg4RzFesQ==
X-Proofpoint-ORIG-GUID: 2Dd5cO9-ZCVw4TH0MQk5HJP6GHp8zfA6
X-Proofpoint-GUID: 2Dd5cO9-ZCVw4TH0MQk5HJP6GHp8zfA6
X-Authority-Analysis: v=2.4 cv=AZm83nXG c=1 sm=1 tr=0 ts=69d36df4 cx=c_pps
 a=EZwmcie8zcfNvCQIxZ7BwQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=A0BZ6K4IPXlCKyujOdEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060080

On Fri, 27 Mar 2026 17:10:07 +0100, Valentin Schneider wrote:
> I can't answer for 2., but for 1. & 3.: NO_HZ_FULL is about squeezing
> as much as you can out of a CPU running a pure userspace application.
> Any kernel entry is an anomaly / interference, IOW "you lose". If you
> know your workload is going to periodically enter the kernel, put in on
> a CPU that isn't nohz_full (but maybe isolated).

Thanks Valentin, that makes sense.

For 1. and 3.: I'll test with isolated CPUs without nohz_full
(isolcpus=domain,managed_irq only) for workloads that do periodic
syscalls. This should give the isolation benefits without the context
tracking overhead.

For 2.: I've filed a related bug at bugzilla.kernel.org covering the
latency gap between 6.12-stable and 6.12-rt with PREEMPT_RT:
  https://bugzilla.kernel.org/show_bug.cgi?id=221316

Thanks,
Ionut
