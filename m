Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFED47D931;
	Wed, 19 Aug 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152005; cv=fail; b=hxHyUK9UWsCuY+PDdZczwpeNsJScoEpoZ6oyytfRcIMoMpGhYWExjFcp/YRqWNZAVDTh3JMWX9RZVj/kY86cqWXIo6lN4zmVjG+2IPEIkX/bNpzJivl/ipVRBrnRhQLmb9q+UvtkNZ9cJ4DPvhtpGKnRlJbl54f1do/NfEue9cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152005; c=relaxed/simple;
	bh=BKFYUuRWF2p/ilVxZucE0tBVDMe5qKd6zbvBzsbmtDo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mY6aUhW5uE+4s2jg63POTQF+6CbZdL/X4Jxxxzgh9LOG+lrsrH/W/v12akMoTc0/HGI5s83zEkrU08+DD69tQYzHT6S0QgSucMCTQnQ8UM/UH9LEJWbzmPgyJDapbQhcf7hhX7yAQA+95pJa2ZARcpWrCN5HVqgSiQiYMsV8wwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kns.com; spf=pass smtp.mailfrom=kns.com; dkim=pass (2048-bit key) header.d=kns.com header.i=@kns.com header.b=jdbO3I9U; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kns.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kns.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kns.com header.i=@kns.com header.b="jdbO3I9U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5U57Kk9Tqixd+r5vl9ccxyBTsppY6/f2DY40zzyP/a3wlYueODm7aw2Q77N25Z01nr6dKAC+vr2eXdoRGYg7ms8ACg5pDXJFKJOJDr2B9h3ctEUE4Qir75puuITr95Zg42rNMWXgo8OcLJx6Q1A5dQwYFAqOiwbSDpF0xf5YJx0pxc62Ca0oCMSaRfL6d77cIdxE+bV5JTnyQvpcu1dXj6NQbk/EHhXYZzGc92CPxBS92NO581e5SYTjnGWtVgWjZ2UAK4jnY9HR/YC3h2ADD4ZnajHAUT8D51MS4hUKvYThD8NpWp2ar0Fn4/X5PsoipiqnVw78BXs26XOzeGXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKFYUuRWF2p/ilVxZucE0tBVDMe5qKd6zbvBzsbmtDo=;
 b=epevdf6xC7oIXmnYCi1INxvxV9/BeDOMoHwgoS1SSNvHjhSJfIdsYQGQPwxViIFM1RuzeEADmPHf/1oAy+KEyyA74pO7dMrBw7awSpQB5ZuLOatB60avuDed/eI1wS0G7MAxYPFnqvMkKEqdATzkt9GZF1nEGyH3p0DJC8Q9hIl+YFXgzV68aDnxGAS9Z9KQMols5GD5IOilrX/NO1uL9EQWWSfTfmE19j7u4h6vtpj6MoCY98gAg4Z/0Zc3Ek+1iOCMGS03OyXIAWjoSXFdWTk7jWYnHMO2LJYmMFvjEq+H0OuLbvM1MsgvHjoexcBlJw7ghfaP8LOuNkuv/XgMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kns.com; dmarc=pass action=none header.from=kns.com; dkim=pass
 header.d=kns.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kns.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKFYUuRWF2p/ilVxZucE0tBVDMe5qKd6zbvBzsbmtDo=;
 b=jdbO3I9Ur0bUcgSD7XyOusN4krt4qmWpY4rKTbQZolmGEwLiHfgmS5Yex+qXlsvnNaKx5xpsPpwPDIJk4z/lbGU86mWW1eEltg4xrUvd6wx3UEqJ6ToZGhqfftjQYYwuBiNwVoZp41cBx6dBWnMKOk+FIUXHTku1sJRLOO4Xc9okMvhJ/zSv6P1xVSeI90RhyPiIebnAsIL6guAX3ToazfV79myEnaOyzJsPn6eFquPEWU3J7t0EsPtL05x6fv3MF6rKMwmGXkURZ94LKiSmqhz4iZeJQ7Z9UutBQidnqXa00J6KA+S40BpTagWyFHJsW6WTcM3pdvMoryDTlaKHAQ==
Received: from TY0PR0101MB4867.apcprd01.prod.exchangelabs.com
 (2603:1096:400:273::14) by SEYPR01MB4770.apcprd01.prod.exchangelabs.com
 (2603:1096:101:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 15:06:36 +0000
Received: from TY0PR0101MB4867.apcprd01.prod.exchangelabs.com
 ([fe80::d4ef:d9d8:7b81:6135]) by
 TY0PR0101MB4867.apcprd01.prod.exchangelabs.com
 ([fe80::d4ef:d9d8:7b81:6135%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:06:36 +0000
From: Mike Schanne <mschanne@kns.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
CC: 'LKML' <linux-kernel@vger.kernel.org>, "'linux-rt-devel@lists.linux.dev'"
	<linux-rt-devel@lists.linux.dev>, 'linux-rt-users'
	<linux-rt-users@vger.kernel.org>, 'Sebastian Andrzej Siewior'
	<bigeasy@linutronix.de>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Steven
 Rostedt' <rostedt@goodmis.org>, "'chris.packham@alliedtelesis.co.nz'"
	<chris.packham@alliedtelesis.co.nz>, Todd Leitzel <tleitzel@kns.com>
Subject: [PATCH] uio: eliminate extraneous irq thread under CONFIG_PREEMPT_RT
Thread-Topic: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Thread-Index: Ad0v7EYIkkDdm9liSo6xF7NbQKbnuA==
Date: Wed, 19 Aug 2026 15:06:36 +0000
Message-ID:
 <TY0PR0101MB48676D503A7F6C5CAC112B3BD2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kns.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4867:EE_|SEYPR01MB4770:EE_
x-ms-office365-filtering-correlation-id: 82c00e85-8c9c-4934-ea96-08defe0376bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|38070700021|6133799003|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 sYO124aB3KBbRnN8+zLTDRWMthyohB7RKCnG6qYftDVA8gZGg8G4RM/XaWcK8xnXdkFqMbV0hcOiRFX/iYMC0utz8AQd7qMUFow3XCly7CkqjQxPYkWUwf75Y+cJsVHvjnvxUhfZds+q9LHShvyL3t0svOd+aJldlSof4/S3bMNnSuz9ji8cCvS0Wwc5A61lgh93p8BEMDqvXevPu7sfr4+78wU0rHrhgbg4qLhpg6ik9nANq7k/ZeQI0fOomDXZcmS+sC5nyF3yHAz9vt1ZfDWNZgxQBuaYwsqOD6S7XM/ur1sme8aPJv5KljqpkTgK4PzlOl893DX+xniRU5+hK7nIKnuCozkQX38nfH4L+t+w+Gc0mAjxhMXQbKvoRjDWhXJkui7GZGQ1RhlSd1x/WwtwBKHuJu6Y0d8ur+JjmXAOOxh8a551Tw8yq6lUEct3OlbKADHoyFVhn1JBrL/KZDZIGef612NJNlaAvNwQFqJJMTZBcgN2GEBGzipGtR7l8tNX3Hi1Xhht3z8dMyLnVhgtzV8hGMLE+c67P2GYJy5Tl1moTtXJRbUw/yhG3ydM473A409pTkPO5b77qzk4d1/IQBykm5igZvNTbaIy0cCMIcJmfQ5EWk+3iW+Owv8DlavqfSKnw7qDIzeZX0+VlNREy2QQmqjrmtZrrSZLGYI6zQuGZyHi1ad4z1vN8zCL/PE+WrtX1JYUW+8uTQ6n2Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4867.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDNpRW1WTWc0ZHVzeDF2eFJPSkxTbFQ2ZGhULzFzaHRvcXBrV2QyZllBNlBr?=
 =?utf-8?B?c2hWUWdNd1ZaWG1pNjBmVWUwcngwc0YrSzBGY09MaWpuTVY1UXNFQ3UzcGNX?=
 =?utf-8?B?b0wzTHo1UCtoVGN5d2pEcmV1c3JjVWg3RTNFWkpZanVrYmFaVE9Qay9jczdJ?=
 =?utf-8?B?TVRLTGYrVmJrMlNyWG1FQ0c4ZTZXRkQwOTZhZ3NYNlVQZlhxTW5pSnA3Q0FW?=
 =?utf-8?B?aG9IUGtsRHFCL0lDMysyYXFQc2lsTnY5SkRVZVdFNURMNlVoWlIyaHdnOENL?=
 =?utf-8?B?ZHNGTkdqUVpnZFdONzA3Ky9KNXJMd3Q2dWdKaGxQYWh5STZhUEEyTTdUb1pm?=
 =?utf-8?B?V2NxamRBVUJFMGM5QTRoM1hDRmFKU1A0eUFod0htWi9lNUZaVVVzRHhJTjFl?=
 =?utf-8?B?T3d6RHRQU1U3NUlzQ0lCQmxRejRSdTR5V28ydkJiK0FWWlBnRERHNm0wV2or?=
 =?utf-8?B?MFBtNDM2RU5mVW1pa1J1d2VIUHdTRHI1MHNLVWlRUkh1TDlrMjBZUFB1dHp3?=
 =?utf-8?B?RUlObjUrOXozakcyL2NQUWFQcS96dnRsUnhJVVl4b1VDc1V3S2x6OS9OeHFL?=
 =?utf-8?B?QmljenFFUGNnUEtXbmNNWUdzVmNQVEFQengrS2xWdGhCNDRWQitoYlk3OGVy?=
 =?utf-8?B?MFVuUDgwWHR6U0ZZMUxsdXp6ZWxYNFRKc2k4amp4VDkzZFQ1ZndtWFU1S1NH?=
 =?utf-8?B?WEY5blNTZU1vVzc3U0trUUZLcDdEZ1cxcWZxMUFkQVdGQWZqUDBySjZJTXFX?=
 =?utf-8?B?eVRXTmNuVFpjQzlRRXlkLzFMSUZ5QUFXUGUyRG0vaWxDenJub3BITjNEUkFI?=
 =?utf-8?B?YmtYT0xmMDlnalU1ME1Icnc2SnNRV1ZQa0hlSVczWlozTXdRQkZnczVDM3Z5?=
 =?utf-8?B?ZVMrVEMyMjBCNkNjUmFHbTJ5elRWZmxiVmdLejNycjF4RFl3dmdBdStIKzRx?=
 =?utf-8?B?K1N6VVExa1kwRFFOZ0t5U2tKN2t2KzZ3cERuNmJGblZ5RjBGaWZGMjJZbWpY?=
 =?utf-8?B?U0NMY0d6WlJidDhZUHBSejFOUG5xcks3NDBHZVZqRC9wV2lFNmZBdVZBbDRB?=
 =?utf-8?B?TEc5cGRSakNDUW1Vc3dXWjNpekREbDBrVEhWRFZEa3VSWUpqUTNwYW1yMW53?=
 =?utf-8?B?eXFkOWJvSW1rbzNCSlRIVlhsdjVvVGxNbkRxbnltelhlbmIxT2JVZWVUOEVv?=
 =?utf-8?B?eHNiSGw3ZmhMQmNlbWZsREJZczNYRHY1b0p5WUdIUEhFWFRDYmtSWWNXT3Y4?=
 =?utf-8?B?MVBaNDU0azVvMlRxTXQzM3Bac0RsbWJpYkZoTmZ2aXl5eWd4Z0hjc2tIMG5t?=
 =?utf-8?B?VzMvdUVLcDNkSHkwRjdRakR4SThkbGZjZEFrNmp3TDhNeXVmUFI3SU5SQ0Fn?=
 =?utf-8?B?dTdvMDlSRTR3SHQ3SzRReW4vT3FjblluRUVzSUMvNkhVNWM3REswS25taHd2?=
 =?utf-8?B?eFNQUEtpUUlaTGZsVitqYlZPOXpJVG9QTHlxY3dnRXdDbFVsbzhhaCs2b29n?=
 =?utf-8?B?M0dWTkVZbjVYV2ZXQ3NOYnk3OWdqL0JRSUNYQm5Salp2Rk5yUHBFUXVKTTlQ?=
 =?utf-8?B?VWFGTkxpNCt3WDh1MUZmUHYrWVVQSWtSTUlEY3RwT3kwQzBwVXRnNVdHZnh6?=
 =?utf-8?B?TTZrZnhvTk5zaWZJSTVSSWxIamFNUVhyekVFMy96TkJMTkEyMEVZcm15MXhS?=
 =?utf-8?B?a3BqNFAzdWR1UjBwc243ODZsTG81S3VXNXFHbUk1WmpHY1BmWCt4WE9GU3cv?=
 =?utf-8?B?YWM0TWcyNXpoQVFrdDFJOEd4VjBKUkhjWXNhYzZiMnV6alJEMEFXdWdsbGVB?=
 =?utf-8?B?NjErSEdyejFZcVVjSllUSXErWSt5UENkOFAvZkhlUFhzV2hNNVVyY0hLWE9L?=
 =?utf-8?B?dU1uVjdrZ3RaWVBTMWtDcnpSVjZXTkplaXNSN2wySE1QVWsrRVM5bEFzSkhO?=
 =?utf-8?B?aWNySzhHMnRvWExFNmZMWjUzdGp6ZWg4RVdWRjN5U0VFQ0RzWUJkQXRDOS9M?=
 =?utf-8?B?aldhSWVhZ1IzcjJLZ3Z3VTBLWVRNc0h5ZWRpMm1xY01vU241SWduRU42eFpQ?=
 =?utf-8?B?ZVVSSHFqUVMyT2RHeXUyZXhtcUtOa0tkS1ZDR3RMM0h3anBiRVorSVYrakpr?=
 =?utf-8?B?U0Nib200dlJacXNtYk1qU3RQRnNtSEZGeE9yK0xaaC9QNy96TU5RZklGRFRJ?=
 =?utf-8?B?RjhrVVcyUGl5T3hGRWl2VmNXK3VoVERzbDNhYS9qVXNUU01hNHpMVDhmLzFK?=
 =?utf-8?B?b1NGdW5KK2FPYW42STZnQ05rYWV3elhMaWFpUTBucWE0djUvcXBWb2RHQUhX?=
 =?utf-8?Q?AGFIhx81TTcQuP7e9D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kns.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4867.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c00e85-8c9c-4934-ea96-08defe0376bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 15:06:36.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 13db00d8-2bd3-413e-a71f-ae7175d8527f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOxdQE51fxEhZaw1i7G9GaGzsFx6A6W6jekSvCF7nxFdy02vMLmJIu0PFPdgBL1MTcA2ES4fmRlr4XIrpyGK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4770

RnJvbSA0MzVkYjBhNzVkZTk4ZDIwMjFlMDIzODFhMTVhMzAwMTM3YTU0NGIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogTWljaGFlbCBTY2hhbm5lIDxtc2NoYW5uZUBrbnMuY29tPg0K
RGF0ZTogV2VkLCA1IEF1ZyAyMDI2IDE0OjM0OjIyIC0wNDAwDQpTdWJqZWN0OiBbUEFUQ0hdIHVp
bzogZWxpbWluYXRlIGV4dHJhbmVvdXMgaXJxIHRocmVhZCB1bmRlciBDT05GSUdfUFJFRU1QVF9S
VA0KDQpDb21taXQgZjhhMjdkZmE0YjgyZDQ0MmFmMWMwNjQ1YTVhY2M3MGNjOTdjNjdmNiAoInVp
bzogdXNlIHRocmVhZGVkDQppbnRlcnJ1cHRzIikgbWFrZXMgYWxsIHVpbyBpbnRlcnJ1cHRzIHRo
cmVhZGVkIGJ5IGRlZmF1bHQuICBIb3dldmVyDQp1bmRlciBDT05GSUdfUFJFRU1QVF9SVCwgYWxs
IGludGVycnVwdHMgYXJlIGFscmVhZHkgdGhyZWFkZWQuICBUaGlzDQpyZXN1bHRzIGluIDIgaXJx
IHRocmVhZHMgcGVyIHVpbyBpbnN0YW5jZSwgYWRkaW5nIGFuIHVubmVjZXNzYXJ5DQpleHRyYSBj
b250ZXh0IHN3aXRjaCBwZXIgaW50ZXJydXB0Lg0KDQpEbyBub3QgcmVxdWVzdCBhIHRocmVhZGVk
IGludGVycnVwdCBmb3IgdWlvIHVuZGVyIENPTkZJR19QUkVFTVBUX1JUDQoNClNpZ25lZC1vZmYt
Ynk6IE1pY2hhZWwgU2NoYW5uZSA8bXNjaGFubmVAa25zLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdWlv
L3Vpby5jIHwgMTcgKysrKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWlvL3Vpby5j
IGIvZHJpdmVycy91aW8vdWlvLmMNCmluZGV4IDAwNGE1NDljNi4uNGUyODc3N2FjIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy91aW8vdWlvLmMNCisrKyBiL2RyaXZlcnMvdWlvL3Vpby5jDQpAQCAtNDQ4
LDggKzQ0OCwxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdWlvX2ludGVycnVwdF9oYW5kbGVyKGlu
dCBpcnEsIHZvaWQgKmRldl9pZCkNCiAgICAgICAgaXJxcmV0dXJuX3QgcmV0Ow0KDQogICAgICAg
IHJldCA9IGlkZXYtPmluZm8tPmhhbmRsZXIoaXJxLCBpZGV2LT5pbmZvKTsNCi0gICAgICAgaWYg
KHJldCA9PSBJUlFfSEFORExFRCkNCi0gICAgICAgICAgICAgICByZXQgPSBJUlFfV0FLRV9USFJF
QUQ7DQorICAgICAgIGlmIChyZXQgPT0gSVJRX0hBTkRMRUQpIHsNCisgICAgICAgICAgICAgICBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfUFJFRU1QVF9SVCkpDQorICAgICAgICAgICAgICAgICAgICAg
ICB1aW9fZXZlbnRfbm90aWZ5KGlkZXYtPmluZm8pOw0KKyAgICAgICAgICAgICAgIGVsc2UNCisg
ICAgICAgICAgICAgICAgICAgICAgIHJldCA9IElSUV9XQUtFX1RIUkVBRDsNCisgICAgICAgfQ0K
DQogICAgICAgIHJldHVybiByZXQ7DQogfQ0KQEAgLTEwMzgsOCArMTA0MiwxMyBAQCBpbnQgX191
aW9fcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBtb2R1bGUgKm93bmVyLA0KICAgICAgICAgICAgICAg
ICAqIEZEcyBhdCB0aGUgdGltZSBvZiB1bnJlZ2lzdGVyIGFuZCB0aGVyZWZvcmUgbWF5IG5vdCBi
ZQ0KICAgICAgICAgICAgICAgICAqIGZyZWVkIHVudGlsIHRoZXkgYXJlIHJlbGVhc2VkLg0KICAg
ICAgICAgICAgICAgICAqLw0KLSAgICAgICAgICAgICAgIHJldCA9IHJlcXVlc3RfdGhyZWFkZWRf
aXJxKGluZm8tPmlycSwgdWlvX2ludGVycnVwdF9oYW5kbGVyLCB1aW9faW50ZXJydXB0X3RocmVh
ZCwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5pcnFf
ZmxhZ3MsIGluZm8tPm5hbWUsIGlkZXYpOw0KKyAgICAgICAgICAgICAgIGlmIChJU19FTkFCTEVE
KENPTkZJR19QUkVFTVBUX1JUKSkgew0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gcmVx
dWVzdF9pcnEoaW5mby0+aXJxLCB1aW9faW50ZXJydXB0X2hhbmRsZXIsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGluZm8tPmlycV9mbGFncywgaW5mby0+bmFtZSwgaWRldik7DQor
ICAgICAgICAgICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJl
cXVlc3RfdGhyZWFkZWRfaXJxKGluZm8tPmlycSwgdWlvX2ludGVycnVwdF9oYW5kbGVyLCB1aW9f
aW50ZXJydXB0X3RocmVhZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+
aXJxX2ZsYWdzLCBpbmZvLT5uYW1lLCBpZGV2KTsNCisgICAgICAgICAgICAgICB9DQogICAgICAg
ICAgICAgICAgaWYgKHJldCkgew0KICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+dWlvX2Rl
diA9IE5VTEw7DQogICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9yZXF1ZXN0X2lycTsN
Ci0tDQoyLjM0LjENCg0KVGhpcyBlbWFpbCBpcyBub24tYmluZGluZywgaXMgc3ViamVjdCB0byBj
b250cmFjdCwgYW5kIG5laXRoZXIgS3VsaWNrZSBhbmQgU29mZmEgSW5kdXN0cmllcywgSW5jLiBu
b3IgaXRzIHN1YnNpZGlhcmllcyAoZWFjaCBhbmQgY29sbGVjdGl2ZWx5IOKAnEsmU+KAnSkgc2hh
bGwgaGF2ZSBhbnkgb2JsaWdhdGlvbiB0byB5b3UgdG8gY29uc3VtbWF0ZSB0aGUgdHJhbnNhY3Rp
b25zIGhlcmVpbiBvciB0byBlbnRlciBpbnRvIGFueSBhZ3JlZW1lbnQsIG90aGVyIHRoYW4gaW4g
YWNjb3JkYW5jZSB3aXRoIHRoZSB0ZXJtcyBhbmQgY29uZGl0aW9ucyBvZiBhIGRlZmluaXRpdmUg
YWdyZWVtZW50IGlmIGFuZCB3aGVuIG5lZ290aWF0ZWQsIGZpbmFsaXplZCBhbmQgZXhlY3V0ZWQg
YmV0d2VlbiB0aGUgcGFydGllcy4gVGhpcyBlbWFpbCBhbmQgYWxsIGl0cyBjb250ZW50cyBhcmUg
cHJvdGVjdGVkIGJ5IEludGVybmF0aW9uYWwgYW5kIFVuaXRlZCBTdGF0ZXMgY29weXJpZ2h0IGxh
d3MuIEFueSByZXByb2R1Y3Rpb24gb3IgdXNlIG9mIGFsbCBvciBhbnkgcGFydCBvZiB0aGlzIGVt
YWlsIHdpdGhvdXQgdGhlIGV4cHJlc3Mgd3JpdHRlbiBjb25zZW50IG9mIEsmUyBpcyBwcm9oaWJp
dGVkLg0K
