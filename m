Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535117BEB7;
	Tue,  5 Nov 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839330; cv=fail; b=jTUC5BTakhxeVdVGR1bQDfLr/ChqlHnlcrCeMBKK2ExK0uhURuTV7USAEvkwVLi7XzMyoe6TtJkzQlKKicS4/A1xYH86PwHn8CrTMFwkupPwMVidiTQGbk3qP4I/9p80LZbu5bv7NAsRymbBl9UHrqQswaxzsBL14qhQIZ7qf9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839330; c=relaxed/simple;
	bh=T90O2CfNUJ2JNuV+daizBUac2GfX/RKC98MqfXIbRh8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WrCOdEl025arQR3yrwQuCDoF1vEoU7wDNdrFgBuRnnduyJhAPj6h5Yp+L4OBFO2T/zTFsX9xqtEWLIAsb5ipaaWo2u+qt9LISrl4dKYBzpets7tSiQr/wRCoA7h9QXucotkQC3Y++pbo/ByGE2wg1AkwyNL1gPhv1HezXqrzccg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DXNN7Lk/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qmrcM5Il; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DXNN7Lk/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmrcM5Il"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KfXqa030373;
	Tue, 5 Nov 2024 20:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7Uv2PJarvdHx/wk8BYPM9dCIQtNnCOZNOE78sk6ERe4=; b=
	DXNN7Lk/8cmmpEFJrkZHKVsL92bnLdLh4ed/mTYz93UsF1tUfTZRteMv6R6D54DB
	9R7B6LIc6prgh6Uo7V6VaR0Iesno7IpCx69c0JHT0sQFPCeWeXXlBjQZkuXZ1H7+
	WV3dvlV7b2k6DfMCvDIKNhwDaLZSwJ0OKSMaXAFMctH3MEOOPOmr0v55844KrHhT
	81XaQ0MM3i5eH9WpVma088CW3ylhcrlz0o1eOKbOfoHXF3rg1NKIt7dxeU5sJxc+
	3CBVwLpdlfKpTG026xU9DBgRD/1c6WWk/AuSA6WcQfqGSsmRnQF9q56+fM0Int+R
	AeXu+64MnmR/WqIMOqjveA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt6c0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 20:42:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5K3Srg005055;
	Tue, 5 Nov 2024 20:42:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87b2kgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 20:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBGyqu6v3wYabhQIS+SFKyVyszYT+OIQYKvHVrrzZFJnbYG/1fChXuS+DmnGEM/3F4sZUDJdmKaB4pT+HU471E2t5Oy5b59ajGC32G83+wsCgRvM9UTt7UomHmZb4xXly0fzThaZKUlyUEzRRqx/8b9Bmz4gCdKkPcGhHRhKGz7hdTb5mXQEK9jRriletqKCj7LDplui1c3JuQKAOdmzg1GQnhMxHUOyKYgVQ6nzTcKqYxnXFLJvg1QuuxtEZvjzPipqRT1WuaZ0KPeg3cx0tVd3WyA2BCRc2jzN8Wgzl3o8mtDenPkDnBR+emfPgmi/Jg0vX/slimCeIn6+qjk/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uv2PJarvdHx/wk8BYPM9dCIQtNnCOZNOE78sk6ERe4=;
 b=ynAA9+LwhF+5gUy8LU3Yn4ya1Wuy3nfhN1RSmpfZpHphBVTUFkJRT11lUWCiw46+44IAhuusGkWCbIGmaJskMU16H2KIqpMCyJNfmkCW1MvPX5tP+kAQSJyzTWcK+uO5ljOyEJApZB8QF0Vnx7+uez5dsVwVlBhQn5/pzf6WHixBlhBhJufqtBdKZP1qMGv7FbMN/YQyHjMDJZUzV5hJ8RQWJBywuqA8AztDMJbQ45S4jbRhK2DWNMcB2ZAIOWHlMWTrj3Y5iYPi2ibHwAtWYJuSuqJ9I/E050+tEvZrjp/KzuUZQqbZYJ23y1TTlZMKm+CNXTv0Mss/69uMOzfP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Uv2PJarvdHx/wk8BYPM9dCIQtNnCOZNOE78sk6ERe4=;
 b=qmrcM5IlDqxsKYUnbxdAbOzoQzP5lirxN84I6XTgCuFROYB05qifWrhYh0U1MzFqgpFWsodaHyoQMlL+z3TFNprjbhcWDMlqNedE1P3wUCwCKnF62BX+ZptmtXqzF8NO9IS1DnaQBlrzPnS8kFxpQ6kYM7iEcdNBC7JVPgQUIfk=
Received: from DM6PR10MB3881.namprd10.prod.outlook.com (2603:10b6:5:1fe::23)
 by SJ1PR10MB5905.namprd10.prod.outlook.com (2603:10b6:a03:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:41:58 +0000
Received: from DM6PR10MB3881.namprd10.prod.outlook.com
 ([fe80::9c40:1c28:9d29:6d9c]) by DM6PR10MB3881.namprd10.prod.outlook.com
 ([fe80::9c40:1c28:9d29:6d9c%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 20:41:58 +0000
Message-ID: <595e91af-7737-4567-94e6-6f97a281354f@oracle.com>
Date: Tue, 5 Nov 2024 15:41:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: Linux 5.15-rt still misses commit "NFSD: Fix
 NFSv4's PUTPUBFH operation"
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joseph Salisbury <jsalisbury@kernel.org>,
        Dan Shelton <dan.f.shelton@gmail.com>,
        Martin Wege
 <martin.l.wege@gmail.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, chuck.lever@oracle.com
References: <CALXu0Udop9Qx_N8KwScmGk+j3NrfDry1r-Fk=5bc+9EXsfnB=w@mail.gmail.com>
 <20241104132412.dFx8w7ZH@linutronix.de>
 <6aadadc1-63f3-4300-9ceb-0475e0203ea7@oracle.com>
 <CALXu0UdCqYJpDGKcvZ9ZvXeUkYtVW_7thGuQy4gMjgO6uo4Rew@mail.gmail.com>
 <d370e7e6-9b33-4901-b49b-699e1932dc49@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <d370e7e6-9b33-4901-b49b-699e1932dc49@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0476.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::32) To DM6PR10MB3881.namprd10.prod.outlook.com
 (2603:10b6:5:1fe::23)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3881:EE_|SJ1PR10MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: b721c554-a45b-4d76-f213-08dcfdda4aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnBUZWNXMXFMSlg2ZG5wdzdONVpkYXlRdmFQUVNzamFwTVQ1VTlteE55ZlRa?=
 =?utf-8?B?MU5NeFYxeHA1YmtNZ0xxRnhxbkNsSURjelRqcUM5S1pmcGE3Q0VIZVp6T1FM?=
 =?utf-8?B?N1JraWRPQWhuQ1JCUHVSUVhhMlFPVXpDTWZWaE5YclFnaWdLYU05c21PRG5m?=
 =?utf-8?B?SUtUS3dJY1BabGN6ak5tVGJSaWdrS3hTSkM4OTZvUmJNYTZHK0V0L21mUUNt?=
 =?utf-8?B?UGN0TUtBRlBQZXVyd1BPNFcvSm4yUW5TTVZyUXcvblZ6OER1Y2hmTGdJYmFm?=
 =?utf-8?B?aGp4bWVsNVlFdndIaW9rMWdORVRna1BpTmVTTi9TSGl2VzdmR1ZRODRNYjNj?=
 =?utf-8?B?UmdmNEdxZnFEY1kzQktwZFBGQ1hoNHU1Q09haW1aZ2VzMmMvUndXZ2g3VVZE?=
 =?utf-8?B?OHQ0SGxHU2w5NlIySi94ZXRGcndIQ0ZVODB6MzMvT2NWb2JtelJwTVBmaitr?=
 =?utf-8?B?TWk5UXNQY0NMWi9KUUV5MFc0dTJJQUM3bXppSWk0MXNnTnc4aWU0T1JNdmVl?=
 =?utf-8?B?dGpITzJhcHBoWjE3MFIxQk1VQWRnTkNBN205ZStndnZJWFgxaFFlTEpVOU5t?=
 =?utf-8?B?L0ZPcUJaOU92WkQ0RURGYTBFM3ZWamtXMlJPb2NsbW1MV1VoWUtQQUVqRHBh?=
 =?utf-8?B?eGtuUFFNRk02dllBWklzdVFpbXNZemw5bk52b2pVejVkVTFIOFBsdEFzdzUz?=
 =?utf-8?B?R2w5MG9ndEZSWEZ5OFk0WDhURUFDMnFhMGUvVWlLUWR4U1FVWlk2QjhTREVl?=
 =?utf-8?B?OHRkY0tQdkN3Ky9GTWRGWXNxcWNqWmtsZktoVWZ2QUFmR2VVMzllWjJxZW55?=
 =?utf-8?B?Y3NtNEVYSjdCR2NYelhpV0RHdUZoNU9WcWt0QVRCUkpyOXo3QWoyRVYzazl1?=
 =?utf-8?B?TkxlUlFRRVhqalZVcGI0aGRVcEV2Mm5PRlUyb0tXT3MrTm9VTWFwM3F0ckds?=
 =?utf-8?B?cG1tWXdyOHFmMXhUWFY2ZU1vSnBqNkxBSytGTThJZW1LZENSZTB2REQwNlFI?=
 =?utf-8?B?Rk9ZcXo1bVUwRXBHcmNmZm5SL1g3OWVHOTZFRXJQb28zYW91dDQ5SkxVT1FL?=
 =?utf-8?B?Sm44ZmRlVWo4Mk83ejB4eFZocStXWlJHbG5BancyY1I3bzJiRy9vRUFJZ2R1?=
 =?utf-8?B?OFFGbitQRjNENmw2OWk0VnJJelVCalJHTy85Wkw4V3NyMnUrcmwyTk5MdGdI?=
 =?utf-8?B?ZFFGNHBsYnZTbFdGWUd1R1JyYjc5Q3ltTmp4bnoyZFowMU1HdTlPdGdWMVl6?=
 =?utf-8?B?YnJRdlFNU3ZBKzhGZ2ZveCt6RkNaYTRLTnN5cDhPUUN5WTQxdk93ZWFzdlZJ?=
 =?utf-8?B?L1B2NjBZVmZOVUtpV01oYmduTVFsZXMyNklqWmppT3JkSDNtU0t2eUZxOEF2?=
 =?utf-8?B?YXI3RndabUFVUHVmOUw0UmdmSUtDc0NYeElYem40NjJOQzhwT0d6ZDdKY25Y?=
 =?utf-8?B?Q1JHWFUrQjlpUUNvdXo2Yk5VenlNUEVlRnljUThqV0IzVmN3Ynk4ckdVUEV1?=
 =?utf-8?B?U3BnVHZrMldjRFhCZS94SkFOOFFDQUcvQ1UxQ3dQWVZVV1pEVDc2WnNZdzBZ?=
 =?utf-8?B?TVVBNkoxUThwUUpDREd5WXRudUgwOG9RRnpoY0U1bG5vTnNRaWY2YmxLUWpp?=
 =?utf-8?B?ZTVaN09KOGlSWkV3U3NXMlFWR1ZRekM1K1lTNUdFYXNRWVl6dVdzUTlEQXBl?=
 =?utf-8?B?MnM5TkZxTmZobUs5LzhRZzFmQUNmYlU4azUwQXFSK09UcVZ1QjhJMVl6dUpr?=
 =?utf-8?Q?8Yr+6rAJ0zBzr69wZzLITV/A4si7dflo5C+DRtQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3881.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JPL0llMXdyYVBhd3JyZEtOQ2dBY29FanhvSFZxeXNST2RhalpYUkUvYi85?=
 =?utf-8?B?MHZEUzgrbUNLZ20wL0hxKzBBRGl6QXZmNURHWTJZV284azN2djI5eUU5bzdG?=
 =?utf-8?B?YUJnU3BKbHJ2NXRJY1BndENnTjVVbjQzdjBqb3FCZE44aGpvdTZhRVYreXVI?=
 =?utf-8?B?dmJQQjBSYVZIb0hLbkRTOVkwT0ZzdHdZby9zTjg0azJwTmlqMk00cFJxQ1Ru?=
 =?utf-8?B?ZUZVV2UzOWR6S2VFRVhpMjg3MWc4a2JFbzdSUUhUQU5CbkVibnFtN1lxZjlF?=
 =?utf-8?B?aWRWMzFXa04vVTBwblRCenorYjFHUURTa0JjOXplRWRlRGc1allqSzJiNncz?=
 =?utf-8?B?TklNTXhTa0NjYjJGRjgwc3BjSkJwUmxDSStBUlc0NjJDK2E0TnZ2UU1hbEV6?=
 =?utf-8?B?VnA2a2Z5N3VoNU5LRGp6UHQ5Z1dnWmtacExkTDhra2U2TjJvZC93WElJbFhl?=
 =?utf-8?B?Y3p3V1d1Ri8ySXlQcG1MQ0ZjamM1dkRGK0FTUjJPbSs0WGN4Z2puRWk2Uzdu?=
 =?utf-8?B?K0Q3RFZENUhwbHVqSzBxR0xOR3FwdHRjanJFb01na01yYUhmaFl1Vk14b1pS?=
 =?utf-8?B?bm9UL0ZWQmIxbGhtOXRKN2pIdlZJQk1zcjF2bGt6aERPT2tJU0VvWEhlY2d4?=
 =?utf-8?B?a0lZTHdXWWN2Z0dOWWpwSjkveGhnUkRmV1MrNERhMEVwdno0djN4UHRXQ0k1?=
 =?utf-8?B?aTcrMk5xT2NiamdTTitJVHVuU3NiUWYyTGVERkE4NmI4TzFpZG9sa0VjZ1lq?=
 =?utf-8?B?cHdyZXNpeXRKMk1PbjJScTB2bVJXYjRiRVpqL3hUNUxBWlRod1gxWElnK2Nq?=
 =?utf-8?B?VHI2M1o2NlMvQTA1WENvejNxMEMyUll2Rk5xT1RUM1labDNwZFp5VzdTRUpi?=
 =?utf-8?B?b0JkcnBLWTQ3bW0zOWNHaTA5RWNCbWtVY3ViNTB6ZFdGLytob25QNUpteHI0?=
 =?utf-8?B?TmdUOHlMNWxZZ00yVDF6NUhYNlYyTGhLUDZscVVSeWp4cGRqVGFzV1lMbnlv?=
 =?utf-8?B?TE0za2lMRjZsRXkySElOcHF2S0lQV0VtcUxMMGhhU0UvSysxMWlpNmdrZklU?=
 =?utf-8?B?Q1JaOFVRSTF3YVd5NlFlaGtSK244a0orZi9GcWVXYWpoKzhLeE5Zbi94ZHYw?=
 =?utf-8?B?R1VZNTJOaGhoYnFLZ3FFbTUyc2RwK0plVXcxVlg3SmlxTmdURXZzb1M2UGRp?=
 =?utf-8?B?emhHYjYxUnJXaTFuTGNUUU4wdmVpWVVDQjV0QUliK2llWlNFYlZ3U3FTWStO?=
 =?utf-8?B?WW9EQjRjVWV3NWlwU2U3bFl4ZWdSVVRMdVprSGJLQmJBOHpyZStWb3A5R0p0?=
 =?utf-8?B?NHcwK1MyVlQvNjBEb29zK0dOdERvazZuODdJSXFzWXJ5bThqMklTMy92K1JF?=
 =?utf-8?B?bWZhb1VaZ2hIS2pkaFlJbEVSd25scHJGUVVEdUc2SklXc1FUSXQ0RCsxOFVP?=
 =?utf-8?B?WlZySE1iRW9oY2pNYVF1ZEhOZjQyQWtpY2p2Z3JvLzMyZlBRZW5nNGJiczRM?=
 =?utf-8?B?TEMyVkNndXlNaTVEcWljTUs0RkFPeXNMTGhBaHVYS0RjbnNaT3ZubW90U0hw?=
 =?utf-8?B?Wkh5bUpjbEtyNHd4VFZxLzBOZ0w1K2s4Z0IxT091MDlHZERSM09Gci9sSWpN?=
 =?utf-8?B?ZllyQWZ1dnZpWlpLVWJuWjJET0RZNURsUUFKaU9hNDczdzNFMmgxVlN3aXJH?=
 =?utf-8?B?UWFFL0tnclpvdEV1RkMvdEZYQk9xaStoUHkwZ0szNlNDYTFxWFdGNDJja0JS?=
 =?utf-8?B?WVMvMGppb0FYblR0cHJ5QldoQzN5KzRUc3NkQWdQU1NMLzRNbGJEaEN3MW50?=
 =?utf-8?B?d1ZWdzhSSGFNN2J3SGczeUU3TXFLVHR0Q3VUM01xU0xTZEZRYzJvMEdQNjFk?=
 =?utf-8?B?dmhLM2V6RzBRVFlQMG5VWXF3Q3VPYjBHNlFJM3BDUDZRM1paR3pjU21aR0dx?=
 =?utf-8?B?U0hUK1NXS0YzMElYRDdDL2ZQRnFzQ2pZYVNNNkt5cVhkLzhGRHV4OFZ4ckEy?=
 =?utf-8?B?eWZ0RnUvaDdWTzBOQ1gyNkQxSlJTdi80clBiVkllS012N3hBUDBWbGtsaFBm?=
 =?utf-8?B?VURCb1kxdzNzR0taY3o1blFhQVNJWElwQm54cjFaQVhkWkE0Vk9DS21oQjRq?=
 =?utf-8?B?K1VhOGJJcDNtdFQrQVZvVDNkSjVIcG5lclExS2JFSGNvc0lCVWNzOTVwR3JJ?=
 =?utf-8?Q?Xhsr5qOZ/uggIS/dLZa0Akk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Af3eVNr3rCnBp7q5TkAs2RvV2Ehh0DflBoBd5RNWKRDL0JXAqQJh4Ll397OeOkzFvzFGNQFYXXIdKlw3TQraZk95fcU4mNEhaqepDN7e+Wwr3cPelF+M1M4U/NcVcLXjLMQfVdSZoLEdV8CrYp6TMYD5ZIX+etVU5iebrClDOgqaBZW6X/QUQIX8jmligGP0ibNy6uYriodxGsRa9gBI9WqEDU4Jqf/DqGTUSaGB4v78M5T2l/lqTssinbV9QT1yyr1szbRtuyYTxz2/HyK29VN/vv9xfr0zpcfx8yOUChwnPDFcJNIx+Kz7QSn5JNHRNCYm1OmFc18OHlHnnhWRqK7ZBGbLgbLbP+tEyZXtbNsrUD0tRr+MBKMJT6o3Mn89vUG0PoUFvbytPvKL4Ss+rQvx+ZRdl6gu94cwa2XO+a12/bMHO2MutzAaNZmhcempIg9sjKVJ1jQJ/0cQA5S62vsbO/oR6hQXHUGwdNsSDfs3fk70SLAYuZrvHmZ40ZjVTJUWkyDJI4V4sK7h1yrPDqB4PGziWB/74EtSL2RApKUZoe2rrStWaTZWdSVNWPY0SKAz5+9caG1pl429IfrI29AB179ssM/8fbsG+aiwaKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b721c554-a45b-4d76-f213-08dcfdda4aa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3881.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:41:58.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /csdjZcvT7p1r3cKEa+3iRogHCEIXpRZaE2eiuVJ54jSrPrfyCEH6qeao+OVK47MeLqlJZt2Gn4lnIjnVzcOxdydWJQiNRBydAe2V+pw0QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050159
X-Proofpoint-GUID: c7u7AVxYj1H8SdOdqMswNOBVI7ZoAyEs
X-Proofpoint-ORIG-GUID: c7u7AVxYj1H8SdOdqMswNOBVI7ZoAyEs




On 11/4/24 12:10, Joseph Salisbury wrote:
>
>
>
> On 11/4/24 09:06, Cedric Blancher wrote:
>> On Mon, 4 Nov 2024 at 14:53, Joseph Salisbury
>> <joseph.salisbury@oracle.com> wrote:
>>>
>>>
>>>
>>> On 11/4/24 08:24, Sebastian Andrzej Siewior wrote:
>>>> On 2024-11-04 13:01:42 [+0100], Cedric Blancher wrote:
>>>>> Good lunchtime!
>>>> Hi,
>>>>
>>>>> Linux 5.15-rt in linux-stable-rt.git still misses commit "NFSD: Fix
>>>>> NFSv4's PUTPUBFH operation":
>>>>> Title: "NFSD: Fix NFSv4's PUTPUBFH operation"
>>>>> commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae upstream.
>>>>>
>>>>> Could you please add this missing commit to the 5.15-RT branch in
>>>>> linux-stable-rt.git? Thank you!
>>>>>
>>>>> References:
>>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.170&id=2f8f226f4d56fae0fabec23cf0af82c43cb4dce0__;!!ACWV5N9M2RV99hQ!J_i5oEOgM6dLLOAkgjiM9ncalWBDCr_5-CaHZBZI8r2RU3TtvlTNnrOBlTBiS6Z0M3ETfv4emw1N632COpow2bNbsDE$ 
>>>>>
>>>> The v5.15-RT series is based on v5.15.167. The 170 minor release is 
>>>> from
>>>> 2024-11-01. The commit will be picked as part of the update to 170.
>>>>
>>>> There is v5.15.167-rt80-rc1 is preparation, I guess 170 will be next.
>>> What Sebastian says is correct. v5.15.167-rc80-rc1 is out for testing.
>>> This version has a release candidate, since it introduces a new patch:
>>> 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for 
>>> statistic.").
>>>
>>> Version v5.15.167-rc80 should be released the end of this week.
>>> Currently v5.15.170 is the latest stable release.  I should be 
>>> releasing
>>> v5.15.170-rc81 next week (Or whichever is the latest stable release is,
>>> if a newer than 170 one comes out prior to my release).
>>>
>> Could you please just manually pull this patch in?
> We generally don't create releases for individual patches that come in 
> via stable releases.
>
> If you need this patch due to a time constraint, I can release 
> v5.15.170-rc81, which includes this patch, immediately following 
> v5.15.167-rt80. That would be towards the end of the week to ensure 
> proper testing and allowing for feedback of v5.15.167-rt80-rc1.
>
>>
>> Ced
>
Hi Cedric,

The v5.15.170-rt81 patchset is now available.  This release has the 
commit you were interested in:
2f8f226f4d56f ("NFSD: Fix NFSv4's PUTPUBFH operation")


You can get this release via the git tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

   branch: v5.15-rt
   Head SHA1: 67017c496f78e15598f48bb3115e3641a82ae507

Or to build 5.15.170-rt81 directly, the following patches should be applied:

   https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.170.xz

https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.170-rt81.patch.xz


Thanks,

Joe
