Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F2284691;
	Tue, 15 Apr 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712640; cv=fail; b=ULm9M5LDHrzy1gz4EwgHmcpfIxM8oLuSnoC14NXsZdz8vnBtlvE+sW1kPqbIHL12/J3+luWRR4YJcU7MFggAcddVN3v36J6LxLeAJWevw2Jzvd5zEfXwKMtbjN6YasDijwU4zD73ufKOZzcdPcGfY6Bki2ZwEIDiijxPexIsSbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712640; c=relaxed/simple;
	bh=8/VbUnvOL+km9U7PGC2zqmsWwyT9cmtpHGpJM6nGf4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFE2YHyPY+1uuD4k6Labu4b0qKb9XtNchrnr3VwPF0hra91+akdpkjuCGTN/w/2XZPXfmL2oXt4SCebfZrDzZwMx1Ycn7b4nIZ17eyIMQNsNBzrbcL3aZ0ACEReeCEc+c4bJOxMl5+c/1hJsL06MaGRVtcjAbHFSPaaIKxqoi0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qabUrMel; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qabUrMel"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiybk1lriV7BrSY7t84YxLLdpmknzeNneq6Fq8cngyRIQzUOQXB3wR5JfBBuA8bKfVvY9/GKl9qRQMEHCrGXLJky47bBUg6nfllWUg++FaIeJAHzRo3ZBNIdtys9A7dUPUfZlYTghVgg5/unmajYWf1YGzlQdo0kuGtwf3HKiANEfiJg+3FkAcjGqI19Fq86fcU3VcizBrl5MwNdx9a9rjK0vss6zQZwaqf5Z4rycfrzd6+VwhcHCxGV6EjIoAlskafC08F20hn9dBZoIJ1HPpWH7id+Y9tpbklzojd0Neo3SPUKF3dqNkifYjvsasBE8NtJajFChITOkJ0GCcILgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a7IXNgPZSKH0LdO95lAfj/LzTbd2rIH053q3qzRAgY=;
 b=ROvLSzln72AxDst4oGOJ+PD6A83uOlRWZomy7PtlkdV0pUFnbm++27PB77YUcYDYUD6zjqTfk8pLhUJl65Z69sGAG4iAuv3dg/1vy2DFoabqRIQipWx+VjGI5+s0gUgZAkc0zD+mGotV2KTVUP72lQXxFZYGMtuVEqyKsRMeJHZTs2r+MfbWSVHGG22h5Mjylr4U0ISv5yp++X0+lvCA5ufMexM1c02cG2fyEUepZsHbmRDQMpGxxXOqpFUZ9QxaCuoZUfnBjHgT7OWrRoxk3shBmiXKZx7yG3MmXW8EjUTpDhmtE0BH0BQaL9cqeoq84yHU7mieN4JJlD3DLofY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a7IXNgPZSKH0LdO95lAfj/LzTbd2rIH053q3qzRAgY=;
 b=qabUrMelcnsKLjTuhqxAD/i8/p/WXjjIDttMjEhwFZou2J2uHx7tvB+InW8GUJpmQFOw54YC+/AxIDPauKkdBqDPL6ps14nbfwNuqo+6uVh/zfp0ONoIoDS1u2MFpqqrxZD9OPGZA8LGBXClQEP+M655f8rObQATvQmw131mEtqKXd0wk7RRsl1O0W5yHsRyjC2CIBP8Rg4yNL4b/0z+OQuGDbnIi/RCBYJByITrsta7xfWuWTjL+UpRcLo40LuNja5xO62NQt1ynmQLDjIHWE0Qv0x+t5YrHrmVvaDJhk1AtultMQ6wUINyUHgjYpjQ8wNlmcju/KoSsR2yXa520g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 10:23:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 10:23:55 +0000
Message-ID: <e2d5f785-193b-46de-9a64-5cefa5196345@siemens.com>
Date: Tue, 15 Apr 2025 12:23:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Andreas Ziegler <ziegler.andreas@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
 <20250414150513.klU46xkw@linutronix.de>
 <438a5250-30c0-4820-9084-cdef50f67865@siemens.com>
 <20250415062320.bMvqQsQ4@linutronix.de>
 <f5520221-b5ec-4204-966c-881b3428d4c0@siemens.com>
 <20250415080041.kePLxkOG@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <20250415080041.kePLxkOG@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4030:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb5cc1e-e60d-45fd-27c1-08dd7c07a018
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVpyYU9VSkcyUTQ0dlFhVnV3OWFiSFZoSWFlSkdxWVA0aE5OaWJZWWdZeWtP?=
 =?utf-8?B?NkFMbCtLUkRNOW11U3BXZVB2RDlZdDJ5SWgwZGpDNHZ4LzlpanVsQXdDWG5I?=
 =?utf-8?B?UDFNSTRRNnA0dFdpYXYrZG05Y2RzbXBDSFdwV1NhS0VOWUJOcGlhSmdjZGd4?=
 =?utf-8?B?TmV0VE0zb2x0Q01jMEloZDhSTWRmcVpieEdTcTFsL2huYXo4dC9iamd5ZjV6?=
 =?utf-8?B?RjlVbXNOQm95R1UzOWZmQmczUnBteHZDVVUvcXptK0o1SFBITEFBZUNJOG9n?=
 =?utf-8?B?clhVbjNIVU81MGMyYStqWGhlZ3MwL3lzSDJtU1B6M3NVRUFTelVQMStWQkho?=
 =?utf-8?B?aVFmbmwyMGhvL0FBTGdOaldCWDNWV2JPZUFwZGQxNGQzaUlVbjVnU08xd3R6?=
 =?utf-8?B?OVUvWGVaVzVlcVZCbWFrUGF6SU8yd09ha1dxSUtqdDk5ODVPbEtZOUFMUGRy?=
 =?utf-8?B?SjUrdDdkT2FMZXdRaHg0V2RuSU5pd2xkNDJzMVVlU01QaHpGbkk2RXhMcy9B?=
 =?utf-8?B?WjFQWnJhUkVkRVJYcTZWVXJPdmswZGdaNmtuUGZGSkRmSENvZmNyN2ZrK0wx?=
 =?utf-8?B?WThKK1EvRU5JcktBaWZsU252d2EzZHB3ZWZUZDhxK1J3MlJtQ3p1Qlk5NEtY?=
 =?utf-8?B?SWFoYmpOSUVXeXNvY3ltVHJnb0dVUXRRbG4xeWhzL1pPbWxXRjcyM2I5eGJq?=
 =?utf-8?B?K09HWXpsSWNKYXhER1k3VTJPMjNRV2FJbEZXallHZDNVOHpSekk2a3VyNmVt?=
 =?utf-8?B?bmxaeGwvMzF5TWJENDdyb3FEZkNvR2F2TmhXVHpOY2NCV2tFUmF1eTdIY21y?=
 =?utf-8?B?TkRiV25KNThjK0lzMXZhdk1lbmhkQ3R6SjRLSTI3RVJzYmxueThkOC8vallh?=
 =?utf-8?B?MXo0ekpuM1huc1ZQc0x4Q3dnMGVyMG96VEtrTWdMN0RPNDlZVi9rNVhJU3U4?=
 =?utf-8?B?YjZZSjRtTGFqdWM5RnZiOTY4MEVVQUNiVVdvZ2ZPdlRMTXJtZFl5SFFRYXJX?=
 =?utf-8?B?aUdrRFlwOUpoeWxwUkdlWGtVZ0NyK3lKRzlNMElrdy9PN09ZSXh3TzlGdFBa?=
 =?utf-8?B?eTMrR1hicjA1TGxCOEl4YW90OGpQd3ZlelM1VTZvSk4rbGVZT1JqdVprQWtR?=
 =?utf-8?B?SmRVYlo1V0NiZm5jMVRxcXY2dVpLenQrYnF1SjdIcE15bDdENU90M3RpSEJJ?=
 =?utf-8?B?eVdWdzU5NmdMN1RUSzFtUGJCZmswYjRwSTFDSHo0ZXMreE16Z1BQbExjQk9k?=
 =?utf-8?B?U0QzcGlNV095OHF1aENNVzhHWjNsZndidTZzc3ZDak9kZ2V0V0x6bS96Y1N5?=
 =?utf-8?B?eU04WFNRMnVsdXdraE9COFp6TnVkVFVkanRaT2lyUFVzbTljSm5kMkNvMjM5?=
 =?utf-8?B?VncrRWpiR3ZQUXZtcE9LL25lR0dRSnB5YWpqcGw2dklPYzFmTlozYldXV1Jl?=
 =?utf-8?B?TGVSM1VqTWRCUjRWdTVWdkFBdzArZ3IwOW9LY2c1djNRa3Rsb25VSXIvRm9y?=
 =?utf-8?B?Z2xYaVJHL0dFVGpFais5TGVmME5ySXg5endscGpqUS9tQjkvZ2pEd3NWS0Iy?=
 =?utf-8?B?TkxOaiszWGhKdGRIMkVFWlFlRlhYRHpqZGZ5VDVHeHJ4YXB3L2kwQzZ3OHVu?=
 =?utf-8?B?cmNQOXMxalpLdHlFNWF6ZG5lUWdCVGRNV29ULytOVUpieW1KbjBCeDZIMENS?=
 =?utf-8?B?Tzl1UFF1aTlUOXB1OGpQS0V3WmtvRVpNSE9wM0FnWkxUMVAvSUpNUXk0eTlG?=
 =?utf-8?B?VXVWMkgzbHlud2dsUDgvSGN0YVdmSGFleGdjNVhSaTNPYitSa0V2YkZLS25P?=
 =?utf-8?B?TE5nSVFOQUJHSTFDeEFKWTZPSEF2bXJBVVZXdysrS0xqQUdUdmdYTzFpdHcv?=
 =?utf-8?B?enJBT0N3OVZLZ3JBUE1hTzQ2L3dLKzYyb05GckFCUkt4ak1OUmtlMEpVc1cr?=
 =?utf-8?Q?2MliKdVFj0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGRCOEJyc3dvOU5LS1c4a3VyQXlQaW1wM3EzajY3RzE0dzVRTXEvQisvUjBo?=
 =?utf-8?B?WUxlcmJNU1V1a2g2Y2ZKb1pvRG1qZEpFbHg4RkVMTUNoTWxmSGF2dG9PTDlM?=
 =?utf-8?B?bCtlQm15NVVxMDhydDJlUHVWUVpGYVpXcmlhcG9NNUtpRitxYUVOY3BuNHJr?=
 =?utf-8?B?aS9WVGM5ZW5LUk9WZUJaTkdMT3ovYzV2YlIxUFBId3YvVlRDTHFBK3BOT0ZN?=
 =?utf-8?B?SW5FL3pNeGk1cVJSdU1uWnh5T2N4c0ZCbGM1T2JWV3JDVG1iVEFyeVYvSUhF?=
 =?utf-8?B?ajBpMnY4WWpRWjlQTTZKZG1LSk5JWjF3dnBkTzExOU5qSDZOTUFmemRFZWVk?=
 =?utf-8?B?ZUVuODkzTXZuSEtkWjJIWTZOOEhqdjI0ZU5vU1lUN0RjYzJ6aTJNZWV2ZWdr?=
 =?utf-8?B?RnhFZVlsRFJCZkkvWm9aKzJSK00va0R2VzF4WXZCM2hUL1FQR3VkSFQ3aVVu?=
 =?utf-8?B?SWF5Mmd3V003TUNhNGc3ZTllNG1PMEZPUk5NcUMyMmtSM2MrZ0YxL2pPS3B5?=
 =?utf-8?B?RklGVmpmYk5ySzBUWUs0S3Z1QjJUcHdZQmJGQXMyVVBrWG9oeWJJTFNubDJE?=
 =?utf-8?B?dEUyOFlDL3VrOU1UWHFOU1pMR3JCanhzNUdIUmpBRm1QTDB1MHF1SzU1U1F0?=
 =?utf-8?B?aDdvTEZmVTYyYmdjNFBtQXI4WXkxTFJhTUgrdDdRdjZYOE54bWdrbjI2VTVw?=
 =?utf-8?B?dHF5WDFrRVU5ZmxjMmJtc2VncU8ydDBURWl5SU1ueWJESWlaUWU5ZHJzNkx1?=
 =?utf-8?B?OURtT2JzNHRyNCs2WXZuTEFqRExEWkxwZWY3NEpVR0dkczdOMTFvNmlvdTlM?=
 =?utf-8?B?MDkzNVAwVUswUkFaVXQzQVhzKzlOb0Z1NzR3U2wyZ1Bia3MxNmRrS0V1aXpG?=
 =?utf-8?B?Q0RVK09ISUlBSSsxT1lobWh0WFlYd1c1aWlDM21jZlNkaXRaM04xNkhESHlo?=
 =?utf-8?B?TnFZTStaQlN3WmgzbEFwd1VqKy9JSkJxR0dBQ0FiUzBGVmQxU1YvNlVMSk9K?=
 =?utf-8?B?QXVObDBTM0lkQkNFMWdDV1RDMU9aOENPeGhWUFYrNkd4SFRUWURRaXdlUklT?=
 =?utf-8?B?RXh4K3E0Z3N4UVEwZUIreUlMbkdjNlVwZnlvL1pma3B0YXdOdHRiUDJkQVIx?=
 =?utf-8?B?YnQxcUZqZ1ZnMUNLYnRBdE9OcUxCelVEZzdEaXZHWEh2eCtEVWtmRndCQmxi?=
 =?utf-8?B?S3c1TWV2K3RvSlVwek8zT211Y1FkTzhQLzJuSzQ2SlVHanRQVkZKVlNybWIy?=
 =?utf-8?B?SWJCN211TGpUOFBKaEFubzFRRjJtUVhCY1N1dHBhUDNlY1MrT0kzQzhYS2NI?=
 =?utf-8?B?TlZPRzFBajNiWWcxN1VMM3pmdUhqdG81K2dHeTcrTm1mL2oyNEc2SmRTNHJm?=
 =?utf-8?B?eU1FNFppRno5VXRzU2pzSndvck8vTEtCLzQvbFdJSElXdSsvWjR4SWNZczBI?=
 =?utf-8?B?Z1kxL1VQMXlRZVpPdnhiVm9DcU93MzZvenRvUCtnWEl1QzZuYk43bXRleUd1?=
 =?utf-8?B?UVRkSjJLUUdBejk0SEgxN3Bta2VyVGswNWE4cForK0t4dG0yZWY0NG1adG50?=
 =?utf-8?B?MzgwcXhUc3lUMFQ0VXhCdFRXaStacVhQNy83ME11NkxPTGNkR0YwQ2kyZGE5?=
 =?utf-8?B?ZlNOQk1GK3h0TkdhVzNOTEVtd0xOQmtDSDNnS09YTWcwMHZQV09lK204ZWNn?=
 =?utf-8?B?SU1RNTVUUnNXVlJrZUVNajhxbVVzUW95TnY5TUpoZUtYcDVzOWIwaCtpeGFQ?=
 =?utf-8?B?YXFEcFNLbWlMNUNWbkhDUWtOU1JGMGFYOUliM3hvajN4dmRuc2tnSjA0dXBw?=
 =?utf-8?B?dVJoMytWVXdTUUZUOE13NGd1SlViVGN3TGN6bXlOTm9YdXZybTg5VE53S2pt?=
 =?utf-8?B?Mm1nU0RHblY1TDZ2T0xYNWcxOXFCanlVQ2dnbUZWalN3c1pEZFNvZUFYZjdB?=
 =?utf-8?B?M2EwemgxanVTQ3htSVViVEt6aU5nSURUZ2dYZnQ1Z1RzWDl2NzdxL1BxUC85?=
 =?utf-8?B?OWFZNGd3RzQ2M29ueGNXQkZuZTBkMzNhaUkxZ1kxSVErMURZaVoxRWZITXhP?=
 =?utf-8?B?WEJPRURqdzg0NE1rL09leCtpZlZyRVZoMW9wZzNDTlY0ZXdmY080SEVKMWg3?=
 =?utf-8?B?Um5rb3RWZWQrRUVCWHpET1ZLbHRsUWp0T2lnSVpTRHhGZkYwaGNEc2ROQjAr?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb5cc1e-e60d-45fd-27c1-08dd7c07a018
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:23:55.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECxnyPJssIhmKSkLYTE1U2CHdBDI+L+IeWzXtL94ujosjU2UFyn92fuDTX7bk03UkUWqz1vPwaW6GseOkKzchg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4030

On 15.04.25 10:00, Sebastian Andrzej Siewior wrote:
> On 2025-04-15 08:54:01 [+0200], Jan Kiszka wrote:
>> On 15.04.25 08:23, Sebastian Andrzej Siewior wrote:
>>> On 2025-04-15 07:35:50 [+0200], Jan Kiszka wrote:
>>>>> On RT the read_lock() in the timer block, the write blocks, too. So
>>>>> every blocker on the lock is scheduled out until the reader is gone. On
>>>>> top of that, the reader gets RCU boosted with FIFO-1 by default to get
>>>>> out.
>>>>
>>>> There is no boosting of the active readers on RT as there is no
>>>> information recorded about who is currently holding a read lock. This is
>>>> the whole point why rwlocks are hairy with RT, I thought.
>>>
>>> Kind of, yes. PREEMPT_RT has by default RCU boosting enabled with
>>> SCHED_FIFO 1. If you acquire a readlock you start a RCU section. If you
>>> get stuck in a RCU section for too long then this boosting will take
>>> effect by making the task, within the RCU section, the owner of the
>>> boost-lock and the boosting task will try to acquire it. This is used to
>>> get SCHED_OTHER tasks out of the RCU section.
>>> But if a SCHED_FIFO task is on the CPU then this boosting will have to
>>> no effect because the scheduler will not switch to a task with lower
>>> priority.
>>
>> Does that boosting happen to need ktimersd or ksoftirqd (which both are
>> stalling in our case)? I'm still looking for the reason why it does not
>> help in the observed stall scenarios.
> 
> Your problem is that you likely have many reader which need to get out
> first. That spinlock replacement will help. I'm not sure about the CFS
> patch referenced in the thread here.

Nope, we only have two readers, one which is scheduled out by CFS and
another one - in soft IRQ context - that is getting stuck after the
writer promoted the held lock to a write lock.

> 
> That boosting requires a RCU reader that starts the mechanism (on rcu
> unlock). But I don't think that it will help. You would also need to
> raise the priority above to the writer level (manually) and that will
> likely break other things. It is meant to unstuck SCHED_OTHER tasks and
> not boost stuck reader as a side effect. Also I am not sure how that
> works with multiple tasks.

Ok, that is likely why we don't see that coming in for helping us out.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
