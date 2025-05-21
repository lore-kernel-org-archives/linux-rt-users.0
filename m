Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CC20D509;
	Wed, 21 May 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816140; cv=fail; b=b8X/4UA+z73oH+XMvfgzmRsZapQY5yIQWJTh/biyjzKcf2GfpshJsnW9yABA8TA5CCcnwbfISuCUX1EQsGW0dG8+WrI4JU+IWE+34OrfJkBgQXgc2yAfJB9QjD4w5XiFLgIYPC4e7OQlTK+hpjDGHTSdssD5Rh/R79jEtSLlr2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816140; c=relaxed/simple;
	bh=WEsL6xKpxLhy6NQYPEuN0GpI3dwPrn+iWrTFzjmkgFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exZlJdHHyhs3wV3Phhh2ipwgPhdGbdphnwv2w3cszJz5mE5K5rCmS6wyMK13/swvIAVbzKqtHzK/zw1ytgvVU7F8qNeD/8fM9A9EpcuF2hrYoeP2AEfO2WS8gG8Yft9bRbPSkr1hLHfucXQQwYpbgFNj0y/3yW53RCWbw3qYKJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=c4Qxd+pl; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="c4Qxd+pl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch0/GIlla3tzwprMwF6OtDjpKfmLNGLVCjJ5kbOPsTMpYpKHRg/rOaoljAgLqhmxs2n+Efkdvn7euL1hlSLnXsq3zgD0Dsqes4s/qVnobW9iXpaevYOtseImL5UJDVxnvOC1GjQRph/SS9Lsbav61EdbI88Qq3Z9DpeR/JUfYFuJcJG9QnQH1I0BsCwbVRVgEWHBxExPSkqrOpr8gqO5J3m3//xqS01zI527VKlki68ewGr9XfuXBMBvHY60ahnDcJOFmMKpXtz90uiCEMrGKwr+60q/jukPWd2aNk/sW3pHnytrr91aTVphdsaOdmTgZjzZkzcFXZNks0aVxyiKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEsL6xKpxLhy6NQYPEuN0GpI3dwPrn+iWrTFzjmkgFM=;
 b=uU9LbKOAWMkEQbd84ieT+pClPRZVLqHkSWSyyaP/0JgE9A0742ZKdA5wke2XobJYcV3PuUOWR1bXMZPYLazsE5pyN5gPj/e88jWQA5DXzemCm1YF1DnHffg/lzYeIujBoRav+og7zw1h9fbujx2FYQCLE6N6SjajFgCsWzf4sjVSDgcFtLGetrjmGvsOZrESGSuRA5MRpftdIE5QV/fVKabmkR6AriXxEhNmeRMKMF2P105ivUapyNNEOnc77RiRk4iIlv/4egpiPkqhtdwkHwjkAfAGv/yfc4BYs/zo8fF4NS8Aseumva4XsLGyVPdZFGCY2CxjdkCvxG4s+xItTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEsL6xKpxLhy6NQYPEuN0GpI3dwPrn+iWrTFzjmkgFM=;
 b=c4Qxd+pl+OtPs5/kVjxbdwNhIxQRdcZ2ueD66SKSXsQvtCHPoVhSM43wvePlbvAEKifAt/aut2LhMIuRyt9b4Z+4jIUptvesvgjsmSJLL8eEP8gNRHWbi+FRIM+VdAg8+NOqgr3uLaAeG3ecQ0C+YJRorWUfSwQqGxQHGBZJNAQxtu9uP+gTgM54kM5MboN4tfFEK0X1cH+1LjFWOri26ikCqRH2zJwuOPNYzGSM6p0ROnJADGvrXtZfEkR3xnqO4NS4SUd63A6Zu8xUr9kWNS8RkAFqskapB8UJ6fXNWeN9jWRifvPxc1Iu7pS9R7WK8XpAlQl2uOvhO05wdkg1WA==
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com (2603:10a6:20b:370::8)
 by AS8PR07MB7238.eurprd07.prod.outlook.com (2603:10a6:20b:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 08:28:56 +0000
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c]) by AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 08:28:56 +0000
From: "Ismo 1. Puustinen (Nokia)" <ismo.1.puustinen@nokia.com>
To: Steven Rostedt <rostedt@goodmis.org>, fengtian guo
	<fengtian_guo@hotmail.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux RT
 Development <linux-rt-devel@lists.linux.dev>, linux-rt-users
	<linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH RT] Possible spinlock deadlock in kernel/sched/rt.c under
 high load
Thread-Topic: [PATCH RT] Possible spinlock deadlock in kernel/sched/rt.c under
 high load
Thread-Index: AQHbycDKZNJTtiMQ30KL6LVgnOOhNrPcv/wg
Date: Wed, 21 May 2025 08:28:55 +0000
Message-ID:
 <AS8PR07MB8117E00A3016725F7D70FE5E859EA@AS8PR07MB8117.eurprd07.prod.outlook.com>
References:
 <OSAPR01MB4675AD3FE11ED9C21055DE5AF59FA@OSAPR01MB4675.jpnprd01.prod.outlook.com>
 <20250520155324.3968b7d4@gandalf.local.home>
In-Reply-To: <20250520155324.3968b7d4@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB8117:EE_|AS8PR07MB7238:EE_
x-ms-office365-filtering-correlation-id: ad82235a-e7b5-454e-1e48-08dd984186e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUJDckVvRTdHRk9FaUpTOWw4WDM5clVBTVRDWS9mQTJ6UFVNRnFLN3dscnJq?=
 =?utf-8?B?TzJKYVhzdVo5NUVMVmNVN0lPTFFQVFBIV3E4SnVZYVIzOGpId1RDa2lnUkFC?=
 =?utf-8?B?ZGtsR3VHN3JmcHVxVkxLZHJOY1dTUGJmbUdRU2RmeW1YMkNnZWRMTm80azkx?=
 =?utf-8?B?TjJOMG9SRkhYS2M0N3QxdjVFY3Y1YWhTVlB1ejhaUUZBZlQ2eUkreXBhRk9Q?=
 =?utf-8?B?eFdmcUtiM0FUNGROQVl3aC9JK1EycmlBY3pOdnVsTXE4RGsvSEdaRGZXODVS?=
 =?utf-8?B?NlZzN1ZYc0dBeDBaTk5BUWdCZGhYajdqSUlNbHpCNGgrNExFbmdMenVDOGJj?=
 =?utf-8?B?WGxEVkVRZDM4cXZDLzMyeU9VZFNTUzZMbnZEZC9TSTNCcDdQeDhTdWk2SnI5?=
 =?utf-8?B?aHRpeTRHQ2Y1NTVGcHIyU1BtbXZpZ0dUT2NwVE5Qb0kzZ0dJTFp6alI1eHZM?=
 =?utf-8?B?U2pqU2kxak4xdTlKZ2loUHNuakExNXV0d2t1M2g0UmxpcjZna1ZCdlFkT3R4?=
 =?utf-8?B?eDIyY0M4akhGS3NhV0ppL0RnbmdoK082VlJ2Nml4NzZsellBOFl5WjRVWEhG?=
 =?utf-8?B?NmNKNE0wWjIweDRxMDR4bGYrY0dBcEkwVXJlZ0g4N0ZUSC9ROVNrRk1Gajd2?=
 =?utf-8?B?Vkp6WVlsZmhsYURFVWh2bFVMcnpOMXVoeFVlSjFhM1JQNG9ZM0UwRjl1d25X?=
 =?utf-8?B?MHNqOHdhaitMbTlCKzFUNjVvbXJZR2JDNmc4ZFpoWUZDdzZIRFMzU2M4NnpU?=
 =?utf-8?B?eDVDNGR0NVhIaEl6amZSQ2EydFpvSVlmcTlpMzZhb0RyS3c2YUhONHlGSXF5?=
 =?utf-8?B?enVFcmRmandqRGFnenJ5NDVjQlMxajlKejh6WUozTUNOTXN0QnRSRWI3WGx6?=
 =?utf-8?B?eEtqaUpweFI1dGRFa2NQRFlSMXVtWHVEU2lKV0hIdTlQNVdZaVY5dkhLMElF?=
 =?utf-8?B?bXlTcVkyMVJOZytqa3o0OW04TjFXeFdJVVNkK2hTMG9sYW1IWjBIQUNnNTZJ?=
 =?utf-8?B?K0JBY0J2YWZlQ2h2K05ZeFJScldYUmVTa3BQSk1wajlScjI3azdoSUhCVmhz?=
 =?utf-8?B?SkQ0N2pyeFNwTjZaYW54OUxIS205bG5VYUR2aWd1NHpaeUZxWS9EWEdjcDV2?=
 =?utf-8?B?NHY1ODIzMXo2enlUTmh4SlJsczNjVDV0dFpjMlV0T2FqaDhQQ05rck1jeDBG?=
 =?utf-8?B?bEFKNGxWbWZhRnZlalZZTlQwZXJPSlhwM2VQT21XcHc1R1F4V0tmYTNKdk1Z?=
 =?utf-8?B?Q0FiNTc3TDY0dHBKaW9xTnJLd1JXYitQdVFWY3ZqN2g0WERHNXhNQlZjc1J2?=
 =?utf-8?B?dy9BQnQxcUVvT081MmFmSkJ6RXhobTdJd3NDLy84a2FqZGx4djViTmVXSFQy?=
 =?utf-8?B?MHpIaG82Z2xYV3RScGgzNlg4WTYrN1R4NFdNbkhCOFVCOWVmWFcxYXNHY2k0?=
 =?utf-8?B?a1BTWnoyd1Bhd0tSck1jQnlIczZWbmt2bzhSc2dMcml0MEFTaWxYM1d6aVBS?=
 =?utf-8?B?RXI1TTlKUlJOR0JZSkd6NmVub1R3ZG80a2FEUFNMSDYvcUVMRnI4aXlXZGxw?=
 =?utf-8?B?cFh4UGNhSDVaYTR1U243QldQT0JPdk1NcEdneVVGb2J6TWpwWWJtNVFMSDBa?=
 =?utf-8?B?NXRSSWNRL0hEbzBsa05DTFNUNWhZQk5CdVVVbHhDODdkUFY0RVh4SFIzcmxP?=
 =?utf-8?B?R3BzZHZDWVRKT3pKd1VoY1krZkx4VmRzWHhyREswUFpTUktTLzY0MnJ5cUdz?=
 =?utf-8?B?N2c2WjhCQ0pkUVNpS2thdVdmOXNVdUZEdTh3eXhuQjkxMnRDcjVkNllhUncx?=
 =?utf-8?B?L0txUThOSE1vbEhmeVpBb3VwNWxZdFhmNThRTmEvTUxoZTQ2cHNBTERjTnQw?=
 =?utf-8?B?d0hSQjNUOUFjRDA5eW4zVURmUEpQd2Jtb3dTcjJyUFdSQzg1bGR1WFJETUd5?=
 =?utf-8?Q?wwHr/NEBQGM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8117.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTdqd1MzS0V6WlVzMHRRSXVPUXFmV1ZuNWJMUjB2bSsrQ0ttbFV6aEs0eWZ0?=
 =?utf-8?B?TC9aTDVieDlVU3o4WkpxbGtYdzlCQU1QSXFmeXl1SXBZdGliYzdma0Q5NnBP?=
 =?utf-8?B?N0dLeDQ4RUc5Wjl1TVBqQ1hxYTBQRUdvTFFzd0txVEVpQXI2THErbkhVL0dO?=
 =?utf-8?B?WFIzUVB2TEZTcG5sU3BFYjhxNWlDYVZNeXcwUG4yRjdkUHl1Njd6L09LLzVG?=
 =?utf-8?B?eTN4YWczY3NiV3hNYklKdEZWL0ZBYUk0cEFmOEgvbHE5WVp1Z1p3MklVTzly?=
 =?utf-8?B?QndueTJHRFU5cnZUZnd4bkJ0T2dwUWVCeDVJdC9yeEFVSlc3TlJ1ZzV0WnFG?=
 =?utf-8?B?Q1dxQm1Xa3hYMHptdytRN0dXanJReW9DR241UkIyTTE2OE9iMXZvWkJNMlAy?=
 =?utf-8?B?TSszRkJ1TkRGWEl1WFFpNW8xNTFqVTdQWUZ4dkI5Qm15RmI0a2pQWkk0SXMy?=
 =?utf-8?B?OFNJNFBMMTl3ZklUakxTaExyb0NIbkpiQU84NXNVblBNczdtV3lMa1Y0VHdt?=
 =?utf-8?B?bDNJRWY2aU5ZYzMxOWVHMnVUR0NWRGZvdWRRT0QxM2pBNFRwM0FJZjFXNWtv?=
 =?utf-8?B?RWNDTG10V2VubGUrTEZtQVRMcGVxc09JL2dJNWtGY0U0anBQVGg2VklXeUZJ?=
 =?utf-8?B?V05tU0dIOHp0ZFBUcmZxZnI4bHdrbDU1ZDVES2thQlhBYnhmKzNITWJSSDhY?=
 =?utf-8?B?VmZYdk95cUM2RVlrVWJ4SkE3OFByRjhIalNtL1NKc0ZqNmQvcHd3VkdTZHRD?=
 =?utf-8?B?enZvWmJ0Ti9jelBQa3ZjSERPc1hDK2JQeFF1SVhwMkVHOTltQXJLczB3V1JX?=
 =?utf-8?B?WXl5QVlBTEVRZjNGaHFkai9nMnpWWVphdXpEd3FKd2hrVnZpeGRRRjBieDlr?=
 =?utf-8?B?cUgwU3FIZ25ZaVdTUCtzdk9zazB6V1hzbHhhMkF5OVJxNmdxc3NuYkk1NCtw?=
 =?utf-8?B?bVpBeHQ5Ni9MRlVvdUY4NklFK1NxUUxBcVNlTFVBNzBIY0FpOG11cm4xRlFa?=
 =?utf-8?B?WnBrK1c3NDloemEwSm1KTEE5a0xlR1A5cFJ1K2RWbVJpUjdtS2pWNGk3ZnF5?=
 =?utf-8?B?cDNxUjZ4cjNyMWduaVFtZmY1S2RWVDdRMXpVTGhuUDZhSURNNVArdXRvbGFs?=
 =?utf-8?B?MFFBc1RBWmg5SFNscVRidHZjemhSMzlEV2g5OERmWCt0SlpLSkJMZkhlV3h0?=
 =?utf-8?B?dDRqOXNCWG9YWGUxQkpSWDRRbEdRWDZHcS91cnQ0SG1xWUx4TEVaT0hNcita?=
 =?utf-8?B?Mms0ekZnejRsTmgzR0NUQXFVazgrb2FiL21xck1ScUI3VFgxR0FPdjl3dnVn?=
 =?utf-8?B?TE9MUER1YnBDUnZUR3hHZStmeTltemEvbVlwYWNVR2dVamJvdFo4Z1dWenhr?=
 =?utf-8?B?RGwyZUtRZUtRNVdDSXRzWmh0L2NkMzc2ZzczUUNpTlF4cTltUmREdjNydGdT?=
 =?utf-8?B?bWttcXdRams2bElVb3RRK2RGL3J5Z1J0OWIwdWZWcnY0KzhRT2dRY3JlUHpJ?=
 =?utf-8?B?QU9Vc0JKQXEzSmpraVc3eFM4ZHVJNEFiWTdEQnRoSGRQaXJxWDBjeHJ4a1Uv?=
 =?utf-8?B?dzJuOTIwazVMTkJRcDZpWjZEakJLUXhmMXpRS3ZHbFFEUURkM3dHaUF0cndt?=
 =?utf-8?B?Q1J6dm1LOWdNVkIyeVFiVVgyakx1andsM01leFJacUJxMWQrSVh4YVR0eitw?=
 =?utf-8?B?dDFWcU1HQW1GODVEeXd4MUYxd1d1bFgvUWh4WHVMTFo0U2ZjYjEzL1hxMzh4?=
 =?utf-8?B?bjNjaUFjR29Mb0l5dmFkSnFFdE96T2lrVmkwVVVrRHNCYnYrSmVPdDhHajFD?=
 =?utf-8?B?aEVJc3IzbHBMVnZRZFY0RFpCb053d1puN2RqZnc0dm1LdytiOTdZNkpJK1c1?=
 =?utf-8?B?T3ZaUXZ6OEZTcmtoOHZ1RFpZTVpmdEhpZmVUNytQa0NUZHA0QmRoUTArZ1pj?=
 =?utf-8?B?SHk0a3NoWGFjbXB3aFBva0hnS0RmSUwxaGRwY1NlM1I1MWdEY2JyTDVYM1Vy?=
 =?utf-8?B?WmN1cmJBRlF5SGhnZ3ZPRUhKMWMrbTNNYTZheU1ZdDkrbTVCZVB0ekVaM2pi?=
 =?utf-8?B?TUxPdWJtZUFVK1BpZW1HV25JZ05pb1RUOWlvZ3N2dGYwU3RlTzZkQThneGxj?=
 =?utf-8?B?a0h6MzRsZUp1bGRMY1hsWnMxMmR6SGlZbSt5NWlMNVo3aWIvR0pLSVdBUkJH?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB8117.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad82235a-e7b5-454e-1e48-08dd984186e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 08:28:55.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfgRoXgAgM04n1Pd5QWeJRXxKYTwRuJtPA5b7AQUXcDYVtQ4yrgZAvmNibIbbP8cTxPYnkFMQlezoDM7I+H481vWBAC+0JQBkgqSZvb2lmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7238

PiBJIGVuY291bnRlcmVkIGEgaGFyZCBkZWFkbG9jayBpc3N1ZSBpbiB0aGUgUlQtcGF0Y2hlZCBr
ZXJuZWwgKHY1LjEwKSBvbiBhbiBBUk02NCBhcm02NCAzMmNvcmVzIHNlcnZlciwgdHJpZ2dlcmVk
IGJ5IGhpZ2gtbG9hZCBzdHJlc3MgdGVzdGluZyB3aXRoIFJUIHRocmVhZHMuDQoNCkNvdWxkIHlv
dSByZS1zZW5kIHRoZSBwYXRjaD8gVGhpcyBsb29rcyBzdXNwaWNpb3VzbHkgY2xvc2UgdG8gdGhl
IFJUIGNyYXNoIHRoYXQgSSdtIHNlZWluZyAoaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMTk5MTkpLiBJIGNhbiB0cnkgb3V0IHRoZSBmaXggdG8gc2VlIGlmIGl0
IHNvbHZlcyB0aGUgdGFzayBjb3JydXB0aW9uIHByb2JsZW0uDQoNCklzbW8NCg0K
