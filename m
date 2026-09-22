Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7E2F3632
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101174; cv=fail; b=rrNq/rjC0PsIXk5/9JXDHXPfDhWCAihSrflzPc42IEqKgY113mrq6pA0en3ulQgWjT3n3ItbyqHA39CmZ4xY7hb0ox6dJPESqF18oGgvm5TCtLw9g82lqlKAISkY7xNP4ephPazUFs/93wqsNlkL8RM8QKp2idhnDZ3LiQbvWs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101174; c=relaxed/simple;
	bh=W8QIa0vIUOVf0Fp2cIPAqQn+OIE3pOYdqYxIllTXRMo=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=B1QNmjdfih2gTWu9M49O7gmu7fI7iHqJOYtN7mMO3gtdO30bAkRk4AUFjhEYtC1JhusagYQ/vpIvgMM8gEQ+5lwLGxxAO/laijlF47z4l5GLmfplxUwmxsb5X4L3xRL9jid3BLSppcCCFJkQGDyeMggrb9k2Ilun0hK0ci9e0qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oG9Fn1ei; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oG9Fn1ei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpl0AUYhDU2ZuEsl9zlSoi+JjVFHCk1q2FMlAWY9FPnvx05sMBK0GFROMVHjznt4p0gbjCmBK+TuaLWcXLDKn0/FRoLXAyhjaWdW47/1p4dz72oTLXDUd4BhSTv54aajrogdUmcqpRGUiNfbjX7lHaD+O16KqFmxNc739LNEAr87MJpXx+BVmGmyflW5o/mInG0PL45KqGMgLTg7HoQ0s1kZsMgM2gDPOrZKiOarAhwo8kEw+6q97m56wco+TwGOf6vtkcN25ZrScy+VuP1461Q0CEMn2ppT/M475PC2eFmamDGMu40SNRutJ0d+AiemiDB17pZWe+mg8qZrmAKeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFsFBTm+kDInP9BJ7+jH+usyl2WBl/dC2LjTdGwNWJA=;
 b=xwKYni7b3jwHg2d76SC4D1DPfmAr3jB4Dr3LU1iLWK+tiATzymUhsdSXIq3kUbTscFoLR4deZl9i7hA64Wox60FrnoABjaNdeAMRI0u2RrKT1X3W2wf3Pd6OdW5W8QbpbE4flaXjQhDPx4nF1G+GycB4HuydKvVH/dDZ08/et5pfAZNYxbjXG71wih2HpzLr12eBnIGL4BTVR2pYxl2jVA31RMCrm3gaAZuLb2RnpwvP8p6cYTg8ReAyO+NrPAQvm8tPwmMZimFrCxmu7UViY9jRMA+QRyqVjETkC98M4mYngmkW8l04XHHCoqoxeqp4kKEmx+/xhofZxCWrrHxnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFsFBTm+kDInP9BJ7+jH+usyl2WBl/dC2LjTdGwNWJA=;
 b=oG9Fn1eiyG3QQY/uUBTtrai3d0iFIi6wqJnIl72aB11rtEwLD+E0WfhgHfYQJ98LswxNdLQ2q13orMYUzs1rll3Lm/TKX7pcvmwlwn3g7iY5gTYn1tMR/+Y03aoGZ1W2JynVo36VyRz0QsNj0HCZGKlbnatr3lyd9zVuGwF2Elv1oxjNId0oJv5irzSS2pnazXUIAF1G2CP/CGyKvMo0j3IiFJh8cUe22Noz89MDwSlqTOkRtoEqdTOxuGjbU8LKGLMI7Xh0vR/ThCA/O5KTyI5WlxRnjvzPrC3BYyi+QwaJ2j6fvF4VW3IxqExftHjaKN5GIqld+SJF6ZojJhFdUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:67f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 18:19:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 18:19:29 +0000
Message-ID: <7bdf7e12-1ad2-42d8-9596-71232d9b1b7f@siemens.com>
Date: Tue, 22 Sep 2026 20:19:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Real-Time Linux User Forum - October 6 at Open Source Summit Europe
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Jan Altenberg <jan.altenberg@osadl.org>, Min Yu <myu@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8872fb6d-4ad0-4655-701f-08df18d60afc
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 nPbC3SrqdBBRIdKPjke4x1C0O2ngUfHrqEeL1fiz88a6LT0DuTPuHeM0LDk7AEolB0EU7FDqgvlxD4RQOMcIKM1NzXTovONV9h5zKlKTEZ5bpqLjkOQ18kgDsl8vhqbo7qFALshQ6O7U0gz4i+O6uOJgsw7xtmH14FjB6ZzT9DAvt7Huwp/zB8/HLFCRFdjHb8kT+xthrFowPlhMkn8dgGjfXac0W1In5Ka738JOCQC1okckI2VQXiYqkKTvXzIUuET8NK6EXgtn/oKS17I7C5bC1zmgYOQSGlSoD8R23e+Io1T/9U58U+0IkHFEQrZe5pebc+NPhFBYXzpsdQpwL5W1e09yjyOPouTSCmukFOMDx9Y0cTcitw1CcNljMzAPrYxGjVdhS555/oQdq2a/HUXrBt8m9qcPljha/rAOTRIeJds0HRvLv+WbxUDEFXytLaitdNzy+xYFqbgYKVTG1M5uMX/ESCXip2TZyLRGOe4f6aLZ46nrzHOQP4VfisHh/BCbY15MMjhAFRK58XbjGkoUdyZVRItJzQm88vO4xaAbUpjZ/zu66PqjNydHQJzLnuYc8Oc4VHjtfZYlBAswcKEcPRkQsNqv6m/uyCHgTUGsQLnN5vOLFSxfW+ioMjXX
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dnc0WmEyd1EzdzJLWGU5MTV1bkFWKythNGFhWVhmTTh1VGh6K1l4eWVVaXZI?=
 =?utf-8?B?TElxem1INlBOYzByTW5objJjMVlidG5YeGdVUmVKc3Y0V293eS9nU3R0WUY0?=
 =?utf-8?B?VTB2RDgwbk1LSzdsTW01TlI1NnJFVEtLSXJLS0xQYmlWVzg0RGVDckVnZUNM?=
 =?utf-8?B?VWtpaVNHUXJBNzJrUXJ1dzYxaWtXd056QkdjazE5Z1dsQVF3NU82WG1vTU0y?=
 =?utf-8?B?UVJGVEMrblQ1L1BtWUFtQVRVZ2NLMGcvK29kTzFnK095NU96bXM3YnU0ZHVy?=
 =?utf-8?B?NXpXMmFBMTNCcW9YdVNHVjdadEpFUVJPSnAzNVhTbUJ1VDluY1ViSjlucFBk?=
 =?utf-8?B?dDRoTm1oNVBjNjNrUkx5QnI1YTNUbmhCdyttbDRncWtYNDFTMTM3NzVXQlVa?=
 =?utf-8?B?OEdkNTl6QWJudEUwTnJZbStFdlBGbloxREFtWERkQUpmbEZrN3VramtTZHFS?=
 =?utf-8?B?UGNxaEtUamFYZ2szdHZBZW81RHNHdEd5VldpU05nZHZ1OVd2QjlydUt5SW9R?=
 =?utf-8?B?L3hXRHpGMWtZSUxtMWVhUWFMSHhyNEdBcVVuVmtwd25ETGg4endUOTlPbDE1?=
 =?utf-8?B?OEZjQXA0ZFZpYWN2ZGgvTm5iNzJqQVUvVWsrQ3JDM1JIeE5wWVUzSVFNa21Q?=
 =?utf-8?B?QjBJUVFtN3cvdkZJajV6c0VTQVdIU1dXYXVaS0w3ME9HTXlBWnZHNnBKR01s?=
 =?utf-8?B?eWxFaC9qUkI3MWJMMjJnaElxYlZlZjBycUpVVEFBSjB5dHg0RmJtRUNSSXJR?=
 =?utf-8?B?MTMzMjlQZE5LL256amdYRGJyTld0VE9kaUgzS2ZJUlZyOSswMzBSUENCQXR3?=
 =?utf-8?B?dmN5MHcwZDNadFdITGV0cUp2QWlzeFhwZEgxeHo4am9VWEFyL1lKRmlRWGpm?=
 =?utf-8?B?OTU1VDZpMlV0a1E1d2o5UlNCMjV0NVJFdy9wUkc5Zkh2OStaQVp4V1ZMK0pm?=
 =?utf-8?B?Tmd1b3A1bElQMFoyQ1I4TnVBWVo4aU8wV2pxVFF2VGw3UHFjR3d6cXE1N1RR?=
 =?utf-8?B?N1dYdSsrU0lSd0xSYndIbjBkcHR1MmxwTTB2UmJnZFlVTkhETjlyamduQXVs?=
 =?utf-8?B?K045Q092Y25uMVY0VW5KbEZsN0dSUzR4ZVBhWUJPRXAwRzFPZWdFRElpQ3pp?=
 =?utf-8?B?VndTVzQzWFBJNDh4dmlwVHJpZ2dCRGJMdDdXak1va2ZFSHVVaUQ3Qmd0VVEw?=
 =?utf-8?B?Ukh3V0RHNUhxZTJQK1pKNDIxSkpMNHUzeFZ0QjZseDRoWEtMTWZMZGxMeUFY?=
 =?utf-8?B?elp4TEJxUGdPakVDZUE5R3B4QXl6cEdPamd3c05IeGZHZEU0Y3pMVjUvdUFQ?=
 =?utf-8?B?K2IvbGVGN3FGZEhMSFNLd2FhUGpQeVowVmk1TnA3ck55Y1pkUmdDN1hoT1lX?=
 =?utf-8?B?Rm9BelpZNGFmNjVlbTNzR1FwOGh3RWl3dTB3YUpVRzBETFlCMHgvNmtReUVT?=
 =?utf-8?B?aGRDblg1QzlwQThHM3NlK3hUVmZwZko4SFFUdElrOUZEbUlRcFNldDFGeVZs?=
 =?utf-8?B?elFtUzJoS1lOYjhybmIvM3ErdDcvZ0RLaHRqV3ZwU3UxcENodUFQZEgvOXkz?=
 =?utf-8?B?Y0VSTnl5QmlQcjVVZjlSaFZzQjFTVWdEbENlajNWWE5EcENjdkkyRk92MnVH?=
 =?utf-8?B?U3p2VmFYQTNjQW00QzZsMU1VNjJmeUxNRElSdWFVN1JqN05lRkgxSDhFa3ln?=
 =?utf-8?B?SzhTQXdsMlFpZ09hUTlxRFY3Y1ZFanBROFNYbENLMnAxVWlyTGVWQVFzenF2?=
 =?utf-8?B?T0x3K1JQSWd6T29RekxiMGZBTzQrMWRvOXFuaHViaUt5TFBKZytIKzkzNVdt?=
 =?utf-8?B?WTlkRm9hT3prNG9OalRoWG5COEVrMGx4dk8xSkF4b2VwL1dZRTRlbDBhSkJS?=
 =?utf-8?B?QVZZVmlZVC9wTUhxT1o4WElkbjhRdERzRW91NWV2SWNKQ2U1L3NNTlBRZGFI?=
 =?utf-8?B?eGpGVUJLSGVMRGRwc2F2RzFnQ0xJYmZMVXFneUZ4WERTdmxOckM0b0pFRWhI?=
 =?utf-8?B?Ulp0cjh6RHBhV05RZEtZY0FHSEZOR3c2MjA1aENKM0c3MDhTYjNRNzFVdVVa?=
 =?utf-8?B?REhpN1Fmb25JcW9NTEwvS2VIS0FEWmx3cVFxNFlHZDJCOXdiNFRmdkZzMWVN?=
 =?utf-8?B?SmluenlNVkhKWUlmQU1DYXl2WUNMVDd4RkdiQ3o5LzM0OVRsU0xaU05nbFVz?=
 =?utf-8?B?MVNDUEhkNi8rSUdpK1llbkVsUXZCall4UFNFQ24vc2NKVGFQUEszTTVld1V2?=
 =?utf-8?B?djAyRVBpR1d3eUFUWXdqQW1SK3JoUU4yKzR0UjBsOC8zeWwzVWdEQ08vTDQz?=
 =?utf-8?B?ZCtEcXUwQjcrZ2VQd04xWEduMGYxMzZoNUpwMlhycm1uVFlGa3pTQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8872fb6d-4ad0-4655-701f-08df18d60afc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 18:19:29.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YI7FRvb1msV23+cgpu6IKqXVYHHqj4mTXRlnWwiai/wmvG1i1X9qqfcweg90CvjT1UXhZZEVV7LkIAHRnHpCqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8270

Hi RTL users,

We are just two weeks away from Open Source Summit Europe in Prague.

We are excited to host the first Real-Time Linux User Forum, taking
place the day before Open Source Summit Europe begins.

  - Date: Tuesday, October 6, 2026, 13:30 – 17:00 CEST
  - Location: Terrace 2 A (Floor 2), Prague Congress Center (same venue
    as OSS Europe)
  - Session Details:
    https://realtime-linux.org/event/real-time-linux-user-forum/

If you are attending OSS Europe, please add this forum to your event
registration as you finalize your schedule. We would love to see you there.

Please also feel free to share this event within your network.

Thanks,
Min, Jan, Jan
