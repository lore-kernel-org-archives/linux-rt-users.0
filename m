Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D032DFA32;
	Tue, 15 Apr 2025 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744695357; cv=fail; b=NJM8VQHznSbTH6G9v7AJ8zWWxmgUGGagkDsv92WBfEmi04UU3Phe9ZrgJMZLl8Ih0Qm91BUqtZ1RmECYAoc6TsCVe4M+zQUvQ6InTg55hygOJBczY9BjIknHWtKNghfydcvdAOFjSfUk/3+9bO4EPKJwUZeQirRP01KGyw2nMCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744695357; c=relaxed/simple;
	bh=DEyqHTciZL0SLfhW4GYoX44mgU6+ZeWm5VC5vlR9Pf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ/QXANV+RC3QB/QOA83e9wQxFHovo9Dt7mwfJM5uY6XqWAehtZyiPndAgMc6ZQk7Ihebe5av7itq6K+ncO62TdD0EcTV4d331jLM6iHyFd4byzlIzZOo2TUUDNTPqHKXXxCUb/IovTB0mqbox68tv99IF60CJ1zDxgwVau7xVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KOQhCmi2; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KOQhCmi2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzknquQ7jLmpyMgwaueHesuaau5ucU7GLGcQHX4EE37OyynB1TDJNpQKarDrehTnj0enkS3B/RaleVrpThZRz7yceCgscy/gyGx38xQ5/qUJ3eDwBpblmUd6JZRm0O+1VP88iqMULMUYjtXQeO1Q6hMozNX0T0bLU8eeGU6Ot9RDQhUAAHk0sm1L6rqGVl70TYffiVbyzCG+C4anX3sXPB5dbH5eFSyyrTehCJUyrPnjd7ru4JavhF/U3fygMkFjRf7m27ig7UZEByAC/oUvcXanahN24p4MKcickladv2pr/J013MazijR8oX74b/XlxCpL2tiaFDrAA5fNSpaalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3dh7VC5ak0Al6YjvS3fuBJKyTkMZKyt7aZUSS+Kcjs=;
 b=tLSVVhcE/13NDnLQrazI34AXaRuyBb5Tf/74sgOVpC8V5zBLaLqHe6gd7OzVIYvTmtfCD9ZYZC+xqA+0UWFHBjDwz5gprsn26S5iMJU+Tr24g8AlBItSVVjAyvm1gWopauHaSW2pexap3DHwmI1GKEphwpd1MyN9UqZ+gP/rPcTn0HM38GO/23I4CKGgzn0mTMWMbKV8O3AdWw2mYe9KxfCi6h4U5dg7XT+vl8C9eO/EqeZIjvUqefYRTnJxQja8fszb2bp1Hg5zdz/A2CtgSSWUj+2CbnfaPP9fschC9v3bw+9ENwrnAzwz5qoxJILKr5lH7Ocabigh4yglmE1Smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3dh7VC5ak0Al6YjvS3fuBJKyTkMZKyt7aZUSS+Kcjs=;
 b=KOQhCmi2urnQ7Yq/oIqejuDz1yiwLg8D8/YmCr3XCaWMZPrMgzZZhqsvURkm+KoGQYe2hw5pcsYxAlnHxw9wORLev2ZmvLaTXHWD3UhDmrJ8tvx+Y9J29x/LYEKlCCgWzf+OOfm2/8j8C7VUAZjOnGWdBiw3yekoRZzXy3kMrN2QCr9avfTsolkno1g5f7jzPaxP2QbNWwOxfsR+VpcGVWRXc6B2RJvMVr+o/txWRPe7pI56XiloWjjI4evyKgNwTbfEDesC7Csd74oJVCFIrA4abTvO2fiP4W+lCczjuRqhK6BnxAZeSI7OBvN5Gx6jMUagbvQWZZm9y/PiDGMaaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 15 Apr
 2025 05:35:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 05:35:51 +0000
Message-ID: <438a5250-30c0-4820-9084-cdef50f67865@siemens.com>
Date: Tue, 15 Apr 2025 07:35:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Aaron Lu <ziqianlu@bytedance.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-rt-users@vger.kernel.org,
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
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
 <20250414150513.klU46xkw@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250414150513.klU46xkw@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: c62caaec-eff4-43b8-7d45-08dd7bdf6268
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHNiQmdHT3RFakJXVnZmUDc0S1VwbzFoZlNuK1NGamtTazhRSGFJZ3Y5d2NP?=
 =?utf-8?B?Q3dYcFd3VU02elc2ZlFkQVRpZGtVdmpWR05FK1pTRm9TS1prcVNXeFV0dFdO?=
 =?utf-8?B?TVhxai9OVlhWZ0t6RHVnOENMMEpibnA3M1dTWDZoMm93T25hWGZmaTgwa3FP?=
 =?utf-8?B?YTZZQkdwU1c5ZE4rZys1bFJjYmY2emorS3Roc296VlJPZ2Y5QzVtUVVIVUJI?=
 =?utf-8?B?K0tHNmlSNk9TMjJLUHpvT3h2bFpYYkFJQXBSYk94ajd6R0Q5V2M4L1E0NFZ6?=
 =?utf-8?B?OW9sbTBvcGF6UmFxcFUzSHFXdStrV255OVVwcEFCNUFIcW05S1g0aWNSNUk2?=
 =?utf-8?B?S3Z4RWRUR05tdHdMRHhjNUhyWkNSaVIvdEgxbHNSYk9SZnVmcWwycWRLSXQ1?=
 =?utf-8?B?RC9pM1g0V2hZUHFUWXJRaHFubnBOeWtUN2tPN05XMmUzcmlZd1FZckRHcTJn?=
 =?utf-8?B?M3BBTFB4YnV6Zm9PNERZb1hQSnhpU3VBUUtNNjBIUmNMZ3hYOGE5d01GMjBP?=
 =?utf-8?B?TzdsWU5Qa01qaFZuWmZKbFNjSFg3Ujl1UzFkbStHK0V3bCtRNVNGUVhwbVlk?=
 =?utf-8?B?SGwrR1RnY2szcGtGZ0xsSWFSQnhJKzRvckcwZHA4TUlIZU1SS2FJaUUwaFVS?=
 =?utf-8?B?SktwQ3A1NkVGVUtTejRoZGx3TEdUN0ZidGsrc25yK3VVVm9Hclk0R3lqNXFF?=
 =?utf-8?B?MHJ3U1NWREJKWVh0RStnc3hSN0E3NFlvdmc4RG94NnVnSm5sTVROenZYQ0lC?=
 =?utf-8?B?VDZQVHQ3K1dIbGZ4Tm5DUFYxdm1NbDV4SS93WmZLQjI5YnFmNjZPc3EvZE42?=
 =?utf-8?B?QlZHYkNLMmkrUnRFRDV0bldySFFiZ1NqakpkMlpFL2hGM0FtcGJKL0ZHT2tD?=
 =?utf-8?B?SjdhR3duNGtSNjdZbUFTUmJvVzkvdzlId08vakI2anJNSWxZcVZtV2RhUUEv?=
 =?utf-8?B?YlVNQ2J4NXVWQitlNHJMcVVXdHBlcjlqTldJMjIzaHFiVy91ZldVTGFDc2dv?=
 =?utf-8?B?RVN5RnNtT0VZbzVPcFVvajBEU09sd1hnRnlXa25pL3Y0dmlRcC94b1RTbEpP?=
 =?utf-8?B?QTNwLzRuR3Y3VENXVDVGVnZNeFovYzhqaUFJb015eWZBb1ovUlFZTGxwV1lC?=
 =?utf-8?B?NkNMR0hubi83eDBGZUxQck0reTQ2MWhQYTNSOE5WM0J1VkpSV1o1b2huRFAv?=
 =?utf-8?B?S3UvQU9EK2RtUUNjYVphWEdTRmo5ZnJlaTJKV210Q3J2NC81ZDFRbjQrOGVM?=
 =?utf-8?B?STQ5SUY4RUovRkdXRVJET3hmckl6S0FTMGdOaE4yVTFhZkQ4NFViU2VzU2hy?=
 =?utf-8?B?ckwxUnhJUmJjNktqaGhndnNqejNUbC9ic3BSWC9JekJjTDlCbnRKWkNDbTJJ?=
 =?utf-8?B?ZVZ4U0FLbFBZTDRNSW9qZzVXaFE3L3BENXJsKzFKTndPRzlWK3hCbmRoUFJQ?=
 =?utf-8?B?VnZZU2xmVjFPTzJPbFM1N2RoUnVGaWJobkF6bXBBV1JZMHlEM3NPRjBEZ3dU?=
 =?utf-8?B?a3QvdzlCc1Rxb1pQUzVXaldvelExR0lHdXkxNitmays3OFM1Nkk3aG5pSUxZ?=
 =?utf-8?B?OUNUUFY5bUxnZjNnMUUvVmpraWNlUjlHRXpWSU5pdlZ0UWRSb08yZ2lSdld2?=
 =?utf-8?B?NVBMaVVNVXFlUzUyNWhVUkJUNzhpSzh1ZTQ1ay93ZXhOc0phNWh1Um1NYk1I?=
 =?utf-8?B?QkdmWnFZTEQ2b2hCWUVFOWtFRVhaOWE2UXhZRVVuQ0NFVlduZVhhQVNkb3dq?=
 =?utf-8?B?RnlZQTRVK2I4Ukt4TVNpRnI0dWdGV25LSENwVTdiMmwxTXdxbkFBNlFENWFQ?=
 =?utf-8?B?YVRYVW5BLzVUMFZRUUIwZ3FqQ0RBR3o2K3lHU01lTU1kSVkzeXJCUCs0QVpG?=
 =?utf-8?B?SWN4RDdzQWZrbzlYVXpjMHZyak9xSFZ0T3VNL0JoNDNRMnh5ZE1EaEc1d0h5?=
 =?utf-8?Q?gIJ5gPDzEJo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SldEN3VLMWljb1VScDl0aWx5dlFKMWFmcWt1Wm93YkJpSE00V1Y3c3NpaTdR?=
 =?utf-8?B?em9PSmlrWmNQZ3UvNG02K01tQlJ4OGt6ZWxCZXpaZlB6RHloL2t1MElDd1dO?=
 =?utf-8?B?U1cwdi9rRzBlMlIzYm5pcDBYWUp4WHdtbnRaa1A3dmNHSUZCWlpLTnFqQXFp?=
 =?utf-8?B?SXFvejJBakNlN25HRWoxZ2hWazZCbzFTQjlza3l1dlhlU3FNdWJvaFdNOGVR?=
 =?utf-8?B?aWZRNExWZ3ZSUTR2M09TYkR3dFFzUDBTR0xZQmd6WlpiUjdHakg3QkNMVm14?=
 =?utf-8?B?eVFlSk84RWFUREdxcUlScUxLeVNENWF5Y20yNjJKbzk3VE14QitoNzRWblFP?=
 =?utf-8?B?eGJtSW1EeExIVHRHcVQrVmdtYWtMT3kwaDZSNU5kOWhXSVJuRUxEbEx4Yk5y?=
 =?utf-8?B?eS96cEdjSFZOdUk0a1N6RndPQkJibE9wMGFXOWQwSnhWbi9tOTZxZHBzN0ZV?=
 =?utf-8?B?SHhWTnBwdWxOTW4vTmVtMHV6SWhqN0ZMNVg2cE8yVHd1Q2lQQ29WMUUwcDM1?=
 =?utf-8?B?eGhVdkNpWFl1bGdBTGVuY0FCQ0I3L2hqU0hPTlFIZGxDSDBaaFpHQzZMMVFY?=
 =?utf-8?B?MmY3SVBvOGRHNlF0WUtYdlhrOU12d05XWU1hbENPT3NZRUVtUkhqQ2hIQXlk?=
 =?utf-8?B?RFl4WUxjK3VoQVJmT2FoMXFYWTB5eU1QSUlwOUdWMjBldXNKTVEzakRHdW1X?=
 =?utf-8?B?ZFNJK2grTkFhS0VqUXpXcjFxZ0NuaDh4MEdnVW15UUtTemp1S0ViSThOWDdt?=
 =?utf-8?B?eEdSL09EZnVZb2hCTE41d0xyU0poanlrWlR3bGpOdzFJSlA5cGt4a01pS1JC?=
 =?utf-8?B?a0ZYSDZNUTdGbW9HU1FEVzNUODl6bVEyQ0cxdm90SmpIUWFTenQwTkhyQ2to?=
 =?utf-8?B?WkFKaHUxVlZhWDlrQ0JMUFlZbGlKS1BpekFzbXIyajk2bDR4L3lIajRBbFhL?=
 =?utf-8?B?RkJDNHhIaUFpem05TVVhZFNpeWVvdW01K3I5VmVtbUlEcW5FVHRqUTVWcFd6?=
 =?utf-8?B?a2pkZXdmQTF1eUczYzBnQTJXVlhwN3NkcXZtbXBHVGdueWNpTDdVMmt4Yzlk?=
 =?utf-8?B?TUpCQVF0K0V6NlZacUw2NnFiOXVMWWpDWDNTdHhnTlhDTkRudFFDSy9VbjVC?=
 =?utf-8?B?czk1T1A3Q1Y4c2hpZVVJcXlqeXBibXlXdGFvbWpiV25TTmtueVhCZE4veGI1?=
 =?utf-8?B?TzJKdnFFS1dNcENFa1dqSllZSXN0cEJNcXNNSjNacC9RcGRZc1U3cmQ4Zmow?=
 =?utf-8?B?UHpiZVd1U2RQOWFpbUw0bTZrcENuWHZGWnJTZ252alVENWJTcWhvcUg3NXhT?=
 =?utf-8?B?WTBNeG5pMUQyVUF6WlNpZXE3ZWEyVGZnRnFZQ0VSc0w1TURQZnJOMDdvK2Vz?=
 =?utf-8?B?OWxCeWRrN1BCYzNpOUk5SkRoOXp5bjVFeGNCNDRwLzFid3VoMmU0aEdMT2ll?=
 =?utf-8?B?eTB2MmNXYTc1cmlIdVR6UXpLRjZBSHB6N0xQbDZRQ3UvWk1DSmZpWmpkdTcx?=
 =?utf-8?B?ZGFZTWN4TVhkRjlVcW1neVZ5cGVOaUZ1M3hNZEMwRnp2djBpMUZaT0NwbzVZ?=
 =?utf-8?B?ZSs1cXBJNWVGUkE4VlpLVUpLM3k1c1dGZlVRU2pGaGRhVzUxNGZxaFNGTDNV?=
 =?utf-8?B?cHA4NGNsdGF0WTVjS3E4V1d6M2lYRGEvOWZ0NUU3TXpuVGwwdUdyNGxvOVVj?=
 =?utf-8?B?cExuTTdSVHZtUk9RU05zK0VCam0yTndzMklIQWk2SEk1M0VyOFN1Q1g2TjZo?=
 =?utf-8?B?b1pITVZKTnlqbkpzM0VhMVN0eC9ac0wvRWh2bE5BYkhyeS80WHhVTUpSWGIw?=
 =?utf-8?B?Z2xoZ3h6cUljYzRwRzcvaDFFR2VTS0FMUDZyNjRQSFVqNitJY2ZZcWNyUkEy?=
 =?utf-8?B?dDV4N0xhOTUrYStaSlA3VnNHcUlnT05qYUFiRHAxUGZBT1pISXJWakVVdFlR?=
 =?utf-8?B?dXoxME9EYUF5dk5tdDVCQU1kMVRVQU9pQWZKb1dzMTVjUGg2SDhVVzdQaHRM?=
 =?utf-8?B?VzJPTHhiVW8yeTZzSTlucEVuWFhLZVpwTXpYYXN1TGpLSzNWT0dGQUZIaW5l?=
 =?utf-8?B?MjNUV3ZnWXBvWCtHOHVRS25OZFB3YnZ3dWFleVE5ZXpwUGFNSTduSWRDbE4z?=
 =?utf-8?Q?6FSiKJxtGIzabYJ3jVhOYsDHn?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62caaec-eff4-43b8-7d45-08dd7bdf6268
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 05:35:51.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPbdPi40JBmUcfz9iVz83q/ADGanXW9PkmKFW0D4RwlioCb4/KOeY9dlw90EDw9YFJ2PmZsKDNN1qLojbBDt4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5939

On 14.04.25 17:05, Sebastian Andrzej Siewior wrote:
> On 2025-04-14 20:20:04 [+0530], K Prateek Nayak wrote:
>> Note: I could not reproduce the splat with !PREEMPT_RT kernel
>> (CONFIG_PREEMPT=y) or with small loops counts that don't exhaust the
>> cfs bandwidth.
> 
> Not sure what this has to do with anything.
> On !RT the read_lock() in the timer can be acquired even with a pending
> writer. The writer keeps spinning until the main thread is gone. There
> should be no RCU boosting but the RCU still is there, too.
> 
> On RT the read_lock() in the timer block, the write blocks, too. So
> every blocker on the lock is scheduled out until the reader is gone. On
> top of that, the reader gets RCU boosted with FIFO-1 by default to get
> out.

There is no boosting of the active readers on RT as there is no
information recorded about who is currently holding a read lock. This is
the whole point why rwlocks are hairy with RT, I thought.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
