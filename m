Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C627002E
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Feb 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760881; cv=fail; b=n/B8OzOepefePLbbmnKnkWrS9e7HJ+IGp6ag/XHgKTpRHFes3hAMmElAgOr1+S8zvLsRrfDjZjiiihaINmqoqLxxOPLY9fdqLkSQhNS+SBPsSIxXOOECl2rR++mDUSyvgbZxXHHYhS6N1LrTVKRP07o7LSuRD2WpNHTHzWrk2BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760881; c=relaxed/simple;
	bh=pgEUjk1WRk5AC9WE++K8FdrzganD/PpRxClGM+0Hho0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9DdZk17FBH9MsNQiGH0LmKzIgVuugoPxgAZavvwkgBaCehVFva6kDt5zh1S7RX+FK8lpikr+eG3JnqHxvMfd26l1H2l4lr4uLVItIUhoDRlnlmHvDIWoguIO8ut6I+DhTVM6FKD1DWVH5TgDQExDKIdYvctGEzk3BR+LT1ymEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sbcuZoqh; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sbcuZoqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwXA32dUDymCP51kmIFFWbHv9Q665p3qn7T77TOELVXBoAhlfkEz+uxDRaiVb7SbhOQNRUYddFuvgrPstsdf1BdfUgcc8STK4pZH1QWpU4GOGrsktMAwg6/eiMAXxLaRfru5se/lYTYcv8M6NkVHjmZa5xwV992FQ3srzCvFSrS9V9lP1oRjMI1jZYSLKX4JMyXsLTXtXo3TRXL0YDlw2IIB9bsUV8QDA6aCW5Zhf0MM3J2vElZsLAJD9gj4z/lxICFdBE6sDUvKd1xr8tBkDQvvCchiXnfAVtimK1XF6GdxBsIPycStumTfewpZzs7znfTtrDBnZL0Ba177LllsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMg/L3S4RF64T6vaf3ZyQfRfOoAg+0PE8EsiwNw5G3k=;
 b=jgp9AyjQD+3AqqnWI1h/eZA5DDazLPloJ8j9S3WpEGHPmOJfVmR8bX3AqgakhDcgYBi36hWjic4aPOSEcc6Hk498It4c4Wx5Z0UR5Qbmy/XHmJ2c5vg9D/ZSOf9lzJCdH3hzY+ptnlWr1MrrML3KjyF1JKYwqztme+iOs+UB7vMKsUTfrqeMKbiEz0ned1CsEhn9kYOBUOlj3CAWjxpQTYm1XONTF4udvnepMKdQODSPvBprVqvJevMZLNmmHuaYOTqNPfvhe7+bc7pjxx/wR4R7fBvWH4Gu1T48QZdDjjWVjoqDN5GDtBQwvMUDbtCzF3rCx5Gi64xwn0349M1qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMg/L3S4RF64T6vaf3ZyQfRfOoAg+0PE8EsiwNw5G3k=;
 b=sbcuZoqh3n8NAlDIAmylwgmu1va8kdfVQ2QpG9+58TvsxNC2o3o/zhEBvVU/LHOEsnnKkCMeC2Sf7e7CXDEdqh+3Y362rgWpnXnsEqqHB/PAq/6D/32N1Oyvv3hv85xOjg8clJjpl/6yhJLnbtlcG5L2ueIa/q6t0bxpBa84+aCOLk5lb5+BLHqptC8F8VLK9LpdHkM4NKAZHCVkLXZphgXrjN61n5M+AK1KBdGWsDms0BxPJ2W09n89kE4FFHKyuohETeAjfC2FqU1jj0eAE2t3TUertDAPmDe0y3lCfghiWvkN5xyP61zsYIkuS2p+Ma+gf4EZV3piPtBcRgYAvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by DB9PR10MB6004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 16:41:13 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:41:13 +0000
Message-ID: <9ced103a-bef0-41be-953f-aac67a646fb7@siemens.com>
Date: Fri, 28 Feb 2025 17:41:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "Ziegler, Andreas" <ziegler.andreas@siemens.com>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
 <20250224115557.AIFtijeu@linutronix.de>
 <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
 <20250226091752.jCsLqq66@linutronix.de>
 <7cace5d70278f8ae1debe8cb8d392fb3f59291ff.camel@siemens.com>
 <20250227134304.xLBfiIC7@linutronix.de>
 <2d38f77a2ca81a7112ada30b03698c383aee9035.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2d38f77a2ca81a7112ada30b03698c383aee9035.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|DB9PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: f0972911-b19f-4800-350b-08dd5816b6cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXZuSmxrdk13cWNmWC9UVG1GNUdBYzVCc1dkYU1kcCtOSXpyR2lZb2RmVm12?=
 =?utf-8?B?Q1NZVDF4YmZRWCsyU1lZcHI5Um53YTR0OGpobnBhRVhXNFd3TVNZRVlPK3Jr?=
 =?utf-8?B?VTg5MDlpSW14Z2xLcGc5MStHTFcwVzUwb3B1eXFDUXptNTNWQUlBSzQ5Tkwz?=
 =?utf-8?B?ZFhac1BXd1QvaU5YYUxseVc2RzEvdWdSOVRVQ05uNUlsSWlSRHR3dHN0aFR0?=
 =?utf-8?B?RUxod1hKcnR2MC8wQnJCbko2dTViS05DckI0d2Y0eFVWRWpKSFBHU1BxdFVw?=
 =?utf-8?B?ZW8vSThQdHZ4Nm5XdWJvQXpwNUZKY0xFYW5TYkpzR2p6L3dqWU1YdFhRSEJt?=
 =?utf-8?B?MWVLNDN6NWI4RUU0aVhSRExyMFhwWFFoNEpVNVZVNDNDMWxpZ29KU1hTK2NC?=
 =?utf-8?B?WkduendHZ3YrMGxremVHN3M1THgvSTQrUmd0MHpLMXFKL25TMDZNa3RpRE5R?=
 =?utf-8?B?SWQxbGN3K25lLzdvYVo1YU9BTVpqRU5WTGxvS1BSa1VjQTRLTnBqQUhmbWFx?=
 =?utf-8?B?NmhqYUhGZm9sbVlLbWU3UzdTRWpGUHZaWStNZkpVbFNwcGMvTXFXdWtxSkdr?=
 =?utf-8?B?RStCeE5EakNoMWUxbVFCbUZiVUs4cUpUQWltYy9pbTN3R3NvY1BpZ3BFdm1a?=
 =?utf-8?B?MkM2Q29SLyszWE1aQzREcjRWblVISlQxeEUrQnFQc3MrZnpmalh5UW1Qd0lt?=
 =?utf-8?B?UVdJYXo1Z2xFZWhEcHVVcFIyS3VyVURNVzFkRGFEL0FSbFViRW4yU2c0UVV0?=
 =?utf-8?B?ZGhXMWE0RWNjTXlLUDZJRmRKQ2QweEV1dTFmZE12VmF3M054OU9VODN0UzZk?=
 =?utf-8?B?S0J4OEx6b2JFREhFSkt3ekRIM0RKNlBVd2p6WG9HTFh2N29xQ2JDdHJVWHhC?=
 =?utf-8?B?ZUhBZEZ5NHBVK3FtT3QyVGFzZGhNeUVMV1hnTU1IK0Fwa1NPd3pkRWxuaSsz?=
 =?utf-8?B?MGR0N1J5SjE3WUZUNjZuOHhQQ0MyK1EwQ2Z0Z3ZFdkVwczQ0SUY5UG9IenFE?=
 =?utf-8?B?T0NLcHpWTk5NSFlNbVhiWHU4cmsxWFYxVVRGQ0s4ejRTUVF3a0YvM2dOems1?=
 =?utf-8?B?cVd3TDlkSExEeCtiZG1TYitNTmxKbXdOd1FVMTBmaGc1dnVWeld5NmEwcDRN?=
 =?utf-8?B?MnoydWJjT1JabnRQMFVmcnVMMHlLYkR2RC9SSVFuQWhsWmUydUxVM04yMnhy?=
 =?utf-8?B?V0lsSUlSQ2F0WkFJaDdUS1I2OHhpdmpMV1dYQWozOUM4MlNsdXQwNHoxd0ZF?=
 =?utf-8?B?UlUvNXJIRzVZdXZWdVFnTzJoRDVucE5rMkJHWWovdkQrVmlUQnhQZzRNeUN3?=
 =?utf-8?B?Uy96UnF3MWVjMEpkYmg0bUFiWU5xaGdXSU5ndStyZ1JVSTFsa1graGVvRWoz?=
 =?utf-8?B?bGFOQ0o3bWRPeS9yTktOd1g3a0YwOWgvaFAza3hUQmdEZytrMGhxa0EyWDhm?=
 =?utf-8?B?UlZSOHlxTis4RUlsaDlqYTRQcXc2TncxU1RSNTViSXNHblVrQ2xjdUl4aFFG?=
 =?utf-8?B?aDN2V0hJWm00R1Zua1pML1MwbFl4WVk5clZOK2tnOEMrTEVFYzQ0RG1NcGFR?=
 =?utf-8?B?U0p5aGtYZldwc1BWenNKR2RhbGxQY2JESlJBRzAzUVlkOUtKYmVnb1NvOFJV?=
 =?utf-8?B?VmIvalMzSm4xMEI4VTZiVWM4YitoVzh5SFNsWTdnNkxCUGFZVTZ1NXRIUFZn?=
 =?utf-8?B?azZ0VjczYktOeEtkMjE5MXRTS0prLytzdXBsaW9RYmxzMXNQR3I1a01GTm90?=
 =?utf-8?B?WXAwc05xWGtockJvRmVCVkl5Z3RnTXlsMzIySiticGM0TUM3dFRhem4ycU93?=
 =?utf-8?B?RmFzd25HR2YvMTQ5MHRZZEN4K3BGemFJRkpENmdHdGkvOWJHQnlFRUJmaTVU?=
 =?utf-8?Q?sVqSH5eLy5zhM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhRcm5pZHkrMnRLTjZPRXJiNjd2cHJBY1A0bndEYmtnVVZtKzMybUozMW8x?=
 =?utf-8?B?NW9mY2kzVVVaQWRmamdtamg5cG9QN2pMMU1HVjFueDAyMW9SNldXa1RnN2hw?=
 =?utf-8?B?bGthZW1kam1POC9mS3RZV1dtYzVZbUZzcmhnN2g5TFZTY2NlTytZdHl4SGdG?=
 =?utf-8?B?V3hiclZLOUdnd2hGditBUnoyVUsrbWVWN3JxNjh2QUtDYzRNdVJ4dGJMbWt6?=
 =?utf-8?B?dEVFUnNaT1hDSEpFRDF5VmNxejRsN3o1UGR6bmNLSFZkQ285aXAxWE51Q0dU?=
 =?utf-8?B?RXQwRldUL1gwSGNtRzVLZy9ydEd1RmNtSnk4dG0weVBLQWZmdWdNNmt3TXJ2?=
 =?utf-8?B?MlNNVDlHY0tsK1ZuTmRNQ0dyVGZzRERUSVMySTEyWHp0YStpekU5NlZPSVpQ?=
 =?utf-8?B?a1h6UzBqcExXY2o0Nmh5ZEtwczNCblV1VnVOWVhBSCs0ekhvdU81SEdrOGM3?=
 =?utf-8?B?QzkzYk1XbUxMcnZLZm1uMng1UTkybTNjS3dTWUkyTFNXYWlZbHhOajVVU3dK?=
 =?utf-8?B?NndHNlpYZklWU05aeUpxWElPYmJkS2ZuQUwvZWYwcVRsTGRZb0gwVkZ3L1Qw?=
 =?utf-8?B?eXVTbDh0Tzcva09qZmt4R0pJM21idUZHa3dKSDNYTzhoL3B3QklWNlBmNkRs?=
 =?utf-8?B?UUNxWHNFUEUzUHhNN2ZDcDA0ek5JR0Y1SUhoWXAyMjJTQjdZbjdCQUJFTElC?=
 =?utf-8?B?ZVNnMDFtQ2RXbEdKVjBxZUM3ZHNMZHRobDR1Nld1bE9hVFJpUlJCU0FCUDA3?=
 =?utf-8?B?TTEyRkNCcWxoUVBxa1c4WkJ2cWpCOGVGbEdwSExtaUdJdFk5ZUVwNlJ3MVc3?=
 =?utf-8?B?S1pyeFQrWmJUWmNHZEFwWS9wRUtqS0hwa2dBNEFMK2R0bkRwaUJwWG10YU1J?=
 =?utf-8?B?QjRyY2d3RjVMVWE3K3ZxQUJtVHhtSStKdFNBTFNnWWVGdmR3NWRkcjFodit4?=
 =?utf-8?B?cTRWMEhtWFYweEROQmFuVW12eFgzVlhVQzBqYjlJV054N2pHNEZKUklEeEc0?=
 =?utf-8?B?T3ZNYW04SUpITFJuSUlhTmlhdVZ2TDlNKzlZbjUwWXNjbUUxb1JjbmZJN1Z2?=
 =?utf-8?B?QWphLzZ4clpEcWVDUTJUUmhiN0VhUnMvbXBZZVkyRmRIZE5EeUdQc2duZ1hX?=
 =?utf-8?B?b3N3Y1B3cUR5eSs5VkJsWlRaVC9nUVhUNkhOQnJ2VmNlciszR2k1OUxYdmNI?=
 =?utf-8?B?YSt5a1RBRnI1amlxMFd3UWNjTmlha2hacGsxUGhvVXAybEUxbTlIVjc3ZDJV?=
 =?utf-8?B?UTFqTEI1dDBJYytMdm5TOXJpd3p0STVOanFLL1N6RmxodmZxNHlyU3ZmMVRl?=
 =?utf-8?B?bVNTRmVVVTZPdno0NzJLb1ptL0xLZmhHZ1dhT1BiajVFM2w1STg0WVd5Smd4?=
 =?utf-8?B?aEpZcitiZ2dwbDNSZ3AzcksrRDI3bGQ5Qkl2TGFqYkl4VVVJTFhLS0N1WWhV?=
 =?utf-8?B?dElrS00zOWF0MGNNZWFWQ2doN09UL3Qzc3pFR3lkME5BNEVqdTZLSnZpUGh2?=
 =?utf-8?B?d1R6UzI4Q3ZFOVpVSFI5SnhWRjlHTUt6NnJRY3Q4WG10bmdQRkNzVGFPYnNM?=
 =?utf-8?B?RFY2WGRvRS8rVTJnVmZJM0hTVkZDY1M1VmtnaTc0WXU4WjMwa0h0Z2M3elcr?=
 =?utf-8?B?aTlyeG1vZE5ybFhBZDdxYmdVdHYxbVJkVXhTRHFXRkJDbEc2U1RqU2hwRG8z?=
 =?utf-8?B?VHV1R2VPSGo1TUNSOXRqV28yUEFMS2x4V1R6dGdtVmtrV0xiSE10ak11ZUZG?=
 =?utf-8?B?THQxWnRUV1FsM2g3NmNyQ09hcHdXcWlxc1l5YXJaSTlWUHo4RUVtL3BwZXBD?=
 =?utf-8?B?OVd1ZGo5bDlzbkJVWTVsOC9BNGpySHlBUnREVUtPMytpeVhrYXlyK0o3d2JM?=
 =?utf-8?B?aS90aFFiYkYrWEpJeThGQ2d4TmFTVDBJQnNJNG9xTzJHZDJuTTBaSlBIbCtZ?=
 =?utf-8?B?WHB0N01tTStUSEIzUjkvMWxBTWh2VWloaTNMTWtRSDRQcFBQYXZYbjFPZExP?=
 =?utf-8?B?VWpTaVhLTm9WU2RBdmM4WWZsV2NuL3RkWnRmQWpmdUVjZWFxK0JFNWJGV2F4?=
 =?utf-8?B?WWF4TzZVOWtaSCtKZW5HWFd2WnA1RlpVd2lJT2RnWjBLcUJ6OWtKZDFXbitE?=
 =?utf-8?B?SmJCVld1MkJRTXN4RFBDMFNIaHJYZEs0bEgrS1cwMGdKbk5qTU15Qk1kbEhK?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0972911-b19f-4800-350b-08dd5816b6cd
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:41:13.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5TmsiuprMchoS4Hbi6YajJH7IPMkvfKAEMBQrur9nPn9orlWbOLdGNlbJyvRsTN3bKw8wzJbd6myvH9sxHAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6004

On 28.02.25 17:28, Florian Bezdeka wrote:
> On Thu, 2025-02-27 at 14:43 +0100, Sebastian Andrzej Siewior wrote:
>> On 2025-02-26 23:23:30 [+0100], Florian Bezdeka wrote:
>>>> NAPI threads? You have RPS enabled by any chance?
>>>> Would commit
>>>>     dad6b97702639 ("net: Allow to use SMP threads for backlog NAPI.")
>>>>     80d2eefcb4c84 ("net: Use backlog-NAPI to clean up the defer_list.")
>>>
>>> With NAPI threads I meant the kernel threads driving the NAPI poll
>>> which can be activated by "echo 1 > /sys/class/net/$device/threaded"
>>>
>>> RPS is build configuration wise enabled but not configured.
>>
>> If RPS is disabled then this might be something else.
>>
>>> As Felix already reported, backporting the mentioned commits to 6.1
>>> would require some manual work. Simply picking all the dependencies
>>> seems too much for now. Will have a look again...
>>
>> Can you reproduce this on a later (more recent) kernel? What are the
>> steps to reproduce this?
> 
> I haven't tried that yet but after some tracing I have a much better
> idea whats going on:
> 
> Our RT tuning sets ksofirqd threads to FIFO, which seems not the best
> idea. I have to ask some colleagues why they thought this is necessary.

There are some remaining AF_PACKET workloads with RT needs, and NAPI
threading was probably not available yet when this was first configured.
That was at least one reason I heard.

Jan

> As those threads are driving the NAPI poll in my case they might run to
> infinity and with that into the RT throttling - forcing CPUs to idle
> with softirqs pending.
> 
> Does that make sense for you as well?
> 
> I can force the system into the same situation with threaded NAPI
> enabled and assigning FIFO to the NAPI threads.
> 
> FIFO for threads driving network RX traffic doesn't seem wise. A DDoS
> should be quite easy...
> 
> Florian
> 
>>
>> Sebastian
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
