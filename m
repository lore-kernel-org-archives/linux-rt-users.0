Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE722B8A0
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Mar 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623643; cv=fail; b=N1Ff1xnYC2hIqr9ZOwJHJyAobj/BjgUqi/6vNk1J5NtVVX9qHgkFiyVtKJFcjMa982+yoFLdgttX2dwttPex6jBMPwuEfOZfB7T1VFJpB20RDpFKBk6gKWujW9Q2M8rt3/wRbrrPiS9EiRZJb4UICVHmktxQGSyLRYoxeCRaMyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623643; c=relaxed/simple;
	bh=YndLMFtkcpGBiHpdSYPn6yhZ6a+FfcvkpIT0ZH9KtzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFT6zhpv1kHTad0HyR7Qm9z2cH70Orf5B1L7z2rrD7Qp/NQlWcqKXsA/nrQgMXH5NTKz55XlxNBqzMUZbUq2peiNC5zvUg/UHBopM9VHrX8MAYK0bESLfyWtIoV7XNi+7uZsylnqqQxtrhlQTy1+dvrnVGXHVq42echcqLFKXR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vCM4iNbL; arc=fail smtp.client-ip=40.107.241.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vCM4iNbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3TEif6Kw/3e4qnIpSei6knDI4wtull+ccr0qWg0bFnnZmelceef0FqVOmTo74EdtZnjbY0yZEqCovlzPZzfq/4XLoIfpeMMZ2sy+UDVbinyzmSHMeMeGrHCDRwJB90zUbFqilzZp6ghTmEhEY8brZ4VziHaSHVCkb4XzdUpguzh27blaQuWaiWsiLbR4lWRh1KkceQYa1uMbJ+WIF2npq2r7wlzW+96DG5Tfe6jaHSAtOU4OEsGiwXOvp9gPqRVHjpoW5PlswpWPxu3zAK6qrwtN6M7HvbcQwtjVu1wcW65YvZqU3kSBncyfA9XIPUuBUJQ0uG0wtGugNot9Qyflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig5h3nWR1vDO9MHI/SXzPWdFJ+/z/7TqCa2FgaSOKeo=;
 b=A4KkscavfYkM7Y3uQN3YiFBJGJng7fJzOOrS8/e7EY6Az4pIGdYdIvkWTbiJxN+GXsw/C5UaoPICJCFuRroMGKfQBvLBjIQ5+m72ufAGWT7uJN+5gFsHOfrHoq2QW0QGiiHNUXJo+jKw849RE93FbwTPaVWjzUYvdXfHBRcbDE9j+qgBJe07cXOF8iFUHD6p4iHQMDcJ/QHZeikQ+x3Wx3+xwPkMEOmthP89kpLikPwlm/i/ku067uAJqAdXujm/Z9Pt+nmbtPvf3C2cYZZHJ2iGsQfH/A9cmOVUbWFPmtNSjlAC+9N+H9Csvcdu+fR2u01atoLV3vec0HrbRqa6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig5h3nWR1vDO9MHI/SXzPWdFJ+/z/7TqCa2FgaSOKeo=;
 b=vCM4iNbLFp/Yx37k1ikrDO2Rq+m/r4FvDWpZLr1pv7SqQP+ChJ5lV7mcMLJcfS3snyb5cxKq9oNvokeUEC6yqRApI2e2HvdPuV5hU1pnG6D3ksA+j2zmdC6qQB8Z1fhPGFdFIwI0McJTOF8l8zAGkPxiaHcc357Fc59QtdQCXt68btujKdMZm7q9GcpUhcFSen8bbVJ6sgdnoUAs7vHDZC7klgiLztFvcTFfZ5QNLYzCQiNIPchMqr6y9ysHajx7Bojg0eIlc8jtGxgP36CU8n9/P/XqYoqAZ4HNJHkISqfR8oGu81pC0CGu3JVZn5S19NEq+di/Z6XwqI1uYw0N2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:20:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:20:37 +0000
Message-ID: <f7f2c5d1-aa7c-4f70-95b6-a771ebdc57cb@siemens.com>
Date: Mon, 10 Mar 2025 17:20:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: NET_RX softirq work in ktimers
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Cc: "Bezdeka, Florian (FT RPD CED OES-DE)" <florian.bezdeka@siemens.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>
References: <30a9c98bc11b40de720e1f7462302243f7c8ffb7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <30a9c98bc11b40de720e1f7462302243f7c8ffb7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 834b8557-8130-44d9-5864-08dd5fef7df9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTVQUHdBbXczZDhIYVBMZE1PbE9Db3hhQjNzaUlEcEtoZEJJb25WSTh6ZGlm?=
 =?utf-8?B?Q1ZtL2IxTTF2ZWZCdkR5TStjS0ZVSU9ZTVkvcGlsY2x3VWFDRWppaHFueGpL?=
 =?utf-8?B?MkVYL3VIdXZzWnhmOGpaaU9DN0VGaWUvMWU0RkhZcU9XMHFMekYxYnhKQlZD?=
 =?utf-8?B?b1BGN0gzQmc2YWtBWityWkp3b0lLMjhwN09hNDlnSHZJS1ZWMlJRS0JocHp4?=
 =?utf-8?B?TDcxU3lIV0ZqMTRNVVUxbjhyVUpZaHhscXhiYlduZWY0UEs0ekdyZENWUERw?=
 =?utf-8?B?aHRBdXBmRHVmQ1M2aWMzaTFldUM1U1N4NFRRKzYrMy9JQmw3dGpPWDNGSGFj?=
 =?utf-8?B?Y3plWWJDYkkwd3I0VUw2N041b2dvN2J1cnV0cHhaNFRYSlhzSS9OcVJxdTc3?=
 =?utf-8?B?ZkhVQk9PdXJDRzhpeW1MOWl0NjFZaUpJRC9EUm1GNmtRT1RLSVVsRVdqWDg4?=
 =?utf-8?B?RlA4S0g2WFM0R0YvSDY1QzBhTU5ITVl4UE9ZV2NYUlZGdEplK2FUWVd1QkdG?=
 =?utf-8?B?MjVDOVBPYlRYT3p4WlVkRVp1azV1aHVOYW12dk5uRlQ2amtQc2p0VU53ZFRN?=
 =?utf-8?B?TUJ6U3YwWHMxR2l4SjBjR25zZmtVQnE1bCtzZzBJNGp5YXpTVGFiU0VvaDBl?=
 =?utf-8?B?N0p4ekdFazBXSEZ1QVdnR0xmQm5MV0t0cVE5UFBnckNoMEt4Q3BTRUNPOXFY?=
 =?utf-8?B?MkpHOHE3eDVjY21HcjB0VERXcWtyNkIxdGZVNXRPSWRjajI4R1hHNEk0SlRR?=
 =?utf-8?B?R1NNRWcwMm5sMGNzelJtem9JeVRENHhMT1VmbTlESS9EdCt4eU5mb0o4akNr?=
 =?utf-8?B?dkJ3UU1zcTMrSElVdHJ2NDVaUWxyaFI5bzZCLy95K21kSS81VEcrUDVmTE1L?=
 =?utf-8?B?VVhidDlHc3lUcW9NYi8wZE05Mi9rT3ZxTW9qS2ozWS9halZ6cUtSa3paM3lM?=
 =?utf-8?B?eTYzSm5kU2J2WlNjd2MwSk9aZ21qL0FHdHFDZmoyam96VHMzampROCs3bDZR?=
 =?utf-8?B?WEZzYWJkcDcwd0s3OGFHSG1iamhQQnd4ZVlkaE9XTVdtYkpHbXdDUkFYZkhR?=
 =?utf-8?B?MUJmNHRpSkFXRXhyNmRXbER3dTFCUHBkQ0VBOWZ2RnVjUUtoZGJKZHYyY0hW?=
 =?utf-8?B?QVlTQklXVkhjMDFEaFBaaGJkbWVlV1VJYnRpY0dib2xqeE1yK1FGZHZNa1Zr?=
 =?utf-8?B?MWdIckVSYThaOG03eVBGcFFKUkhEdW5JR053b202QXRsejk5RkFHdFJFWndN?=
 =?utf-8?B?aFUyemR5emxYM20zbm5Ed3dvdU83T25MaExKMVh0OWZxbGZJRm1QTGlxeVJH?=
 =?utf-8?B?S3ZMSFZqcGM1ZEJ4VGFYTlRhQXg0bkkzc1lWV0VSODRUNXkvZkYzRG1zY205?=
 =?utf-8?B?YXZJenJvYTlteE5pVlRpSG1aTXAyZ0Q3ZDUycUZ4cmVBMGVCM0Q5cDBCbkpp?=
 =?utf-8?B?Vi9sTFRUNkRqd2tZVFo1L3UvdlNTMkcxZ2lUZzgzWEZHVVNMVGZUUjFtRTQy?=
 =?utf-8?B?TW1USTB6SjdBWUJUcXA5VjhHVklJUjVib3VUNzBGTUZWbHRzc1YrbytUQllH?=
 =?utf-8?B?ZkNFRWp4d1ViMGRyLytYaW9zYWlLZGZTb0haVXVIREN0cUVWNjBJN1p5SU5U?=
 =?utf-8?B?R1p0U2U0UFBRYm1UcjNZK3ErMGY4UDNXVEtQdFI2Y2Z0NUhBVFlER1QxNEk2?=
 =?utf-8?B?ckVwSUJHMEtlbkRxZmNiNTlyejhFVnJBeE9ja3RaTHVpY01vTzdsSE8rWG01?=
 =?utf-8?B?SjMrY0UxZjQvRnNYYkFSZDlOa1JpZWdjeE1KZjhTVllGdVEwbHhXYjVZS2E5?=
 =?utf-8?B?cDRwZGpxM2I2clZFMEJ0b0ZMaHJTemxXUlQxNVM3WVE5REVxTzBvdm8zbHpi?=
 =?utf-8?Q?wgJm7t+DDxL0u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZPVXhtUGU1RDVaMUtObW5BaHFWZ01US1FZQ0pVUTRwYUhBS3lGblhYT252?=
 =?utf-8?B?MGYrMU1PSnRFRVFYQXVEYUJleHRGeUJOR1lTSmQxWFZNSXJGVFpqYkhORWY5?=
 =?utf-8?B?d1Z1ZjRHVlNQcUROV3BSaTJVZFEremlscThVeE04bitMdmdWc2RmelBicDAw?=
 =?utf-8?B?VkorZGo3aTZVUEhCY1MrWlF1d3FUVnBLQ2szTWlLQ1hJRDNWTk1YRXFEYVNH?=
 =?utf-8?B?YThCejBKSEp5RjlsQ3d5K1pSN2NyWXdla3B2WlYrendtSWtNVno2eW5aWGNt?=
 =?utf-8?B?bFpSSHdhSFpXVFJqQUV3UURIZXdYaU0vcm52dXVoNlNtVmVjb0d1YnA3OTEr?=
 =?utf-8?B?MjNCczJsSHBramdOQ3RiRW90Zk9XVERabXFkZmJEZHRyeHJpanVKNGF6ZndF?=
 =?utf-8?B?WEhqU0FvRkU4b1JUalZPYW5mK0lEcGNuaHVXdzFrbFVxVEZwSWRIeXVXZStT?=
 =?utf-8?B?RFJld3Y3RnkybWgrTXNNM3V5RXFZUVhOM0ZrcU5WUUdOeHBJMEU3eFJBOTlu?=
 =?utf-8?B?MlpBLzVNbjJzUVlEcHlIajBBbDR0ZERSRU00OHhnOVZ1OTUyK0pxV0NDUzdt?=
 =?utf-8?B?WFNJMWg0R0N2ZFJxd3hQWW9xZEtoU2ErWllWelM4MHI1Z09BS3lUazh3cVVn?=
 =?utf-8?B?OUJHbTM2OVRrdWwrMllHai9QcjR0S2twUE5kMnZoN3BFSWY5RFowM2ZwMEk4?=
 =?utf-8?B?S1YrOXdQcGtiSnBQMkhEc2JmRTFPb01xZktsbVkwTXNBaGNYOGp5c1JqQytV?=
 =?utf-8?B?cXhHZzhwcnRibUdZbG9BZVZYNWg0TGd6TmtwdlpCdEdKaWJBUUFqZTA2Y1cv?=
 =?utf-8?B?RjhVRXI4bjRFaHVKUTQ0b0M3cThMelI3RmtRd29WNGF6MWJuenc1ck5pMHp1?=
 =?utf-8?B?UjlMcUlsTGRMckk0aExUaERES1NJVHZTTnRXV1E5N2FMOHZNNjFIM29Tem9L?=
 =?utf-8?B?cWNFdzlxMEkyTFFLdmhsTHBYKzFaOXFnMWFWOWRkVzVVL1gvOHBEbHp1R2kv?=
 =?utf-8?B?M3ZQWFFwNUZ2UkJQL2hlK0xreS8xQWcwV1RDMm9pamtnOFo3Z1NsVHdoZnZI?=
 =?utf-8?B?NitKK0JYWmVJdmRRejRZOFllZnF5ZmtQcDdQNE9HNDFYRlBUVjFBQmFKTmpk?=
 =?utf-8?B?OFR6WG5UbmU0Q0V6ZHpQdWtxeFZyemJBSHNhYjV4Q1NQdWxmNXArQno0VGM3?=
 =?utf-8?B?ZW5NQVpub0hWU3UvNXdUWDZvVkNZa2VFZ0ZEdmdwRTc2akF4NlRzbXVjSVh1?=
 =?utf-8?B?UTI0WTBYeXYyRG1NYkt6c3BDUkNuRzB1Smg0R2hmZXdmNWpiQ25pSWErQllL?=
 =?utf-8?B?MTlqcEVNc3VNY3BtTlBhazMwS1U4emdkMnBoZ0R2ZG8yMEwxNnZObk1ENlh4?=
 =?utf-8?B?ODYyQllsOHdIbVpjcGVhcmJIV3RiRElIalJmVVNCWG5wc3FrL29BdWc2b1Iw?=
 =?utf-8?B?N2xFeklDb3J0UU56OW1tOHdseVNKbEVkMGdEaTMvYkpDUlptSC9EWExyQS9r?=
 =?utf-8?B?NHorYVlCZGJ2QTJ2bzVJZldMTXlkbjZWWVFIRG1mR2NlUW5jd1RzQzhONnRi?=
 =?utf-8?B?SEdJeEF2UXFFeS8vR1hwUDB1SkkrUkpidEp6SEl4eWY1aW9PNllGZm12TUpw?=
 =?utf-8?B?YmRHMHJWRFVFL284cmJ5UXRrVU15RWo1eDdKWGZWWGJQVitzNENXZlVQcWsx?=
 =?utf-8?B?cmhreVlYbzk5Vk1aaVVqVjFDMDVOT3lpZ2d2KzFPcDI4N1F1b1FYcnU0VFdw?=
 =?utf-8?B?UUVNRzh2K2lrSHBxN05YTk9RL2NTZXZ3YWorM1FQUCs3ZFkyaVQvbGFLVFRZ?=
 =?utf-8?B?cDNVOEFtT3ZZQ2MzbjlERGlEVFFQdWVwNFBLdlFtbUFMbzlXQmcvR0Y0bjlt?=
 =?utf-8?B?eU9WRyt5aktUbEw3T0JBTkJuMXlGbGxPRHdOMDgrMU1ZN3pHQVJlYTYveVJN?=
 =?utf-8?B?dnkvL1hxeDYwdWl2b0c3dHJ0K2ZBQkVyUktMS1BWRSs5MktoTkUrZzBlbk9P?=
 =?utf-8?B?c1FveGQ0WEVjQ2J2QjkrZ1VLM2NoQmlXN3JRSGdtQUp5SE12ZEZITUZEZFVn?=
 =?utf-8?B?bUI5cDRNNkNWbmVoNlRPQmVrbzFFZ3dEQXFIQ2EwQm5hQkZmV0RNdzVsTHNj?=
 =?utf-8?B?SzE5QitMNDZOQTRndzh3U05nZ3JIRElncU5mZjU4REtONmtXUHFMYW1abnlz?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834b8557-8130-44d9-5864-08dd5fef7df9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:20:37.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LzX71Tw41gVKbL8xQli9BbZcQ2kaLwBRcOW1pSUzD4rSck2mCqhQlbODUPXB/1ZGsHfjvgTuwNGWNJpqibxYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6820

On 10.03.25 17:07, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> Hi,
> 
> on a 6.1.90-rt30 system we occasionally see NET_RX softirq work being
> done in the ktimers thread. This could be related to running ksoftirqd
> at a RT priority, but this by itself should not be problematic as PI
> boosting can result in the same priority.
> 
> Is this already a known issue?
> Does it only result in delayed timer handling, or is it also
> problematic from a functional PoV?
> 
> I quickly checked the linux-next tree, but did not find any fixing
> commit.
> 
> Extract from an irq trace:
> 
> ktimers/1-29 [001] ...s.12 ... softirq_entry: vec=3 [action=NET_RX]
> ktimers/4-53 [004] ...s.12 ... softirq_entry: vec=3 [action=NET_RX]
> ktimers/4-53 [004] ...s.12 ... softirq_entry: vec=3 [action=NET_RX]
> 

BTW, the reason is because ksoftirqd and ktimerd are sharing the some
softirq processing loop. run_ktimerd simply merges the so far separately
tracked pending_timer_softirq into the common softirq list before
calling __do_softirq, thus will also pick up any other softirq that was
or is going to pend while at it. Looks at least suboptimal from a
ktimerd prioritization POV.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
