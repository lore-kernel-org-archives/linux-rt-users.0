Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFB28488D
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Aug 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778304; cv=fail; b=K5g7bzQ9Uh1MOqsymHeFGBIw+EX6nYXOBzFqI9GlrUxjpQAwr4iU2uV2YMYADc1srcCfLDReE9EkR4//CO2C69+wwyNlckdgBodc0uJMPOK1nuQnr3A6ZsLJnh+zKOhC598U/6FVkhASihqv9FYJT/eeeLCWuDTGOEmsZ4hFR8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778304; c=relaxed/simple;
	bh=tqISCKugkWoBfKiljwjCyk1z5tBAf7i8slqnzt0JMG8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NaxASx6COrMYiSXbYvx8aS5ZpCZUbsWHOGv1QZpsCOwZCiPgRk8U5u9TNuutStwx2vQt1my4mBxYoGhyy8hmkxoYrhlR4T3bgQlv9NoEADS4TvjFS72PJDjChXWfuuTseTf7vSJH13lxPhcFNBsiRJe1Ry5YTzwaEG60l8x1WkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wpSr7L71; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wpSr7L71"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHGjjFfMm3po74qfHgjr6RgZ6KgFfPQdJ2S4JimAXnyCfyIt/hn+5NhRB/ZqkSIkjom0AwPb1tVRn5pOQbKCdylkPXoQcSPgW7imCeQSJMXwt49egnotjpsR43y2o7Is0ZXXK1EpFpGgOFVy72YQZKt7PPHj7l371xM4eOTjsRr4uS9kzaLcVOn+YowKW8zHWEiMIoHYO0ne3G5aDJtR1Wp3wTcHD2idtHGKvw+4WgJZx8u2yEcoOTSojoCY5TBpGgxoh6wNQa9DBFdWvMrwxThlIrHh1Nzuq/VVmXd9DPvEQVK1GZfqc/xcOXtDsW8/FPaBm58DAMUAe6Jvrpk+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENRNEcMdT9SxkaQLtsypnkZIpFFs+U33SZAu3jVoi9M=;
 b=T+bbYHzxW9de3p9KmOtuQmzYMtkeTx88yyBwlsIpDCbczdsiUwqEafqAMRA1vwPNcJrNJDlTtCthIL823RyoexBPSe93iEYQ6MgrGSUZkQoWTf58VSBlT5B/FGqaUasu/SR9z5YZ6Z3YdM8AEsbjBoXU5Yz3BU4PUE5erhfDfUSjRXkUdreVvYsjdB7PPVq5Cz9MugYzgvA/tGZJI7ChCcjtvP+RKuDjh3A8zff0UmtrWqV2BJ4PrClYWM4T0cvyojxnwWDhFRwI725Bl28W93Egtbn5UieQzy3dMpGj47UI1ejEjH0VQvaDQhSZ0c3VXTK00pPRNFT8crPlyGwf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENRNEcMdT9SxkaQLtsypnkZIpFFs+U33SZAu3jVoi9M=;
 b=wpSr7L71mbtFVjOhO9CxFpvgRH007E3aqPAJoPd6awwf+eub8iVJ76XYyzwihpcyXlkG4spVNPpi5oruYkb7J8tB2G7buRcD90378z8f3DUfABOT9pOkUmk2JhFYoll3xNVsAC4WzwuiE47n/d/b93NRuVMqjPL0wxFSauj78lidb7bZvofIlO1AsC7E3y+vvJfwnav/cdDw5KiOPViKwcklcj4ou7Y4mtz9TpUpokyu8scYjeo2rf0AFxzOsKoifJ9Eyiy4M7q8g81at870iVaSPEMuHHO8l4g3JmRL4IcYCM4bakBLCFZpzBdsx7f18ojexwch2XrPQCu/wgJIng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 17:31:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 17:31:38 +0000
Message-ID: <e077e665-0221-4bd6-81e3-c7df9f3dff8d@siemens.com>
Date: Mon, 3 Aug 2026 19:31:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CFP Open for Real-Time Linux User Forum - October 6 at Open
 Source Summit Europe
From: Jan Kiszka <jan.kiszka@siemens.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Jan Altenberg <jan.altenberg@osadl.org>, Min Yu <myu@linuxfoundation.org>
References: <020538a3-4a09-4b16-a3f4-5bc09d65b5b1@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <020538a3-4a09-4b16-a3f4-5bc09d65b5b1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef8296c-0266-41fc-5061-08def1851311
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|13003099007|55112099003|18002099003|22082099003|11063799006|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
 Hbm4djpnNYQfkeoXg63kwJkBVZPFRvA7iiB9EzURmSgjbA4TThdLiksj5047/vctE2xSOlaP70fCGEo+/Y5Oj36Us7VCnT/PuEJJsUJUt1pFTX90l28ymj4vXqX8tIabVJNnU9qdovacIIcIMTkjQ9WV//q31xYO2pklylP0EwUMX2m7XzzR07W+00/bOd8xOQRBwVuMHo4mk5298jSuV3a/vEw4Nsc9YpHNt5kFqttEJ0AHyq8rnfJt+RYLfOyqQwMKQmTdj9LxYz55203LChLtZoYgKgc19gnf/CahLEdv5QbqRiXh6e2COdGj89Z/US5yQ6xkuhkFRHwrStfvwQe9j9qsh32zaHs3rmKPaAbuxVGftFusyD/NZ+5ecZIXQBuTudF6hxUlDVGEzhPPNM/ALWpdONN5svz6/6B7LYBB3vPAqLrvujqUFA4bRfCFvP/Py48fZKbPvDGy4lTLykLDuWQQ36TJx8U9MBRHS5hL9/B42ss2KNT8Y0qkC93HUvccaeG7o2hVhT+VEiq1Gmc6S7UGqJn6ZJrh1MSgaX/xw1KCAuCYd3Taz5DtqkKCiPcwQAfXNT4mn/r1DFvzrfEbRV2aWdiDkVpt4lSpc+A=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(13003099007)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T3RYZGVhemZreUkxbS9Ic2ZFWjR1YUNveklabmVWMUxTaVRoWHhsaVdvd1Fs?=
 =?utf-8?B?SmdReDUrSjJGU2YzQUpWRFpxRzJDVmk2WmVuVWYyODFheUEyUmJIa3Y5UUNz?=
 =?utf-8?B?U2tlaWRvY3FNVjAxZ0xFQUhZUmxpK3JZclFNcU9kbEFDNWx3VkpGdUZMNjBw?=
 =?utf-8?B?RGZ1ajZ5MEh5Q2JydmxMc2VmVElnQ01jb1piSjNXaHhIak9vY3ZCMjFOZGJJ?=
 =?utf-8?B?dExNYWFjV2doSWZFaERWOGdvZkxYclA3ZTV3cGVPR1k2STJ2eWtLNkFteitm?=
 =?utf-8?B?empVSGFvbDNnMkJTVm1aVlpOMlQ0WEp6VlRUQno2S1U3d3hCdmhENWFhckZX?=
 =?utf-8?B?djlZVmp4elIwRUw3NlkvLzFTU1lzNXNtWWxTUXpwcCtZa0MyZmV6ODFzL3Vr?=
 =?utf-8?B?dnVEQW5tdHM0TENDSTRYbEVtNjFERDdZZjFJY1hYTmo2WmJmTGtucXVOWEpE?=
 =?utf-8?B?bVJpV2dzQmNNOE1ZMGpNN0lxU0o1RE5pdkdJRGt2SmNqVjFKZGNsaVA4U0pt?=
 =?utf-8?B?bWdpQkZmT3VaSm91V3U5eStyR2laM3dtOFhHWGV3YUFFaWlINzRhMHQzZWND?=
 =?utf-8?B?cFdZSjRKbUtzaG9SUEFrWk44Sm90WmNZVldLRWFoWFZsc2d1WmtiWWc2dWRu?=
 =?utf-8?B?MzV1UTJRY0lBSVBCdmpBSG0wb2o4bDMzQWFUL3d1UHZvbFJKWE9tbjBubWdm?=
 =?utf-8?B?ZUNMTzcvcVRkRmIxakhrdkl4c1VRWHhoQXJGcWdaQ2pTNWNBelZqTEkrK1JF?=
 =?utf-8?B?VGtLSHE0QWc3ZDB5QUlkUFlScHUyWGNtb3BWQVZJVENKbkQzd2RmYVI3VTMz?=
 =?utf-8?B?STlFNjZMZll5TG1wbXJDL3Y4WnVDYTR0R0s5Mlc3QmIyNTk0MUZMd0NjRnRZ?=
 =?utf-8?B?NjZKRXZpaG1IRXRyY1I0R3N0TWxMQTMxTzVob2V2MzdtZmxOZURzMTZVUCtX?=
 =?utf-8?B?UEt1R3dnOFFldkRtZkN0cVQ1VjNDaVRBUUpuRHJBeWk1bnZ2K2JObVNKVGJB?=
 =?utf-8?B?cllLQ2p3QURxMlROaUJmY2w2TGlVdFczam1tV3FNTWZGbFpJNnZreG1Vb0xm?=
 =?utf-8?B?TkVBam16NThzeXVjL1RYQ1MvdWdwU2JvbkppZnNodTJKalQyTzNuNUVDRVBp?=
 =?utf-8?B?WEhWc2lOT3dvdUI0SkdiejBmUWNaSWR6dEtkSVprakhpYjk3M0RiNlMrQWpa?=
 =?utf-8?B?Rm95RTZIR1dtNWRnV0lKb2hha2hsbm1aRGF6QUdDdXlQbzVNbkJ5eXl5ZXph?=
 =?utf-8?B?SmV0R1M2TFlWcm5EYVA0TFhLSWc4Zm5LcXJpdTRwaWV2UVhnZTlxaVREMUtz?=
 =?utf-8?B?dUIxdXVxUlFVWlNsanJTZElLSzVRTlpmaU5sV2t0enpMdm1jWnhwZkNEUCtU?=
 =?utf-8?B?QmZLMVZvOXJ4U2J5czNrc2h4SkpWeEkrWnNVY1lseHM2aVpFajA0Zm1GNFA0?=
 =?utf-8?B?R241Tk1UQjhKREVRaDlHWTRTWlJLYlFzNEdnaFNDMC9WVGV6YWp0SFl5VkFQ?=
 =?utf-8?B?VnF1WkxJRGphczQ3cEVNblV6UDF6YTJzSWd5Z3phRFZ4eXNVU3krOXBNd3Q1?=
 =?utf-8?B?R016Yko5SlVkR2ZHd2Y0MWRJY1I3ZVV3SUpZTVQ3OFFGMzZodkdoQ05ZazdQ?=
 =?utf-8?B?eFlqOTFOTmxLM3Fmc2hxSi9mZFdnWTNXZXlyUkR2SE1iRFRBaVR1Syt2Mk9G?=
 =?utf-8?B?ckJyWkR6eXVJU0xvRlJCeHBSZUZXMG9nck5qVDFnd0d2cjJsOE0xR1YrakIr?=
 =?utf-8?B?eU5IdXJyS2M0QVVIVXFSRXJtczNIbGxkYWh0SXRyQ1c1dTVkb04rbmFmUGdF?=
 =?utf-8?B?QVVxdTc0WVZOdDMramU3V1VJZmpKVUwrcHNYVzBEWGlNdlVzdENQQVBjSDVo?=
 =?utf-8?B?N09ZVTJsZG1hdldjVzAya2xtdFl0TGp1Y2h6SmtiVnNtZ2cxcTI0SGtrQ2Rz?=
 =?utf-8?B?ZHFWU0pGajlqbTYzM2xqR3lLK2t6VmtjRzdaZWtSWUtyTUxlOHNtUVp0SkNw?=
 =?utf-8?B?SUkweW5mbkhsbTlKUHNrdjB1a2kzV25IMXBFT040VHE0Tjh3NnlKK2VCMVhs?=
 =?utf-8?B?a2hkYjJXeWk3ajMvSnVBSHM2NHRQV3JFRjdpeGExT1BzSUhOd0kxUWFNbnFY?=
 =?utf-8?B?Z3RtbkpTclVxRWYwbmtIbXBRZXpQQytvRzAydE91bEVVMm02OUtMUHNENThD?=
 =?utf-8?B?Wm1HV3dnQWgxY2lkYnA5aHBCWXZEcnpNenV0RW0yaGhjNHRZY05XT0lmOUJB?=
 =?utf-8?B?aUVteWRTUVNERGtwVWt6b2lLN0xJbVNnUndiaFh2ekNSU2ZnbkpxdTgrUkMv?=
 =?utf-8?B?M3RkelExRkowbFdnTXdjblZSRW9IM1crUFhURW1CYTVjQkx3OHp4QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef8296c-0266-41fc-5061-08def1851311
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:31:38.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRVt56yXboMQw1ZoJNVCk6Vc/QDgE8ypfJiwP6gaKStoNN0TcEoPHFX9KGEIFkAJyCrw1HX1vBDeq9tRdA6oYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8309

Hi all,

Just a quick reminder that we're organizing a 1/2 day Real-Time User
Forum https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#real-time-linux-user-forum 
on the afternoon of the day before the start of Open Source Summit 
Europe in Prague and that the *CFP is open till Sunday, August 16th*. 

We welcome RTL users, developers, and tooling experts to submit a
speaking proposal by using the Google Form here:
https://forms.gle/iRK48ACWnMatihg59

Additional details about this event can be found on our website
here https://realtime-linux.org/event/real-time-linux-user-forum/.

Please reach out to Jan Altenberg and Jan Kiszka and me if you have any
questions. 

We would appreciate it  if you could spread the word about this event in
your network.

Regards,
Min, Jan, Kan

On 20.07.26 15:58, Jan Kiszka wrote:
> RTL users,
> 
> We're very excited to announce that the Real-Time Linux Project
> https://realtime-linux.org/ is hosting the Real-Time Linux User Forum
> https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#real-time-linux-user-forum on
> Tuesday, October 6, 13:30–17:00, the day
> before Open Source Summit Europe in Prague
> https://events.linuxfoundation.org/open-source-summit-europe/.
> 
> This 1/2 day User Forum is intended to bring together PREEMPT_RT
> developers and tooling experts with users who are building products and
> solutions with PREEMPT_RT. It is an opportunity for users to
> share real-world experiences, and exchange ideas and collaborate with
> developers on the challenges and opportunities shaping Real-Time Linux.
> 
> We invite you to submit a speaking proposal highlighting
> your user story, implementation experience, lessons learned, technical
> challenges, best practices, or innovations related to Real-Time Linux by
> using this form: https://forms.gle/iRK48ACWnMatihg59. Please note the
> following timeline:
> 
>   * Deadline for CFP submission: August 16th
>   * Speaker notification: August 28
>   * Schedule published: first week of September
> 
> Please circulate the event and the CFP widely within your network and
> community.
> 
> We look forward to putting together a strong agenda with your support
> and contributions, and seeing many of you at the event in October. 
> 
> Thanks,
> Min, Jan, Jan

