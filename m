Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022073.outbound.protection.outlook.com [40.107.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEC1B6D08
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Mar 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.161.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648052; cv=fail; b=AcdRHJJfRwimdr+2ndfxIz57LgBmjGjxyIFDzYIdujDweArauh+tGP3vSeGmtIDRl0dTb8hq2KIhKkoGg/P7yL6EqM6S1lynujjFg+jNL8QcFFyE55mNwTnzZEL6WhKjwsfCHTflUHDPpyPMzWD4uOHGdX5ya/gbTMBAURpCMBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648052; c=relaxed/simple;
	bh=O313Ra6maKoKZ1Idgx/KKDzoTDMDRxJdhhgfvADsoU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sZRzYFKZ7G4ciDWKlh7rFis8APzI68HMyjAXbCySXjksQqECHiO7pJzoYAS0Ufy6MVQ0HacSuqW5bWsMgP1M90lHNgpY5wg3dNnIau8APZzEumw8P57rpoX/qkRYVILJtIqDl9PTk/Cak5ZM41BpQVIdGUcho5WzANeLmGvxeR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=numalliance.com; spf=pass smtp.mailfrom=numalliance.com; dkim=pass (2048-bit key) header.d=numalliance.com header.i=@numalliance.com header.b=KjEF2ENs; arc=fail smtp.client-ip=40.107.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=numalliance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=numalliance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=numalliance.com header.i=@numalliance.com header.b="KjEF2ENs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/e/lmkXKsZWBo5/Ots+9EqBxTAKNUOvISovahC8WKTlk4SC9t3iLGXNAW2Afsj2rd5insTUipy2viMdNRY6BXodim4qeBmpwUc5ZmC7BRWZ06Ytlu1sgjyw9Ty9NgG47CJ2wLNnIbBH/5e/wiV6JCEbVIxoL87eKGkOKI37tv5wvoo8wWsWqbcr3QUtXUYt0DziLKHQUuPkGkLw8Z83tZEfwo/FYHYgm85gq4evIsgpgpDWZ8F0nRG0eNvcjbyo4lpQQyVUmNlffwm/PCMBt9PV17VH6+3HIu8ndLhKEuksKY9/S8yvp0QAVHv/rmkLZyIORzB8lZBWmI8+8I1CMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O313Ra6maKoKZ1Idgx/KKDzoTDMDRxJdhhgfvADsoU0=;
 b=K8EQY7t6+zVd4LjzqnSGKU21TWJ0iMG+8Gi6know4vMuczkK9LU+Fz92l2D/1h82AZPRxVyIGIebe5WUrUAeVOQV1fhaAZ0yeZd/Dbk9XbhEGGYRlqMIqizmKGIITFFEF32wjPlqX2VUYaTv1QSAIMKRFMfaOCK/5L7HoW96SS2uGsOaTOe/Ufw5P5MXONSqGdld+DaIpQaQj3o9lp9tGiaN65bdemb+bbyoT1hJfTfeGHXq+vpaqvF+7OI3d8Rx9rE5N7WPoJZhU/krf9z2usInh0xwlqUFOL3ID4RA1mkv6UwBzTOAMrLeP1BTX9U2j98BL1/tQhUI3Ip6UkgpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=numalliance.com; dmarc=pass action=none
 header.from=numalliance.com; dkim=pass header.d=numalliance.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=numalliance.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O313Ra6maKoKZ1Idgx/KKDzoTDMDRxJdhhgfvADsoU0=;
 b=KjEF2ENsGO/XaM3hyNXRu8GgRBFeQoyL6PX7bLkGcahrUwX3QfpF94eFxJnmqWP2aOwt8yIFetQLELSNu6CwAOnIi1PLXfJELzEhkDuyODZVRTL0XLmSUy5FAtpBeU/6Y1aVWvNrjheKRE+4uF8YQEz6mPiMjPIbi2TB1kP//qCJCKNzi2ZZz140k04c3fNVJlCMlvAPbNpE7w93/zj3lAJ7P8NkSxLZtmMKwYQvUcmPChQdcDan0TQWe20CIsbxky1grNsWCiBKMbvBqCuu3rsK0XUUFvGPJLUUcF+Joul/l4XLSJ+m37to34+l+bnFd4Hcv/PhV9h0tEei3cCP+w==
Received: from MR1P264MB2468.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::13)
 by MRZP264MB2825.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 08:00:41 +0000
Received: from MR1P264MB2468.FRAP264.PROD.OUTLOOK.COM
 ([fe80::48c2:ef6d:ca0d:4a55]) by MR1P264MB2468.FRAP264.PROD.OUTLOOK.COM
 ([fe80::48c2:ef6d:ca0d:4a55%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:00:41 +0000
From: Stephane ANCELOT <sancelot@numalliance.com>
To: Alexander Dahl <ada@thorsis.com>, =?utf-8?B?6rmA66+87IiY?=
	<m.kim@knu.ac.kr>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject:
 =?utf-8?B?UkU6IEV0aGVyQ0FUIG9uIFBSRUVNUFRfUlQ6IHNlbmQtcmVjdiB0YWlsIH41?=
 =?utf-8?B?MC04MM68cywgbG9va2luZyBmb3IgZ3VpZGFuY2Ug?=
Thread-Topic:
 =?utf-8?B?RXRoZXJDQVQgb24gUFJFRU1QVF9SVDogc2VuZC1yZWN2IHRhaWwgfjUwLTgw?=
 =?utf-8?B?zrxzLCBsb29raW5nIGZvciBndWlkYW5jZSA=?=
Thread-Index: AQHcstPF7D/LTD+z90uJHCceXu/SB7Wwz3C8
Date: Mon, 16 Mar 2026 08:00:41 +0000
Message-ID:
 <MR1P264MB2468DAE07A123EFC6D0A7FBECF40A@MR1P264MB2468.FRAP264.PROD.OUTLOOK.COM>
References: <C35885A5-1CAD-4373-927A-CBEB7DF116EA@knu.ac.kr>
 <20260313-icy-nursing-37b1bbeb83a1@thorsis.com>
In-Reply-To: <20260313-icy-nursing-37b1bbeb83a1@thorsis.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=numalliance.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2468:EE_|MRZP264MB2825:EE_
x-ms-office365-filtering-correlation-id: 5ce92d7e-dba5-440f-c674-08de83321e27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 +oau+TrSMqJ44zWHvoqwzP8UKmVlLiVGM+6s4oUyEaEp4vhbi9f6JUVZV2U0ezU0g2aO4cKtqBJd/ZD7+FNw3Hre7FJf282lDr6RFO5vmxlTtLXYWQo5v7COKKvICa+/tzAaczKZTnbx95v5Jt3XW9hVa8qfFOJ7Kf7Hi+K3i01Y+3F+EHPKqf4Unfi6c4u/7w3qmDh/GMPu/C9YvYJI0Tks3q2N3qo1yh1LZoRSXwWScmO1xAyDM+7sdMT4PMDQuV9mcAEBfC+VWscYBSNh4VgNiz1+logA2TFjHanYpKVDVZkdHaVjnsPC0CLNDHjIJryPXmcL7m2ZMA6Azbhubc66jIjm2T5pZQcEkfqYcHZSmYFnbSwbY/mfyKYP/TZnmA8oO/7Yk8awB98j0hV071THeIFpctvoYWhbvQOeJ2zpgYxYSJjJU3p6PUFmcgFut2Z7GtSreaWY8xbyvW+lBZns5qQ9X6NVGs/6knJXhnFB3zHNstTk751EWBwcEuzwx/gNToEiJqCHOUVm8MATLY8y4hQ6po9NowZA+zcM2cAuQAZKOirF48+Sw0JynjIl7xQmZNTlKfVBjkbY25CXpSrzFZQ6hPbT8cqjwzh9vt1oFJkEsvciGjpVLlEyZgq9+5p5/mlSeji9X0Sj0Cjtilfdhn25vcrkszzgOHCF4j5A6BTQUl5t4cEP+LmKhvtr+cpPXW7r6EbQk1nuAeAY3He9p+iQrgxTTKJCUlcPxzpGcVKJo5v3NYIIRdfJa1jx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2468.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0dsWVZHVFlLSDlRQVVMNURiVVB1eWlSR3ZQK3RBaEtSQ2ZMZG1IR0F4ODdQ?=
 =?utf-8?B?SXMxWmRBME9Rc1E5VGhFalFnSjF3RVRVU282UEJuU0JBZC9KT1hKbDRTVlVE?=
 =?utf-8?B?RDh5V29kbzI5OGpOVUltZlFLcU90RGVxMTFzR3UydWNwR2Uzc2VQNTdONGgy?=
 =?utf-8?B?MHo1bXY2MTcvNzd4YlJiUUtxTGRBdzhhN2VKSXllTHlSUU1rOHpJZFhCSjFW?=
 =?utf-8?B?aHU1V1dwaUdYMXVsenBxQWlMWkxuTmxtRFpVeHRHQUptU0xEcWlSTTR5VmRj?=
 =?utf-8?B?cFN4cjZTZ1gyVHl5RmE2dkdSaTVEcFkwdW0wWnFkdGFHSHNkK0RaTWs3S0Zk?=
 =?utf-8?B?b0hrRmcveTJ0aDh5VlNnVWNMWlhEeE8rK05VQ0V6dU56WG9NcFVPUmswRGcv?=
 =?utf-8?B?ZlVrb25xRHhxb2pCcmc1b25nU3d2YUtUclZmcDlpcVd6VW5kWHVrYnhiRTJk?=
 =?utf-8?B?TlQ4ZWhIc3U1K2RpTldJTGZwM0MvVXJETzFPbG1ZSEJRNTRWS2tYNTNZRGVF?=
 =?utf-8?B?QlBuQldFZmd6YXBWUVR2T1NaeHo2MnpDQWFLZzhOZmFhSFpqdmJ6VnNwSTY4?=
 =?utf-8?B?aWE2cE9jRUphYVREdEY5RDV0NW1obXZqSU1HdUtmdDhRbWxSQ2JoakV3MUVq?=
 =?utf-8?B?emJLeityNHNCSkUwVHl5TWpXZXo4VnlxMzdOWW5PUDRCeVVuNVRwbG4rQW8r?=
 =?utf-8?B?Skw3UHhoazRMU2N3ckZmVmlZNmxpSjB5bU1EOExrZExDbXRKaFExZzBiQmFC?=
 =?utf-8?B?N0NldXlQSUpPZmh3NW5VcFAzNXFPZUFWbnNLYnZnbjZ0ZlNyTENaKzBHdGsx?=
 =?utf-8?B?SG1SbDQvcWwzRU5oV1Q4Y0RYMUFJUWhMWDR2T2J1TzJiRW9qWHNpUnpGZHJZ?=
 =?utf-8?B?eW1VbWdpRndtaVFsQnZqQTlJMlphWGZkR040OFQ3T2VYcGs3Y0NBaGE4MG5X?=
 =?utf-8?B?Y0dGejhMQldrSzZudDlIKzhNdGxONXFHTmtJckl4b09LdjIxMEF4bjFyekM0?=
 =?utf-8?B?cE5POUtrM0QyN2k1aUN0SS9wS0FiM3B4QlU0ZzdDMDZCMWgra3JwRGcyZkRJ?=
 =?utf-8?B?c09SMTNUVUcxdTR6bWh5WSt1OHM0YkNnV1BqNUpCNklMNDVweGpHN2FkQTFq?=
 =?utf-8?B?eEEvQ1I1ZnZlYnZ0Q1dwWFFSb1VJSGNiTS9vcjhoWDNYR2x6c25QeFoxM0RR?=
 =?utf-8?B?ZzRCZ3QvUHBjZk1KckFKZzl5ZFFzTkFFOFVrWXl3RnplWDNYbkpGcVQ2TnBs?=
 =?utf-8?B?cmZieXgwbUx6WnFoZVVOaUlGVE1HTlk2OUpkd3d5RE14bTZ5VFg2Q1ZHb2lV?=
 =?utf-8?B?ekk0UmNnZkYreVd5VFdQVEM1bklhV0hQT0o5d015L2J1bk9qdjZsaDFYWk9x?=
 =?utf-8?B?MUVXRCtNRmhEUmZjMmNuOU02ME8xazRMUUcyb242NEpFV3dqcm1jSzczT1dL?=
 =?utf-8?B?cFFsTmRQUHRINTZneGZXUW1oc1F5MTUyZml0WFhQSURUdDZ0UFNpUGEwOHJH?=
 =?utf-8?B?TjVndnJMSVZ6Z3ZFaTVrWXFCRzk5bkpGYTRxTlpXanpEajQ5QTdFcjh3aW1I?=
 =?utf-8?B?SWFsRkhvM0RPcWJzN212M2piWDUxNW5JUE9uYVROcnJ2NU8zRXhJSDJmYzAw?=
 =?utf-8?B?dVAwOHZQbElxSGZDWnJkNVFuamtJL1RNZzdjdTlCYzRtSXNncVNLaUFxazVt?=
 =?utf-8?B?bXM3eFJOQVJ0ZDdibU1VdGtianJ1bDJCOGV1N1MzM3NTWXBTWUd1ZVFHWGpY?=
 =?utf-8?B?M1EwWGFKSnZobHpUeVV2dkhQYTM4L1BQMW1FMUhDaXNieXVLUFljUDZCUGJX?=
 =?utf-8?B?OWFxSkVMdDJTb0NnVnF2bkFRM2MzZU1sYXpPNlk4VDBWanMxRTNuclk4cVN1?=
 =?utf-8?B?aFhLL3RzaFZHUlJFU1BPV1Zubk50ZDdBdXBjYlBHZEFMMllEWlBtRlFzSWVk?=
 =?utf-8?B?T1Q0Wi9EaFZtcnhsK01BTDAzNldZdWlRNUdETnNvRytwWnliVlR2bUMyWDZU?=
 =?utf-8?B?VGtUUklYQ2x2VExURmJrQ3NYUCtQbXp0WXB4NVJvYVQxSUJBek14VDFRMEY1?=
 =?utf-8?B?MzRoUGVzZEVPR3k5NGI5M3hxY0RJVWdIell5cFBRYy9xR0VxQVZtK29zZTQ2?=
 =?utf-8?B?TnNMRitvTUpPV1dRdm1yMElraWZ3WC90SVAxK2dUeVozdzA5R01GemR5Umlu?=
 =?utf-8?B?a1oxUDJsaFBRWjB0SUplWVpacTUxMUo1RW4vSFFXYURSQ2tmUk1tblljR1Vw?=
 =?utf-8?B?Ujk4aFRrV29Sc2d6WDhGaGNSbUFma293UmEvVDhKM3ErK3dFaHY4TzNtbkpG?=
 =?utf-8?B?c1JNOGMrL0hYdXV5M1plSFZ4YzUwKzVKVjY4b1lUMnp6UlhHajJXaThVUTZi?=
 =?utf-8?Q?Ljcv92US22ywLGS9JTLiDQeF8SDPhnkbJ6le3w33Eu2UQ?=
x-ms-exchange-antispam-messagedata-1: lYn8v05UqgdVew==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: numalliance.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2468.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce92d7e-dba5-440f-c674-08de83321e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:00:41.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1312b0f2-6ca8-425a-b2f8-24eac9852610
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRy+sg+JTxK7RPhpWPD3IACABTEPIAYTEEyaL8Gp5UZotQ61mo/jMj6KKuAlxUg2ZvRoFn2cpHrAvlFOTUyN2+GfQy2RwxP/XizVCBWPlvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2825

CsKgCsKgaGksCgpCeSB0aGUgcGFzdCwgb24gc29tZSBydGw4MTM5IGNoaXBzLEkgaGFkIHByb2Js
ZW1zIHdoZXJlICB0aGVyZSB3YXMgYSByZWdpc3RlciB0byBwcm9ncmFtIGlycSBkZWxheXMgLgpJ
IG1lYW4gdGhlIGlycSBzaWduYWwgd2FzIHRyaWdnZXJlZCBhZnRlciB0aGlzIGRlbGF5IGJ5IHRo
ZSBjaGlwLgpDaGVjayBpZiB0aGVyZSBpcyBzaW1pbGFyIHJlZ2lzdGVyIG9uIHRoaXMgY2hpcC4K
ClJlZ2FyZHMKU3RlcGgKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkRlOsKgQWxleGFuZGVyIERhaGwgPGFkYUB0aG9yc2lzLmNvbT4KRW52b3nDqTrCoFZlbmRyZWRp
IDEzIG1hcnMgMjAyNiAxMToxNQrDgDrCoOq5gOuvvOyImCA8bS5raW1Aa251LmFjLmtyPgpDYzrC
oGxpbnV4LXJ0LXVzZXJzQHZnZXIua2VybmVsLm9yZyA8bGludXgtcnQtdXNlcnNAdmdlci5rZXJu
ZWwub3JnPgpPYmpldDrCoFJlOiBFdGhlckNBVCBvbiBQUkVFTVBUX1JUOiBzZW5kLXJlY3YgdGFp
bCB+NTAtODDOvHMsIGxvb2tpbmcgZm9yIGd1aWRhbmNlIAoKCsKgwqDCoMKgwqDCoMKgIEV4dGVy
bmFsIFNlbmRlcjogVXNlIGNhdXRpb24gd2l0aCBsaW5rcy9hdHRhY2htZW50cy4KCkV4cGVkaXRl
dXIgZXh0ZXJuZSA6IFNveWV6IHBydWRlbnQgYXZlYyBsZXMgbGllbnMvcGllY2VzIGpvaW50ZXMu
CgoKCkhlaSBoZWksCgoKCkFtIEZyaSwgSmFuIDMwLCAyMDI2IGF0IDAyOjMzOjU4UE0gKzA5MDAg
c2NocmllYiDquYDrr7zsiJg6Cgo+IFRvOiBsaW51eC1ydC11c2Vyc0B2Z2VyLmtlcm5lbC5vcmcK
Cj4gU3ViamVjdDogRXRoZXJDQVQgb24gUFJFRU1QVF9SVDogc2VuZC1yZWN2IHRhaWwgfjUwLTgw
zrxzLCBsb29raW5nIGZvciBndWlkYW5jZQoKPgoKPiAtLQoKPiBIaSBhbGwsCgo+Cgo+IEknbSB3
b3JraW5nIG9uIHJlZHVjaW5nIHdvcnN0LWNhc2UgRXRoZXJDQVQgc2VuZC1yZWN2IHJvdW5kLXRy
aXAKCj4gbGF0ZW5jeSBvbiBQUkVFTVBUX1JUIDYuOC1ydDgsIHRhcmdldGluZyB1bmRlciA1MM68
cy4gSSd2ZSBkb25lCgo+IGZ0cmFjZSBhbmFseXNpcyBvdmVyIH41MGsgY3ljbGVzIGFuZCB0cmll
ZCB0d28ga2VybmVsLXNpZGUgZml4ZXMsCgo+IGJ1dCB0aGUgbWVhc3VyZWQgdGFpbCAoNTAtODDO
vHMpIGV4Y2VlZHMgd2hhdCBteSB0cmFjZSBjYW4gYWNjb3VudAoKPiBmb3IgKH4zMc68cykuIEkn
ZCBhcHByZWNpYXRlIGhlbHAgaWRlbnRpZnlpbmcgd2hhdCBJJ20gbWlzc2luZy4KCj4KCj4gPT0g
RW52aXJvbm1lbnQgPT0KCj4KCj7CoMKgIC0gS2VybmVsOiA2LjguMC1ydDggKFBSRUVNUFRfUlQp
Cgo+wqDCoCAtIENQVTogSW50ZWwsIGNvcmUgMyBpc29sYXRlZAoKPsKgwqDCoMKgIC0gaXNvbGNw
dXM9ZG9tYWluLG1hbmFnZWQsMyBub2h6X2Z1bGw9MyByY3Vfbm9jYnM9MwoKPsKgwqDCoMKgIC0g
aW50ZWxfcHN0YXRlPWRpc2FibGUgaWRsZT1wb2xsIGludGVsX2lkbGUubWF4X2NzdGF0ZT0wCgo+
wqDCoCAtIE5JQzogUlRMODE2OEggKHI4MTY5IGRyaXZlciksIElSUSBwaW5uZWQgdG8gQ1BVMwoK
PsKgwqDCoMKgIC0gQ29hbGVzY2luZyBvZmY6IHJ4LXVzZWNzPTAsIHJ4LWZyYW1lcz0xCgo+wqDC
oCAtIEV0aGVyQ0FUIG1hc3RlcjogU09FTSAoT3BlbiBFdGhlckNBVHNvY2lldHkpCgo+wqDCoMKg
wqAgLSBTQ0hFRF9GSUZPIDk5LCBwaW5uZWQgdG8gQ1BVMywgMW1zIGN5Y2xlCgo+wqDCoMKgwqAg
LSBBRl9QQUNLRVQgcmF3IHNvY2tldCAoRVRIX1BfRUNBVCkKCj7CoMKgwqDCoCAtIE1lYXN1cmVz
IHNlbmQtcmVjdiB3aXRoIGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDKQoKPgoKPiA9PSBX
aGF0IEkndmUgdHJpZWQgPT0KCj4KCj4gVXNpbmcgZnRyYWNlIChmdW5jdGlvbl9ncmFwaCArIHNj
aGVkX3N3aXRjaCkgb24gQ1BVMzoKCj4KCj4gMSkga3NvZnRpcnFkIHByZWVtcHRpb24gZHVyaW5n
IE5BUEkgcG9sbAoKPgoKPsKgwqDCoCBEdXJpbmcgcnRsODE2OV9wb2xsKCkg4oaSIG5hcGlfZ3Jv
X3JlY2VpdmUoKSDihpIgc29ja19kZWZfcmVhZGFibGUoKQoKPsKgwqDCoCDihpIgd2FrZV91cCgp
LCBTT0VNIChGSUZPIDk5KSBwcmVlbXB0cyBrc29mdGlycWQvMyAoQ0ZTKSBtaWQtcG9sbC4KCj7C
oMKgwqAgU09FTSB0aGVuIGJsb2NrcyBvbiBydF9zcGluX2xvY2sgKHNvY2tldCB3cV9oZWFkLT5s
b2NrLCBoZWxkIGJ5Cgo+wqDCoMKgIHdha2VfdXApIOKGkiBEIHN0YXRlIH4yzrxzIOKGkiByZXR1
cm5zIHRvIGtzb2Z0aXJxZCDihpIgcHJlZW1wdHMgYWdhaW4KCj7CoMKgwqAgYWZ0ZXIgcmVjdigp
IGNvbXBsZXRlcy4gTWVhc3VyZWQgb3ZlcmhlYWQ6IDUuNc68cyBtZWFuLCB1cCB0byAyNc68cy4K
Cj4KCj7CoMKgwqAgRml4OiBjaHJ0IC1mIC1wIDk5IGtzb2Z0aXJxZC8zCgo+Cgo+wqDCoMKgIFJl
c3VsdDogRCBzdGF0ZSBlbGltaW5hdGVkLCByZWN2KCkgcGVhayBpbXByb3ZlZCB+M868cywgYnV0
Cgo+wqDCoMKgIG1heCBnb3Qgd29yc2UgKDc3zrxzIOKGkiA4OM68cykuCgo+Cgo+IDIpIFRYIGNv
bXBsZXRpb24gSVJRIGVsaW1pbmF0aW9uCgo+Cgo+wqDCoMKgIEVhY2ggY3ljbGUgZ2VuZXJhdGVz
IHR3byBwb2xsczogVFggSVJRIHRyaWdnZXJzIHBvbGwjMSAocnRsX3R4Cgo+wqDCoMKgIGNsZWFu
dXAgb25seSwgfjEuM868cyksIHRoZW4gUlggSVJRIHRyaWdnZXJzIHBvbGwjMi4gR2FwOiAzLTEz
zrxzLgoKPgoKPsKgwqDCoCBGaXg6IE1hc2tlZCBUeE9LIGZyb20gaW50ZXJydXB0IGVuYWJsZSBy
ZWdpc3Rlci4KCj4KCj7CoMKgwqAgUmVzdWx0OiByZWN2KCkgZGlzdHJpYnV0aW9uIG5hcnJvd2Vk
LCBidXQgc2VuZC1yZWN2IHVuY2hhbmdlZAoKPsKgwqDCoCAoVFggcG9sbCArIGdhcCBvdmVybGFw
cyB3aXRoIHdpcmUgZGVsYXkpLgoKPgoKPsKgwqDCoCBDb21iaW5lZDogTm8gaW1wcm92ZW1lbnQg
YmV5b25kIEgxIGFsb25lLgoKCgpJZiB5b3Ugc2VlIGxhdGVuY2llcyBkdWUgdG8ga3NvZnRpcnFk
LCBJIGFzc3VtZSB5b3UgZG9uJ3QgdXNlIHRocmVhZGVkCgpOQVBJP8KgIERpZCB5b3UgdHJ5PwoK
CgpRdW90aW5nIGZyb20gbXkgb3duIG5vdGVzIGhlcmU6CgoKCsKgwqDCoCBOQVBJIHByb2Nlc3Np
bmcgbW9zdGx5IGhhcHBlbnMgaW4gZXRoIHNvZnRpcnEgdGhyZWFkcywgYnV0IG5vdCBhbHdheXMs
CgrCoMKgwqAgZXNwZWNpYWxseSB3aXRoIGhpZ2hlciBzeXN0ZW0gbG9hZCBpdCBtaWdodCBlbmQg
dXAgaW4ga3NvZnRpcnFkLCB3aGljaAoKwqDCoMKgIHJ1bnMgd2l0aCBsb3cgcHJpb3JpdHksIGFu
ZCB3aGljaCBwcm9jZXNzIHByaW9yaXR5IGlzIG5vdCByZWNvbW1lbmRlZCB0bwoKwqDCoMKgIGJl
IGNoYW5nZWQgKHdpdGggUlQpLgoKCgrCoMKgwqAgTGluazogaHR0cHM6Ly9sd24ubmV0L0FydGlj
bGVzLzgzMzg0MC8KCsKgwqDCoCBMaW5rOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD01ZmRkMmYwZTVj
NjQKCsKgwqDCoCBMaW5rOiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvODUzMjg5LwoKCgpXaGF0
IHdlIGRpZDoKCgoKK8KgwqDCoMKgwqDCoMKgwqDCoMKgICMgZW5hYmxlIG5hcGkgdGhyZWFkcyBh
bmQgc2V0IHJlYWx0aW1lIHByaW9yaXR5CgorwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWNobyAxID4g
L3N5cy9jbGFzcy9uZXQvZXRoMC90aHJlYWRlZAoKK8KgwqDCoMKgwqDCoMKgwqDCoMKgIHNsZWVw
IDEKCivCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ3JlcCBuYXBpL2V0aDAgfCB4YXJncyAtbiAxIGNo
cnQgLS1waWQgNDkKCgoKVGhhdCBlbGltaW5hdGVkIGxhdGVuY3kgc3Bpa2VzIGZvciB1cywgb24g
Y29tcGxldGVseSBkaWZmZXJlbnQKCmhhcmR3YXJlIHRob3VnaC4gXl4KCgoKR3JlZXRzCgpBbGV4
CgoKCgoK
