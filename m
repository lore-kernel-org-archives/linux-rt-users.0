Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F41BC09A;
	Fri, 21 Feb 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131412; cv=fail; b=hJfANNq1/pX4xOHuwyrxxbS8HAUIdf5NPV+eiy1w0MDLwixdyKHWNEAxfYNOasJcL+r20L3ZViacMsgJLSGPe2ITrafnyHRgVL/QJtGL4Z7jABGyhCMn5RfHrsURkrfvQYP8tUuFz2/qyBdSOPW/0+a6Kso0TzOlp+0z58GCiPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131412; c=relaxed/simple;
	bh=ZT8ic3InTyqE9cwoGEZwPmLlPnEnUQ0m+Xp0WT/EKek=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=llg1xuGmDp4YzGZ35ExYociXuWQ6VG0F2Aeum/LQTVfS5M5Fv/jA5g4uqUpb7pqbSfQKhqx37lItxyeDZxCW51u+mrxMnU8bi1CqifVqH7hWAbfQU0NJqIg2sf9VCQgKoDIc1Y/vAnCOyEt95yosrb6lBPNkgEm9MJpv659ivzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SO+ZjBDb; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SO+ZjBDb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB6Y7Bgd83O/Ly8c/r7/HSkXD2SGrLIHMnmI2vd84xvyTbxfrjweL12HBjA9AzbZ8WYzytLDX/KQ2G2a5pGSQMYJjK1BVt4RilulGmie6oEBsFFwKe5M7WjODh/50DYSbGuKyOM2ZRrxCOsJ9kT3nK0ZQuAY2XyAJ4yeSYCFCHVlgZQ4afsEFTXfUk12CejvJUdZ4phUTiCgu3aRDc9uD4fcDymiBvRVeLv8co4Y+noubdHF2yZz2n0SX+yw2obYdTba2bbiq8njQ6V0W7UqO3J9ETLhF8xH3ng4XyjwTVGnG3azb+p9YbSXT+HIV/B3/OdNCSi6M6cCXwSPcdaiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WlRok7u3NFIiNW/NjFJkUDGRlDiilA0hZ4oirGAdgI=;
 b=y6qKREw847Va/60V3klvnf2SNsyzDUynN3h8spowlUcZr3LLtSSvfSJLjTemkDPW2v0WbPE4Cxv/8JTummr9W5WIL4imTemmVhI/sv0RPS1FNHdYlmAEcbzRtBRRjTLcoXY4bW988x3Lp7QbSSMzOcEkigK/JkA/fI0nxd/7jQwzrLmEVQyRlZ6fsTa1fiieWpasVAhBdcgB3pD03sxoVm47cLRaMxVz+3Q5ZhNDPQPp2Rf5t58Zkv5gbyL5rteXRQhZtxktLrZUr38su8hqGZTNtSJeEElehQ3mTqYWBIe83JvPbDQvr30OinnYsx7wBcFovJ8j/gcinVoQGWxPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WlRok7u3NFIiNW/NjFJkUDGRlDiilA0hZ4oirGAdgI=;
 b=SO+ZjBDbYhpm1mlAmCGeoTQfM7cddRF4o3F/wM2caGaHW2X6KDXu7qk9q6XVJCT/SspApIgmHR/3ijGQYv6q1XOIHnLW3v341AtNc8/tb+6aDaOErLLtlmShUB3PYsIB/VX65kEs8mcP+SJ7BssrifqzV1tVW0vb2Q1cUIbhGdMIM1CKinhnw4NoMpK5BHOMIA7oZm3mzxBC1n+1HBJBKrhoT5IMMSdejMXIdHdOfUwNjUzuQ9WM9T07mQjU0zYzS7HBySVdTp6wyn6J8PMMnzx+7yIuB+PjWopLDNJCU+UIM0TypDWGG+1ULp1eWQ+MY9N5fx7y8+ugLw8hBKPLSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 09:50:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 09:50:08 +0000
Message-ID: <26f102f6-4e35-4267-b6ec-9ebd0c7572f7@siemens.com>
Date: Fri, 21 Feb 2025 10:50:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] 5.10.234-rt126
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 stable-rt <stable-rt@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 Clark Williams <williams@redhat.com>, Mark Gross <markgross@kernel.org>,
 Pavel Machek <pavel@denx.de>, Jeff Brady <jeffreyjbrady@gmail.com>
References: <Z7ZWPGBt4Pv9o54T@uudg.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Z7ZWPGBt4Pv9o54T@uudg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 31201203-39e1-43ac-29a8-08dd525d1fd7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkM3VjRyaWE0V3FzTGZsMU5qWlFReWQ0K2UyZXlQd2x3WnNxMklhOUJuSHVt?=
 =?utf-8?B?ZVJ1akpWYyswdk1DNFZYV0cxaElQUWtBVEc0Z1QyZHlJQ3BPczBYK2FMejZB?=
 =?utf-8?B?QWM3R1RhVE1wNFRhMjlVM1E2NHdmNnZwcE13Q3h4TXdtcGMyU0E4WkhaYlg3?=
 =?utf-8?B?L3dUQnl3VXNNN0Z5aUJTVjlIT3p6NzBwdVJXQ1dtUTRHRUNOalpSdW5JZktw?=
 =?utf-8?B?RlU0RGd0SDZQZzVqdXhRcXRRVFA1RVpsQjJoWmE4YnRobDBka3lKUjdYQSs1?=
 =?utf-8?B?VjU3bXNGSWRGamdZVG9uMS92aEphcmp6TTN3RmhRZk51NmZnWllwNDhscnFS?=
 =?utf-8?B?QzRuRUFLdC80ZzIxOEdEVkMwM3NXbHRONlhGR1BLa1Z4TFl3TjZRenFoc3FJ?=
 =?utf-8?B?WGN6cnJkc2ZmRFVXVDcrU1Iwc3pFUFNrNS9sUzhiWStNL05HN3BzZXhaOGxF?=
 =?utf-8?B?Mko4WnROR1pDQ09neE9acjc1QU81amVKM3l2YXppTGl6WG96TmF2Njg0MzVL?=
 =?utf-8?B?WWxoTktDTllPTzUvaC9NelNVd3lWMnJLeEVhcmNjRVEraDZlTGlJdjN4c3Za?=
 =?utf-8?B?c3FQK0VHdmVPbklYbk54bXN4RnNqNnNreVR2RGorQ0Qxamdtdll6bE5aYzUy?=
 =?utf-8?B?aml3eHNRR2MzNlAvMk5uZVFYbXhUT3NnU2c2ZisrYk14Q1UxSy9EeE9tR3cw?=
 =?utf-8?B?YjBsYkhCM3M1T05wU2gvVk94emJGdG93eG83SmRuekR5QjlJK2ZERnR0bE55?=
 =?utf-8?B?Nk43NHpSLy9CbHBuU3U5VXBFUnhTNzY3N3IvZ2FNcWtlTmlMd2NaUm1PVTJ0?=
 =?utf-8?B?NEYxVFA0Q1U3Y3ZqVTBSUTUweW1Va0JRc29vdHE5T3ZqSFdTY0ljaTBhTEZm?=
 =?utf-8?B?VXZCbytTdmxZcWpKenBPU0J0d0JvZG9lbmhaOXN5NHc4MUtHTzdHd3NhUk9t?=
 =?utf-8?B?eWFwMlFmQ3RmNmRsSzFQS2FYRlVPM1VUNk05enVadmc0RjNQeEo4YWZ1d3ds?=
 =?utf-8?B?Z0oxcmcrRyszbUtjNGNpS0k1RktNSE00KzZDcTg5N0M4ZjJid01WaG8vZVpT?=
 =?utf-8?B?aFozS0FlNjM5eHV4MytoSVJzdlhKT2JLL2VRWENid2daMVJDdU8vVjRWRFJo?=
 =?utf-8?B?L1JVZ1hPNm0zaVpSYVRXNUVSM0wrME8vUWt2RFRYZjJQMEJPeE1SbnNIMDdX?=
 =?utf-8?B?bW9IM3d6Zkh2ekNhWEN5RHg2ZW5mWmFEMGRjUTI0bFRhNFBYM05CcmtOZ1BZ?=
 =?utf-8?B?YUZTaWErRXJQOGZKcHJJakRrUjkxMnFYRnMyVzFzdUMxV0xmMlFXTkxxMnJw?=
 =?utf-8?B?WUFGeFJ6MmtQSWgxUzdBbjREYXJUYkNqSGZzMVNtOGRwRU9qREZ0RkNqNzd5?=
 =?utf-8?B?VWtaQVlzR3FCaGZMUk52UzA0YVEybER4R3ZucHJnbmZTakhldnlCa1NSNEpj?=
 =?utf-8?B?MkVlWGtpYzN2R1cwdUV6MUxXOEFXT2hidnJCaERqRU5mQVhSc091UTlJdm05?=
 =?utf-8?B?ZjBjL0tBdUtGTFBVaElJcGNUdXNqSzkyM2VseGxlR1FYQnBLSGl4MU82d0hX?=
 =?utf-8?B?YlpWekltTVlrTjFqS09ETEhOVS92WXpScUxtbzllUC9GQXp0NXNNa2IzU0NG?=
 =?utf-8?B?d0phOGZ0K2JhSVB1RGt2cm9ZSVJPMFpqRmk4OGhLMmNFM2VGc1kzRCtVeGJJ?=
 =?utf-8?B?dmNTQndKbWw3K2lKMjdLRHFaQ3dGWlBnYnBLRE9kZlFNMFFFa1N5Rm1oMDVL?=
 =?utf-8?B?VDBDdE4zZ1VPeGFrc0I1Vld2bkxweEQ2YjJyREJVaC9GSFV2ek41dXp2eStw?=
 =?utf-8?B?UlN2VW5tRUVISk5ldkJPbWFGa1FEYVRDM0QrbkRzYVBpRE1rR0cxMzU2dGxZ?=
 =?utf-8?Q?i8l0gkze5eljz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NXRFcyL1V2VWdpcHpSMWFDUE1tNEZ0NjJub1lNb2FNclNlUVVabEJVVkY0?=
 =?utf-8?B?YnBPRGt0TzQxeWNPRURuZ3J0aXBnODVjQjcrdUIwY1Z4SHFzb29FZ3Z3d3FU?=
 =?utf-8?B?RjNveWRBeFJuclI1Kzh5ejhjaWJ3SkhxZHNqSWFBTWw5Zis4ZzZNR2NjVkxK?=
 =?utf-8?B?bG1zNmxOL1UrTndEYmdveURMY3ozT3RPWVpJNWlUcmh5dTBwdis3QXlHTkY5?=
 =?utf-8?B?eE9DSE5NVkpEZmRpdHNjblNxYmh4WWFBMWErVzV3OGtCK3ZvRHJHUEhaNFlP?=
 =?utf-8?B?Zk9qYVN1TlJwVHpSMmRlOVFQK2cwR1RtUzViaDRiUTRUQU5vWTAvanhpbTJH?=
 =?utf-8?B?dEpoQTNPUnE4ZVpBb1BFSDBOMnZrUWpVN1M0RmtldlBUeXQ4LzJyS1lyMDNC?=
 =?utf-8?B?OHNaaXpSbDNEcGZGcWRFRm1FcFE1ODdYL2theDlKVzA3SUlhYnhnaXU1ZzJT?=
 =?utf-8?B?dElNVmo2WXNXbTJuM1phbnB4Q2YwY1lyWXgxNkQ4bXU1QkY2OU5JMzNPVGNq?=
 =?utf-8?B?bzFjeUlUOXJHd09KdVBqU1pjbk4xcHJ4Zk1zd0kxZ3RYNzQzQlVvZVB5WjFQ?=
 =?utf-8?B?TWlRZ01QZkVzVzczMDl4V2gyQXBWN1o1V1pvZEJUUGU2SVZJYWJIRVhjSWpZ?=
 =?utf-8?B?QTdHY3VRUGJMay85MlFkdzJGMlM3SVNmN041Z041WlJoenlPaFdMc1FqYTJH?=
 =?utf-8?B?VS9xVitOb2U1WnpNZnZYZlFpRkZHb3BoeU0vTmxwUDJhZnFHYkhoK1pkaVFC?=
 =?utf-8?B?ZklvV0o5dEd1OURGTEFVNVBzZmlPdm84NVdZYlc4TGVhTXJHWEZwRUFra1Iw?=
 =?utf-8?B?VjZxQ0pYWHQxRnhHZlUwbUVHRzU4NlRsd0VaNjV1cnp1QWtOSTZJMkxzb3Yy?=
 =?utf-8?B?d0lDOVdwMzdLeUtUUk9vcDZzQlFKWlB5L0QyWm9VSjFDMGFsdkVTVjA3RUFH?=
 =?utf-8?B?SlErTFVWWExvQVh0cHh4ZEZiWlRpS1A1SzdrUTRvbXNwOWpBNlZ1d1JuWGdX?=
 =?utf-8?B?QW5KM1dzKyt2N1lDR0dCM3lJYjRGME5SeWlENWdHRER6TnVaTVVRek96czkz?=
 =?utf-8?B?R3hiZUNWbVNTNGtIczhQeTNjVk0weUZUR3ljUFBuRHhzS3laeE5SSWRVWnc3?=
 =?utf-8?B?NDIrVkhpZHMrTnBlN01NT3ZVQnJOUzVKN1JmSm9XOFl1TXBkV21BMkhSUTYv?=
 =?utf-8?B?R1hFTUs5bUtBbWI0anN4dGkrcXl6bmp6b0NocnF3TDE2d3QxU21ydzJxYjVT?=
 =?utf-8?B?cktrY0puT1ZTZzIwZzk4UTBvbkowVk1GbER4Q2hKQ3V2QlhwWjFQRndhTjlr?=
 =?utf-8?B?V1V2N04vSDdUMmxGUk9DMk0zL3h1UE9uYlJpZElYQUhoUkhYck5IZWRrZ1I5?=
 =?utf-8?B?cWpCTXBndTZoSnJGcVZrOXZsV3REMnBDbVhRb1lOQm1yckJWSVJEOGV5WmFR?=
 =?utf-8?B?bDBNRDRyOUxTZ0xFQTBaV2VWc29CQ2I5ZnM4blN0RWU2U0RqWTB5NHhxZk5C?=
 =?utf-8?B?Y2JXWE5ScWdOemVra29rK3NhVHhyZVZicjA4S2xwbHhhQUE1TjBoNFRuOXI0?=
 =?utf-8?B?cEhrRzdjZktsbmV2RERNOG5xbThqYmdzWkdyY0hZSDRTV3E2czlZOFlUbkY3?=
 =?utf-8?B?M1N3dnU4a2V5T3Q2ZWsyRVVkdFh2MkNPOFdiVEhFMTZRNWJMSnQ0UytXMGo2?=
 =?utf-8?B?dTRiSWlXVTdXUzVUM0JCQXl4YktKRWl4NTVSQkNZdHdzRmlTTnMzTXY0dk5l?=
 =?utf-8?B?eHhuY0RFcUI0bG1iSFZQZjZxUXRPWmRsc0hmMHFHSDdDdzRwQkxDQVZvbGpl?=
 =?utf-8?B?UlpST0RYUFhJUnNvR3hsbTNOck9XVzVrTkNoTk5Vc1VhdFBJSDBUbzBJVUR1?=
 =?utf-8?B?T0FtVmsydzlEMzZIRWR5RHMwazZJTEQzdURURVQ2V3h4eld4aHV3dXdWWGxt?=
 =?utf-8?B?ZEVieWZCTmorUmdyUzdsNjUxallncUNJQlFKMUdCYldEcy91U2JDOU1vY09v?=
 =?utf-8?B?TFFkY1hwbm0wZE8wRnhpTVkyTUdqK2xjMUtXSU5pNzlzSThsV3cwVE5iK2F2?=
 =?utf-8?B?eWNVbko5djNFcVZwMTJDbGxOeTBNa1JnTzhuOXpaajVqSHdBcTJTeVFPaW9N?=
 =?utf-8?Q?f7mu8WE+48asaI7iyjZJACgvI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31201203-39e1-43ac-29a8-08dd525d1fd7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:50:07.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qy0QV6ni0bmAbV6Lxzr3iBMgdRc1iQ0CtxdqVfLf2yl3NfWdSsDi4UMfeIO90JJItodqoeuMi73lm+XMT/LbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4098

On 19.02.25 23:07, Luis Claudio R. Goncalves wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 5.10.234-rt126 stable release.
> 
> This release is just an update to the new stable 5.10.234 version and
> no RT-specific changes have been made.
> 

Was [1] coming too late for this release cycle?

We may have run into this bug independently a second time here, I just
don't know the exact kernel version yet. However, we do know that 5.10
needs the fix as well.

Jan

> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v5.10-rt
>   Head SHA1: 5c5f37fc0ab0914da38776700e77a46ca3e30bf6
> 
> Or to build 5.10.234-rt126 directly, the following patches should be applied:
> 
>   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz
> 
>   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.234.xz
> 
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.234-rt126.patch.xz
> 
> Signing key fingerprint:
> 
>   9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26
> 
> All keys used for the above files and repositories can be found on the
> following git repository:
> 
>    git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
> 
> Enjoy!
> Luis
> 

[1]
https://lore.kernel.org/stable-rt/CAMLffL-PTp+Y-rXsTFaC5cUJyMMiXk-Gjx59WiQvcTe46rXFrw@mail.gmail.com/T/#m67dce3408cac40318ae3dbe1c713b13621ac66c9

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
