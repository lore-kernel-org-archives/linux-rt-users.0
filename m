Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD127A10C
	for <linux-rt-users@vger.kernel.org>; Tue,  5 Aug 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403105; cv=fail; b=GjkZIkwlxyL0VwANjIM4mVTCHe+nPBlxf214aLFeaTMxqNBDqHtuWGrNBnjSs9iHGYZednhrv1/4v5U5GT794+Bc+OtmiPfz3q9IxK/BSIsV//z/qOS6RoJQvOkkYrUbBH0+h1oHZURG7uCdUG/AlMkdxGqtMIJe7KtjjERRpLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403105; c=relaxed/simple;
	bh=uqeRAagf4ddVZQFJztfaXlWX0lyPCsxTvD8rKkjBOLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kz4AQF4Q1nSp4HFvPnt0qNvZDfY4+Dw7c8ioHLiAF+R+Pr4fyHgjpM90VndnavUnGFUHTegHhQk6H1TxHrtRzr7HBuGlPfURBOtVi8vYguRsv+o7gYVjzV8zDWkvMejcP8QS6OXzVFdjk2Rj6X8qxLVZFBlNsaJyAiVXwis5aIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=q3d0dKz2; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="q3d0dKz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3iB7IiaCJtOLiPk4P5vtIxYRytFsnt7Q7hestoNSAowjeuyMhWKkHERlrggkYWF9EjzlRwCMEbgztpA57i0d7QaA+2MLGEGF0GM+Lua2Lfc0sLVNOEgq9EAtlQbZxJR1i/GdoYcdOuUfGbHHM1yKYlgOimFhnf4HMzSdmCwg5G86JKowTmBmiage2u5yI5nouS6nPaTmYIjzQ+3S07sTdauksRqe3q81IpZSMFNuNNqQTqa0hxoQbuILAB/oMRHGptN6bbbfQDXmM7zIo0LSUYregzZtSbWdIxF+sBT1f2ItS/CBPZdO7nzCy86esotyMoXd6/yJ2Jxpp/vRXGnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqeRAagf4ddVZQFJztfaXlWX0lyPCsxTvD8rKkjBOLw=;
 b=jmKVHyiIGwfUsEZ44BQum9tcZ1v044XzuUdGE1xGo+DTzw9KPoS9wcXFxH9ccP/4szScHKa/iKoakg/uKNd3CT+UcJReFbm+sK2qt4e/OOU8CLHgAaa0TR1q8q+XmgBmBm569AS8AqCB9WgVC3kSmMjgFwRG39rayP9RWF4vuBCmcLHtc6n7M8VTegFNoyvBw/jyRqtwK8GYi+HuJ61i6FH6+EvOYymhJgCTX1sOTGDgbQORtmo/UDHAs5lnl0I4M6GsxYLYtQ78BERzPjJHUpzd6x3yS76RtuKPQpISXrBT0rZRhUYWxEhR7AF8thi8KSyTuWGY5HfxPBeSHDWceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqeRAagf4ddVZQFJztfaXlWX0lyPCsxTvD8rKkjBOLw=;
 b=q3d0dKz2lFUFoC0GedP0WZUjZoMeRZetENhULo0g/g3YUd0Bxgij/t+MfVzYM5AEucFigqPATCp8OTkSA0AZsZo90gcnRCX7Xy3uuFb7BiZZb2kvUgmS1Hj83+TgCPXG5KeU4kX3V9oKUO+Huhpd0GnV5r1Fu3GY7qh9r76YnwEziFHK9Df41QjPtPjNP2R29V2CnWTbcx58e2etG26h9DkXvNNX+KVLevMLICRnHGgXmN5OSkYdDGFEbDb6mkQeAQdq/giFLAX3oeCCKaPyLKesfQ7zQNzr4ICHazU2W2B5CqWgeLivn/T4PoIynzKXro/Sgk4CCqrgHNiN8IHYIw==
Received: from DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:322::12) by GVX0PF5391DB7D1.eurprd01.prod.exchangelabs.com
 (2603:10a6:158:401::84d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 14:11:37 +0000
Received: from DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 ([fe80::27a:7a68:5d97:fae3]) by DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 ([fe80::27a:7a68:5d97:fae3%5]) with mapi id 15.20.8964.019; Tue, 5 Aug 2025
 14:11:37 +0000
From: Alexander Krabler <Alexander.Krabler@kuka.com>
To: Frank van der Linden <fvdl@google.com>, Vlastimil Babka <vbabka@suse.cz>
CC: Mike Galbraith <efault@gmx.de>, "linux-rt-users@vger.kernel.org"
	<linux-rt-users@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Dennis Schimmel <Dennis.Schimmel@kuka.com>, Daniel Braunwarth
	<Daniel.Braunwarth@kuka.com>, Hugh Dickins <hughd@google.com>
Subject: Re: Realtime threads delayed due to kcompactd0
Thread-Topic: Realtime threads delayed due to kcompactd0
Thread-Index:
 AQHb/SUMECAAoxVz1UW75TJas4YXXLRMmU4AgAABygCAAIeOAIAAeK4AgACe+ACABe3aag==
Date: Tue, 5 Aug 2025 14:11:37 +0000
Message-ID:
 <DU0PR01MB103853936E7A3476080F411BF8222A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
References:
 <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com>
 <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz>
 <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
 <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
 <CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com>
In-Reply-To:
 <CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com>
Accept-Language: en-DE, de-DE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2025-08-05T14:11:37.006Z;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=0;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB10385:EE_|GVX0PF5391DB7D1:EE_
x-ms-office365-filtering-correlation-id: ad07e3c5-a6ab-4ef8-fcde-08ddd429fddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTc1aG5tUkthZkJQZkhwYTBlYlZiOVNaYlRsS0Z2Sm9HREVIMkpuTkxUWmxz?=
 =?utf-8?B?TUVGUzBTMUNvVGtjWTFSNm5pNmpRQ1NpR2xCUHZsVnB0ajRPdC9mOWZMQjhw?=
 =?utf-8?B?UEpkUEl4a2pqM2k2Qy9uc3VHTWJiVDBxRFV3Y0I5bGo4TVE2WmNnaTJ4OHlE?=
 =?utf-8?B?RzhBdFJpVzVKNFE0eFA4R2xUQlpMM2lGMCtmTDdIa3BHS05EY2dFdzd3Yk1N?=
 =?utf-8?B?a2hCSGxncE1rT3pBcHIzeWV4MkFPUFFEa1ZESnYvSlh5QjhqUTZQR2ljbVBw?=
 =?utf-8?B?Q2pLYnFBTXVNT0t3Y0oyMGxaR0ZqamhjQjNmd05HMmNWeVFqM295RU1YaFFw?=
 =?utf-8?B?YUJQazhua0Y0YlJpbVdHMnBzWHNhbGhUUUtEajdqaFJGMWxtM2EzcmdEbVFU?=
 =?utf-8?B?dGlMWEcrZ09obXdTZzFmaTZmVmVLMjB4OWN6L2VCNi9wYkVnM3pzMUQ5WGJT?=
 =?utf-8?B?Wkt1bU1ZQ0g0dkxQUmNId3N0dmZ0dUh2Y1k1ZGJSSGJKdEMrZ2Fya1pWMGsz?=
 =?utf-8?B?Q3lpSGtEaHdONFFLYVg4Mi9tTDVUWHBiT2ZGdWg3WmVGVmlYa1N5V3dwMnQy?=
 =?utf-8?B?akRON21zcnd3RmNjdlRvY1grMkVMSWdwd1p1STR5N0txeTBSMWo2NUw1YnVF?=
 =?utf-8?B?SHRSeUFzaTVkRHo5a3Fwb294VlVIdW0zRW9xeFlCRGN5cVRNODF1Rm54cE9S?=
 =?utf-8?B?ZFR2NnZsNFBnRGE0L0ppU2FQK0xvdXlYL2h1LzA1MGkwRkdCYmhzY1ZCUllv?=
 =?utf-8?B?VVhzaU5KT2FRMC9JaUswcUZyVlJpWlZ2Ym9IMDIyQWtvazh3MnNQUGpnN2Jk?=
 =?utf-8?B?RGd4WnFnOW1penhWVzZpUkgwZ2VCa0hHMFdOWFcvOXdzTkpGN1ZuMDUzMTZS?=
 =?utf-8?B?QWpuczhNZzgySGR0NkphSFZyNjkwSnhvcktBOFFOeXV3L0JQM3NBOWtwSXIz?=
 =?utf-8?B?ekttQ2JUV0drZEJjQ1hxdWVseUNVRFZudUF3SGlLQWRxc3k4WVlwdTlZYnBG?=
 =?utf-8?B?K3JpVE5DVjNDcC9ZdlM1OVFOME1ZbjNPV3NWRVpHUzV1R3lxK3V0Sk45cTVD?=
 =?utf-8?B?ZkRPWUVBK3Rya1BmZzNmOGIrUEE5VjFLcURnT0tQbktQdWhiellaNTdUTkxO?=
 =?utf-8?B?dXNjMmFsSXZQTWJpTmwwcEV1TXdBM1J4VUZOL1VxWCtOazFJTVQxaDRVM2dr?=
 =?utf-8?B?QTFvWEhzanAzNXI1MVJWZFd6Z1NJUnFSOThZNzdTMHJFZ2NoUXBVbk0rV1R2?=
 =?utf-8?B?OVBqdTY0NmRraU9jTTlaMU9XeEhDQlE3emx3a2s3VGJxaFhOeWZFZWxsSXF2?=
 =?utf-8?B?dG5JQ3dQUVNLOUIvbDcrbTNyckRjb1o3UnV5cE13c2o2OHZsUzZjSEMzbHFk?=
 =?utf-8?B?NDJLWEo4NFl6L1N4bU1kL1VENms0bnMvaEZvS1U4RnNHYW1FUlpmWkJJQWt1?=
 =?utf-8?B?eE1KdGIxMHFJS29rR3N3eGV5djVDRHBVb0cycTcrWWI1b3QwR1YzUmhFd0M5?=
 =?utf-8?B?U3BhTnQxa2l5aEpQazFITUw3YUoxQnV5aHNYajl0SFFydEtMT0xCQmRNUnlh?=
 =?utf-8?B?cjY2NjVFQVlqSERuLzRiRUFSWmV0OGoyenh3YjJEaDRJTUhtaUdhUGJQMnZx?=
 =?utf-8?B?bkxJU1QwRWtYejdSSmxwR2dJbS8yVVBUWGlrNENQWDBOQ1FuSnEvdWI5WnRo?=
 =?utf-8?B?QUJDVFY2UExiakUzSUtiVmVDU3VYRSswL1lhaEhoY09wYkROd2owdjNlcGY3?=
 =?utf-8?B?Q1Z4NXN2dFVyRWVhSWY2WCtTVmJVRDg1S3d2OWVOa1lXRDFJQmkyR3JxRFFh?=
 =?utf-8?B?TkplNDR0ZS9SRENPTkJiTnNWSFdUb2cxUWNoZEVSMXpMRHJKWWZoMTNOYnJM?=
 =?utf-8?B?QmN3dlVuQWNmcHFOK09IbHc3bGxYS09Za1hhL0ZnVEc0N0lLUjFpenFUdzhu?=
 =?utf-8?B?SjlrZTBYc3NGb25TVUhUUVhXRTVkSWE0S2IwS0V5Y1pIelVsanljbm84S2g0?=
 =?utf-8?B?UEdycHFpcUVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB10385.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlJaWnJ3dmRvRFAvQmRVY0RBMGxwM3k4NzZrNm1welBJb0RGQmtUNlRDUkl5?=
 =?utf-8?B?MUo0USt2c1I0SFM0SlVUaFMrdU9YTnNFVSsxTXRkbjI3ZHdObHFRMHk0aGpW?=
 =?utf-8?B?RXBjS3FHOHJoRjlwbXRQR2JxNWQ5dkF4d2Q0RXBBM3FEbHliTjk0YVU4YXFl?=
 =?utf-8?B?d0twQzR5b21mM1o5dVU4b3UrMlp0M0xqbGlHekNOSSt0eFg1S1ZNQnJ3bFUy?=
 =?utf-8?B?U2NvVllGd1d6bTJoNHFNKzlDOUpWV0FRSGRESlZzWWJjNXRGNnl2TmFBTk9h?=
 =?utf-8?B?Y0NXcmJQRnU4T2d5MEF3ekFFenBJYXd4bnVEb3ZXZWtwV1hmWXdtOE0zREhl?=
 =?utf-8?B?NzBuQko0ckhoTXEraEhlYUQ5MWNBd3d5b1czYWJCZXVKVnorZmJ2MXdnRkpm?=
 =?utf-8?B?dWNudWR3RTk4WS81Zm5sN1YvOUlyWkJNRG9KNE5MVjNTRXJMYzBZb0JONjAw?=
 =?utf-8?B?MVhTQVNROEVzbFNRWVhmN1Yxa040allCOENVcE43dERQY2hNajZ6WnlUQzAw?=
 =?utf-8?B?VzhDbk1xOWRHRFU5SThGbWdwSjJscW8xRkRHa2hsc29IakwyTS85aTRyNXJy?=
 =?utf-8?B?YmxPRkRzb0FPU2pXaWY0ZTVKb1lpcWZEV21wc2tJTDhNK2o2TkVTQVluOWNX?=
 =?utf-8?B?aGcwMld1Y2o1OUxiZUhQR3RQTEtqVldzbVVVLy9KeVB4RlZ4YW0zZGM4NXdC?=
 =?utf-8?B?MTY3WXBkUVF0T0lPYSsvSXA3by9xb2NDVGVrdEUzNG0zc21wYjZ5ZkxGblZh?=
 =?utf-8?B?Y2pQZHkwYVFSeWJkQUI1YUdvTUlhOUZpRW8wdEk4K3hnRHpBWkZ2bk12V2lF?=
 =?utf-8?B?d1UvSU95dERodU13UGg2TjF0V1lWbDFNQnpVSnJmOE8rK2RPYlhNSEQrMUo3?=
 =?utf-8?B?Rks5SHFmQk12blo4Z0dBQ3ZpajBDRVZPK3NpVEMwMWxOK1huVCt3WTlMK0FJ?=
 =?utf-8?B?eTJVMzNNSitpQk81OVJTR3dwd3A3MjhoVGhEYWg3VmRNU1RRS1VQRy8yNVFa?=
 =?utf-8?B?bjdTRXYza2RzVWhKMUFmZFhTNWhlYWdaRDZLUkNpRHpOVkJYazJqRS8yMzZM?=
 =?utf-8?B?QU1nVnZ1QTg0VHVRS21HejVkcFVUSlBuMlRwbElXc1VLeU1HaWNSZE5mdmxQ?=
 =?utf-8?B?TmxvTzhReWt0eFQyT1JGRDhQS0tOclhHZGdhUzAxQXFZaU4wQ3ZTbDVsWTRC?=
 =?utf-8?B?T0h0TXpBQXF2TzM5cUJkZVRLSjBiOWdYYkFPaVR2SDJ4THdwMHQzaUdqVm12?=
 =?utf-8?B?OWxQNGxLSVY0dWg0RnhhV0ZvWXBuV2poMEhLUmFXWTltanJBR21hZytqWUdk?=
 =?utf-8?B?bXVqbjY3OGlRL3RLbERYM0lHT3VzRU1kWGsvM2lTNUkxV2F1ZVFOcTZCMkhR?=
 =?utf-8?B?TzA5S0pqYlE2akUxTUFGZzh3U1VIdlFSK3pRbDFmaTF2Mm5WQk1INVdkTmdv?=
 =?utf-8?B?L2hEY05XeHp6RXptTUFNTzJBY2Q1WGJ5UFZDcWU1alJnbG9LL3pvbXZ4RGVB?=
 =?utf-8?B?aUxiMEU1WW1xOSthR2hVeDlYSmhYTU1uTDUwZEtLcXh0dEYwMHpaSThWc1py?=
 =?utf-8?B?YU1nNjEwNmFGaFJDalBHNVpFcHA4UnZHWThyOFIvTjJPbjFSRjRhR3ZwR0lQ?=
 =?utf-8?B?REVOVEJZbUQ0MThJT05aZjRhQ3NiMTlrNHJWRWlBd0p6MTJvSm5zU1lPUFVV?=
 =?utf-8?B?ajJlMmtHUFg1YnZmTlB1ZWMwZ0dUWThqYnFEOTBHTTNpbk1IR3Nyckt2U3dn?=
 =?utf-8?B?dXZzOGx6WTB2YmxOU3BPRDZ5V095YkNFMG1ybVFjM2dhWGkvQkdNL1h2eTIr?=
 =?utf-8?B?VndwYnhCaWx2cnRERS93RE5Ha2JESERLZ2cwK29MVFV6aU5JQTYzczM5a09j?=
 =?utf-8?B?eVorOU05bVhqN0dDSDBBUFdWaGpMcndSR0ZHWk9xekhKNjlXZ0I2K1Q2dVJE?=
 =?utf-8?B?RDVSQ29nL3Y5QVBMdFhxRXREZDdCdjl4U2xCellVY0pDN2xzRzQyUmNnd2Iy?=
 =?utf-8?B?T2FEenVyYStSanZMUlp5M3MxcmQ5Wkt2b3h1cWlrN0JTZmJ5ZkNUbkVXc1Q3?=
 =?utf-8?B?L3ZZRDRkeDk1TFVDYnZXNEg2OHljWWw2TG9kNWNweFZKbDZOS1dQNlJIcWlC?=
 =?utf-8?B?Z004ZUlaTkdwTGc3dWtCZ0M2Z0pka3RHYXZ4citmTTBoSnVPeG0wMGVjbDJ3?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR01MB10385.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad07e3c5-a6ab-4ef8-fcde-08ddd429fddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 14:11:37.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 678cPUccyo4v+vWBP1rCQZZlhjMM6odQe93tCZkztaSR6Fq3kVeyLHayiC89pTBm6mH3fVkqpOTjEm9ZmBmvXLBLW7JT0aYogNLwiUd/1sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF5391DB7D1

T24gRnJpLCBBdWcgMSwgMjAyNSBhdCA5OjI34oCvUE0gRnJhbmsgdmFuIGRlciBMaW5kZW4gPGZ2
ZGxAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+IEFub3RoZXIgaWRlYSBpcyB0byBtaW5pbWl6ZSB0aGUg
dGltZSB0aGF0IGEgbWlncmF0aW9uIFBURSBpcyBpbiBwbGFjZQ0KPiBmb3IgYW4gbWxvY2tlZCBw
YWdlLCBIdWdoIChjYy1lZCkgbWVudGlvbmVkIHRoaXMgaW4gYW4gb2ZmbGluZQ0KPiBkaXNjdXNz
aW9uLiBFLmcuIHNraXAgYW55IG1sb2NrZWQgcGFnZXMgaW4gdGhlIGZpcnN0IHBhc3MsIGFuZCBq
dXN0DQo+IGFkZCB0aGVtIHRvIGEgbGlzdC4gVGhlbiwgZG8gdGhhdCBsaXN0IHNlcGFyYXRlbHks
IGJ1dCBkbyB0aGVtIG9uZSBieQ0KPiBvbmUuIFRoZXJlIGlzIHNvbWV3aGF0IHNpbWlsYXIgbG9n
aWMgaW4gbWlncmF0ZV9wYWdlc19zeW5jIGZvciBwYWdlcw0KPiB0aGF0IG1pZ2h0IG5lZWQgZXh0
cmEgd29yayAvIGxvY2tpbmcuDQoNCkFub3RoZXIgaWRlYSBtaWdodCBiZSwgdGhhdCB0aGUgYmxv
Y2tlZCB0YXNrIG1pZ3JhdGVzIHRoZSBwYWdlIGl0IGlzIGJsb2NrZWQgb24NCmJ5IGl0c2VsZiwg
cmVtb3ZlcyB0aGUgbWlncmF0aW9uIFBURSBhbmQgY29udGludWVzPw0KRG9pbmcgdGhlIHdvcmsg
aXRzZWxmIGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgYW5vdGhlciB0aHJlYWQgdG8gZG8gdGhlIHdv
cmsuDQpXb3VsZCB0aGF0IGJlIHBvc3NpYmxlPw0KDQpUaGlzIHdvdWxkIHNvbHZlIHRoZSBwcmlv
cml0eSBpbnZlcnNpb24gcHJvYmxlbSBhbmQgc2hvdWxkIGJlIHdheSBtb3JlDQpkZXRlcm1pbmlz
dGljIHRoYW4gdGhlIGN1cnJlbnQgc2l0dWF0aW9uLg0KDQpBbGV4YW5kZXINCg0KS1VLQSBEZXV0
c2NobGFuZCBHbWJIICAgQm9hcmQgb2YgRGlyZWN0b3JzOiBNaWNoYWVsIErDvHJnZW5zIChDaGFp
cm1hbiksIERpcmsgQnVzY2gsIEpvaGFuIE5hdGVuLCBIdWkgWmhhbmcgICBSZWdpc3RlcmVkIE9m
ZmljZTogQXVnc2J1cmcgSFJCIDE0OTE0DQoNClRoaXMgZS1tYWlsIG1heSBjb250YWluIGNvbmZp
ZGVudGlhbCBhbmQvb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbi4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCAob3IgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJv
cikgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IHRoaXMg
ZS1tYWlsLiBBbnkgdW5hdXRob3JpemVkIGNvcHlpbmcsIGRpc2Nsb3N1cmUgb3IgZGlzdHJpYnV0
aW9uIG9mIGNvbnRlbnRzIG9mIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IGZvcmJpZGRlbi4NCg0K
UGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1h
aWwuDQo=
