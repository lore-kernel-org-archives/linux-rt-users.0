Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231520C473;
	Wed,  4 Dec 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331358; cv=fail; b=iB1J/NrxufKu/WAmrIi2Q8Dp5WR8fxes6soS+MwxdRaA3uXYR/rp7cBdaV1h3egKOi1kh33PJzMeeLAp0a6NLLoecsMrub9L9NRY0aMCtdrdUsYDd3vjI2+IPvoYTzrTvdjccNPFrgiRUGj9qT/QMShaJBMElORd/Evx1zQQbr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331358; c=relaxed/simple;
	bh=tzoy7DA7Qm7+rBVziaPFCXqYjVxqv2OCCW1jqQA6HHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyYpTtU12R4k8JEN3Eu33jh4mb2R4FYf/MSqnmg+rZ+zOh3pxQCr3Zfwy2Gfxxki6bvfwhwNYk8ledoD1CRcx0vAUXZ8PZy0NZSB8BNeTKos52D2IzzZYC4e710kD0WdZg2GYW5WU1pJFKrtEcclNM2qW3gZ7L+mevU2/exxpA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT6fyCBHOeq7A08VTO6pik2isv0LoW6uVQ2lQDBVPGkxjvPG6dssY3tDXkoiDYxrNb+OXjW1rnyH3Q6rfKR0PnUVtyQvgxyk2Pajd3nzbwOglPNQP4/zk/3pGaJB9DsHu2rwMrhIw3DXmeZfkLlfuvrxJTBj0Yc3W597VQfWYRdbVoQYi84GKRbBOS7PDl9vltcSOCg1gxHglNIrQO8Rovy9wRzgYM3ZGxm9Oz0oGDsm6UAFlhAAs4dBhEuC3sP6hoiCeofW/SXTog7PXeTge0keMO8/NhVaFG89Idy91nqEE9SXm14vSD/5eTjFove6yw6y8mE7iKdHKn4mMBBq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzoy7DA7Qm7+rBVziaPFCXqYjVxqv2OCCW1jqQA6HHQ=;
 b=RajgZ4yGO9vAgz6YOd3WQ5tatty5g0GsD9sytEtJTgAWKvw5cY305NSn82Rr27aznJaBJTyNAyFgnEafgRvkPQ50/bHnnlHtuU7AMtuBTRjpeY8p+HAC4DE+ffEe4Nyso1F82jTTZAeRiT5QzhqFLdOeTLDJp9jS5+SW32ys15Dua5Sx/IDzOBc8LmPOD7GRDZLGaZnHzMrmLT7I0zx/xzl0tVckH0PWKf6mZyY1OkjgzTr2XqrqAks8SbqbnbW5XY5xDOoLkA6BxvuZiY3Nf7vbz3N9OYgn8vHVm9u4eGZDbi2AIFW7W2aRwyHIDoHMCSyb0EKPbV9GcEdggy5K+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 4 Dec
 2024 15:24:38 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%3]) with mapi id 15.20.8207.010; Wed, 4 Dec 2024
 15:24:38 +0000
From: EnDe Tan <ende.tan@starfivetech.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "linux-rt-users@vger.kernel.org"
	<linux-rt-users@vger.kernel.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	"endeneer@gmail.com" <endeneer@gmail.com>
Subject: RE: [RT,1/1] tty/serial/sifive: Make the locking RT aware
Thread-Topic: [RT,1/1] tty/serial/sifive: Make the locking RT aware
Thread-Index: AQHbRWeYAYEA3AjpL0OogbeXF1KKX7LUU4eAgAHg3nA=
Date: Wed, 4 Dec 2024 15:24:38 +0000
Message-ID:
 <NTZPR01MB10187B77E803325E8C88F383F837A@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
References: <20241203094009.67697-1-ende.tan@starfivetech.com>
 <20241203103611._nfkyEXJ@linutronix.de>
In-Reply-To: <20241203103611._nfkyEXJ@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1018:EE_|NTZPR01MB1017:EE_
x-ms-office365-filtering-correlation-id: 1315109c-7cd8-4f08-0f7c-08dd1477c435
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 la01WSyQxaVB4UDyUpgML4S5SOAzDwaDcld76kX4347frwOmuBkiVg47Mcm8Fj250BXIoLatQKh8XDrVjFN+dUNlRHjfh8ulnaIZAZXMYn5piUyzKA0XxDhbhHu6PRkFrvS7KuzW0AYvd4OQlTCIivBgv16lIAjiTFYLeSARg3w6KJmLGbb52Z93bJkUg0mzwp6yj8Q5/M5Z/3FItpYrLXPstND8EGkZ/X1XGycmIv/HyAxTQdtNY5/ubHBgTBDNwZLO1FLhwjaIogsG83l3J+5JW7Yt6IAMp9JVF25TKtZus9vF3ZUL2qBYtLRoOLR3ql7e/Gpb8BzGDL5Wc+4V7zh99FL0cl8zTGluE61ff9HRSe8Rj17M6beVjftPNKpCPYFUZsZisQKiyCVqZ1qvsVyp1CX1vTV+cdiG1U1VQlyeIlfC9zO3kX/+xjup9lCJKZbafXZ8xFMHdKdcUS0Yzvf36JEXPHfWaegTW6B+0pqhXhduQEkf53moc5I9jJDTNM0/eH7rM/2yI1F0a35hbx59oOK+XHBSIUv4/NLHET+NmEXYZQCOixkH1xppjitDnA8Ctd9elzGL6sxyum3jn/N0CeSH7Il3n6Puc2Sop+JmTwdabHF+5APO6pgYL4nf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0VxcC9RRC9ZL0NsYy9Pa3FxUGozcmt0VUxQQlRyVTBYdFlxV3o5Y05WOFRC?=
 =?utf-8?B?TVNRaUFYMFpGVVVpc2xSRitHR1VPcnZjOEwyb3JqUTZjNmF5K1A1Wml0Q2RX?=
 =?utf-8?B?L3liZkIyc2ZxM3YrTGFybmh0aFIza3haSXRNQkFVMlhLVktPZDZOTERHUWFM?=
 =?utf-8?B?NjFDY2JhSFNZNEY4VVk3ZE1lWnN5SlIyNGJqeFEzWmpmSkRMQk9WWDNNcFBw?=
 =?utf-8?B?NjhtbGQ4UTl2bmc4ZDRRTzIzclRMUTV5T3JmVTRJa2FZRHRXTjNTQ3JSbnA2?=
 =?utf-8?B?SzFsV3QwbDF6R0lBN3JJSHh2VTVGQkkrR3pEbUk0bVAzd2JCRnNEVjh4cjFC?=
 =?utf-8?B?Z1Y2WUp3cFpXbHFSNENvajA4dlR1a3JWRHFMQWZlak1SaldybkJTbHhBa1pU?=
 =?utf-8?B?WkxzZUE0ZHFLOHdQcEh3a0F6bm1mb0cxQ1VraHFXeEx3bHdIcHFPNHBUVEFx?=
 =?utf-8?B?aWtPY0szOUdmak53VStlTThsTXIyaVk5QnNFZFNFT1BKOGVyRGVJTkhWZ3JV?=
 =?utf-8?B?azJMNTZiSm9NZTFacy9LN3VjSnhPaDNpM0NWaG82Yng2NmV5blpjQXdETDlU?=
 =?utf-8?B?MmdqUlhNRzdYWUd0L29BcjNZTE1LL0lpVkFGN3pHQ0pPVFM3eGcxNml2VDlm?=
 =?utf-8?B?OHlmajJzTEZUbVFDaEZtbUJYbDF4WTdxSDFHTjYyOWo3cnl6RmJwb3RvSHVh?=
 =?utf-8?B?K1daZTg4Y3JDUnlQSGNTRjhpd2g0cVFCSnRDT3Rrdi81ZXlZM2pWZWRNSnJv?=
 =?utf-8?B?SnkxWFBrcmxkdXdaR0FSdktXS3F0eFcvK3JPSkpyVjJKTFhJbDNINjIyUDdH?=
 =?utf-8?B?aGFzcytnNXJlWkU1OVBjbERyNHNEWkYrQkNUcnRYVHdPbUNwUFZ3K0QrZVpJ?=
 =?utf-8?B?MUJXenVSQ0ZrVXFjTzRZL0E3ajZ0SUNYSjRreWtVS1R0NjNLYmttSHgwRGtZ?=
 =?utf-8?B?Ry9FRkgwREFxaUgxcklNdlBDb2ZEQit6WG1WemFOcW5GWWRCWFJadElER1BJ?=
 =?utf-8?B?RFBhWmpadmNmVW1nR3cxMXRwcEV5Mm1CZzNPVVZEK2YrQ2pTYWZTTVhtYVBK?=
 =?utf-8?B?R25lQXdMcnNqQW9Cb2h6OWExVW1VcVFTMUJQempSbHdnemQzSGFheFFpTHhB?=
 =?utf-8?B?bm11VXJYOVc1cXhUdzhtcVZVWnYyU0IrL0drS3M2bkl2RXYxNGJ2THBXNHBj?=
 =?utf-8?B?TWQ0ck1pQ0RzQVcrdWRaKytCSWRxMkFqMHFhMU1jNEFkaHUzV296ZERsbjhL?=
 =?utf-8?B?eWpMeWRER09xcnZHaGM4aFduSXoxcG43N3lJUEoyZGJKTE44RUZ1ZXYrdDl5?=
 =?utf-8?B?RHhmRTZMM0pWM3lqNnZTTjg4QjdJUXdCZExxTDNzZ1UvYXlmNXk4ejBlUngv?=
 =?utf-8?B?U25SWEpjZ092ejlNZkwxeWxEdVBQUWxuOGluOURtSUxXMzNvcnNvdFIxTDFB?=
 =?utf-8?B?UXBvY0RwMVlvc3lWcHBnNlUrcTZXck9FeVVsV1kwQk50WStleUZUVDBJazRi?=
 =?utf-8?B?am03TkZCYWV2dnVoL1dpbVVhUXVCV0JsZWM1TUNWOTEwaUpOMS9wdHlQYnN2?=
 =?utf-8?B?UnlPV3dTbmdkS3ozczgxM2NucFNlSXAyd0J5RTFadlVUNGFIL3VBTzA5U25t?=
 =?utf-8?B?T2Njd3oxOVlxbVBwdVJ5WFJvalk0M0h3cUxxV2RzMnhpRjVPcTlORTd4aDkv?=
 =?utf-8?B?TkRmWDRDaVFUcmFRYXh5dWZTNDhEcVVZWWxkNThzWnorelZoRHlVMW9FVkM4?=
 =?utf-8?B?RUtaNExyUUpXMlZKS2RyUXdBMGZWeVFMeSt1SkNGdGdWbHE1aG5FZGRFeHZq?=
 =?utf-8?B?akd1d01KT0RvTVA5d2RTTUJPbXdPbFdHTTJleUZBNi9kT29oTW1ONlo3MGFD?=
 =?utf-8?B?V0lmdzlwYXVOdW92OXlaNDQwUXlLbk5RWm5BK3VKT3FTRW5TRGxrNnFTWlJ0?=
 =?utf-8?B?ZGZQQkFNbUpNVDdTTkluYnh6eEc4dXd4dUJxaWpMQlI1ZHdzL3VJeVZ3VXJ2?=
 =?utf-8?B?cmJPRTFaZW5hT0luOXB1a2lQZ3dML0xZYzh6c3gyNnpzTERaa3NYbk5EVHRY?=
 =?utf-8?B?OWlxTklHRDNjcWFPVUFFelFRa1ZuTVlpTnM0NTNBNHlKQTYyckozMkIxZHBh?=
 =?utf-8?B?Y1ZMQjROM3czY2dhUDVNcEl0STRFLzFTVGdNK3dKV21wazR0Y1FHdVJvUEph?=
 =?utf-8?Q?0vCamk2p8UQRFq8BjYHQuyu8rBudracEcSC+GCk9Vgk5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1315109c-7cd8-4f08-0f7c-08dd1477c435
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 15:24:38.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtYsHpR5p6LcUjal3wgPthNHlSz4g0/5Biun8Xq98DnoaKQEw4xOfxIw9NPwstJBb/JrXshyFNnkJQJpWn6dbCJBYqEPhMkV8fP8ushJpN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1017

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBZb3UgbmVlZCB0byBzdGF0ZSB3aGljaCBr
ZXJuZWwgdGhpcyBuZWVkcyB0byBiZSBhcHBsaWVkIHRvLg0KPiBUaGUgY2hhbmdlIHlvdSBsb29r
aW5nIGZvciBpcw0KPiAJMzJjNjk0ZWMzZWZjMiAoInNlcmlhbDogc2lmaXZlOiBVc2UgdWFydF9w
cmVwYXJlX3N5c3JxX2NoYXIoKSB0bw0KPiBoYW5kbGUgc3lzcnEuIikNCg0KVGhhbmtzIGZvciBw
b2ludGluZyB0aGlzIG91dCwgSSBvdmVybG9va2VkIHRoZSBjb21taXQgaW4gdGhlIG1haW5saW5l
IGtlcm5lbC4NCkJUVywgdGhlIGNvbW1pdCBpcyBub3QgaW4gdjYuNi42My1ydDQ2LXJlYmFzZS4g
DQo=
