Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012061.outbound.protection.outlook.com [52.101.71.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA525EFBD;
	Wed,  9 Apr 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206752; cv=fail; b=oam1PZDj4I5fzgOTDZFkGax6nV0UhyBFrDRg9W5R26OsQoGBTcMKqogZavdSv723jXCM6nxwYLm99X5vC/h/4X2nLQTBuXew6RqLbSXal/4tZZswwxl/cuedQuD7ANXHf+pzOsMfpG+7ZkJEvunTJt/HEeUQdmjVE2UrWuNepdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206752; c=relaxed/simple;
	bh=5PXrD15EQENmb4DfxOFu0bWCXCnNYfBIz/9tDwS66rs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMIO4UNe3t6YQztGeXCaXMGmj6Q6ZF1/3X5Uqy3qn4WHu1UMzI2pcrwQanODDfQ8A36nK8/dWfWRo0J70dfxwgvubSqe74DBr+l92TkC95oBJ4dIdlgdAMMyfYc4Tbn7OjIM6YY++zVxraXUDjMMCTVzmy3eNvh4JvBtYv5VVlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QxeEqS3L; arc=fail smtp.client-ip=52.101.71.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QxeEqS3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh2Df7Jntd2Fa4/gLCe6QmJZ4Qac6QjFDoelvtpmDD/YA7PG6+nxPdjxtpwtxmje9tALca563RqFCtJSU1CtJF1+ulElXSIRiOk0IEXai0va5FT+PJ7+yT2DapNIrFHVbSAKKxRjzZrMM7QudC0xP4K5quVftrX58wSiAXD782tlv/3I/NIrjPlcqI0TcDgL+WpbUEG0fArCXDXjj50OKrzA/jkffVkxJ7q7kXALD22rHQ/q6nfE7GuqVr2/vg3nYyShJnISTmlgQtcBQF8NsEBV3XW+50+RJ5EujxBK5U5z9ighM8HGhXPA0JwhNVKxMt+EbJS+XfdySjvgO0gXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jmGoTmDCzqU2mcvf5eWu+VzPSM/pbNdsBvlqWRt+Lk=;
 b=QxuEAOTpM/hnHTcEtvGszta0Bh5M9/ZWj7foraJ8H8N7ROCfziZfJj3nH/D/y/Q2LS5WrSfmS12rx44fl/r9gCq5BqizKkARCTWaL8fnYPcDcNhjhp/SkdT5LVoG2SZQVBnx6dGelTmgb09tlvI4JspKq4aJcO3ZBZcPlK+BgixBrH25oTqgScenWZYS5zzvR5dRUyizC7fwEbT48b8lJx6zEVdb0KPvndxM77rkcJK49EOA4UsqKDvE1DDKk+Y62BEcRe/j6eEF2cjqoXuaIv1iaaGPf3cOLq2jXZG7NkFZBk63WOyInxQoCHIURx3rn73FFVpaOqfUpPfXPgjrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jmGoTmDCzqU2mcvf5eWu+VzPSM/pbNdsBvlqWRt+Lk=;
 b=QxeEqS3LiZ1jURlYwGWtVnzOaSyrVEXPK2oEaP2UuBhfV38e5EXCG1wT8dH/y7FSNm/0PEXO20Nq+SNZcvBGCd7BuqkTWFHFr5Iedt3aHHOR24kU2GCzbCPPeV4YXU+Bfw1FaKsSpNX4pfiLEv+ZheAVP2vCYHbeZiCZEoMv8fcAUi97GtjUPrx506xVFyYnXRlDDiHp558nYLKV1tkLSvG5NGn7kyztQZirol2jmUEwVEpOaAfhrIcfdX9K75xD+eF8mHu5WsmyaQ4gcHUaNzQuyPHVcjRuNILySn5kh2O7L59mDm7eG8kybm0A2ZfmL4AkiI6LIgYtB7XX7erfUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:397::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.49; Wed, 9 Apr
 2025 13:52:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 13:52:25 +0000
Message-ID: <905b3cca-e9ab-4844-bbe2-aa9a8c78e047@siemens.com>
Date: Wed, 9 Apr 2025 15:52:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Andreas Ziegler <ziegler.andreas@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <20250409132149.rFrzBCrP@linutronix.de>
 <be4fa21d-0b96-45de-ac5e-bdb54bee335e@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <be4fa21d-0b96-45de-ac5e-bdb54bee335e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f8c189-d5bb-4808-476c-08dd776dc221
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjNzYXgza2dPWjBjdU9lSVRQWjNEd2wyWEt5eEJQS3pQVFRjeDVaSEtOclRu?=
 =?utf-8?B?eHVJR1VZRy9NY1A1dEUrSlhHTFU3eUk5eGoyV2QrenQxV0Q3T1JmZTFVbkhw?=
 =?utf-8?B?V1lubVVjMTRSWnd4RGYySzlRc3RGVzJrSURCWFlJTklmMTNWeDNWZDRvUnBD?=
 =?utf-8?B?RUZOMzYzRGFLS0JMR0ZjMUN6bGozeHBreWtuR3BSamxDeWdTWkx5b3IxMGZw?=
 =?utf-8?B?cStBWE8vN01Hcjd4dDYrODVSZWNjMlBpT0VNWjJLVW00TUJHcTBqRDVVMVF5?=
 =?utf-8?B?RmZkSnZjODVqaVZ4SE1mT2NqUW41ZkxSNFZSUG9xdzgrTXNwREtSZ0NLdkQr?=
 =?utf-8?B?VEJ0ODFTQWpxMDVucUhBM1BlTk9SQlI3YXJHUDBTU2dYc0ErcUZYY2dzTHhC?=
 =?utf-8?B?SU1NVmpJcnhLRVpucHFHb2ptVlZ1cWdteUdVb3ZhK1VlVTMycksyOHFiaWFn?=
 =?utf-8?B?MGtkL0UxVEV4RExWR1pkY3ZEK2RkQ1FFYWxzSnVlZTlFZWY5enVFUDkyUml4?=
 =?utf-8?B?ZjhIZFA0elZrWVhlaURWSGdKVWZCcmFJZmlySVp4bVhibTRNSWpaZDQrOXh1?=
 =?utf-8?B?TVhUVDFqVVRLVGk5a2JlbDdRV1RlVVIzeUZPRVpnYU43RkFmK3dEMWZMKysw?=
 =?utf-8?B?RTRqUTFRSkxzT283OVJpaytraEtaTERseEYxUmFGSnR0S0R6ZVBQTGZrSWpZ?=
 =?utf-8?B?UGFGZld6VGpCeS9jR2NLVzlRZHpWczQ4SzVkVnkzZEtiTk10RUU3KzNVOGRL?=
 =?utf-8?B?bG9ObU9sUGx5Q3k5TEYzaDh0VnJoNzhNampaRHpuU1A0VHduZXc1WjUybkZH?=
 =?utf-8?B?V3I0dXMrTTA3QkVQbERZQytvWko0bTlIWXkzdW4zbE5WVXFNY1hjKzdXNEJy?=
 =?utf-8?B?ekZLTHU0cVFGL2JHRWo1cWpwZXk2N3oydFdSRTVnUDdOWGNUYlBsM05IZVRr?=
 =?utf-8?B?M1plUHVzRFFJeWpqN1laeEdMMGRLVUUwYUpEU2NuRDlHZm11UlY2Q0poOGNp?=
 =?utf-8?B?RStSNTRjamMweXZ5Zmd1RnBDcHNOUkh1ajFVRlRxMUNxSG0ycVJxNmFTRzlw?=
 =?utf-8?B?QVo1empsY0Y5aS9RWmh6b0JjNFQ2aUNGWHorLzB5bmw5aGVOOGpJMnNLVlht?=
 =?utf-8?B?RWxCeEd0NHBOTTFMZWFoQjZrZHRWS00wRmxLZVFoc3BQeUVyTHpFeFFwM2Qy?=
 =?utf-8?B?ekdxRTE3UzQ0ZDhiM2lPUUI0TzJ2QWNuU0tHSXByR2JpSVdITm45Zm9abTNX?=
 =?utf-8?B?OEg0SXNIRHBzcS9QV0p1aHVGcTJwUmFxN2JtQkFyeUlVclIxQy9OK3AzRG85?=
 =?utf-8?B?R1pybm1QTHlGL09hTDFYb3VyTnNUeHZ5eHlSbys3YjNYYmIydW41aUxyNkg1?=
 =?utf-8?B?ZzNaNnE3K21kaVM1YWtpTlVCdCs4d2tqN1lTWFFSdVFqbkZDSnY5NFkwd3lr?=
 =?utf-8?B?V0VtWVRFWWhFOUtZU21Qb05Ia0pFMjNMUDl2WVVkd0k1K1U2KzhRYjU2NEpB?=
 =?utf-8?B?SGlmeVRyL1dKbFVBMGtSRG4zZDVnU2pCeEJvMXlEN0x4cTFjZnhMUU1RN2tO?=
 =?utf-8?B?NU80V2dJTVpVSXFHS2xDQm80dEVtUWRGQWNTZ0k5alhOdDdOYTVnamdaNjdD?=
 =?utf-8?B?NEd5VFFqRVl0YVNxZnQ3NjhFbWh4c21OZ2ZaaThvT3VwQ1R2S1RGY3RBZTEv?=
 =?utf-8?B?bjlEUWdtN2RBTm9UeWd0QnIxYjYySVJyR3lLZUg0cVpENXdIYVpyWDArKzNH?=
 =?utf-8?B?OFZncnV1R3NRc05ScHRTbTZvZnRuS3hMZkY4SXBFbFJNT2haWXg2cXlvUlJi?=
 =?utf-8?B?ZWZBNjd3bnFiR0xwV0YxVVFFZDhkYlJreGJqVFovVWcrQ042OWxjQ2paWUVC?=
 =?utf-8?Q?HU9fAU6LYVfp6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzdYdkRqNHE2Z0RnN3htZmVHSmQ2NG9EWTFZVEFjZ2ZERFZvSVprZlNTQzZs?=
 =?utf-8?B?RUZPYVJTU3g2UkxBd0Q0dFR1a1llMGRXUnZ2aHRIWElZbW1TVVlCcm9CNzIx?=
 =?utf-8?B?bzNYcFRaaXErTCtRY2wrQWsrbkZSN20ycVJPaXhCOE5aWDM4UXpSUVd1bzgx?=
 =?utf-8?B?eWdxL1hqWFhqbkV4ajRNVkQ4SUVFWjJPSW54NytKSytMNnFPMDV1YURjckJ5?=
 =?utf-8?B?bWFVSHc5U3AwSEtJMmsxT3hTbjR2dmpUY1p2UlVjbG9JTjAxMjM1ZFdBejFa?=
 =?utf-8?B?Nkd6YUFkbHJFbkZkWjRxOHNjcXpQWlhxdjhJTERZc2YwNjAwZUpiZ0xCNThn?=
 =?utf-8?B?K21KY0pYaDFuNGMwY1dEOERsTDJ6TnU1RkRNMTg4Z3RMaFFndkpnOSthWkRl?=
 =?utf-8?B?NkFCTmhiVlJxQm1yT2Jkd1EwTEZZT3FHaE5BdUt1b2R2V2w2UUM5emR3L2tx?=
 =?utf-8?B?OW9XQUVtWUxnSUhuZEpWWTJrMzZXN2JOdy9BU0NEd2U0V3ZlWjRJcU93bkZ2?=
 =?utf-8?B?aVV1ZElBeml4RWpud1FBWU1Ib094ZGV3a2JjRldYVjk3cFM4dnJ1UFk2U0d3?=
 =?utf-8?B?d1Y1WW9LZld2eE1Sb3NRakdqVm1ibk1YeGVFaXE1eE9IWjd0WDlaNFZHRVRu?=
 =?utf-8?B?bmR3MkQvdHViQWZMMW13S3lWbUZoVStrZjkxbGJEWTZQUFFMYzJ4cDJNTUpD?=
 =?utf-8?B?Wm1jcUhFTWo0bkFHc2Zvc2lMSFlSdi9TWEE3TVk2YlJBQ2F0V3ZFZHFWYk5L?=
 =?utf-8?B?Qk5JMmh3Q2l6N0ZGMVpmc3o3UXBwMFhsamZJYnN6YkIxMGlCOC9abmtGcDNi?=
 =?utf-8?B?ZVpkZUpBOGxYU0RzVXNOblNBRi9VdEt0RUFKNnZaV2s0RG95cmdXd0VGVSs0?=
 =?utf-8?B?eFZyUHFLbHp3R0JaOGlZV0ZvS1hxTndZT2dyMWdpbm1Tbm80ZWhIWmppQUlp?=
 =?utf-8?B?VmExbk9jcWh4ci84UCtWcit1QVRHazhZWHEwZnlVZEFzVWVOdFJuTXVpYU42?=
 =?utf-8?B?QU9maGxSSklFamxkRnEvdEdrUlhJdVpNYU1aM3RZVmowYTI1Y2paTktHZk5m?=
 =?utf-8?B?SFJlN2NLQThiZXBWT3FOVXdCaXdUMkhGRWh6aWpGVzRFZDR4UjVSTFJHMFNp?=
 =?utf-8?B?M20yMUpSdjNVaytWMEV5TWp6cFJTQWQ4eTQvejlGMDlOU3ZNY3dhTzVKQjh4?=
 =?utf-8?B?ekRrZDg1MGJMM016UVZiVGJFZ2xWQzlZQVdWQlJmc05aVzNhZm1jU1hPV0Jh?=
 =?utf-8?B?V25wUWd0NHk3aFpETTBHclNnRU13OUlzSmVFUy9ybUhJcUNRcUtvZjBORG9t?=
 =?utf-8?B?Rkg2VVdTRmE3Rjd0SStJdXVrVmNZbFFUWVBqNTdQWCtZVWlyaEhHREo4bGJt?=
 =?utf-8?B?eXBRZlM0NHpNbUZDalZKS2tub29sMks2djdMN0JFVFYxazNTSzh2TEpoY2sy?=
 =?utf-8?B?SDBoczRTYVh5U0thQUtuNHlaQ3dRTWR3YnlBQkV6bCtvRFBYQXNLbndKV2I4?=
 =?utf-8?B?ZVNiZE5zUUdvaCtNcGlqanYyRVNKVjFXK0hOcjZmcG0zL0FRU3RSWUQ4Smdv?=
 =?utf-8?B?Z0hjeGM3dC9Hd3lZVkZBejJYU29iQWRvT3hVbytKdzZwWE8wKzBlTFBpclZv?=
 =?utf-8?B?RC9OYzNVWkx2R3M3VVpFY3VIRlJocmVqWHBNeEFhTHlYZWFrNHFaQ3BoS1hY?=
 =?utf-8?B?WWhpY3ExeGNmMTdGQU4wR1E4RnBUOWZUR2YzR2lnY0VuM3NZZzViajNBZkQ4?=
 =?utf-8?B?c3RTaVdPcDAxU0xuVDY5ck9kSjJSSGVBTTB3cldvbTNtNkNVczVvQjIyUnFE?=
 =?utf-8?B?Qmo0RjdoUjdhR0NySndCYi9LWm8rTE0xWlQycytPSzJJU0M1NlhWSVdUVkxw?=
 =?utf-8?B?S0RUcitvMFdad1FIWmZtRm9YVWZwRTJYc2NKVlQxVlhydWJHQUh0NnUydWhL?=
 =?utf-8?B?WjdNYnFhNzhpRVhKMTA4aXd3MWR2RHE3YXdzUGFFQU9DR3NxWVExSTc2dGxD?=
 =?utf-8?B?TS9Tb2FuVlhrQXg3dnBvM3FsUUlMWElVMWVxWjZvM1dqNUxMZEJQSmtkUlNG?=
 =?utf-8?B?Q1NqUUhrcmwraDR4SjBXRjM5Q2dPMDMzdnBONitlZDBPWERDNFI1UG5Gc1ZE?=
 =?utf-8?B?UUUvVStpRWpndGpSVjBlb2wxd0hBTHJwclg3OGM5QnVVaEVYaGhvRkdjdjUy?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f8c189-d5bb-4808-476c-08dd776dc221
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:52:25.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXg5Y1Sspk3DMYkF0VjF/ExEknh/w6IpKa2rtMOJ0cRTDE13SnDr50n5RO4nVldz2cy5q4bTQ/nqo7Lgl88Rqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5860

On 09.04.25 15:41, Jan Kiszka wrote:
> On 09.04.25 15:21, Sebastian Andrzej Siewior wrote:
>> On 2025-04-09 08:41:44 [+0200], Jan Kiszka wrote:
>>> We are hunting for quite some time sporadic lock-ups or RT systems, 
>>> first only in the field (sigh), now finally also in the lab. Those have 
>>> a fairly high overlap with what was described here. Our baselines so 
>>> far: 6.1-rt, Debian and vanilla. We are currently preparing experiments 
>>> with latest mainline.
>>>
>>> While this thread remained silent afterwards, we have found [1][2][3] as 
>>> apparently related. But this means we are still with this RT bug, even 
>>> in latest 6.15-rc1?
>>
>> Not sure the commits are related. The problem here is that RW locks are
>> not really real time friendly. Frederick had a simple fix to it
>> 	https://lore.kernel.org/all/20210825132754.GA895675@lothringen/
>>
>> but yeah. The alternative, which I didn't look into, would be to replace
>> the reader side with RCU so we would just have the writer lock. That
>> mean we need to RW lock because of performance…
>>
> 
> We know that epoll is not a good idea for RT programs. However, our
> problem is that already non-RT programs manage to lock up an RT-enabled
> system.

On second glance, Frederic's patch would probably also avoid the issue
we are seeing as it should bring PI to the CFS-throttled read-lock
holder (which is now a write-lock holder).

But given how old that proposal is, I assume the performance impact was
even for the RT kernel too much, wasn't it?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
