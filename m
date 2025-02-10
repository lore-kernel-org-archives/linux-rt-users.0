Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30D81749;
	Mon, 10 Feb 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172065; cv=fail; b=EgKTu6U+4R/dHWbzZtWlFaTZw2ZqoM5CXlbUoKP3KxAerPzlxkh6lSnUIZH6X4yRgBjy+lF9JZagM8o1H9wV5NS4idHHgDJFd9u8vTxgV2wJRzbEjl6F5Y65gWRIgM9/9DMhyHkj7qqudDnFHwl/a0eaVxfiTHZsGd5dXACZ1C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172065; c=relaxed/simple;
	bh=CMNX6TDnjk6YjFHKmWwKhzKMfcI0tKIZWpLOtuJTG7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l3UZP/QL0Q62UlT8tYOM1RzSgAWJUJYkF7HWtPcruzRgomuFeRbptoFvXr3QCRxn3j45XdQLxyrtU062WcjDc5C9WX5ceF/bWXo0O41Md37R9ac7t9XQiTJmuyzq4VcSYNRbihKYdBqnxE1UfNtNe5hs+Gx0c+J/pMDvb0I3qSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=Nnvo3Zrm; arc=fail smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="Nnvo3Zrm"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1739172040;x=1740381640;bh=CMNX6TDnjk6YjFHKmWwKhzKMfcI0tKIZWpLOtuJ
	TG7c=;b=Nnvo3ZrmlG4gORPof5F3PC7vbO1OqvoqdVjUXr5YkHqFvOFqOhAGGkcsZfy7KI5rqwOyF
	bjPlKYG9pas9nDk8O8GrLWpaRnMdiT0b98m0mIhpeM7Q2Q10exZgUNp8w4VXIwh3GW2tMfAdtqVmL
	S5IcwOfa91BrZClvqZzgQmrvXlRq/yRRCCQUZh2jrEXRfhoUjccnEJCPC6064QeIRCimNOW6BRUkO
	k6LXwh+4gapA+7h6+NPLyslSUpHBj66ZllG1Wdt1PiAq78QuctzgdiKv5cNDO56odVyf93oxLz0qN
	+cEam15K1uh9wmbd9S/2IohjY/j21PfpR8DL8tQDcQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51A7KdiR3691993; Mon, 10 Feb 2025 16:20:39 +0900
X-Iguazu-Qid: 2rWhEqwpinqXgaV9Iw
X-Iguazu-QSIG: v=2; s=0; t=1739172039; q=2rWhEqwpinqXgaV9Iw; m=ySfCtEOy5V8M30p1TpsN+cJSKaBXId/q2tS2YNi1714=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 51A7Kbak3774744
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 16:20:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6VaJrurXSBI1dSFZOjDPmpuRYdzfT9yar2pU41NZ8jf4OdB0ZmCaNyV5kZdN4b06bVgZzJrsOqD4CtLLNa3NoacqLyivmHMO6M5S+jyk65Nq3oIoc+j9+c14GUVABx3kcdRU4dDlSU+9L246v0YrFa9ftXT58GuE4NElyaAM82EMbKpk4cmyP1hdebnFwZdodjy40engCWAf4Z40FFMG+YpyZl8N9e8QCKZi7s1X8GrWhKxlZ4L3vT0nHRy6y5o9GdKDs+zi9x6qrJfs0zIUZ4ldA3EUMlZKaT8FZRDUWNyFKQs5w9FIm0FQyYIySvqsh++0XZ5N5Ezi3CbJo2x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMNX6TDnjk6YjFHKmWwKhzKMfcI0tKIZWpLOtuJTG7c=;
 b=Tg1QrJfhY8CZH4guFeamywqh8yLQP4BtWFfds0kWKj55YI8IE9SJe0xC51BTyH7Bo3Mj2ACPawM2r3WGlaKdEReNLBJPP8Wa34DW3yE3aCudkCjHF+p+vkrPS18RwwYcTzTsA3TA9aieMRFNomCU/3UYFGebgCnjoX1Mc0eCAY6YXvGD7g6S+QR/ez4VXNMD2ycmkUMGBBuHNkTn9mzIzc0h6YrqSzwnx/96I4wg3ybOULxmaIdPT9uXLp02q0kty/pyi73HpVnvKCoNLxLwzduR/hiFYxZhXjDe9vzKQjN4PJSEkrD1khAiFFuf38ctekjG5qYNX8WGdUMbx5la1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <bigeasy@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
        <cip-dev@lists.cip-project.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Thread-Topic: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Thread-Index: AQHbdt1fjynK67IvsUq7IgiGjY4ghLNAJwIg
Date: Mon, 10 Feb 2025 07:20:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385E033624D2D9D93992A95E1F22@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <20250204081813.7qsvLFsU@linutronix.de>
In-Reply-To: <20250204081813.7qsvLFsU@linutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYYPR01MB8117:EE_
x-ms-office365-filtering-correlation-id: 4b7d659f-0bce-4cd7-78ba-08dd49a369ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a2JJZW9KNlNZNSsxendValFoa0UveExpSFMybWR1V0RibG4rVEZrNVcra1JX?=
 =?utf-8?B?Nm01Tld3aThxQnhPaTFzdEVHQmVqUDVtRlBXVGc3cVYwZ2FzZ1NNa2N2dFhr?=
 =?utf-8?B?RkYxSnYwd2xoZmVRbHE0U2w4UTVlbE55aEJNVTUvZW9MM2xQREFRRDYwOWJ1?=
 =?utf-8?B?Z01mcGQ4dVZPWjlOR1JmcGc0aUhhcmlnaVVBMjRxSlovdVV4SzBVd0lMWGhQ?=
 =?utf-8?B?aVBDcEtYRHNSU1pVdnJlRDAxbmV4a2g1S0diYlppcmpxZzN3VlVOdmg2cmI3?=
 =?utf-8?B?Y21hMlM3NU8yUFk3MUtXSXQ1aW1ENUtCZGxxNXBhdjRrZXRWQS9HZVdnamNP?=
 =?utf-8?B?WlJlSE1nRDNJbzhWV2c2WnJpb09KZndza0x6TW11eTk4T1hieW9ZOG95R3V4?=
 =?utf-8?B?WnF0Q0tHU0lkUm9OeHBUQzRGRFh6QlhETkxKS09remtPV2lOQUFERTVwT0xD?=
 =?utf-8?B?QWdIdGdSMnd6QktlcVRMbi9DeHpqQ1ZlaXZ1aytYUXIvMGZHTEZ5ZEtJMkhV?=
 =?utf-8?B?WnlHc2pncEVhcGNGcGRQLzBYb2M5TVpXOEZSS2FsSkhGZGliM2xYdEhydHNx?=
 =?utf-8?B?OXd4WmNBTkZaUGdIdmJ1RU50eDN6dXNmdGVKa2RtcU9MMGxIWmg1TFVmZW9z?=
 =?utf-8?B?TkN2QXk0ZW9GMTVUb3hMSmtQS24zYTdCT0FPY1Qwb1FOUDhWRFF2VlRmbHQz?=
 =?utf-8?B?dWZjeE44OXpkU29zZzBFY3cybitnVE54OGcwNXZib3VqeGk5Q2o2d3M0K1dq?=
 =?utf-8?B?ZmZ5Q1lMZzc3Wk52aXNoQkplWUdRMHplQ1h2cHZjWVl6R0wrVzhjdkx3U3Y5?=
 =?utf-8?B?eVgwNS9tNFFTdm9uSk9DRitGSFdkTms2elhiTG9lN2czQm5IWmlHRGJNS2Vi?=
 =?utf-8?B?SmxsR1ZiaUZoUU05VDN5N3VzRHEyd25PVWR6ZkRkYVVhY2twQTgvQWJBYTMw?=
 =?utf-8?B?K2hpUmEzQnNjVHI4NFFDeFRBczE3c2pORThWWmRBQWxMMzh6MXVvTFdxUklj?=
 =?utf-8?B?TmdmcjZSa3BtY1pQOEJJbjEzZERPa2ZXR2w5WVd5TC9yOVFWMUZrTm9Tcmpr?=
 =?utf-8?B?bGR2UWNueHUreDErWFpTVlNUL0dpUnc3MFNwU0NpYy9IZHRlWXMyZGxuN2Ju?=
 =?utf-8?B?cmNFQks5NmV2eHZsc3pRdHdNSWlDSEUzTDZQMktjTWdwbURrWVJNYXdWNkp1?=
 =?utf-8?B?dVRucUtMeDVtM3o3QU1xUHdwTE5lSldvaHpPZW94NlBuckQ4aW1EY0psZmdD?=
 =?utf-8?B?V1RsZnFhbURJZ01mc0V3bm5aVld3M005Y0Y2YWhnYjQvWm4wSFpRb1BhNHdo?=
 =?utf-8?B?ZkhSUzZ0NDlBbUJRUHByR2FldUdHeGtoS1dTTGNiSERwOHJ1VWdLdzNMdGhk?=
 =?utf-8?B?Q1phaENzN0UrbUdyQnAvQkUySkZxUTRxK05PTjdPM1pVNmRyc281NTkrNkh5?=
 =?utf-8?B?ellpYTByWmhZZlI3RTdzc1RMblF5Ylk5QnRLdlZtMXhaM1hKOEUzaHRJZlc4?=
 =?utf-8?B?c0kwL3pNK2lVWllZTGlNT3NtWld4WExBQ1dwWTZtY1Z0SXRadGxFbVpodGZM?=
 =?utf-8?B?TTBUZHFhTlpwVjgxaTdEeTdCc3JzWWpjYjhudy9KRTFlODZraDZBbk9jK21D?=
 =?utf-8?B?SnpHald2SS9JNUo5aXV6QnYvcTkraUw0NDhvaE1nRU1aVXB2d1JITW1SRmt6?=
 =?utf-8?B?L1lHeHBpaGRWYXNUWG9uaDk5Wk1FTlZYdWVnV0lUbXQ0WElJRGV4dDdHbklv?=
 =?utf-8?B?Qk9KLzNQRmM2YWg1aURUSHZLd2kvN1J1Y3liMTdSbERVMjRubklpTjV4VGxJ?=
 =?utf-8?B?MXFrekI5Wnc4ZDBzTEkzWlFQdDdVT1hXY2c2SHd0UWdHOXZST0FnbjNmSXZL?=
 =?utf-8?B?N0ltVDBEandlb2hEU0xaN3pTMnVuQzBaNG9oRnFmdUp6aVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OUQrVjVOTVZzNElCTlBXRE9aWmdxVjJpQWxGWS9DM282ekhyVklHaVFEVStU?=
 =?utf-8?B?UlVWT05YbHNXRUMraDhOT0pJMEhaYlBHeVB3OUVxZk1xU2NCak5xczVhajZH?=
 =?utf-8?B?QllPenJxSVhqNEpnMGcwTXZ1K3l2TnZDbjFqOG9iem5VcDNHTUY0dnlMMFlY?=
 =?utf-8?B?WEZsU2ppWFFwdHU1TE94NU8vcnlKS2RlcWlHS3VGc0xvMmhpZGlZalRza0Zn?=
 =?utf-8?B?SlNla0JzUXE3RmRYNytteDRWMGhmb0xTemFpcEoyTjU4TEtoajFvcXlXVE40?=
 =?utf-8?B?cjZDU0Z0VkY3aWNaa1kwKzRIVVBCSUo4RDhhb1NUM2VLTWQ1Mm9BWGJ1NUZ1?=
 =?utf-8?B?cnc0THVCK2F1SWk5aS9OTGNjNTZsYTBJUkRXQmg0a2dBclJ3TTdvZ3FHU0wr?=
 =?utf-8?B?d1FuUDE5cEdsQm5INUFjRngxcXRJRWo2cy9PUWwxMDE0N01EV1ZJWTVxWmNC?=
 =?utf-8?B?cmNla0ZuMHAyZk5NRUtSbXowRGM4WWZqS2NFMzg4OG12SU5EaTNWcVNPSWsz?=
 =?utf-8?B?ZVArWHI3ZFlBWE1lODFoMGFBenJLVjJBUWtkTjRSSitTMStiZHM3NUhYZkc2?=
 =?utf-8?B?c0Q3d3dBNWFFd3VLU3praUpTZ3dIR3l1S3FoczFsS3dwbkZVWGtnS0w3cHZv?=
 =?utf-8?B?Vkt1Q1NKYkNDU3g2NWJ3dVBQKzJJMHMvKzlPb1k1R0NGY3YyQ1FPeFB2bmFh?=
 =?utf-8?B?aHNiWVJvaGUvTWR6WjRkbStJNnYvZngwclkvNDFiVnRwZXVkRVMvaWV0Rjdu?=
 =?utf-8?B?NGRUbEhDYjFkeEtObUEyQldGWis4MEtod2o3ZWVIcGRlb0pjc2xlYjdPTEZk?=
 =?utf-8?B?OXYxWTMzZkxuMXN5YzVJT3lxejVWL05rVkI0MUxwcjBFT3hqUnU4cGVYbTZK?=
 =?utf-8?B?Wk1FbjN4V1RDSGpaTVVyMGVxT1JWd2dJQWlCeHVuNnlKYldMVTVROGZRRGZv?=
 =?utf-8?B?VXg3cnpnMWpOMlJJVVlDM1ZINk1CTy8rZFA0elc1R09YZVhDUjZTeThKWkF2?=
 =?utf-8?B?OTloOGVYVk5oY1NhOS9RNHhuTTVOVWxnZUozSXRrNFN4ejJOMUtaeFBpbEQv?=
 =?utf-8?B?OW40OTRPSXlNUWtHMzNudFhrb2RvUE1qWHM1WVNYU2piaktxUEQ0UDRnZnox?=
 =?utf-8?B?NEFidE1BbVkwNnhMZlNyTUNhRmVwMWY0VktDTmtjWUNFcUxTOFpNd25XMDRk?=
 =?utf-8?B?UExjZ1paMCtVbW9zSDJveGE0TlAvc09mWXQ4YXIvRG1SNG93TGpGYm9TcGtw?=
 =?utf-8?B?VXF2ajQ1UWE3Ykx2OTJoRjdodTRmQy9KUTZucm5pTEQzcXczSVEwQUVhZUFj?=
 =?utf-8?B?QU1lWktnTjBiYVBtdS9LSW5LWlJNR3RtVERHUDRnbkFrckh0Q1dnYXlQU29D?=
 =?utf-8?B?dHA2WDNOMDBJQnpCYTZSZHZHNTlSOExjY2l4ZkNaclpEZTFRb0w3OGNVTlVF?=
 =?utf-8?B?c3JYQ1FtUFJ1UEJsaWhBVlNQNW9XbjV2eFlWeVQwNmxmdUo2d0pROURweThv?=
 =?utf-8?B?MWN5UkZQaWJscjErc1ZqaFVBQ2t6NE1BdUc0azlpc1ZyVnVQdWhKL2d0YjJ1?=
 =?utf-8?B?dVNSdEg5QytvU01tOTVUMFhUN29KRnp1dmlZZm1BdzJHY1J6RmlaYlI2cEZk?=
 =?utf-8?B?N0VSelVJMDlHWUtJaFVNd0VoYW5adW54TWc0dnF0c3RLQ2dSam1ZbHFYMm9Q?=
 =?utf-8?B?a3FOdXRrQkNUZ2pYbW96Ky95ZjdBSnNoVTM0M3BKYVhXZHVJRjdQeHRybW1v?=
 =?utf-8?B?dWJIaFZQekc0MStzQnA4Nm16UHYzakRVSUdQYUVkK0lrSzhTSjdxOUFwSXhW?=
 =?utf-8?B?ZzRjdWtraXR3enIrRlRHRTlmaXJla1Bnc2NEcFpQQUtFOVUvU1loV3BTK0Nv?=
 =?utf-8?B?UTFuS3B6UnZUWjlBYzQ4ajFhRmZTNVFuNnZaV2hPUnFjQy9EamtJaWtWeTdw?=
 =?utf-8?B?UDlBVzJZbEVxOUNha0FuZWJsb2FDQXdORGU2K3lIdXh0cFU0OVRXT3FLb2dB?=
 =?utf-8?B?d1lONFY3ZlUvb0V0N0pBMmFiaWNhdDkwSkNvdldBQ2JMcXFja2xoUlp2ZUdp?=
 =?utf-8?B?TGU0UVYzdWNzU3FCakZ5QWZ2RGJTRnJlVjllYWFvRERqNHRWcm9UeFpvUktS?=
 =?utf-8?B?dWJnUGhMditwRGl1NE5yMFFLa2lRM1B6NnV1L0NZS1E3cFNCWit2T3U3WXov?=
 =?utf-8?B?bUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7d659f-0bce-4cd7-78ba-08dd49a369ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 07:20:36.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JTT1EHCSwYdMqNuba0BpxUymO/upuaTg1vzWfGWNDFkpMFL4Q3Y6wg99pHZ82gIaRaQoeT9DXeppj7O/5CNMD977GaJYiWkwRF9ZyDF/ZibM7/irbBkYZNefDeLqCvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8117

SGVsbG8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50IQ0KDQo+ID4gLQlpZiAoc3lzdGVt
X3N0YXRlID09IFNZU1RFTV9SVU5OSU5HKQ0KPiA+ICsJaWYgKHN5c3RlbV9zdGF0ZSA+IFNZU1RF
TV9CT09USU5HKQ0KPiA+DQo+ID4gVGhpcyBhdm9pZHMgdGhlIHByb2JsZW0gYnkgZW5hYmxpbmcg
SVJRIGFmdGVyIFNZU1RFTV9TQ0hFVUxESU5HLg0KPiANCj4gWWVzLiBPbmNlIHNjaGVkdWxpbmcg
aXMgZW5hYmxlZCBhbnkgc2xlZXBpbmcgbG9jayBtaWdodCBiZSBjb250ZW5kZWQgc28NCj4gaW50
ZXJydXB0cyBtdXN0IGJlIGVuYWJsZWQuIFRoaXMgaXMgbm90IGRvbmUgZG9uZSB1bmNvbmRpdGlv
bmFsbHkNCj4gYmVjYXVzZSBlYXJseSBib290IGNvZGUgZXhwZWN0cyB0byBydW4gd2l0aCBkaXNh
YmxlZCBpbnRlcnJ1cHRzLg0KPiBUaGlzICJzeXN0ZW1fc3RhdGUgPT0gU1lTVEVNX1JVTk5JTkci
IGxvb2tlZCBsaWtlIGEgc2FuZSBzdGF0ZSBpbg0KPiBiZXR3ZWVuLiBIb3dldmVyLCBvbmNlIHRo
ZSBzY2hlZHVsZXIgaXMgdXAgYW5kIHJ1bm5pbmcsIGludGVycnVwdHMgaW4NCj4gdGhlIHN5c3Rl
bSBhcmUgZW5hYmxlZCBhbmQgc28gdGhlIHNsdWIgYWxsb2NhdG9yIG5lZWRzIHRvIGFsd2F5cyBl
bmFibGUNCj4gaW50ZXJydXB0cy4NCg0KQXBwcmVjaWF0ZSBzaGFyaW5nIHRoZSBiYWNrZ3JvdW5k
Lg0KVGhpcyBpcyBoZWxwZnVsIHRvIHVuZGVyc3RhbmQgd2hhdCB3YXMgaGFwcGVuaW5nIGFyb3Vu
ZCB2NC4xNC1ydC4NCg0KPiBUaGUgcHJvcG9zYWwgbG9va3Mgb2theS4gSG93ZXZlciB0aGUgdmVy
aWZpZWQgdXBzdHJlYW0gdmVyc2lvbiBub3Qgb25seQ0KPiBhZGRyZXNzZXMgeW91ciBpc3N1ZSBi
dXQgYWxzbyBtYWtlcyBzbXBfcHJvY2Vzc29yX2lkKCkgYW5kIG1pZ2h0X3NsZWVwKCkNCj4gd29y
ayBpbiB0aGUgZWFybHkgcGhhc2UuIEkgd291bGQgcHJlZmVyIHRoZSB1cHN0cmVhbSBzb2x1dGlv
biBmb3IgdGhvc2UNCj4gdHdvIHJlYXNvbnMuDQoNClRoYW5rcyBmb3IgeW91ciBvcGluaW9uLg0K
SnVzdCBmb3IgeW91ciByZWZlcmVuY2UsIEkndmUgc2hhcmVkIGFub3RoZXIgKHJldmlzZWQpIHBh
dGNoIHNlcmllc1sxXQ0Kd2hpY2ggaXMgYmFzZWQgb24gdGhlIHVwc3RyZWFtIHNlcmllc1syXS4g
SXQgaGFzIGJlZW4gdGVzdGVkIG9uDQpzZXZlcmFsIGVudmlyb25tZW50cyBzaW1pbGFybHkgdG8g
dGhlIGRyYWZ0IHZlcnNpb25bM10uDQoNClllcywgdGhlIGN1cnJlbnQgcHJvcG9zYWwgb25seSBm
b2N1c2VzIG9uIHJlc29sdmluZyB0aGUgV0FSTklORyBpc3N1ZS4NCkF0IHRoZSBzYW1lIHRpbWUs
IEkgdGhpbmsgaXQgd291bGQgYmUgYWxzbyBwb3NzaWJsZSB0byBhcHBseSB0aGUgb3RoZXINCmlt
cHJvdmVtZW50cyBmb3Igc21wX3Byb2Nlc3Nvcl9pZCgpIGFuZCBtaWdodF9zbGVlcCgpLCB3aGlj
aCBtZWFucw0KMS8xNyBhbmQgMTcvMTcgb2YgdGhlIG1haW5saW5lIHBhdGNoIHNlcmllc1syXSwg
b24gdG9wIG9mIHRoZSBjdXJyZW50IHdheQ0KaS5lLiB1c2luZyB0aGUgY3VzdG9tIGZsYWcgc3lz
dGVtX3NjaGVkdWxpbmcuDQoNClRoZSBxdWVzdGlvbiBoZXJlIGlzIHdoZXRoZXIgdG8gaW5zZXJ0
IFNZU1RFTV9TQ0hFRFVMSU5HIGlzIGFjY2VwdGFibGUNCm9yIG5vdCBpbiBMVFMgcGhhc2UuIFRo
aXMgYWRkaXRpb24gd291bGQgY2hhbmdlIGJlaGF2aW9yIG9mIGZ1dHVyZSBmaXhlcw0Kb3Igb3V0
LW9mLXRyZWUgY29kZXMgdGhhdCBjaGVjayBzeXN0ZW1fc3RhdGUsIHNvIGFkanVzdG1lbnRzIHNp
bWlsYXIgdG8NCnRoZSBtYWlubGluZSBzZXJpZXNbMl0gKDIvMTcgfiAxNS8xNykgYXJlIG5lZWRl
ZCBmb3IgdGhlbS4NCkNhbiBJIGFzayBpZiBpdCdzIHJlY29tbWVuZGVkIHRvIGludHJvZHVjZSBT
WVNURU1fU0NIRURVTElORyBldmVuIGluIExUUz8NCkl0J3MgdjQuNC1ydCBzcGVjaWZpYyB0b3Bp
YyBidXQgSSB0aGluayBzaW1pbGFyIGRpc2N1c3Npb24gaXMgcmVndWxhcmx5DQpoYXBwZW5pbmcg
aW4gbmV3ZXIgLXJ0IGJyYW5jaGVzIGFuZCBMVFMgYnJhbmNoZXMgd2hlcmUgUFJFRU1QVF9SVCBp
cyBtZXJnZWQuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ydC1kZXZlbC8x
NzM5MTcwNTQ1LTI1MDExLTEtZ2l0LXNlbmQtZW1haWwta2F6dWhpcm8zLmhheWFzaGlAdG9zaGli
YS5jby5qcC9ULw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDE3MDUxNjE4NDIz
MS41NjQ4ODgyMzFAbGludXRyb25peC5kZS9ULw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9UWUNQUjAxTUIxMTM4NTc5Q0E3NjEyQjU2OEJCODgwNjUyRTEyNzJAVFlDUFIwMU1CMTEz
ODUuanBucHJkMDEucHJvZC5vdXRsb29rLmNvbS8NCg0KQmVzdCByZWdhcmRzLA0KS2F6dQ0K

