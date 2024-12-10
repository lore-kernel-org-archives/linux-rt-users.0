Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020112.outbound.protection.outlook.com [52.101.189.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1321422D;
	Tue, 10 Dec 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857428; cv=fail; b=SDhIMiprylHSLa0/HztH1TOrD1g0Eua6ASNwiot0u3zCpjNMeOYDJ30PBezkQhNPzKiyEO1v7pTEt78oo66TfhLoHiHJambqLJIIfSKGk32XXcx05Qss2QhxhO1AQhGhESMtcCnpwVpNTUHPdkuxKYxgqCDJwLOX4NYnNTab6OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857428; c=relaxed/simple;
	bh=8HenvubNydl7hPinSDTgINWqOrpgS0hLRpRd+K6E9eM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pSdcBkFrd7YGX8nrHa0oZC99x9nrLMw9Fdxhat+IBSmHymZeP/wm24fmlQCVWKJFf4Ws1aYDJf+IpVttrTIdIYjv3D+LWTdPML2Qg4SkzEB5ArtEfekeFlvu1eliLGGIU1Vja+hF6VEY9aSa3wN/H+bY/Df0jyjc7vUD0yo7dD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ElRYbvXR; arc=fail smtp.client-ip=52.101.189.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ElRYbvXR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbxMBPqZgUddEVIgXc39BZ8bUozDxl+dRGlSyntIpdvgzDAsv0oEN4mZuBwdmHLIt5c0t3zFVFZuQznGFEjShp8asaA+Sk+9piIwErtF+Z4PTagw6mexFirxRBbqeF8hFtE9ge/rDB3dVNINZOrtmep14sJNhkQ9a+jBuMc3k5ggbjGkXXAsW+g/x8al9Tp88R1B/59WkGw8UCyPjOV52ouJsLuSjCozrcLCjHUXpAqkWI1+F3tqBi7pgRlA/pPTwicaqK3ZMLi6tEYRymqa9RblMFijMQkgvBY6Ze/c/ciFgMFrU3hAsMyuphwH157QWfSHBE6ebZEU47le6o6VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkH9bqguqY39jz5ntBhWQmpumuEPX75ZBWlrd6vhY9I=;
 b=Q3qm+AZ62pUAFsFbi/TTCG27++iZPuANUa9Sazf+FuUIHF/8Yki84WqEPqPIhhvJacQMvSG6CXzMYS6B7fJVmmTOw+zjpzjHWHoR9G0mM1yyGjuD0D9rXi0l2A7nNXcHlegRPSqipbBGKgejuqPnqhjsqqRLUcYokHa0eLDHcPhosr8m3XaCDJqdAAUnyplfnOHKcj0IcY80hPwfjXBWug+ZCRqCYR5kYFOKTU8sqMNTpm4Yr23i1tNXceRMjXKqQxbry3dR7ZUEFrm19WHoGA5gPo7kLaONiptdAA3eT2D1n0QV0s4ZzpyW8QVIVnjqajxuSgAaG56GY2ffz0D0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkH9bqguqY39jz5ntBhWQmpumuEPX75ZBWlrd6vhY9I=;
 b=ElRYbvXRBSZaiOCz0jc3WqP0cWAqmJVc+0MRzoEnH35GMsKrQKnJYmnlhgns7/dI30ayI1axxK+Lu0Wd/p5GaMcILmzv7OPFDHFmC8dNTfnPohXSiUuSwrwSN86MCITHILddSGE5vsL9kgwJFinoin6d9bF7ow+SnzwxG/NS6gsz5FLYRwd5IcZNxW8tm5PU4/kJRo0qeZHYox/074UqjooKWu+wajeAbu8B4FCstjX0MkDfZ/REmPdPEDZtV1fVDV4LmrBdBPpzVVyi8GTo7G4xV7HnmhGuBVJKtbRBc63GuOkG3UJtySzj7D87mg3jfDtyAmi8C8pL3hiVS5GnHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5485.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 19:03:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 19:03:39 +0000
Message-ID: <fd4fc5ad-1a55-4a6c-b98c-4b58dd3c36bf@efficios.com>
Date: Tue, 10 Dec 2024 14:03:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Can we switch the tracepoints from preempt protection to
 rcu_read_lock?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
References: <20241206120709.736f943e@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241206120709.736f943e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: 27905491-7deb-4a93-783e-08dd194d5b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1JJNzRFK01ENGJBd2VUQU9zNmNFUmluVFA4MVRmOXgxY2RaVkVQVnBVaUVt?=
 =?utf-8?B?NW5kUzloRVhpNENSVHJQY3hPSkZRK2d5czNiT2FHdnBJTFVYTDhmb3NER1dE?=
 =?utf-8?B?MGZsQlY4RjFLanUyaENleDRSUFQxc2t1RGZOSTR6V0xFRWUvMm9MY2VFVThL?=
 =?utf-8?B?Q3Nvd3FPeG8weHhISkF2SG5uVStVVS85dEdDQU9YRUI5b0d5V3UxdDFTMzdS?=
 =?utf-8?B?LzhvSUkrZFFFZzNTTG5sQXg0Um9lRWIxdWlXeTBZMTB3WW4zdElVSzAzQnNC?=
 =?utf-8?B?MFM0R0ZaVVVsaUdzd3pjNmV1WW1HZXNaOXI3SzlzT3lwdGp2elpGTDVteTJY?=
 =?utf-8?B?ZGJPSTZRaXIzWm9malAxdTJFak5rOFRCcTVMMmRBRVVEamZsaW1FYjF1ekdE?=
 =?utf-8?B?c05yVGZiQXFWM014ejAxN1dUa0JRMmNpVXpPb1dHUTRmVUN0d3ROaFpwMWpY?=
 =?utf-8?B?emV5QVkrSnBFM2YyazNYMVlVL0p2cFVVUENOdDNkaFFGUVFkaVZPYnhvYy9p?=
 =?utf-8?B?Y1BCdStRT0xVc0laTy9zdDNLVXVkMzZTb1MwZTdVc2RoWU00d2R4MnEydnVq?=
 =?utf-8?B?NFVvTmxpSk81U3NJSEdOc2VhMWs1WjN6bU9mQ2tlSFlZSFZoWjRHRU1NdG9W?=
 =?utf-8?B?YWFxdS8zcm9RUmtHSGx0b0tGS2dWbnd3UW9EWXBRT1Z2TkJGdUtLUE1wb2RE?=
 =?utf-8?B?cDZJYktKMXVwaDlMYU5ORko2VU1YTERkV2tLdHJBWjJMeld4c2hGREpPVGZa?=
 =?utf-8?B?N0lsY0xVaTRKMU9sTGhHeEJLTStlU3ZRby9xNlhuMUdnV091cC9JN21RSFJJ?=
 =?utf-8?B?NzZnbUZiM0ZoVGg3aXp6azZOdzlOQk1wcnp6d1RLRDVuN1RybVo2U3Jld2Zr?=
 =?utf-8?B?Ym84QTZsZktQSXVaL0lhUmEva1VDcVhZamxwV2RJNGdjVjJoTWkzdnZWQlpF?=
 =?utf-8?B?S0dHTEN6TGEwZUlUeUxLUHp2M0N0TkVPU0tkMDk5QUNNUUUrc0oyaGdNOFoy?=
 =?utf-8?B?Ym5IQlVUZUpkSmpWT0k0Ry9KMkNFYWpnSVYyZm5XRFdQRG04VjI5SDZNYXg2?=
 =?utf-8?B?NWowekJLbGFpRlB1YzBtS2t5a1pjMm1VWWFHcEcrd2VzM0pBVmkra0FGcXpK?=
 =?utf-8?B?U3QwNUZWZk9xWTVrdDlMc0Ztekg3dDAzRkpIQ05MQ1ZlK3hxbWc2Sm5KRUQ0?=
 =?utf-8?B?bVo2NzRkUnNjR0VxSCtJYlpqK1RQd1Y1TEZ2NzRBV3h6dHRiWVJRbVpVU3lT?=
 =?utf-8?B?eEp6Yk1EWFlLZ2ZsaUtvdkdKdXVWMDdGL2xQVGJKNXdHTkgvSkNKNGFPYkcr?=
 =?utf-8?B?WC9zL3Jsc3p4MW1NblUrWDVGWStvZlBqMFhVYlpxekdMTlpCK21wcFBaa3VP?=
 =?utf-8?B?a2lNT1ZGbnFmYXYrZkkxaTBYZzNXUWI0dFBMNDVXVmZGUmxhaVBQdlRpM0pR?=
 =?utf-8?B?d2pLbWtiZGd0N05pVWtnMHZvNmIycmZnNWlJZmp4dS9MZkV0dGFEcU9scUo1?=
 =?utf-8?B?TTc4SW40N2s0K1hlSjZsT3pFeW1ySyszY3d0M3JQT0oxNVo0eStVSXh3NXB4?=
 =?utf-8?B?N1FlR01tNGVVMzczZzFLQWllMHl2b1hhaXpqUVNoaHlzL3ExaERoSXd1T2ZE?=
 =?utf-8?B?YXlncEhkZXZ1WHFoU200aFFzUFZZN1EzY1J0eGg4UEJIbWxGMWh3ODF2SC9k?=
 =?utf-8?B?S0xCTXJ3OHJpNVd5aGtjVjArczI5VU04Rk5yaFZGWWkvczZFR24xdE5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9xWXNnUUtwWnZhS1RSQVh2VjZqd3VISFgwLzZnN0k5alVoWjlFZ0ZrRGNB?=
 =?utf-8?B?Tmc5QVZZdFNqcFdsa0luS0M4N2ptVGw2KzlCbURHdC90YVZYMmQxMUVuMmZo?=
 =?utf-8?B?VktlbVFLZjNLOWZKcE9zT1RDRE9vZW8wR2FSTS9vUEl2UFY4eVRvSVExUDBI?=
 =?utf-8?B?dG9vUmIwdXNaQU9rZzBKZEUza3hNRC9VajEycVFtRVZIUHdOUndvVTFkZkd1?=
 =?utf-8?B?bU1RdDMxN2QvaTh0bHpCS2pvelY2RlNDT0tKUUVENHNJMGIwVTYxQUJ0U2dE?=
 =?utf-8?B?SThOV1lqVzcwanNhN055dExDRy9mb2g5em8wanVpKzg0c0Z4SnRYZkxEdjJ6?=
 =?utf-8?B?am9qaDNYUDB3VlJWY3RDSHFvdENXS3JuVE9nUmdnRW5TcU9xUytsd3ppdmFT?=
 =?utf-8?B?WVQxL0lWTnZoOTQyM0Vhc0ZHaG4rMEx3K0Q1WTZuOFdMZXdndUhTWW5JV21m?=
 =?utf-8?B?WVU3SnNzOFAxOU9oUVBwVkw4VkV4TWhxS01nNjR2bzVzMmJKN05KbTNyWnV1?=
 =?utf-8?B?OFVmODE2UUpDUU1jL1R3V20zallJdGU1aldMcktQbEhKb1ZNaWt6dnFoUjdr?=
 =?utf-8?B?Zi9mK2doam5hdUtGOWxBUnB4MWV4TENJa2d6NjIvVW1IMGZYMm5JZXlTM3dG?=
 =?utf-8?B?Y0JCSTlKZmJtbXg4RDk4S3JoRFJxS1lTeVhmVFc0ejRac3hacXdnTlE2THZZ?=
 =?utf-8?B?ei9ZWCttN2NWNHh3bmV6RC9kNlBpUk1uRk5CQTVaSWgrVHNPWnkyVk5UMHor?=
 =?utf-8?B?SWV1cUdLUGJNbTRiNE1MS1RSUU9HYmtPZlZRV0ViZktoQXpVWEhYZXJNSUt6?=
 =?utf-8?B?VWlpb1YrRGcrdTJpOTBMTWN4NzkrdGtGS1RibUU2T3U1UE85R2xOYURTQzVv?=
 =?utf-8?B?NE8zSFd6UFhyemR6SEZuR2RxeWpqN25maUZzNzVDMFdZZjRDQ1BSMDFEM3ky?=
 =?utf-8?B?Y05NUzBOcUVwTHlOU1Z3aHFuR2U0WXViYUpFL2F3NHdVZHJ5SmhQOTdDQjhX?=
 =?utf-8?B?RTd3bWJ6a3dxQk9FU0RqNVpSVWJIQ2VUQktyb1prcERJbkNERitqU2J2RUVV?=
 =?utf-8?B?d3JYb2EweFJ1TE4ycktwNllXbmdsTnViOFB5SVVxcGIwbkN5bmR4Tm5SRERN?=
 =?utf-8?B?cXJ5Und6MjN1djUyM09XbDBsUWViSFBxbU00SDlENnBvcWVRRnRaTU12U1hD?=
 =?utf-8?B?akM4cVhnWGZmN0ZtcC9jU0loM0h3K1FhNmwvNTN2R2Y2RHRPalU5cFdaei9q?=
 =?utf-8?B?Vk5ZTEpOVTJ0bzdWTXpqRm1jN3hpN1NCem4wMnc0bUg3ZmgrOUVtdC84akFQ?=
 =?utf-8?B?bzdDSVlrMmMzaEJxR1hHdGxoZWxOajQ1WWdjcVE2QTgyUElUZnhZeTVZcFFK?=
 =?utf-8?B?dUpKQUpyeUIvaXp1bk1mQ2R6R0VKcGRFMEtQdUYyelhNODI1eE1KclFVd241?=
 =?utf-8?B?QlI0ZXBsUXJZMnkvUVJHN0U3ajFmaVpqQ0hvdnQzY3VoNXFnbzk1YW12VnNj?=
 =?utf-8?B?WTVxbnJEZmljSnNHaEx4L3l4RmQ2bEU2ekVaV2llU3h0OUxoMXVEYkNLUnJl?=
 =?utf-8?B?MFMrejNadjVSblZNN3F1WHNUUExIOUpRU1BoVldBTEcrQ04yZk9pUE9MSXE1?=
 =?utf-8?B?UVBBMzEvZFB0d0YyMmNpSy9lRDBORDY2OUpYOTB0QytGZ0NseFkwcnFYMVRJ?=
 =?utf-8?B?YThRR0FOcm0xUDdOZTZaaG5DNDVzaWtWSHNQZW9CYU01bG9vL1ZycW4yYmRa?=
 =?utf-8?B?WXVCcGtkL3RVSVllajZZeGtGOERCc2FxV3BCblJKanQvVWxiTFNobllDMjBX?=
 =?utf-8?B?c0luUjhXRkd6YUc0cnNRTFZJKytPRFdmR2xKSERYVUJuU01IUVJHYWZtWjcy?=
 =?utf-8?B?RzJiYUNucHFQTkMyalc5ZUpzOEhoMXcxYjV5TUxFbVh1NVlvUDVBb0NnT0pK?=
 =?utf-8?B?bGw0d0NHZ3pJa3lXRUZObVFkSzdPR3U2QWVnUDZrNXV0M1Q3TE5VZmRwYjRZ?=
 =?utf-8?B?OU9STXpvSHZUZU52aFJVdENnQ01qMGlUTndKV0RZZldiL2l4bmt1aXNWc0ZR?=
 =?utf-8?B?MjhLUUh4VUl4emdOWVlrMnpBRG5FMTljdW1FVXBrdVpvZ3lLTlVEazZlN0hG?=
 =?utf-8?B?WHpWRUNqemJldVZmcHNrSkZWeWlYQk00Q0NFV1ZPYmdkNHljZkZZOWgxRGlh?=
 =?utf-8?Q?gDiknrpMCN06TKQF0ovVhME=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27905491-7deb-4a93-783e-08dd194d5b81
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 19:03:39.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWOkd4QJ+lcaYn+akE/NbxSsgPf1zYtdN0NrfBfMfxrRicy6k8n+iudSdu+jhkl9xZiY51EEUczJXtprjf973e0ryg8neXon1Zj0DNlgDAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5485

On 2024-12-06 12:07, Steven Rostedt wrote:
> Hi Mathieu,

Hi Steven,

> 
> Sebastian brought up a point at our RT Stable meeting. BPF hooks into
> tracepoints and can cause long latency on RT setups.

Indeed, as expected if BPF don't have BPF hook duration validations in
place.

> 
> IIRC, tracepoints themselves do not need to have preemption disabled. It's
> just that some of the users of tracepoints expect preemption to be disabled.

Correct. Tracepoints need to have some mean of synchronizing callback
iteration with the callback registration/unregistration (RCU). Which
flavor is used is based on the constraints of the execution contexts
in which tracepoints are inserted.

Then the fact that tracer probe functions expect that preemption is
disabled when called is merely a consequence of the current tracepoint
implementation, but this contract between tracepoints and tracers can
evolve as needed.

> 
> If we fix the users of tracepoints not to expect preemption to be disabled,
> then we could just switch the preempt_disable code (guard(preempt)) to
> rcu_read_lock()s for the tracepoint callbacks, right?

There are a few things to consider here about the constraints of the
callsites where the tracepoints are inserted. In general, those need to
be:

- NMI-safe
- notrace
- usable from the scheduler (with rq lock held)
- usable to trace the RCU implementation

Hence the use of guard(preempt_notrace)().

So replacing this by a rcu_read_lock() would lose the "notrace", which
may break some users.

Other than that, I see that the PREEMPT_RCU implementation of
rcu_read_lock/unlock works pretty much similarly to the urcu-mb
flavor of liburcu:

static void rcu_preempt_read_enter(void)
{
         WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
}

static int rcu_preempt_read_exit(void)
{
         int ret = READ_ONCE(current->rcu_read_lock_nesting) - 1;

         WRITE_ONCE(current->rcu_read_lock_nesting, ret);
         return ret;
}

Technically this was designed to be async-signal safe in userspace, so
I expect this to work in NMI context.

I suspect that the main thing we may be missing here is a rcu_read_lock/unlock_notrace
that similarly to our use of preempt_disable/enable_notrace don't
call into instrumented code from the instrumentation.

> 
> There's a one or two places in ftrace that expect it, but I don't know
> enough about perf. I don't think BPF needs preemption disabled, but just
> migration disabled. I know you had some patches to work around this.

Correct, BPF needs migration disabled AFAIU. Perf/ftrace/lttng would have to
explicitly disable preemption within their callbacks, but that's easily
fixable.

> 
> We need to get BPF working without preemption disabled for RT, I'm not sure
> how much you know about what needs to be fixed.

Well the first step would be to introduce a rcu_read_lock/unlock_notrace.
This solves the problem at the tracepoint level, but requires that we
initially move the preempt disable to the tracer callbacks. Then we
can figure out within each tracer what needs to be done to further
reduce the preempt off critical section.

> 
> I'm not asking for you to do this work, but can you remind me what you saw
> when you created the faultable tracepoints?

I saw the future! ;-)

Thanks,

Mathieu


> 
> Thanks,
> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

