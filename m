Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B026157E;
	Wed,  9 Apr 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206305; cv=fail; b=PgLxVm9xARYwROTcddiXBAlOfj8XdlsdaEecQxsDVDarF1tm2kssbRb0oXAP+0kBdHs8jlkqsaf+Moryh3rGJjqbblMog6XVlFiuGeJxnT34GzFLjjhvyPqsPUkCq4DycDCngZOt9L0DnUQ1Cnc1hiRYCm8VGtfB6JtzZSgTmIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206305; c=relaxed/simple;
	bh=7qiXjWQR3OBSmHnKwxcP6g5U2uIHLbv6xGpnlx7EcqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kdq647QMfDlvglzMgmW6u3qLUxMNC0/GOCplTAc0bHJGmhvpzOCaQ75t+UbnSsJXerZ1Ux3/UzkoLP18t6QVFJwLUmiCmwaQ4UIJdK8dZjYiwAZmpQ4CN40DjllJfa76Y4MHx2Bs7dmjc0Z9M2N93JqflYYjsjUYGgozPza/0Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PYMkAjHG; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PYMkAjHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua7T+mEMMboLIPBzKkzwMitVTY7L3WUTWKbE4xtE8NsDJS3dK3Urxx2++tAUtr14mxODqVhTMwPtHqRG9EkeI/isx2o9CCJ1ZusYsAFGczQDSiZG69Vaq0ByLCPr+1gd/sclFe1hjBQIr9wuSsvo4QTJrTc4EUSsUXIgFE0lyg27CKMQzpP9yNG2CtQ8NWgzprrVDttTi4s9ygbT3ygoWGLMP5eQBhhxOhipmbkhqANocgSVyBIEk4NasOwCm7e5n67yh71xxPHwvXOwfop8wCadBu5KsMPilHgc1GvNwCGCeGhowDlrAiPoR9GpY8/Ggws4iX/v8YXsp9dp+hFUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOqOzbGr/A3NMFCRyhvQrJT+er3HPUCjBO6Cei9Mbvc=;
 b=XvnHrQv1Uzx6GmwEZMnI+T+7PQuHOf6JfLP8Yrcu4yRicpg+KI0N79ZGEEMEQBL959sqLKGkmr97uOrscuvF28TqbBcVSocqF9myjTde6eL17NdIS4ei5Bj7ek3yKkHcp1rwKqGddL6Q1iBkHdNf/lh9oRpk7DmPHwT9rUI/XALLVcOpY19fYhmqg/xG4DugTNAuTBjIa8k0jVSLPlPexD2aCi7nOwHaoo4d4HKRVWJjf0NCdCGeXMmFfq3qXejAgCXvvvEeCv3tfudDlGUx7tUGV/pIqXFstUYcz6IVBqyLR8NRofrgFB0EiAGsQ96B+r4FPdHl/tLl2Y1S9vwdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOqOzbGr/A3NMFCRyhvQrJT+er3HPUCjBO6Cei9Mbvc=;
 b=PYMkAjHGFT5ocGhuRrvPkUrOku2RZxDryFcOuTp4EkeUw0wgFhAezxhGpcdqFhe9OtttM7m2gbOPwGt0btbPKMNIOl5KbZkVa1PK+ekc6DMhrHRMSyszEZi7aVd2fEO20eSFNa7Vfny4jFZWVEaGliu6iFqbSIX4BTTvqhON28zJwTIIA9NHSHWYDXpQ1HxVUDX0fw/l33RIyHqGmruhmUv0+oYwjGJaRlFEopDyWAa50pxGG1713fz/HLsVo6BkkXf/Jk30EMH+pBnHeGtPUkCx/DQRaq4krtpcnQF/x386wbOexVFCwmmgV+lmVpGvLeczu2rms6//RbubGRPWUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:45:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 13:45:00 +0000
Message-ID: <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
Date: Wed, 9 Apr 2025 15:44:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Aaron Lu <ziqianlu@bytedance.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Andreas Ziegler <ziegler.andreas@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250409121314.GA632990@bytedance>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bed376-c448-472e-2318-08dd776cb8e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEYxcHErNjE4cFNYazdHVFlnbk9PdVMzeFhIemozZDJDMGh6ckdoekFPMTE1?=
 =?utf-8?B?cFBSWkNJUXZxQW9jeHpUcU1QaGZTWWM2UjBCQnNnMnNhQmZCTkZDcmE2WmtF?=
 =?utf-8?B?b0ozNnlCS2xJYkI5cG1kZHhsYm96NTdjbXdlaUg3cFVIU051M1VnK1RmSmhh?=
 =?utf-8?B?Q2Q5c0ZKT2VPeEhmN1dUd0dsaWJZNk5RZGtwRkcwRUV5QmE3WGNoeEJXbDYv?=
 =?utf-8?B?a1NxNkZyUUZzeEhPZGRjSWtpUWI0UDFGQnpKVjJJT1NnVmRPVi95UHU0QlZV?=
 =?utf-8?B?MlRIVWJpaGtCdWI3bmNueVQ3OTdpVUVaMEYwZi9yaHFaV212WDBmYzRtelBK?=
 =?utf-8?B?bTRQNzA5S2s0RGFCVnQ0bXVFK20wSjQ0T0JPSEhFWGVFa3h2bFQ5S0Z6eDhk?=
 =?utf-8?B?eVY0Wk5oM1JMQ1c1dUxSazRhNVlTMUpKdXM0bjlBUXpRa1JXQWozOFJLRDFP?=
 =?utf-8?B?SFVaWWYxZEp6SWpMRlJGUTRhTVA4RmFOY2VQSGI0c2xLaHhJL0VjZVVTVEl3?=
 =?utf-8?B?MkNEcXhrNStaMy96QUt0YVB0dDNWTHNnT0xjeFpkRWF5TmtkVmZYeEVBd2Nu?=
 =?utf-8?B?NkFMemE0S0FSdkdTQ3FZM1UrTU80WDU2Y0ZFZXJkS282SUxKeFZnNlBWbllt?=
 =?utf-8?B?bHVsbFBXR1VLUWxSVmpYL1loMDlJeVYvWFo0UTRmVW52QTZ1SFpDV3Fla1d2?=
 =?utf-8?B?dTZWRVRXYy8wc3F3eHlJUVlITGsyQ014bzNFZ3dlSVR5M0pXVlZxNmRwUlpB?=
 =?utf-8?B?WnRsQmdvWnRIcWVlZWZ0RVplTitldithMmREby9RaGNNN1Bwa3FpZnpsTXc1?=
 =?utf-8?B?SG53Z0xpSHhUcGNNV2FzZzNwN0pLNVFjNVh0Z1hIckdxd0R5d1hvbDBpV3pp?=
 =?utf-8?B?NUlYeWY1eHBLUzhjYjdJOWtUY0Q3SnRHUUJnRGJBOFhNdGhQK01yN1VONEUz?=
 =?utf-8?B?NTF0WUdUVE01OEpRaG9nYzY4VGJrVlp5eHpENXF6UE9FU2NOV1B4VG9QcE1V?=
 =?utf-8?B?Z01RcmJVaVpmUXFkc0IyWjk0dTJ6YTRWaDdMKy91T3k0MFJ6cFA2K3U3YTZ6?=
 =?utf-8?B?bEQ1TllYeFgvWjFzUXRaRmFvdi9ZZDdGSDJ3eWowLytDckdoOGlsMXhVK3RX?=
 =?utf-8?B?NTd5Rms3OTJZWDRTTWtSUkFoZXptYlFEbENGZFR1aUJqd1p6QXpUUDl0dmRM?=
 =?utf-8?B?UXNvTUU1Z3UvVXdVK01Wc1ZUdHJtVUtJU2tmNHRSb2NQckRNWnJXbm1TK0Vs?=
 =?utf-8?B?WHZwUk40NW4wMEt5K0cxR3pESXNnbC9iTFhoL1A2WlBhYnhiSjRkV0JIUzJz?=
 =?utf-8?B?aW9DTHhFYzdGSHV2MERDN3BRU1ZZRmx2WTdYM1o5WjBwSlNaL2p5RVRiaVlG?=
 =?utf-8?B?V1B3cUdodDhPVW8rL1VOU1paWExGcmVyNDYramFZOTg4WWxMMEY3dnBZbWYv?=
 =?utf-8?B?azVlMXcyYklsMTBKQ1BOa1k2bGNDTmhxZmJMaUxOeWx1QUFmd25GeGtjZDd3?=
 =?utf-8?B?Q3lyTmJDanJmYzI4Vy96N3JXclYyMHpOL0RRWW9vRHJBR2Y0b1ZQTGtMWDlI?=
 =?utf-8?B?TFlTOUUvK1IyYWVFd0ROR00rN3pMWmM0bXZFSGc3WVMyOG9aM2RhTDl4WFht?=
 =?utf-8?B?SW1Mc3hkWHVFMlhaRVNRRUJ5eUorMUJJWUtzT2JDR2ZVWll4VitmK0dDU243?=
 =?utf-8?B?TjdNRXRVemFDcVlQNzdxS1gyblFVc3Jkd01XODlVRW9yekh3WTlvRmNQVXNW?=
 =?utf-8?B?WXpOd3Y0dnVEZ1p5UmpqbExwNFRmVm5CaVBmbWZhRjFZei9nWjY3SjBwODh1?=
 =?utf-8?B?MS8xSWYzWHRNRGZEKzRGVGNCQ3ZId0ZGWThkYTZzOXZGRzdjZXF2ang4aTBM?=
 =?utf-8?B?YUZEQ3g0TTg1d21tQXp0bStlbSs1bWdGejRPSVhxSStxdndkZGpTM09HdTZF?=
 =?utf-8?Q?XK6jf9jbU14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUZURzdrSEFDeENlaGo5ZnJ5bU94SzFRUldDSTRsSGlmbEJMaXd1QU1oU1Bz?=
 =?utf-8?B?Wnpmc3d0ei9JSFV0Nk9IQ1pvWkhwdVJ4RnkvNnJYTUR1ZTQ0K1BVVTdtQXR1?=
 =?utf-8?B?bFBraXZlaFdEWnNaUmV0SmI3K0JQSkRpNEgvUFRTTEpGMUczcGQrbS94TThu?=
 =?utf-8?B?elhUOU94Nlh4ODZkZDArV2g3RXk2THVtMlhkWktnQ2FDd3hYbGdTdmZmQjNR?=
 =?utf-8?B?bG5ITW1HeUdUb2FsOGNKaDBaQ2tXcnlsOTd3bDZCUG8vUmZmYnRzdlZDajNo?=
 =?utf-8?B?Q3FkQUJrS0hsYVJnNGNPeVF0TElGZFY1YVArRGdTSWFLZ1A1YlFYb1dLSExk?=
 =?utf-8?B?cUpWUWoxcENkUStjTEhqL01YZGQ3ZE4vdU5pOHNtRXNMM3d4amRkNVA1OUdC?=
 =?utf-8?B?OVIxbmUvS09qMC9lbml2N1ViUCt4eUd4c0dxbld6bERDaTRJbCtXT016WHlo?=
 =?utf-8?B?QTdLNU02MUtEMnh5RUN2REVzKy9SamNQVHVQdVNjWW5jUFArRllZRnZFOEx0?=
 =?utf-8?B?OVRtY1Z1cmJ6a0N3Vi96ODZxQ2dyN1ZrTEhCRWV4aVlrZFdZSUZZSGY3Q2Y3?=
 =?utf-8?B?d1laYVNUNk5vd3FLcndjOGhzaEdjQ3BLU1h0VWJtRGU2ZXpickRpa3o2TG5j?=
 =?utf-8?B?TUVEZGROeWVXYjFHVUlNVDZYMVp6MlkwQ1JyWXN4dWhGd0lpMTZZbGlhbERl?=
 =?utf-8?B?dk4vWGd4bStja3YvK2c3SS9TUGJtMkdlLy9kb0pPaU53VFNxcEpvL3loVjlF?=
 =?utf-8?B?TUdhSWNqWlFxSjZobWMyMzBEZGVZM05EKzY5ckxBS2dlbzVFMm9nVHlZUXkx?=
 =?utf-8?B?em1GVkh2Q0hwbEd3M3doMkNKdzE2QjVCVEFXYTlqWlBYODhlNXJ6VzhhTi9M?=
 =?utf-8?B?RU5OcnhmcjE2VUIyWmFMNW1aVi9WYnNrZllWZ3krck5jeDZ3b1Mza0toMFlv?=
 =?utf-8?B?NGZmNHFCWTlZekM2UVhwZU4ya2kxblhxbzVqMHJjMjFBblpQVUpFWi9JbERG?=
 =?utf-8?B?R3RSQU9WZXJTVUcrQXU3K0k3dHhRWVVGdUxWTFZSRjZBRkVwYTRNRXJpOTc5?=
 =?utf-8?B?c0RuWG9EdlcvZ09sdmpockQ3clJnRWJTT29hOXI3dXlXZWh5SjY1U2xlZjBH?=
 =?utf-8?B?TlJndStvNEthNWZVMHBqalF1OW9RYUJtcnFtRCt1ckVLRW9iYWZyYndzUS9m?=
 =?utf-8?B?bldnWTJ6OGQzakhXU2FhUVFaUFNtNnFRVXYrTGJNSEYzcVFkdEtPWHBET0ti?=
 =?utf-8?B?V3gwM3luNEtMQVhDMUZuWFdaeUZvQ01pM29mWXAxdlNEQ2JaNlpwWVRyTHA0?=
 =?utf-8?B?Q3FDK3dpejVXcEsyRXBhc1Q5ZTQrR3l6UTRlTmhJV1lUV2lTZFJzaE5NeitN?=
 =?utf-8?B?dFhnNE02QVppNjNNS2p6UHJ1clYzUUgyNUdESm1JNW1GbHIvcHMvYzVDc1FM?=
 =?utf-8?B?Z0ttVXRGdjgyN2ZOUktXcjQvaFR1Mnl2ZFE0OGcrK21ic0ZrakpDSDJjNkFL?=
 =?utf-8?B?MkV1TVBJcU9QaHYvdG43RXFJNy91WnBqQVJONldqOEFrckNoTGdhODBtT1hw?=
 =?utf-8?B?QTRzQnJWbmFaNnpYNXd4Z2o5L1V0ZVpnd0lTU1VXaUZkeUZCNUdQTi9CNGU4?=
 =?utf-8?B?bmQzSUhRL2pFWVFNSW5MRjh0a3g1K1R4RW5pTEc1U245dEpCaTMwbVBNK3lt?=
 =?utf-8?B?U3Vjc0U0VTh0K0ZORWFoQkM0T09neGVxZjR4UHBnQk5ScExDTnNocUVPbmpj?=
 =?utf-8?B?cnFEeUtEcnpTNXZRbndKMUF6RGIzZGwzNUE0S21xei9pbVAzcFBGOFpzcWlD?=
 =?utf-8?B?aEE3cnpTSXZDMk5SaEh6U3VFOWp6eTdLQWN1VlNSTmRmYXlaOTVuamNqMVlW?=
 =?utf-8?B?aTdJckprTCt6bE5CZ0JZQU1jY2JPUG1TSFNNQWEzTVpIRDNEcm5NRWJJTmpo?=
 =?utf-8?B?WEVtbjBwK0RZNVhob0RqZlF0YlEvRG14RWtoSkVoWVVnTEFtb1lEaWM3Uk9B?=
 =?utf-8?B?VmpyQno5WFpSaFVPSWN1YjBSczZTOW9UdUdST1hrZTVOR2xQak9NamdlT3lZ?=
 =?utf-8?B?b09XT2xGVEI4bEpJU2lacGw0UEdURzEvUDRscFFaSGtRQW9TbmdsZFdwSFQw?=
 =?utf-8?B?UlV6ODJyUGJZL0kzcUd2bEVBMFBidW1JUityRnN5UlBHRjFkUUR1K1poSHJr?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bed376-c448-472e-2318-08dd776cb8e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:45:00.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yAVH5A+I7lb90VKkTnqNk7EUKPau4zRK+51RaGLBsu2QGdiefGT0T8zlz6P4W4h2JlAdYWB+S+QvR6mjV7D9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5759

On 09.04.25 14:13, Aaron Lu wrote:
> On Wed, Apr 09, 2025 at 02:59:18PM +0530, K Prateek Nayak wrote:
>> (+ Aaron)
> 
> Thank you Prateek for bring me in.
> 
>> Hello Jan,
>>
>> On 4/9/2025 12:11 PM, Jan Kiszka wrote:
>>> On 12.10.23 17:07, Valentin Schneider wrote:
>>>> Hi folks,
>>>>
>>>> We've had reports of stalls happening on our v6.0-ish frankenkernels, and while
>>>> we haven't been able to come out with a reproducer (yet), I don't see anything
>>>> upstream that would prevent them from happening.
>>>>
>>>> The setup involves eventpoll, CFS bandwidth controller and timer
>>>> expiry, and the sequence looks as follows (time-ordered):
>>>>
>>>> p_read (on CPUn, CFS with bandwidth controller active)
>>>> ======
>>>>
>>>> ep_poll_callback()
>>>>    read_lock_irqsave()
>>>>    ...
>>>>    try_to_wake_up() <- enqueue causes an update_curr() + sets need_resched
>>>>                        due to having no more runtime
>>>>      preempt_enable()
>>>>        preempt_schedule() <- switch out due to p_read being now throttled
>>>>
>>>> p_write
>>>> =======
>>>>
>>>> ep_poll()
>>>>    write_lock_irq() <- blocks due to having active readers (p_read)
>>>>
>>>> ktimers/n
>>>> =========
>>>>
>>>> timerfd_tmrproc()
>>>> `\
>>>>    ep_poll_callback()
>>>>    `\
>>>>      read_lock_irqsave() <- blocks due to having active writer (p_write)
>>>>
>>>>
>>>>  From this point we have a circular dependency:
>>>>
>>>>    p_read -> ktimers/n (to replenish runtime of p_read)
>>>>    ktimers/n -> p_write (to let ktimers/n acquire the readlock)
>>>>    p_write -> p_read (to let p_write acquire the writelock)
>>>>
>>>> IIUC reverting
>>>>    286deb7ec03d ("locking/rwbase: Mitigate indefinite writer starvation")
>>>> should unblock this as the ktimers/n thread wouldn't block, but then we're back
>>>> to having the indefinite starvation so I wouldn't necessarily call this a win.
>>>>
>>>> Two options I'm seeing:
>>>> - Prevent p_read from being preempted when it's doing the wakeups under the
>>>>    readlock (icky)
>>>> - Prevent ktimers / ksoftirqd (*) from running the wakeups that have
>>>>    ep_poll_callback() as a wait_queue_entry callback. Punting that to e.g. a
>>>>    kworker /should/ do.
>>>>
>>>> (*) It's not just timerfd, I've also seen it via net::sock_def_readable -
>>>> it should be anything that's pollable.
>>>>
>>>> I'm still scratching my head on this, so any suggestions/comments welcome!
>>>>
>>>
>>> We are hunting for quite some time sporadic lock-ups or RT systems,
>>> first only in the field (sigh), now finally also in the lab. Those have
>>> a fairly high overlap with what was described here. Our baselines so
>>> far: 6.1-rt, Debian and vanilla. We are currently preparing experiments
>>> with latest mainline.
>>
>> Do the backtrace from these lockups show tasks (specifically ktimerd)
>> waiting on a rwsem? Throttle deferral helps if cfs bandwidth throttling
>> becomes the reason for long delay / circular dependency. Is cfs bandwidth
>> throttling being used on these systems that run into these lockups?
>> Otherwise, your issue might be completely different.
> 
> Agree.
> 
>>>
>>> While this thread remained silent afterwards, we have found [1][2][3] as
>>> apparently related. But this means we are still with this RT bug, even
>>> in latest 6.15-rc1?
>>
>> I'm pretty sure a bunch of locking related stuff has been reworked to
>> accommodate PREEMPT_RT since v6.1. Many rwsem based locking patterns
>> have been replaced with alternatives like RCU. Recently introduced
>> dl_server infrastructure also helps prevent starvation of fair tasks
>> which can allow progress and prevent lockups. I would recommend
>> checking if the most recent -rt release can still reproduce your
>> issue:
>> https://lore.kernel.org/lkml/20250331095610.ulLtPP2C@linutronix.de/
>>
>> Note: Aaron Lu is working on Valentin's approach of deferring cfs
>> throttling to exit to user mode boundary
>> https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/
>>
>> If you still run into the issue of a lockup / long latencies on latest
>> -rt release and your system is using cfs bandwidth controls, you can
>> perhaps try running with Valentin's or Aaron's series to check if
>> throttle deferral helps your scenario.
> 
> I just sent out v2 :-)
> https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/
> 
> Hi Jan,
> 
> If you want to give it a try, please try v2.
> 

Thanks, we are updating our setup right now.

BTW, does anyone already have a test case that produces the lockup issue
with one or two simple programs and some hectic CFS bandwidth settings?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
