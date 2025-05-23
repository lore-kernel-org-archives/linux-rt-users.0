Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2089.outbound.protection.outlook.com [40.107.103.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AA2253A9;
	Fri, 23 May 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016700; cv=fail; b=VLqkqmWytG2cEF2O5+sGM2GzOUNBbQz27GgjzstwEk0GE634z8PIqrI//zfB0KTwCuMcrUQso74FxyMOT1S8ArawLbYPz24lNYkpH7z6+E1GVmGnz00Xye7UnzwR/yzIBnowAmC//kKhz7FtnxDavSU5EVXF2DofJAhnuq5ByLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016700; c=relaxed/simple;
	bh=Fda9oKrqPny3yCBecmKDiuWcqH8cZ7YJepwbFNPw7e0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOieZ48JskpUjcqM33SnjQm5GDZdHXqMjJWmrPVJzaqZJ1K6FXSJ1EN+0+Bbpehv7pm3Fa6102p+Apkwcm3A2JErxLhZOwCHL8phdQDI8J6Z5EhwgihD/df68+kepU0LGN8j17C9HLvX7lCparGUdIxIxqXXuhvFDkZ9cJPZmMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ohya3vs1; arc=fail smtp.client-ip=40.107.103.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ohya3vs1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAE18sxhOa5R5Kf60JOerfhO+3RnCwEZcNKh439YiXJSfgvyrFCcLGzjOJ3uWSzgrnZfJ/GwsdpgtFhzVgzIlAa+96typMbiXKy3d6ONhLLVrWnmgxNSjsS10mQfOnRavRD5GDMniaL1z+upebllH1S73EFxTkjsfi6XlwomHKK8LfLNvhoj7P7LRAM1M+83xXxJWBT64usi3n02Ryi19bbiMiVFMooaBQpFzESMQbmMwRJcU1vnOtODxQGOYcqXUdd/wQRDboCfsTwQ4tvORYxFUGAh3KyUEJ6ZyJp0hMxPlMEtg2mfbER4atrwYygaMXkSQXXVIuKLC0OcpWXGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bqwr/fcs0Vz/8pdOBqZjUqrm3IMaDozE6IgWpepNHo=;
 b=UpnRILM/zSo+i0oQg7JEwCHv/b/VrjcItUG/2Qoj+xul0ZjAFfJyGYfHOuyJxP/5VVZkZwIy+x97EY2yBrNLYKLld58jXq6Pj7ubxF8aRvWuris0LU+eTzwpYbB9xUp75TM83Pkw6GrS6zgmaGseyEghLJarbmbYxJOrsKeR2GZMTmwzx6pEUX7qwpWDmI6AWwx+3QvJl3qPMCYZ6HbkaSrt9Q72aSm2Hfcxc3BF0DjJpPd0Onsuha+0Xc8QJGPr8At5femFafbivhWoL85vjbv+06mqRNtuRBQFzj6JRSCAlZ+7Fpns5d+FqLLTu90JWDcF0LYOonzQR192IL9i3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bqwr/fcs0Vz/8pdOBqZjUqrm3IMaDozE6IgWpepNHo=;
 b=ohya3vs14HtWkS0iU9UWPFmCdXgu3HGVjb36zu7PRXBRZ2MfnFJ5ccENRm5xCg7GKxHz+NuV1xlv7oItjoFRwNfWNLz2+7XtOYJ6hRS8mBau3y+h5pTijgdV8OjtbztGm541kNazcWuyMneSs3a/m4Qab0GLl3tqATbARvc9djl/TDvzmOkrTPHtiU8zxeYiBQcvvAPJTjLiU0REtpCs2vZY+ttP5NjL+EZj80AAyOM8wS9H/yaf1CdIHQSm580RvCHscWFe4OQGHX8ayPoQYCC+1bxIKHin0PmHmXRQVL8/8VrUQDCApvN+U+sEjfV4t7Y9tF/LgnN3gDgCpYzFTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Fri, 23 May
 2025 16:11:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 16:11:34 +0000
Message-ID: <575533cf-bb08-4071-af67-93432bfa71e4@siemens.com>
Date: Fri, 23 May 2025 18:11:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: locking: update libc support status of PI
 futexes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alison Chaiken <alison@she-devel.com>, triegel@redhat.com
Cc: corbet@lwn.net, gratian.crisan@ni.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
 achaiken@aurora.tech, Florian Bezdeka <florian.bezdeka@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <20241228181546.1315328-1-alison@she-devel.com>
 <20250107153121.wAL-TfKG@linutronix.de>
 <619bfa123308eeb3a548fae36a3f9e4c@she-devel.com>
 <20250523150028.62N5N42-@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250523150028.62N5N42-@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 00777bd0-7396-4b90-f778-08dd9a147ca1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MktReHFHUVFxbStpUmFCV0VMeEZXY3lOalhsSFJ1YnRLV0FOVy9uTWxic3pC?=
 =?utf-8?B?MkQ4SVVnSE11NkZVSk1SNWY3V2E1dkYxVUxGOEpaY0tEYVZxQ1dUdHNJMUZG?=
 =?utf-8?B?clVrK0RIV1pQYlpsWkJxcmZCb0E0alpadDZXbW5ZNElPUURHVEo3MjRiMWdI?=
 =?utf-8?B?dVE3NlcvVzBVQU9aV1c5UTRPeDUralh6MWN2SjR5SlpHdkgwY3I3RzZaMTVJ?=
 =?utf-8?B?RzZ1eVVoTW5rdjlWQzNTUU1lNlhyRXJqMzRNRjUyeHVYTENUVzB2K0MyKzhn?=
 =?utf-8?B?eW9FNWJxTlVRMnVtUzVRbWYrNnd3UTRFemU5OCtiSU9SSmZycktJcHZrMjZh?=
 =?utf-8?B?aDh0YVdQdFJ1eERBRmh6eW5BZm54UWRyZ1BsQU1NaXJHeU9iUEwyUEtWUUlG?=
 =?utf-8?B?NmhrakVuRkhmelMzazVqQkRyK2hzdVdsQmFQVm9neVVUa2NzY2ZsWnpIVlJV?=
 =?utf-8?B?SklndFJzMHRQWXhrL0xaZDYzU3YvK1BEdW9WaXF2cDVOK2p0QVd0VjNCekRk?=
 =?utf-8?B?dmdUVTBWd0h1M3dtcmx4NklQT0gxTlhoaGVJNDZhRWtDYlprWkNSSjk4WUlj?=
 =?utf-8?B?czlPME01V3RCVTNOY0NqS054ek51VlViY0V3R3M0alRvWjhjejR0c2FlemdH?=
 =?utf-8?B?VkxNOGtJczhRSk1VTEx6L25RWHR1Mm14cDZJRUZEMFFWWWNrNjFjTWFLaGxw?=
 =?utf-8?B?U0ZrdThteHJ0VGpYQkZ6ZnNvNGZKZWN2UFc5SGl3c3FLbDkzc1gyaXFmck9Z?=
 =?utf-8?B?cHBIQ3UyMzRzdXRwTUw1QXovbDlNb0pZai90VG5mV3o0bVdyYkRobjJ3RUJi?=
 =?utf-8?B?SmYzSkJqK1lKRWI3OVcwdXdJYUFBVElrRXRzeUFHamlKbWdtYVRHUjF4a3F2?=
 =?utf-8?B?bGhZcG9SUEY5b1VBMHJmdTlPVGpoYm4zdDgxOUFtbFVOQ25QZzlGK1c2MHVV?=
 =?utf-8?B?OTc1UlNWc0d0TzJNbFkySTFsZmE2ODBQM1BhK2VQaVNqc0x2a0VnRHpNVVRC?=
 =?utf-8?B?ZHc2K0hDVkVYUlhJU2pHWE9KcGMva3VTSXZzUXUyMFdNN1R1cEJLZ0hST0lr?=
 =?utf-8?B?eXdTYzViNW5BdnpHZEZTbzZIalF4allCRFVydlpFTTViYkNNamxHZUZaejVH?=
 =?utf-8?B?bTJJY1BCMVNpTWR3c1l3VnNmT3VuMDJBcDFPOStpTUpLT25GQUJ1SDVWQkVM?=
 =?utf-8?B?a3l5K2tBS2tmSURGRXJmK2hVMU9HRmd3aTlVcHdOc01lakcycXJJOG92MnBR?=
 =?utf-8?B?bDY0QmpLVlRGWEFXVXVPd0VMQ1Z0LytBb29BbW5teG9PY0NYZDRlZWhrNnIy?=
 =?utf-8?B?VmVxSHJJSDV4emxLMzYxTlJVV1QyejVEUkR2QnUxTGgyczlvTVpRb0xuN2E3?=
 =?utf-8?B?Q1RyeUZCbkNHNHRMVG9Cd1dHalE4Mnk3WTJRTjB1TVdLV1ByTW1ERUtVbk1U?=
 =?utf-8?B?RUFKeFZBMm1XRTFDV0FueWg0M2k3cXN2cDZ2OWpkKzhmcmsvOGZLbzNmeXYw?=
 =?utf-8?B?a2FNZE1YM2JTd01rbGtIM3dTUkd0QjAySUxnNGswTVBkOS9Vb0h0dzJ5U3lX?=
 =?utf-8?B?bTdlMENHTUdHZE42czgrU0ZBTTJyaXhGcTBsQmtTSlRlMlZ2S3d5OVFueDhy?=
 =?utf-8?B?Q1JmSWVOcGpON0I4SzlKd0I2ZTVWZUl0eVU5SXg1cllrQkYxVTVYcGJPamFW?=
 =?utf-8?B?WjVFdTRRY2s4MkhQQUFONFlORk82Q244am4vcXFnUEtONk0yRElMNjR4Unk3?=
 =?utf-8?B?REVNczZtdUF0TDFPNUlvWFhOZmY1ZzBkcVZlS2JCaEoyYURiT2FmamYvM1Jv?=
 =?utf-8?Q?SCBbuieaB5X825uFgYruOfQGsMX5AwU6E8nE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmF3Ukc5REU0eGFQK042SkY5bGFLVXFCcTNnWm1ISWZBTExPNE1STm9BM2VU?=
 =?utf-8?B?cXVQWFJZaGVkT0hMSHg1Ky94dGVocmZsWkZHcmpYQXpjMnowRW01c0MwaWhL?=
 =?utf-8?B?eWpOcG5zSlJYN04rb0tjWTgrTUpuVG9kekVCSEsyWklydUI0cTBtYnkvc1Q0?=
 =?utf-8?B?Ty9QZDZ1bHc5MGp3b2NrS0Z1N2t6SEhzekViQm9Ecmo5K0JBVUowbWg3OG9X?=
 =?utf-8?B?UDVWS05yenJEWWlPMEpGZkNOa1RqZE5VelJCNTZsWHU0ekVhZU0rdkhyMGxI?=
 =?utf-8?B?Mm5YVGYyYTFpTjBlM1R2SVkrQ1FlbWJjd3JLRmcrMG9iMFRNUU44bThQdW1y?=
 =?utf-8?B?Q2tucFpoU3l2R3orTHdtMHlWZ1BtRStqNW1Bdjd2T2x2QndBaWFpZHlwZzZN?=
 =?utf-8?B?UzJSSFZHWUZ0cEMrbUNLZ3RoSUZoQ2syMVBwY1d3bzlpMER5NDRyY0VVZVc0?=
 =?utf-8?B?Vml4NW83OVVlMmFhdnpvWHYwa0tWM1grQUx6Uk5Za1hGUEY4UVVrQ2ZaUTZu?=
 =?utf-8?B?alhNRVN6WWJ0SHRrV3VtT3drcXNhQTYzcVpJcS9ldWNJVWNHZTNhQ0tIWnJJ?=
 =?utf-8?B?U2Jtd0tONG9pd2pNUlBvQnVlSE94dkl2UWJ0dFV2VUJFN2ZSdUVxa2djaDli?=
 =?utf-8?B?SG4zZExvU095UU9YSjhFN21RMEZoNXpDaENDaXhxYUdFdzZ3WmJCQmFMbmcx?=
 =?utf-8?B?L2JYeitMa2hod2w2TTZQZUFQaW92cVR5b3FlUldrelg4bTFKOGJsOG83SE5E?=
 =?utf-8?B?aTdjcCtiQ2pWd2YzRnVlSGpPdEZvbTJnTXRLQ2h6clZDTmR0Tk4xN0hMRTN1?=
 =?utf-8?B?bitHc1E0cE9mQmtSS2tvdFZCUEUzc2M0Vis5R2ZQMHZrWFpnM1NHZDNLdVZh?=
 =?utf-8?B?d09aWTFMYjF5Vy9BVkFjem9iOCtIL2JuOWhEK3VJbUQ0TklhQit5aGpCb0g4?=
 =?utf-8?B?RVYzbGJWcWlpR1VTZHlPWUs2V1lPUmFRVnYxOFVMZ2pKM3ZwWW1zc2J5Q012?=
 =?utf-8?B?aDhJZUpHZUkrTDF1NUZnYXJibjZBWnpqandpcFJ0ZThmZ000Q01pZUxXSUpj?=
 =?utf-8?B?Sys5L1IzbjJjWk13NjJXQjBTVnozZGtyam4rL2Rjdm5VL1VCZnBnL1o4MXhv?=
 =?utf-8?B?TmRjdENNc0ZRdFRJcG9FMGR4OTVhSFZDbGJwc0JYMmRjMytORkNaYWpnSTg5?=
 =?utf-8?B?OVVNeHVmVWJ3M3ZlZ3cxVmdqQ0hEbTQvbXZ2b2pXSmFzaTZlbDc4R09RaTUr?=
 =?utf-8?B?RUN5RmJRdmFMZ1lHbWN0L3JnY09tcW9JTy93UFJZbnQrb09ldUt2c25sUWxh?=
 =?utf-8?B?cG9xazhqdjNHeW9mNTFkc2xITXlIOE04WU5Wd1FzUlFKaVBQZHBQUTRpbGI5?=
 =?utf-8?B?OEk5Z2ljanRtcURYZk1kSkN2V1JaUDBxSm5jcnNkN1lrS1VQNzB3aGJIV25o?=
 =?utf-8?B?TFVNLzlJOWNGVjZjZStpenVkc002eDdJWDNoZ1pyS0VlbXlmcmNmOTJPd0Jx?=
 =?utf-8?B?SzBSb1N4cjI1ZHVtQWwwdU0vTHd0WXJaSWZKQ1NDQUZ4MnN3RU1ZYysrZmtN?=
 =?utf-8?B?N3B0V3U4ZERoYm56S0MvVHVXZUlqSWtNS1pqOTZpRTg3dWNkOGhFMkxJYVlE?=
 =?utf-8?B?Y1FxY00yS2Z6MjRadkM4Q1cxdklBa2VQSmNmWHZPM2o2QlNOZVRLMDQrQlRZ?=
 =?utf-8?B?aVhBcG8yY0ozeHYwUFIyT2FkSDRqdUVlTHEvK2l5cTRMSmt1KzBydVo1aVZF?=
 =?utf-8?B?RmgyWXZVZHV0endsN3hiZlBCa09UN0dQaVJZOThRTFFKeWRhTGdqQzJZam41?=
 =?utf-8?B?dnc5YnI5MEhJR3ZDT3NHdldMeVhScGJWSGxCdEVzWm50bXd2TE9ZUmNQSmU2?=
 =?utf-8?B?VkpVL1JHQkZmeWlUNzQxajI1RHpMRnZzdzJJR1JLK0VrL1Y4L3VUWTJ1K3Zj?=
 =?utf-8?B?Q1JGRm1sbXQ3MWhkR0JlN1lVME81VEZtWFBNU21GUkdLc3JRU0o3VVNrVVJV?=
 =?utf-8?B?cm50OEZ5TFNKZFQzWUZZUVh6Qk5QdzlLN3A0TjV1c01rdXhyeGNDNlpPUW00?=
 =?utf-8?B?WVUzOFlpaEErT2tCT0t2UDdNQWd1ekJGM0lHK1NOT0oxMmlweGt4SElDTUJu?=
 =?utf-8?B?dzQ2NEk5ZzcrSzlLTHZxeDMxaXduSEF0cEE5L2l2THJ3N2RCR0RzZHdPcFA5?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00777bd0-7396-4b90-f778-08dd9a147ca1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 16:11:34.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /thXbtItMLseVLHyfKmIy0c9WkHFpzaqqjr64gEEbYBpDIFzCjksL/M8I60dYXSH6/9+IMdr08R3wSREdjX7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7281

On 23.05.25 17:00, Sebastian Andrzej Siewior wrote:
> On 2025-01-11 10:55:55 [-0800], Alison Chaiken wrote:
>>> Are you sure? My memory is that glibc avoided using the internal mutex.
>>> The old problem should be gone and pthread_cond_signal() and
>>> pthread_cond_wait() should work.
>>
>> Ignoring support for 64-bit time, the last substantive change to
>> pthread_cond_wait() and pthread_cond_signal() was Torvald Riegel's  commit
>> ed19993b5b0d05d62cc883571519a67dae481a14 "New condvar implementation that
>> provides stronger ordering guarantees," which fixed problems with waking of
>> ineligible futex waiters and with ABA issues concerning the futex word.
>> What the patch does not do is made clear by the commit message:
>>
>>      This condvar doesn't yet use a requeue optimization (ie, on a
>> broadcast,
>>      waking just one thread and requeueing all others on the futex of the
>>      mutex supplied by the program).
>>
>> What futex-requeue-pi.rst directs is
>>
>>      In order to support PI-aware pthread_condvar's, the kernel needs to
>>      be able to requeue tasks to PI futexes.
>>
>> Riegel and Darren Hart discussed Riegel's patch in at length at the 2016 RT
>> Summit:
>>
>> https://wiki.linuxfoundation.org/realtime/events/rt-summit2016/schedule
>>
>> The related glibc bug report by Darren may be found at
>>
>>     https://sourceware.org/bugzilla/show_bug.cgi?id=11588
>>
>> The last comment on the bug from 2017 is by Riegel:
>>
>>     So far, there is no known solution for how to achieve PI support given
>> the current constraints we have (eg, available futex operations, POSIX
>> requirements, ...).
>>
>> I ran the bug reproducer posted by Darren in Qemu and found that it did not
>> fail.   I'm not sure if the result is valid given the peculiarities of Qemu,
>> or whether I made some other mistake.
> 
> I've been looking at this again for other reasons and looked at the
> code again…
> 
> Back then we use futex-requeue API and required both futex-object to
> have the PI bit set. This wasn't the case originally, hence the patch by
> Darren which did not make it into the official libc.
> 
> With the rework by Riegel, the mutex within pthread's condvar
> implementation is gone also the usage of the requeue API. The
> pthread_cond_wait()/ pthread_cond_signal() API is back to use futex'
> wait/ wake.
> The glibc comments write something about important ordering constrains.
> The futex wait enqueues the waiter according to its priority. So the
> task with highest priority gets always a front seat. The futex wake
> function wakes always the first waiter in the queue.
> 
> With all this I would say that the glib'c condvar implementation does
> not have any issues since the rework.
> There were a few loops, with a 0 retry counter (basically dead) and they
> have been removed.
> 

That would be good news.

Which would be the minimal glibc version needed then, already 2.25? And
could we ensure that future versions will maintain these properties by
sneaking some related testcase(s) into glibc?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
