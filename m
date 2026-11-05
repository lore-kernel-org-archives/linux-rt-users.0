Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920946;
	b=NcDo6JZUZIQGaVZ2nzVAJG46RN9aG+aZCSqQB9Ygwmayc+UZpbXsLxhJhMzaUB3mtLro
	 4ORmBMKg93rGjf5SPPudIqtkYU3Q9ZaWkPGwRvasP5tcBr/Q1fanS4GgZCN47lDOVbFoP
	 BAhlTUzTZAqH41raq0pNdbW3k2PX9ZkLTLCsBnbQlFEKtJ2EKjoBMe7oEuJiaTJFO5JDC
	 DnKUW3s5340sVFxi2A+5c0nO4g0oQijT5YnLlqaseeP2FcXUM3PEXxh3ZHpwsF6kWS1Se
	 MxOIKhdX6KR6OceUxWkuK3bsPSV/mkle5r37d3noD5JMHlX7FkKaAKfa4Dv1W0TMzKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920946;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xxeHnkyj/wdNYa4dad/YE7XQLAdR+L/s/agJCAyW8Jw=;
	b=yYMWI6WXdsZXxFokUZnVgw7xtX6OouG0gz+3GRPPXJJx9qxq0fvFomVx8vRzQl/1BGwS
	 ZrAXeAgAp+diMhVsotSkxfe7UdYOK0W6deh7q9pT7w6jlvPiH4uTr5IxyEIi+skLa1bH+
	 sycgQJJuVlPRgQMHEbeKoGLCVk64/6yrWNKe9Jal+HjbQ+cA8dXK0LIvzzsUTIk9WBZem
	 CAw67+ylGEo/MscVE16NzpdfqkSPPfKb5YUl1xeXzJqvsuQPfn00nWdFiI7ivNoB71mu8
	 sTAuH5i/sjyTSgmaHrVBS+otqbJ8L9ptgHgFsSyvDMPUW15RwXrILYfOeA0lBwhjkGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kns.com;
	spf=pass smtp.mailfrom=kns.com;
	dkim=pass header.d=kns.com header.i=@kns.com header.a=rsa-sha256 header.s=selector1 header.b=Tb8RYIKN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.50
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013050.outbound.protection.outlook.com [40.107.44.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2221606A31B;
	Thu,  5 Nov 2026 23:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2221606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kns.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kns.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kns.com header.i=@kns.com header.a=rsa-sha256 header.s=selector1 header.b=Tb8RYIKN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKt8+7G6+CETm91gYVJQu+6czR0v47EwzCEqbqmDbZNkj0UxbiZoWDSMh3beqDnb8NPvhIAK+wVr/T88vlNbP1u5qte3K9gxJEcztCLbJ9lBSN/YGOguNxOpmnisnUjVHBzERHKkkbJCdxU5QMqSNKUyg1/bM02E+s8CNdqp/haeotmnEjZ+9V1l7ZgixTALSnvvGvI10CTuhhUdZgsBMJzXj6vJ1mn8FC0liuKF438/vNhtg09bHcD9b1E56O2bm4QxVfKwi6HH5spDQg+OzFUTqEHFTS0bdUbxQmBZA/oqK+MJjESthVhmqx3ABk/oax+ex8sIz7AKSoJrqOLeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxeHnkyj/wdNYa4dad/YE7XQLAdR+L/s/agJCAyW8Jw=;
 b=v4YLA0f+3hCM32iGKj8r/kUeD6ySkR0zd6Qs17G4sWUA4DH2D0x4BJNo5jXf0yQtvsQOqfpD6qvYmYTuFi4dw6rFwUKJSDrZHZi4Cy/JasucP5GaaH0XsO62NaSXuF9Zybbbrz/hntmgnufiOgCUvv7Y1z/746AoyxbWXHxXuutUq97+gE30yB9pfolZ96ZUeHa8iT/nGICHi1KCRnOivgsHPAjdCDVmB+648RHtYCU9M4ZpsMfnzkcW2VuVtcfUYkwyrEm0Y0mRBlTo8ejdbAWgVl4pbs113bTBvK4g1NPFBeWl7kTiWW2o2ghll7OO53c0oFRoDsDbKbYru24WOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kns.com; dmarc=pass action=none header.from=kns.com; dkim=pass
 header.d=kns.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kns.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxeHnkyj/wdNYa4dad/YE7XQLAdR+L/s/agJCAyW8Jw=;
 b=Tb8RYIKNtMCRFRSmxKrG5cKyciEPvOIgSBq1n6Vs56v9Rp+wAAVFqdT6jwsrEsdXt/aqA/nv/SkJuPtkY9n8PdantYP/upZGXRsULgSuFTjGYsVoS9mOfOy8WKK0Ikx0FuIYRjNQcbTh51QhfwP12yQLJj0+ItPxgHFo6nxtKjUVhZzw3f/NNbLlffT5+HBzRPaGqVcCsWNZ+pLSSFKPdZU5K20f9f0ojMuT91Rs2s/X9+t0+0lF0BQZ7inUSqX2qpfraZa1rx16MjGanAejx0vn7fw0IETNPr6wS+zR0RIvKiuflyzEdtofuB262MyApDa8ZLhV2vnmGNXoR2v2Yg==
Received: from TY0PR01MB5723.apcprd01.prod.exchangelabs.com
 (2603:1096:405:1b::14) by KL1PR01MB4768.apcprd01.prod.exchangelabs.com
 (2603:1096:820:ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 23:22:20 +0000
Received: from TY0PR01MB5723.apcprd01.prod.exchangelabs.com
 ([fe80::150e:2612:b40c:cc2e]) by TY0PR01MB5723.apcprd01.prod.exchangelabs.com
 ([fe80::150e:2612:b40c:cc2e%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 23:22:17 +0000
From: Mike Schanne <mschanne@kns.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
CC: 'LKML' <linux-kernel@vger.kernel.org>, "'linux-rt-devel@lists.linux.dev'"
	<linux-rt-devel@lists.linux.dev>, 'linux-rt-users'
	<linux-rt-users@vger.kernel.org>, 'Sebastian Andrzej Siewior'
	<bigeasy@linutronix.de>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Steven
 Rostedt' <rostedt@goodmis.org>, "'chris.packham@alliedtelesis.co.nz'"
	<chris.packham@alliedtelesis.co.nz>, Todd Leitzel <tleitzel@kns.com>
Subject: [PATCH] Revert "uio: use threaded interrupts"
Thread-Topic: [PATCH] Revert "uio: use threaded interrupts"
Thread-Index: Ad1te4Ezu/k/o99STK2OTlNpcneIYg==
Date: Thu, 5 Nov 2026 23:22:17 +0000
Message-ID:
 <TY0PR01MB57238A4ACC7B9B3214A00A6CD2772@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kns.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR01MB5723:EE_|KL1PR01MB4768:EE_
x-ms-office365-filtering-correlation-id: e0dde153-ad27-4f00-b83a-08df3b93a1f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|6133799003|10067099003|18002099003|38070700021|261102123227099003|56012099006|261028144727099003|11063799006|261022105027099003|261102130727099003|261026140227099003|261021121427099003|261026121527099003|261009223027099003|261022075727099003|261021123027099003;
x-microsoft-antispam-message-info:
 GCXZkHdeKqQVN5GHB5ortb1zg4+lwUkDumqd/APlXBPegKUt2hITQwFJNmRyJsfPW2uPPKnOFSzHicI5xTUBSYTjRXYTPdfEAnijrgLsLDF6YN7S2c6trYgRnBZC4xAWXZGcJb+HS6WO0YZN5qQ7Bzb0jbJBWELnUQnMd+srvJOwCEHJSxmSo9W0oKi3KxF9cfPxCuUYAE6VJBjJW/CoRGLhimhY44lNFYuXWmJ0xFhsSs/8U7dXqsYxW7cllczT69OYBAnjFshhJQY0pabChWuPoFT+W2Tu9pnQM9alEWeC0mZeCsNHZPNS7VPBn21R7Ue3nErCNvd4TeE6heySW0L1U0I1IPlpVwJTxkZgpYALjJN0ixsjDuaX9lWL074eKuLKMgjj6qHDIsaxoez7UdY7nGcB/RPDsQID2pMwen92J7lbNbZM/9nbUJAHCeNz3nC1226x9C/5r3B7+jqjt2JVe4Ki9Mj8AFG6CoaCyVc4b8+WOtO9Nvg4T9Jw1XGjSIvMOsDniXW5uO7fceVnO7bZ1wfqlYpzAYqn4AuFWn3nJr1eryZ+20LqSRKlM79lsuzQpKKRmAZwzkDx6GLrjeFGxPTjZR3NFrt6D9Na0CWQE07LiSVePFvcLCdNa37hLUdg9gbzBRocAf4vRgZ8y1fzYTu3ye7TGzol5s6klyg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR01MB5723.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(38070700021)(261102123227099003)(56012099006)(261028144727099003)(11063799006)(261022105027099003)(261102130727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261009223027099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnNkV0VqbEZqTFFFdzVNbDlGb3FRL1B4c0JNTk11WmlTc1BDaVBiQzdNd3RL?=
 =?utf-8?B?UENPU3JDMVA0SUl6SlliN3F6NDlrWG1iMEhGakVlaXVGV1VFZEU2TklCYVV6?=
 =?utf-8?B?VUtBbUMxL1RzUGZrSnFYZGthTkZmTjJIR0ZiWlREZXF3R24xNEp1MDNOUVVq?=
 =?utf-8?B?Y1hBTFVHK1JLR25JWFRaMGJUamdkUlVxNHhMQ1BlZURjT3hNZTZpV1NETXov?=
 =?utf-8?B?NnFKOEluTmNlRzIza25lUDNHb054ZWs0aVlvVzdNS2JucjRid2ZhUU1ycmZT?=
 =?utf-8?B?bFc4WjNJQ1BRcVN0RVgrWS96dFBsc1RERzJEOUJBVzRGcUExWVlPY0JQdDNk?=
 =?utf-8?B?OUxjM29zVXVjc2NtVHViYm5NY1c4cjNoK3NtUXpTNG9uSWU0TzBIM0NNZHI2?=
 =?utf-8?B?aGs2RHViMXpWaEp3WjB4aWI4azBrb2FkM3VBT1hYbmRGYjE2em5wOW9tVGgx?=
 =?utf-8?B?M09aTm5EemlTMU9QN1JzUVJBd2dMd1gzcjZiWUxnVGwvbGswZnpjcFBnSjUw?=
 =?utf-8?B?RlViQmFLSVV0MG5iNFV4UGY4TlRlcGNWZlQ5YTREOG4vbzZoWGRxVDBrWlJ1?=
 =?utf-8?B?OUNkMHFzb0l1VkhEYXJoZ0tObVNZN0dtMXdsQUkwWHlENzZoa2pCVklTeWwz?=
 =?utf-8?B?aGNmdkxCWE9wLy8zTFRUdVNNM1BHcE4xWFdiSXk5Q1FJOURRZ2tTVlU1ajVa?=
 =?utf-8?B?MmZvZmxCcHVrVXVuTnNOdlEyOEhXcE5hRHpNL0tzdDRSS2pKVEZWR3Y0U1Rq?=
 =?utf-8?B?d2dJMVUwU1g4ZHgvdk9xTFJpV0lLTmVTQzRZWjVnTk5kdUNQUWl3RUZMMkhq?=
 =?utf-8?B?OC9uTW9tR2tIV3ViM1BJSXA2S3I1cjU4V0ZOdDRVdDNRSElrQ1ZZVHJScUgr?=
 =?utf-8?B?VXhWMTNuSGhmSy91cFpsRGd5bVZtczV2c0VTYSt4RklubUR1bURBZXJFTVZp?=
 =?utf-8?B?Q0FldFRiT0lXTS85SUhGVkdxbm1xM2k2WTVyMkwrRWQ5dWtQUzNWVjEvSlJt?=
 =?utf-8?B?ek9xbUEyZll5T1Q4aTVTTTFxVTlQUWxEWVZMNXNtL0FJdFNFU2MvVDk5S1VG?=
 =?utf-8?B?eGVJRnJUSEZYMU1pNzdGMlR2OUswVEJkVFBLdlN1c3JidERYU0ZFZ2dUQUsy?=
 =?utf-8?B?ODFtZU54VUlramVZRjFpVTZML05DQTFmQXdGT0NOSDZrVVRrMU53ZzdZR0tC?=
 =?utf-8?B?d2sxTnFXeVlDMm5YYjlZN0JtR2VkS0dQT0E3Slg5YU9RMWlEZFBtTG55YzYy?=
 =?utf-8?B?dW42aTdscVJIK2dvLzRaOWhpN3R1OGR4QThYTE5jdHpvbzB2d2xRbEVaU3JN?=
 =?utf-8?B?ZkNvcU5TTjdqck90dG9SYXdsWlFEOHJFSVQwREFMUWRhMEc2dEhlOS9LL1p0?=
 =?utf-8?B?VTRmZFBjdHk4Sk5HUzhoQTNaMnJtckQzcElTOVJsQk5WY283MUY3WTFTb0pn?=
 =?utf-8?B?WE9CUVBtbkV1aDlESEgyVDdJY01wVTV4TGZBNnQ3NTBYb3d5R1d3R1ExZnpU?=
 =?utf-8?B?eVJ3aG1vYkQ4d1JpUndHY0RWb2ZxMFZhZE9KNloxUVpOV0pJRllmOWRKR3dG?=
 =?utf-8?B?a2MzbmxaMnVIV1dJSVBxbFN0c2JocVArZFY5ZzNQcWJEQlZRbS91U0F0UGVN?=
 =?utf-8?B?UXRrRnJFQThtUnNHMnVVTlhsMk1jelB5aGlYMjVJeHBYZWlkWHlJWTBES2hT?=
 =?utf-8?B?bUpFejExU1dST0wxTE9QekRqR3RNVW5Zbk5FUnMwOW9rZzlhS0M0RG82Nzlk?=
 =?utf-8?B?WTJJbFpoWTVWSnNZUm9PYUgwQlgyVEJPWHFVL25zenZxTk1mTUx5Z2Vyc3lK?=
 =?utf-8?B?LzJ6bXBUZ0IxY3I2ZHU2RGFGT2h5cE5NVkUwOUx4Y2Y3UVJPU1BCZkNENGpN?=
 =?utf-8?B?blpMZUF2WUExblRHdkFJZ2hleFEvdDAwVFVqa1FXS0thMmRLZVkzWHAxWVQ2?=
 =?utf-8?B?WjFoazhHZU9BRVNNemt3ZTRuMGpxSUtic3ZLa2VpMTIrMDVvMlpxMG1rWHZP?=
 =?utf-8?B?T1JCUUROZ3d6U1BXaTFpVE9qajQwNVNTT0JVNXQ1SFhuQVd1c3g5OVdxZ1Fu?=
 =?utf-8?B?WVVaWkd2L04wWFA4SUoydXp3Mkw4aStHZTI2Z0ZjNjcxNlpCQzlkY29DMlc3?=
 =?utf-8?B?WEZmTDRjUExTNzJ5akRlNUxndUVPZzNSWUN5MnRRaW96RTl0ZFY0Q1R0cHRO?=
 =?utf-8?B?M0ZEeXRCTExZWFBndkJHZHZYQ0Z0VzFPQ21GVFpNVzkrRUpZSzQvV2liK2cx?=
 =?utf-8?B?azBNOXk5UjVNUDRpNkRvcjY5Nnh1WTNldGFqUDlGdEkvWkhrMDBjeHgxQmRQ?=
 =?utf-8?Q?oRLHn3Ej+BUA0zwUUT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: kns.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR01MB5723.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dde153-ad27-4f00-b83a-08df3b93a1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 23:22:17.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 13db00d8-2bd3-413e-a71f-ae7175d8527f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EV5UAhMLuRPamY+KX80kWX8hwD+k93PBGy24cukQbGdZeEfk4T9/fXt+LfACV30Qo8GGC8hadd16FBXxO1ZjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4768

VGhpcyByZXZlcnRzIGNvbW1pdCBmOGEyN2RmYTRiODJkNDQyYWYxYzA2NDVhNWFjYzcwY2M5N2M2
N2Y2Lg0KDQpUaGUgb3JpZ2luYWwgc29sdXRpb24gYnJlYWtzIHRoZSB0aHJlYWRpcnFzIGNhc2Ug
aW5jbHVkaW5nIFBSRUVNUFRfUlQNClVuZGVyIFBSRUVNUFRfUlQsIGl0IGFkZHMgYW4gZXh0cmEg
a3RocmVhZCBwZXIgVUlPIGlycSwNCndoaWNoIGFkZHMgYSBjb250ZXh0IHN3aXRjaCBwZXIgaW50
ZXJydXB0Lg0KDQpTZWU6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAzMjYxOTU5
MjcuMzI2NTI5Ny0xLWNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uei8NCmh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvZjhhMjdkZmE0YjgyZDQ0MmFmMWMwNjQ1
YTVhY2M3MGNjOTdjNjdmNg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFNjaGFubmUgPG1zY2hh
bm5lQGtucy5jb20+DQotLS0NCiBkcml2ZXJzL3Vpby91aW8uYyB8IDE5ICsrKysrLS0tLS0tLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWlvL3Vpby5jIGIvZHJpdmVycy91aW8vdWlvLmMNCmlu
ZGV4IGY4ZmEyMDUyMjY2MC4uOWVmNWIyNzZiMDkwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91aW8v
dWlvLmMNCisrKyBiL2RyaXZlcnMvdWlvL3Vpby5jDQpAQCAtNDQyLDMwICs0NDIsMjEgQEAgRVhQ
T1JUX1NZTUJPTF9HUEwodWlvX2V2ZW50X25vdGlmeSk7DQogICogQGlycTogSVJRIG51bWJlciwg
Y2FuIGJlIFVJT19JUlFfQ1lDTElDIGZvciBjeWNsaWMgdGltZXINCiAgKiBAZGV2X2lkOiBQb2lu
dGVyIHRvIHRoZSBkZXZpY2VzIHVpb19kZXZpY2Ugc3RydWN0dXJlDQogICovDQotc3RhdGljIGly
cXJldHVybl90IHVpb19pbnRlcnJ1cHRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQor
c3RhdGljIGlycXJldHVybl90IHVpb19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0K
IHsNCiAgICAgICAgc3RydWN0IHVpb19kZXZpY2UgKmlkZXYgPSAoc3RydWN0IHVpb19kZXZpY2Ug
KilkZXZfaWQ7DQogICAgICAgIGlycXJldHVybl90IHJldDsNCg0KICAgICAgICByZXQgPSBpZGV2
LT5pbmZvLT5oYW5kbGVyKGlycSwgaWRldi0+aW5mbyk7DQogICAgICAgIGlmIChyZXQgPT0gSVJR
X0hBTkRMRUQpDQotICAgICAgICAgICAgICAgcmV0ID0gSVJRX1dBS0VfVEhSRUFEOw0KLQ0KLSAg
ICAgICByZXR1cm4gcmV0Ow0KLX0NCi0NCiAvKioNCiAgKiB1aW9faW50ZXJydXB0X3RocmVhZCAt
IGlycSB0aHJlYWQgaGFuZGxlcg0KICAqIEBpcnE6IElSUSBudW1iZXINCiAgKiBAZGV2X2lkOiBQ
b2ludGVyIHRvIHRoZSBkZXZpY2VzIHVpb19kZXZpY2Ugc3RydWN0dXJlDQogICovDQotc3RhdGlj
IGlycXJldHVybl90IHVpb19pbnRlcnJ1cHRfdGhyZWFkKGludCBpcnEsIHZvaWQgKmRldl9pZCkN
Ci17DQotICAgICAgIHN0cnVjdCB1aW9fZGV2aWNlICppZGV2ID0gKHN0cnVjdCB1aW9fZGV2aWNl
ICopZGV2X2lkOw0KKyAgICAgICAgICAgICAgIHVpb19ldmVudF9ub3RpZnkoaWRldi0+aW5mbyk7
DQoNCi0gICAgICAgdWlvX2V2ZW50X25vdGlmeShpZGV2LT5pbmZvKTsNCi0NCi0gICAgICAgcmV0
dXJuIElSUV9IQU5ETEVEOw0KKyAgICAgICByZXR1cm4gcmV0Ow0KIH0NCg0KIHN0cnVjdCB1aW9f
bGlzdGVuZXIgew0KQEAgLTEwNDQsOCArMTAzNSw4IEBAIGludCBfX3Vpb19yZWdpc3Rlcl9kZXZp
Y2Uoc3RydWN0IG1vZHVsZSAqb3duZXIsDQogICAgICAgICAgICAgICAgICogRkRzIGF0IHRoZSB0
aW1lIG9mIHVucmVnaXN0ZXIgYW5kIHRoZXJlZm9yZSBtYXkgbm90IGJlDQogICAgICAgICAgICAg
ICAgICogZnJlZWQgdW50aWwgdGhleSBhcmUgcmVsZWFzZWQuDQogICAgICAgICAgICAgICAgICov
DQotICAgICAgICAgICAgICAgcmV0ID0gcmVxdWVzdF90aHJlYWRlZF9pcnEoaW5mby0+aXJxLCB1
aW9faW50ZXJydXB0X2hhbmRsZXIsIHVpb19pbnRlcnJ1cHRfdGhyZWFkLA0KLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8tPmlycV9mbGFncywgaW5mby0+bmFt
ZSwgaWRldik7DQorICAgICAgICAgICAgICAgcmV0ID0gcmVxdWVzdF9pcnEoaW5mby0+aXJxLCB1
aW9faW50ZXJydXB0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8tPmly
cV9mbGFncywgaW5mby0+bmFtZSwgaWRldik7DQogICAgICAgICAgICAgICAgaWYgKHJldCkgew0K
ICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+dWlvX2RldiA9IE5VTEw7DQogICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycl9yZXF1ZXN0X2lycTsNCi0tDQoyLjUzLjANCg0KVGhpcyBl
bWFpbCBpcyBub24tYmluZGluZywgaXMgc3ViamVjdCB0byBjb250cmFjdCwgYW5kIG5laXRoZXIg
S3VsaWNrZSBhbmQgU29mZmEgSW5kdXN0cmllcywgSW5jLiBub3IgaXRzIHN1YnNpZGlhcmllcyAo
ZWFjaCBhbmQgY29sbGVjdGl2ZWx5IOKAnEsmU+KAnSkgc2hhbGwgaGF2ZSBhbnkgb2JsaWdhdGlv
biB0byB5b3UgdG8gY29uc3VtbWF0ZSB0aGUgdHJhbnNhY3Rpb25zIGhlcmVpbiBvciB0byBlbnRl
ciBpbnRvIGFueSBhZ3JlZW1lbnQsIG90aGVyIHRoYW4gaW4gYWNjb3JkYW5jZSB3aXRoIHRoZSB0
ZXJtcyBhbmQgY29uZGl0aW9ucyBvZiBhIGRlZmluaXRpdmUgYWdyZWVtZW50IGlmIGFuZCB3aGVu
IG5lZ290aWF0ZWQsIGZpbmFsaXplZCBhbmQgZXhlY3V0ZWQgYmV0d2VlbiB0aGUgcGFydGllcy4g
VGhpcyBlbWFpbCBhbmQgYWxsIGl0cyBjb250ZW50cyBhcmUgcHJvdGVjdGVkIGJ5IEludGVybmF0
aW9uYWwgYW5kIFVuaXRlZCBTdGF0ZXMgY29weXJpZ2h0IGxhd3MuIEFueSByZXByb2R1Y3Rpb24g
b3IgdXNlIG9mIGFsbCBvciBhbnkgcGFydCBvZiB0aGlzIGVtYWlsIHdpdGhvdXQgdGhlIGV4cHJl
c3Mgd3JpdHRlbiBjb25zZW50IG9mIEsmUyBpcyBwcm9oaWJpdGVkLg0K
