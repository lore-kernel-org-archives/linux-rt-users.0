Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3E204699;
	Wed, 12 Feb 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347111; cv=fail; b=cBcScHmwudOi12+N8bQOXWoES0sW98eakAyc8G6fmb9jRHjvagc1+zYh4xULUiZG/hZWqxkplrSkd1vZU1SSC4qsHtT3mWS/0tqxV/QU/ijkeOMcmb0FUbjWTOfJ/P0rJ07zzH0TRlB/aBdqMvD4pqGrC76q/vosZY6C0VzYrY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347111; c=relaxed/simple;
	bh=60eT8c0vPvJbkfmSuqTQtPGHfsZA3w3B51OFtkQKVO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mpF5mJ4CGqiAEGYgFKXVN6UXYVCCcgTFpdddy8/ZIH3gDMyhTp1skT8NiKgGFi2CQDkw6AB0sS7XB54EiKvLu3yQtIE8Brd6xdw0gFHIC3a7wGldI2E99BYQQYucgvzzI1jb0rnicU7JMfn6VltG5a4Fc3bBeiXel5NYmUOWHa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=HTpPn1u3; arc=fail smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="HTpPn1u3"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1739347063;x=1740556663;bh=60eT8c0vPvJbkfmSuqTQtPGHfsZA3w3B51OFtkQ
	KVO8=;b=HTpPn1u3jPvLvFK+H9+ltrBAjymRcUkey/N0sNj4kXq1ku9Pb1CwwA4qBipLaDwQZSdAF
	uh4B9Kr9r+lNOCIJpIIGQ4ZP/vfO0aajIgZx0v6sPuCpz0ThsFyyinNYWwTcawSKFqb6b1p/u8NWW
	UD9q6tfGIJKXJKFFUy/ohNSdZcoEtSi8M+KPfhjuuhEfQH0ldw8jrR2BZcBq1/k/OenK8WjvHeVMH
	D37thTAYwBjTd2gxMDiExBsaR/CbdVTtMgjByx1MLhIBwZDQUzeScT8GJCbbThbLpZgRC599fGjT0
	VA28OtirVHSZHZip9V0vzN8UlVQPitrsiaR9QKfAQQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 51C7vgtp1652540; Wed, 12 Feb 2025 16:57:42 +0900
X-Iguazu-Qid: 2rWhyCKR4nPrN2LXD2
X-Iguazu-QSIG: v=2; s=0; t=1739347061; q=2rWhyCKR4nPrN2LXD2; m=yn9gDlh0UjrllVGYQA57LwrdN7F//X7cw3byutw8NUo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 51C7vcfK3691531
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 16:57:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1OX45qSX0beWSFpYcmJhYnDR7f2lSat70bFVGSbWcBSBimJ2eaNt2OYDcitEw9D47KB6Clxf+wAn1W7P9+K3LM7x+wQiR4qG9ir4aLmtV6FeCSRxxXQ6rKbpmwnOcjFaRtJjF5rTizcPkvtrzX9Faqv/AII4uQl8PUBUS+dHHNnLUCup9RmPt3Dh6QhY4f5VTPu81GmPT0QjzYtvWXPsh8lmmL7LTyUtq3mp/lR5oOzg39pgkE7N3Meq7IrScXHdhaY2yHRVKGnM6ID1d47gV78yCVTrl/B5XM3FrZdIi8lOBZEWmqDMu9IbdnWKP5/Os9rlp2Vee5y7fCGmwbVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60eT8c0vPvJbkfmSuqTQtPGHfsZA3w3B51OFtkQKVO8=;
 b=ToJSuPW3kKIfnHg1odSP61ZsBIAU+J9DAgbodz31Z+Qm+5ieYD25B2JDXFaNy0/zjOznx41MAONXPe23MXarfF1OC06u7UIlahGcquIikhB3pdlKd5/uXhX+VABye2NOFvfdJWPVfIWJ6sudx++9v9O5rt8iPB3cbl776YM5zqyE+HwkKsTSIR3SiRjslewU/XZtOGK63A6ZNhywwkfGxH9E6Cv00S4GLp7eGF+ytyArE/auM5RvoyLyjL76fgDj+4bG0dE3OlpVUmgZJJHonkuTC5Q1gC9zhB8l+no3QhzkOZsruVEXyw7bh+lVpxVetthqQx6kUKo9Xeft9+yyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <bigeasy@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
        <cip-dev@lists.cip-project.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <pavel@denx.de>
Subject: RE: RE: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Thread-Topic: RE: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Thread-Index: AQHbdt1fjynK67IvsUq7IgiGjY4ghLNAJwIggAA1egCAAtBxkA==
Date: Wed, 12 Feb 2025 07:57:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385606F5378CE8A0EACA29CE1FC2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <20250204081813.7qsvLFsU@linutronix.de>
 <TYCPR01MB11385E033624D2D9D93992A95E1F22@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <20250210101820.lXceJi98@linutronix.de>
In-Reply-To: <20250210101820.lXceJi98@linutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|OS3PR01MB9753:EE_
x-ms-office365-filtering-correlation-id: 4cdab904-2c3e-480b-84e5-08dd4b3ae859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aTZ4ZUxwNk9PMEhSZVA0cTBvS1hWSU9wK3lKN3pIU0pNSkRsbWJRQm44RHp1?=
 =?utf-8?B?Y2RwQ1BZeUxNV0grdVZrOTJSNWFKZDBsQ3JYb0kyUzYzTjdsMkJMS0d3SVd1?=
 =?utf-8?B?WnZDaENGdXM4bDE0a3lROHNrVUhFelBYalhETm1RK1NDaFZpL3JqamJ0cUZy?=
 =?utf-8?B?WU5qdFYxYml6bFJrWnVmZ3pDNFdWRS91ejZ3bzM4SzBJc0pvQythMEY0dzdx?=
 =?utf-8?B?bFl4VXhRelNOemcvM3EvYUdXQVdBMzdrcXIvZVplZU1PZG94ZVJQUHM0UG5O?=
 =?utf-8?B?RklLMXJzc3JSR0Jua1FlMDZrUGVBTU8rQ3FJSG0zQUZJQkJVUGNJWDZwL3V6?=
 =?utf-8?B?UG9ONWwyT0JWcmhlaEhualNRb1BGU0wzaWdEZVQwTStEemd3TkJHWXpUZzMr?=
 =?utf-8?B?L3FPWUJVZGxCNDd6Z2FYN0JmL1R1NGZFVjJrNGNsTkszaGJ3bENSeHJRMDNm?=
 =?utf-8?B?ZnNwblZKSnNVbmhVd1B5dWZjQmNhenAycXQ1cDVmRW14L3RFdGFWcllqaml3?=
 =?utf-8?B?cE5WM1FiZWlXcHl1OW1DL2pxeWU0dUxmdDcrK1htTFFOWit6SzFUdmhXU3lG?=
 =?utf-8?B?a2RwU09SN2pGM09hazVkQ0ZSUWVhQ2dSRWJ1U3JsUU5vU2tYU09jWCtMUjJL?=
 =?utf-8?B?eWxpVkxXaWJVa3dWOUI5eXJ3Rzl6MGZDQnJJVVhmakZINWhQTHRONVAxcFhR?=
 =?utf-8?B?UEM0WEQxd1RQR2VnV091UmZES0JGQmZhOWpxUG5XN1dQZExSUDd0azYwLzMx?=
 =?utf-8?B?dHRPYmd0SjJrZW15UWhrRkp6LzFVN2x4aFFTUERTTkYrRENsWmhkelc0MEpY?=
 =?utf-8?B?OEtSTmVPWVRDR1NVSU5ROEU2WEJUTTl6WUF2N0xMb1JQMmw3YmhaekFQZ3pp?=
 =?utf-8?B?NVJyVW85WnowaUhKOE9rYXFJVjAzVzQwMkQwYmpNTUVWR2llK0F5ZWgvc3dO?=
 =?utf-8?B?azNPamYyYkxCRDJ2ZHQ5R3ZLYWU5SU5sY1Rwa2R0dVE3QmhqOE1SYVVBRS9V?=
 =?utf-8?B?ODJhWGhSQkVkZ0FxODRKRmxtK05SMFNCckZtUkVsN2RDeUs5VTBxZ0l0dXd4?=
 =?utf-8?B?ekI1YW1SaEdwamEvMEdlZDl1M21xYis5Tkd1VTVsanFLc0hlOEh0STJUYjRL?=
 =?utf-8?B?UlpvZlRyN0ZJdWlOV2JYWWtaUk9zNGc2cHp4YjJkL0VUc1pxdm5GWkpscHZl?=
 =?utf-8?B?enhNd3drZkVWZ3ppc0l3Wm5sdG5JSXdzSlltSUVGQVJwNkFRazIrd2pSdUNC?=
 =?utf-8?B?bUNHOHdyS09PRXpaWW81OFpSY2ZSU3hybmNHYk14aXR5RW9qb0VDbnNZRjBx?=
 =?utf-8?B?NWN5Rk4yMUhyUWJ4b2FwQ2lqelR4ZDJWL25PTSttZTcxcXpuZVM3YUVFM2Vw?=
 =?utf-8?B?UkUyYnpRb0pzWGRvVzVTOG9XcUFuZ2RwMUZSSExQYTRxc1ZMS0tRYzVhUXl4?=
 =?utf-8?B?YlJ2allFL3FKdXJsQkREWTlxUHQ0VjBnR1RLVkpxd0dSam5jR2p0VFEvUllR?=
 =?utf-8?B?TGZpZTNKN0xBN051eFpjQWJDZ2o3MU5DcEFtR095MjQ0TlhvUHpEWEp1V1BM?=
 =?utf-8?B?V0FXYVBUOVc5S3MzdTNSaVUyS0F3T2JHbmlMZ0ZPdmRJbFZHRFo1RGFSbXNB?=
 =?utf-8?B?QVRKSjVjMVJiT0VDdVVOQ1JRR21vQTdjdDBrMStWRVR3YWdtaHZ4SFZYZDNu?=
 =?utf-8?B?clZQWTkvSUk5MCsvT0JhOTd1NSs5Uk5VaTh1QlZFVHY4RmFKN2krdnhGemUz?=
 =?utf-8?B?S3lhM1JIMUxiNXhaQWZLL2pmTWlRMWlrdlVYQmhCdHUxcUQvRmZ5SlhIUklQ?=
 =?utf-8?B?UEF0aVRkMXZEYlJTR2J1SWFLVlFnT2lTbXUxT05oR29sbzNqbmFkRHVDemVi?=
 =?utf-8?Q?3zyJc+dLtS/VU?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODdSbTFzTkYxRW5lemVzQ01KNG9yMHZySlQvZUtEdEtTZ0hYdlo1dUc4Tk8r?=
 =?utf-8?B?VnJVRHhDMm4ydlkvZ0ZNZnZYeVNGU05XSVcxYjF3cnJzcy9DcTZUQ0U1RUxO?=
 =?utf-8?B?cXhDOW1LVFI4bDg5WVVLRklRaW14NS91SGVMSnlscHdBVnpOUUJxak5oZkEx?=
 =?utf-8?B?UGhqUkZxd0gwR1JHWFNCMTFROVBHSjFiM1YwakVab0RLR2YwTVkydVFGTUhY?=
 =?utf-8?B?TFBnU0Zmd0ZJN3ZFUzlqa3kxUC9aSURyemtaRU5SYit0eW44Y0NXUjB2U0JK?=
 =?utf-8?B?QnZNdXppbngwQ2k1QVk4aGc2ZnJ4a1lXTGZ0TVFFY1QvT1loQWE1cm5qdFNX?=
 =?utf-8?B?ci8xd2VQK1NUSGY3bzB1Vk1OTWIvR3BXRk1yS01mc0lvMzYwMHpTeXkzZlU2?=
 =?utf-8?B?NmE3WFVQd2g1bzBiOEZWQ1F5bnQvbXVwQVBFZFV6N2J4bkp0bUEyVysrdFB2?=
 =?utf-8?B?cXkrUEhTWlN2Ty9ENDl0S2tvZ25TR2lFaXJ3cU9zaWZITDFRRGpPSU1sZFhB?=
 =?utf-8?B?RmdYblpJL1RnZENicWs5Q3ZuVUg2V2dXbkFuY1RnTzRzbytNRXlrSG5ONDc5?=
 =?utf-8?B?YWVYb0c2RkV5SUNMNW4zVmlLU0F2S3lCd3FhbUFNeXRmODhSSk5PNVQ2RHRY?=
 =?utf-8?B?SW9nd3VGa1pMb3BibkczU3FSUDlhVlRuaGpUTFFzQ3lpT3pDZEszM2ZlRXVF?=
 =?utf-8?B?VXpWK3ZHdktzSFREMlcxNUtPRFQ2NGxXK2pCNnF5dzM5cGxXME9GeHBhcnVl?=
 =?utf-8?B?dElPV0UwZGRWUTJBM001dUtVc25zaTFVeWF5VThFZ0RPMkthRE9hcG1vb1Zq?=
 =?utf-8?B?UGk5QlcwYUlzTjM2QlM4MzJTUFNFN2FabzdYTGZDZXgyZWJaTy9TY1dETW9s?=
 =?utf-8?B?UWFtckRpc0tDZzBzUjFsSldiOFVnOW9meUk2b1p3ZkpDNXZhc0V3eDEwaHEz?=
 =?utf-8?B?RkhCQ2g4K3BJbmcvbEpmVjEycThTSGM2QWFlTU1BSVlNZ3NyUDE4V1VxckVP?=
 =?utf-8?B?eVp5V2tqTGdodHpNZXRNay9oL2ZrMnRiMHhWN2d4RmxXQ3M1emQrRFV2VDBN?=
 =?utf-8?B?aHdTUjZqNmdVdTFqL3pMU0RGUHRoVUlFaDY3ZGZVUmh1TWdRZXJKcUNlSXdB?=
 =?utf-8?B?aTJ3UkVwUG1ZTmkwNHlrOFpDelVCY0lnbGRZSHFDOEJXZm1sbWpMamh1dmRt?=
 =?utf-8?B?Qkkxam05QUdBa00rVitteUg3N21SeWVqckFzaG5GOFJ3VnpsNUpFTFJaUEdh?=
 =?utf-8?B?REtXbzNyMi9GTzhBOVppelM2Q203b3dLMGl2L01kZ09hMW1mVGNUYlp6YlNl?=
 =?utf-8?B?S0YzNHdiZnhGOXo1eVAzVE1NYmdaTUx4RlpyVkNTdVhTcncxVW9ONllyVEwv?=
 =?utf-8?B?NFhORWltTUphbEk0YWJxVENNRWVob1lOazNmNTJrZ1U3N3NkK1NFZDdFT1NC?=
 =?utf-8?B?U21UdGFyWWNQc3FteXU2aDNiNUpmV2ZVejB5SkVwN1pseUNuM1Qyam1hdmFX?=
 =?utf-8?B?djg4cGdISHdZQ2ppNXFxYStIOHk4ZnRBQTlJSkppUWtuSk5SOW4wM2gwYUZB?=
 =?utf-8?B?ZzNzVlo1SS80M0xKaW1ESGZpRnNRaUhWTnp3U0RrdmU0UzRlMDZhM29rcWpJ?=
 =?utf-8?B?dUNiMVcyanA4bURlSFM3MUdoQzlMUFZDSkhQNWFGQjN3RlRJditIaTMzWVZN?=
 =?utf-8?B?MkZxeTl0YUtmSzdsbkNrZTZJMWd4ZEVJdmQreEoxemtLS0pmcEdnc0dZZmd2?=
 =?utf-8?B?Snh4dVJYOTQyV21aeStXMk9wenl3NWtKNWw3WjN4S1h2Z2x4YW5iWVVZaXVH?=
 =?utf-8?B?MkFVaXdhRm40WDFoSkFSeVd0YmxGd2prQ2d0NmdmYUlRU2J5M3MrNElUZGM1?=
 =?utf-8?B?NWZxSGhBbTBqeStJbForRlBDUHJOeU1nQ2x3T21mZnNWa2ZPVktGMFdYcE9E?=
 =?utf-8?B?UGNCYzVKeUVCTWlac3JtODExdmg0NUN5MkN2S1czeGJhNGpRZUJ2U3FLL2NW?=
 =?utf-8?B?bk1hSUUxVTc3MzFOY3J3OHVseHh4WmdxTmk1YlJCWXd1cG9lS3R4YlZ5YXo2?=
 =?utf-8?B?Njlvbmx6Vmw5WEp2RHhtSi9zSkFFMjE2dWw0b3hvRUxRUUw1S1pSSGk2VVVQ?=
 =?utf-8?B?TDh3b08zeEhBa1NmV1d6WVhYZWo2NFV4dUxKMktGVDJmTXRPeTBPSVdiQlNU?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdab904-2c3e-480b-84e5-08dd4b3ae859
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 07:57:33.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yj+jRTA3YilJKT2OiukBinR+yybkkH84pAtXk7XkOLJpdYYc+Fs8Tn0sJERRXGBLre0h3C5KUpsBkYnSbwIQzFwDL3De/typAy0RAkzMrZYFH8zIXTdIIPOuyxylHGb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9753

SGksDQoNCj4gPiBbLi4uXQ0KPiA+IENhbiBJIGFzayBpZiBpdCdzIHJlY29tbWVuZGVkIHRvIGlu
dHJvZHVjZSBTWVNURU1fU0NIRURVTElORyBldmVuIGluIExUUz8NCj4gPiBJdCdzIHY0LjQtcnQg
c3BlY2lmaWMgdG9waWMgYnV0IEkgdGhpbmsgc2ltaWxhciBkaXNjdXNzaW9uIGlzIHJlZ3VsYXJs
eQ0KPiA+IGhhcHBlbmluZyBpbiBuZXdlciAtcnQgYnJhbmNoZXMgYW5kIExUUyBicmFuY2hlcyB3
aGVyZSBQUkVFTVBUX1JUIGlzIG1lcmdlZC4NCj4gDQo+IEluIGdlbmVyYWwgSSB0cnkgdG8gaGF2
ZSB0aGUgc2FtZSBjb2RlIGlmIGl0IGlzIGVhc2lseSBwb3NzaWJsZS4gQSBmZXcNCj4gZXhhbXBs
ZXMgd2hlcmUgdGhpcyB3YXMgbm90IHRoZSBjYXNlOg0KPiAtIFRoZSBwcmludGsgY29kZSwgYXMg
d29yayBpcyBpbiBwcm9ncmVzcywgd2FzIG5ldmVyIGZ1bGx5IGJhY2twb3J0ZWQuDQo+ICAgVGhl
IGNoYW5nZXMgYmV0d2VlbiBrZXJuZWwgdmVyc2lvbnMgd2VyZSBzbWFsbCBhbmQgdGhlcmUgd2Fz
IGxpdHRsZSB0bw0KPiAgIG5vbmUgdXNlciB2aXNpYmxlIGNoYW5nZXMuIEhvd2V2ZXIgY2hhbmdl
cyB1bmRlciB0aGUgaG9vZCB3ZXJlIHVzdWFsbHkNCj4gICBiaWcgc28gaW4gZ2VuZXJhbCBpdCB3
YXMgbm90IHdvcnRoIHRoZSBlZmZvcnQuDQo+IA0KPiAtIHNjaGVkdWxpbmcgd2lzZSwgd2Ugd2Vu
dCBmcm9tIFBSRUVNUFRfTEFaWSB0byBQUkVFTVBUX0FVVE8gdG8NCj4gICBMQVpZX1BSRUVNUFQu
IEZpeGVzIHdpdGhpbiBvbmUgaW1wbGVtZW50YXRpb24gd2VudCBhbGwgdGhlIHdheSBkb3duDQo+
ICAgYnV0IHRoZSBpbXBsZW1lbnRhdGlvbiBhcyBhIHdob2xlIHdhcyBuZXZlciBiYWNrcG9ydGVk
LiBQUkVFTVBUX0FVVE8NCj4gICBjb3VsZCBiZSBjb25zaWRlcmVkIGFzIGhhbGYgd2F5IGRvbmUg
YnV0IG5vYm9keSBjb21wbGFpbmVkIGFib3V0DQo+ICAgc29tZXRoaW5nIGluIHBhcnRpY3VsYXIu
IEl0IHdhcyAicmVjZW50bHkiIGRpc2N1c3NlZCB3aGV0aGVyIG9yIG5vdCB0bw0KPiAgIGJhY2tw
b3J0IExBWllfUFJFRU1QVCB0byByZXBsYWNlIFBSRUVNUFRfQVVUTyBpbiBzb21lIG9mIHRoZSBs
b3dlcg0KPiAgIGtlcm5lbHMgYnV0IHRoZSBjaGFuZ2VzIHJlcXVpcmVkIHRvIGJhY2twb3J0IGl0
IHdvdWxkIGJlIGh1Z2UgYmVjYXVzZQ0KPiAgIHRoZSBzY2hlZHVsZXIgaW4gcGFydGljdWxhciBj
aGFuZ2VkLiBTbyB0aGlzIGlzIGhhcmQgdG8ganVzdGlmeS4NCg0KVGhhbmsgeW91IGZvciB0aGUg
ZXhhbXBsZXMhDQpJbiB0aGUgYm90aCBjYXNlcywgaXQgc2VlbXMgY2hhbmdlcyBmb3IgYmFja3Bv
cnRzIGFyZSBiaWcgYW5kIHRoZXkgYWZmZWN0DQpvdGhlciBiYWNrcG9ydHMgd2hpY2ggd2lsbCBo
YXBwZW4gaW4gdGhlIGZ1dHVyZS4NCkNvbXBhcmluZyB0byB0aG9zZSBleGFtcGxlcywgSSB1bmRl
cnN0b29kIHRoZSBTWVNURU1fU0NIRURVTElORyBjYXNlIGFzDQp0aGUgb25lIHRoYXQgYmFja3Bv
cnQgc2hvdWxkIGJlIGNvbnNpZGVyZWQgYW5kIHRyaWVkLg0KDQo+IFdoYXQgcXVlc3Rpb25zIGNh
biB5b3UgYXNrPw0KDQpBcyBpdCdzIGNsZWFyIHRoYXQgdG8gYmFja3BvcnQgdGhlIHNlcmllc1sx
XSBpbmNsdWRpbmcgU1lTVEVNX1NDSEVEVUxJTkcNCmlzIHByZWZlcnJlZCBiYXNlZCBvbiB0aGUg
aW50ZXJwcmV0YXRpb24gYWJvdmUsIEkgaGF2ZSBubyBmdXJ0aGVyIHF1ZXJ5IG5vdy4NCg0KPiAt
IERvIHlvdSBiYWNrcG9ydCBjb2RlIHRoYXQgcmVsaWVzIG9uIGBzeXN0ZW1fc3RhdGVzJyBvciBk
aWQgc28gaW4gdGhlDQo+ICAgcGFzdD8NCg0KSSBoYXZlIG5vdCB0cmllZCB0byBiYWNrcG9ydCBj
b2RlICgxLzE3ICYgMTcvMTcpIHRoYXQgcmVsaWVzIG9uDQpgc3lzdGVtX3NjaGVkdWxpbmdgIChj
dXN0b20gdmFyaWFibGUpIHlldC4gTm8gcGxhbiB0byBkbyBzbyBhbnltb3JlDQphcyBsb25nIGFz
IHdlIGNhbiBzZWxlY3QgdG8gYmFja3BvcnQgdGhlIHNlcmllc1sxXS4NCg0KSSBoYXZlIGJhY2tw
b3J0ZWQgdGhlIGZ1bGwgc2VyaWVzWzFdIHRoYXQgcmVsaWVzIG9uIGBTWVNURU1fU0NIRURVTElO
R2ANCih1c2VkIGFzIGEgdmFsdWUgb2YgYHN5c3RlbV9zdGF0ZWAgaW4gdXBzdHJlYW0pLiBJdCBo
YXMgYmVlbiBzaGFyZWQgYXMgWzJdLg0KQ0lQICg0LjQgUlQpIHdpbGwgZGVjaWRlIGlmIHRoaXMg
YmFja3BvcnRlZCBzZXJpZXMgd2lsbCBiZSBhcHBsaWVkDQpiYXNlZCBvbiBhbGwgdGhlIGZlZWRi
YWNrcyBoZXJlLg0KDQo+IC0gSXMgbW9yZSBsaWtlbHkgdG8gYmFja3BvcnQgY29kZSBmcm9tIGJl
Zm9yZSB2NC4xMyBvciBhZnRlcj8gRWl0aGVyIHdheQ0KPiAgIHlvdSBuZWVkIHRvIGxvb2sgYXQg
dGhpcy4NCg0KSXQncyBtb3JlIGxpa2VseSB0byBiYWNrcG9ydCBjb2RlIGZyb20gdjQuMTMgdGhh
dCBpbnRyb2R1Y2UgdGhlIHNlcmllc1sxXS4NClRoZSByZWFzb24gaXMgSVJRIGNvbnRyb2xzIGlu
IHNsdWIuYyBhcmUgY2hhbmdlZCBzaWduaWZpY2FudGx5IGZyb20gdjUuMTUtcnQNCmFuZCB3ZSBj
b25jbHVkZWQgdGhhdCBpdCdzIGhhcmQgdG8gYmFja3BvcnQgdGhlIGNoYW5nZXMgaW50byB2NC40
LXJ0WzNdLg0KQW5vdGhlciBtYWlubGluZSBzZXJpZXNbNF0gcmVwbGFjZXMgbW9zdCBJUlEgZW5h
YmxlL2Rpc2FibGUgY29kZXMgaW4NCnNsdWIuYyB3aXRoIGxvY2FsX2xvY2tfaXJxc2F2ZSgpIGFu
ZCBsb2NhbF91bmxvY2tfaXJxcmVzdG9yZSgpLg0KRXZlbnR1YWxseSwgYHN5c3RlbV9zdGF0ZWAg
aXMgbm8gbG9uZ2VyIGV2YWx1YXRlZCBpbiBTTEFCIGZ1bmN0aW9ucyBhdCBhbGwNCmxpa2UgdGhl
IHByZXZpb3VzIF9fc2xhYl9hbGxvYygpLg0KDQoNClBhdmVsLA0KRmVlbCBmcmVlIHRvIGFwcGVu
ZCBpbmZvcm1hdGlvbiBpZiB5b3UgbmVlZC4NCkNhbiB3ZSBzZWxlY3QgdGhlIChyZXZpc2VkKSBm
dWxsIGJhY2twb3J0WzJdIG9yIGFueXRoaW5nIGVsc2U/DQpJJ2QgbGlrZSB0byBrbm93IHdlIGFy
ZSBpbiB0aGUgc2FtZSBwYWdlLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MTcwNTE2MTg0MjMxLjU2NDg4ODIzMUBsaW51dHJvbml4LmRlL1QvDQpbMl0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtcnQtZGV2ZWwvMTczOTE3MDU0NS0yNTAxMS0xLWdpdC1zZW5kLWVt
YWlsLWthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanAvVC8NClszXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvVFlDUFIwMU1CMTEzODVDNEM1Q0E3NjUwOTBFNjY5NDRGRkUxMDUyQFRZ
Q1BSMDFNQjExMzg1LmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20vDQpbNF0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDIxMDkwNDEwNTAwMy4xMTY4OC0xLXZiYWJrYUBzdXNlLmN6Lw0K
DQpCZXN0IHJlZ2FyZHMsDQpLYXp1DQo=

