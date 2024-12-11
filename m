Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7910C139
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877103; cv=fail; b=ZZNi1orDvsBlNfBkuGHLLfCZuy6Hwx4wtBmfAggV+X8LwDa2yV0Cqhx3jMmfqpVzq9RPIPl1C7G7cawuwVYoV05fAqJWLJ4ZB2JkxITz/16He/2telU/3dW0KaQyBqhrxf+VcmBCYEkcQMP5H7jHKqWbgXQ1yxskYpv9FqVPsA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877103; c=relaxed/simple;
	bh=oWWtljAn0v5dgx3eCdtziyCP/1jKlTSHH8z5YNp7Irw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PEI+eaifEgLlpXMBOCwSq+sY1zlI1wLPCN/JwwqPzAnGuyWwr8QKSjSjyKvZfU0qr9R5i/31OtJyyoMXblgoOQyesvsXYMTr6s1KhQMkwpTTWw8wYQF5Hc4dwC1EYFNyFnEU59S+RceMZCQAY7yZVWD+l3cZSBi79BDSz2na6w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=e3BVKBuQ; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=vdvwCdSK; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="e3BVKBuQ";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="vdvwCdSK"
Received: from pps.filterd (m0136175.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANSkiX005451
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Dec 2024 16:15:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=sel1; bh=fcsdMCEo4uH5Q8dX5DW6aqW69lb
	2aVStjmm3iqnLRA0=; b=e3BVKBuQgFZFnFkXNVsLR0JTkFTHoSUq8QyD7LELJqc
	R2OwvO8mY2yZJ/wx9vMmp6LSwnFaq3qZOjDEnBaQGqMpmJC/Fgu/D8rPcTeG00gH
	wRRpwqvp6xsgvG7tnffo5zSN4IT6JYTF9YrG5TCak20h1uqCk0OP+zIUvAMlp/qE
	FmYBN1Rm+qcVhHtAg5xeqG8U7dL/kPDCzM44wm2RY3nMb+aDlx4yPRb3ofCDxUZ+
	gpPUy1yaWKnIWhVOP9rrJZDI91tvH7TYNlMbCWklL0JMk04nKeGkNONqGPqR46Y9
	TTDZwwa4sAGStwjwD9u69AxYi/J3oIWSUKMhfeTjkaA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 43exn8r1x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Dec 2024 16:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6KnnU+PPOp8XZmHhfsBPflcXlqYlGMTJXkf8R9U4tFXc9uIHZ6l5VUj1fBszUeDvljwTwGMy6J0+U/tX6VJqABxP/qzYUaARneIIiJk3jSuf+Nc5Y+Dl4DwHe2Q0VGYjv1GyaSm1BH3YPRfwMLv6lrHcy3A6oVbGN31fHYC9xBa9sLDRSvlOH9i2g9TyXHZYfzDDDSjZF4t8nIUZkr9ElXZinoAITVfHu3AKvMGShfTtC5s3WzPDcLVfzQtTY4a3126ygJQdiWS3xir7GCJT9v3/RbPYNYuBqt0FF+66Az8fHrNumdr+HdFXFrmizTu6ZopgeRSx3QwyAbgWGbq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcsdMCEo4uH5Q8dX5DW6aqW69lb2aVStjmm3iqnLRA0=;
 b=ZE+WCZ26pwZD1ef4k1dFTjtJnnJem6YTddiD8x/2hpE00Cf9/NZum3SsZE/e7rK4iz/zSUtX68ajC5g1QWJiXBPWi2UmES5rLoXAKCsKmKczB+jKaWO63qFE9b14fsjkU/fpXSjE5UndgVeOhCpmPoP7irazdEBqARz9E5XeVh7s1TjVPfZyeo5J4gFa4y91LdTMyj41yhf083NS12q2JXLMlhnmcncg6nYhCUmkHm+FICVTtsE4Hm/Db0lLCxPikZeEDE4ZLnimiu96kOP0T99HbjuWEAY+R3fc8HuDjQnWMOgbklhjXK39zWDz88RjfwJBApwuZIXw7sO/tp2ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcsdMCEo4uH5Q8dX5DW6aqW69lb2aVStjmm3iqnLRA0=;
 b=vdvwCdSKKKPTATzngrrLDg17g7qp6WxdSJ+xYeVR9555RYRstNFf4FAGpcUmegdVjqzV/VG5sorMc7hfAGrpjEDMH2D1/zHJM3DFvV6wDQAh9pGwfvydDo43yz40/KSssxpOI5Mgl1WjDzHKsmS2d+MiK7ImCdNLp4iyPanHgTZ9/pA0uaf0+GLIlSadDOz7+6mMOJOIQe9NYkKtgl5wGwd411Ig0qM6ugmzWflZtjWoCeZCQ7Dnfqv/NvF0Q5pIr8MvtOKWez0Xs3LLCVFy00UxfGBMdOU85c/By4y4I9/YCwCklLwv9QIciSA9GUtMu4HNKMCePPtsiYq39XBvGg==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by SA1PR22MB5679.namprd22.prod.outlook.com (2603:10b6:806:3e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:15:31 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%4]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 00:15:31 +0000
From: Robert Joslyn <Robert_Joslyn@selinc.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: PowerPC Hangs on 6.6-rc6-rt10 and Later
Thread-Topic: PowerPC Hangs on 6.6-rc6-rt10 and Later
Thread-Index: AQHbS1lGKtM6hQHTcEaSmXL+IAuzWg==
Date: Wed, 11 Dec 2024 00:15:31 +0000
Message-ID:
 <PH0PR22MB380974792AE8C9254DD8BA1AE53D2@PH0PR22MB3809.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|SA1PR22MB5679:EE_
x-ms-office365-filtering-correlation-id: bb0e304c-29ea-4468-d85c-08dd1978ec7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DhC3UWoc2U24I+gfuxUUr5jG0NBpaiWpFZDT5q/+4mxYOFtjK34AFNq++T?=
 =?iso-8859-1?Q?Ac82+kBwe+KmUiGSHnpuR+SA1VoZaI/4HV4CrUD5D4pecDNo3dAC1/i+Hg?=
 =?iso-8859-1?Q?LQSI7YhM1aBwtEz03SuHEfucB8KrL99ikHY7bhai6SywVruJJDPFGa/wpo?=
 =?iso-8859-1?Q?wiywsen+A4tZJXx7joZYThNIY6P9CJMQRPcWziJ17yRGzgJl0tHa7kMjlk?=
 =?iso-8859-1?Q?nLBUsWHGrdgEEfAgGId82SYVmC3vButV8K0jYBe1fV3N/kzmCH5IOYCchC?=
 =?iso-8859-1?Q?h2bsSoUvWUqqedfPEU9WbBCZuTFi0SshX7vOypKSUv4+VTgu4AnhtSzDuA?=
 =?iso-8859-1?Q?rNlE/ECfnsqKtNpJpW+Epj1P2EwEbUXgParpcaM2+iP5EOkBYhTvjrELbY?=
 =?iso-8859-1?Q?0Nzzssg0HjlreEhzm2qqI5CUHcJcBrKTuUaphFu20Qy1SR/GvItkxRy0xP?=
 =?iso-8859-1?Q?SL1Y7LmcxNJyFSZL6B0bHCGYFlHHZfoVOaH9OBw4xiRzcp/S7bXtmBgZ1t?=
 =?iso-8859-1?Q?TPGGam4H7SnP1TnsK08+vsF1fe7vKb9Jmuxuhic7H7YWklK5PkTSHarYzk?=
 =?iso-8859-1?Q?hrrhLFokjd/wrpEilurtDubRtiBYdjR19YwHvoj8GLJSzvA1clibZL0mjK?=
 =?iso-8859-1?Q?/D9JvtH3O+4kvT6NOa51dlVKNRUGKbpsUJRgv4GJyn3DjXH8mESS/HeA6I?=
 =?iso-8859-1?Q?GDRn8oqvO8vqmTPmJEcS/yeDxAB07AgYXhxdzfxqmB/P4n8fAZPMbTPd5A?=
 =?iso-8859-1?Q?Pi8cVEGKkVjIy2WNo5tpT9GxbFDzvLjskJ27Xrh2N17t1RJH/Ib2hNIBQv?=
 =?iso-8859-1?Q?s9Ddxz7++OTEwE+L16sRiJydkTxbKz6IcjHj6cz47jR0lp0LBV22XQriUb?=
 =?iso-8859-1?Q?bUmqZJaXVIAEsY03zFhBYR0SQPTw/5Dh4B5TCrEPubC3ujrUJgCkEJng+R?=
 =?iso-8859-1?Q?56zg+nGjZL30JOgULEsrKGPtdwRc0Tjv+37kuODw377UC/V/FZ/BP7eQnH?=
 =?iso-8859-1?Q?An9cizC6oCpvNRdmWyHgg+IYBXo3BDEuirdcZr7Ak89lb6BCzgM1f1Wjeu?=
 =?iso-8859-1?Q?AIAwd4vNKQBM41yXjk7zzUjhEE1yFSPOi9t8cEzDY90hiW3dUwMWOtwDkI?=
 =?iso-8859-1?Q?UsDMvYYhntZEpfaxjPiQ0x1HJM16+CTeUvIzDUy2HhM6p30Q6C0yPaDZt8?=
 =?iso-8859-1?Q?CP40tZkIDsPf/KdM0tXDB2iFzg5kZrxTo4cmTujBrCLt8zLjHJJBUMSROs?=
 =?iso-8859-1?Q?8hvnZsuyKgodFDD+5a8JSP0hFEl3ewP2hYW7X+IT5D2Py6pF6ls4NR1ImC?=
 =?iso-8859-1?Q?8Hhq3ogB4CbeuZcjHEe68l8sgW8EhM77HPoTxSvR4UQ1bK3T2dd1YKN/S4?=
 =?iso-8859-1?Q?Ynr64VRu7aKN2DCscbW1zNLtDQ7nh3Sc7YCLj1qwmq5wEZqd1Wgdd7+xhy?=
 =?iso-8859-1?Q?8Wg+TwgMnHDGlGg9JiMx/08bY/E8eRJ31cFGhg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?a5p5vZZj6sqN0ZWvHY49gjyCXkvMMS7rKehEiqLVlyIy68Gke6vVVFGe1z?=
 =?iso-8859-1?Q?LLQTQx6ztvtBgfbkCak8fvkTupwiWPwCydLnHDIK7UNky9RqNM5q2Os0qB?=
 =?iso-8859-1?Q?AXy5dgR2qt6tmGDuL0Bz33tCK9wGXpqN8oZfQWK7zb5CEBAkqa+rEfPhZD?=
 =?iso-8859-1?Q?Ftdmy3Aa1I/Eq4aq4K/FaxMm8u/p7KHgCX/3hDJIqkaksC8o6l5K5Rg97W?=
 =?iso-8859-1?Q?JV5bxaRzubyvry4xL+LkqFsJ1qmMdF9AJgengPddGenBIwpV026qMOvsf8?=
 =?iso-8859-1?Q?q+NDDK/FxqeBdETBjOjthMMNf6wI4Ibs7KJNhOQUzpcGxijoz5uJNuZF9r?=
 =?iso-8859-1?Q?oqkH1Q1zlqUONdDotb4Zhcn7THJNiiydZcc4jAhjzW5OPT1MrnX2TWx5cD?=
 =?iso-8859-1?Q?3i7N2kUipifuZadME0ZVzYo7b+zU9/9esfzAsDgHkWdmAk3nzeC0ZINI4V?=
 =?iso-8859-1?Q?qiIKD2ZyMWj3vuRWkWtW4twnVJEgq8tO4WDCz+z6dBuEkKyKU1KGAzb/0L?=
 =?iso-8859-1?Q?GVcnsWJ4sKX/oUzdMVvcryfKnVxyso2Z8A78hW7m4KTyEfoBHv1ejK76ys?=
 =?iso-8859-1?Q?kZsFT95bACUd85AL2OVcwV5Hd5yPgeXHGkrpc1TyqWICIVwj6Y2TqIJ7O3?=
 =?iso-8859-1?Q?P4IZ4cxJVK9RNehF2RE9b6TYW7sXGHWgOkRxR8Lg4bINL19mhJVxmlqlvU?=
 =?iso-8859-1?Q?seFr+mBJY/lociSjP3YSZLP0FEpvvPZgSLmWnmmK54KF/M1U1AG230kM/I?=
 =?iso-8859-1?Q?CFqUbR9W3LLgYnFaVSgHleGCMxRM2rkDFvd/1Td/8pFTs19ynLaSEvVart?=
 =?iso-8859-1?Q?zkDE/kLgI2P0YRjC6F/Ly2UnuA6Ya+PAcYNWKZ+hDvsl5MpxrhTZKkQE08?=
 =?iso-8859-1?Q?i2Ul72vBRnPYrWGcUKaLP3shNUk3o2usko6Yudr2cY/Xfi6jPfatopQfyA?=
 =?iso-8859-1?Q?/ecjS3KcZybKveZSijKN7HBBbjSQZ62Hd5Jqwdr9WhS3w0m4kOLOE0tWUE?=
 =?iso-8859-1?Q?yQ9Q9DoWByEPt8s4o87u/13eozFXzgsU9iHbO2bm0NMUk7H7KiBbOSsIGI?=
 =?iso-8859-1?Q?ya4gX3IK1YIcm/ytbgWMmopMnxRuQBHwD+UXYzG7NCnR6pDkphti4exkSX?=
 =?iso-8859-1?Q?wqfjBdcQUfiTYUFt7k4ouOJnwAxyRNHaLh/ZqzxgHab9IW6fkJHys1MoFg?=
 =?iso-8859-1?Q?sHrlfXvssLjO6w5NF6Q6qmIUtz/wwKm35hsSlDxUWACjmgQyMm59u+C0BB?=
 =?iso-8859-1?Q?jzNb+WLhTYnU0eP667265SQAM3W1XEpcRoZAZ3IKk9dPBa1dNyADp96sxr?=
 =?iso-8859-1?Q?FN/bo8e0dSV4lgYynofO0cVBhT1fcteeXnAwqUTN7hSIqlvxnwPnQubTyS?=
 =?iso-8859-1?Q?td6yn4V0hgLTftUqFr5mta9aqzJY3atWFsdkDMNnS0wkD/60LViJpJxtXC?=
 =?iso-8859-1?Q?NrNmbc6m3Z1p/l+36sbBkIVk6Mlp5oTmnmS1gQCEzw0WYjKbmDndEgxWW0?=
 =?iso-8859-1?Q?ROanD0A0Mo0Pi5FdLNdnLiXwxwmOB/8+5ANwCTfFMLioD/31YempKqRG7Z?=
 =?iso-8859-1?Q?S8/u7q79eBaeDhsfbvGFa4Cyc2+G0d6Xmlfxor5jqQ59bnplfaiMkcbiPE?=
 =?iso-8859-1?Q?03w+maSpg6sxjVdnIGewboO6hvuh/PQOvD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0e304c-29ea-4468-d85c-08dd1978ec7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:15:31.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jg3e+8qVNb3knaTVNqwLjzFZFIfvCVTj3G4zZdhdCjHbFTv1YqPAx3L+FmN90yAvsH/F6pu0qOireuHICpql6fNrHns4ni5ubjbOlMVuMuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5679
X-Proofpoint-GUID: K3tParuO_0pkvoLj0tgHMdJM45RP_urb
X-Proofpoint-ORIG-GUID: K3tParuO_0pkvoLj0tgHMdJM45RP_urb
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=624 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100174

I have two PowerPC platforms that I'm upgrading to a 6.6 kernel, and both h=
ang on boot right before my initramfs. I bisected the hang to this commit: =
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commi=
t/?h=3Dv6.6-rc6-rt10&id=3Db33022a48c797082dead4034e84f0adfbc5b1983=0A=
=0A=
That commit is somewhat large, but I've narrowed it down to this part of th=
e commit:=0A=
=0A=
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrup=
t.c=0A=
index 9f144588b33643..c4f6d3c69ba9d3 100644=0A=
--- a/arch/powerpc/kernel/interrupt.c=0A=
+++ b/arch/powerpc/kernel/interrupt.c=0A=
@@ -395,15 +395,11 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs)=0A=
 		/* Returning to a kernel context with local irqs enabled. */=0A=
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));=0A=
 again:=0A=
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {=0A=
+		if (IS_ENABLED(CONFIG_PREEMPT)) {=0A=
...=0A=
=0A=
Reverting this particular line fixes the hang. The change doesn't look quit=
e right to me, since CONFIG_PREEMPT doesn't seem related to the other chang=
es happening in that commit, but maybe there is something I don't see. Does=
 this change make sense? I'm happy to send a patch reverting this particula=
r line.=0A=
=0A=
Thanks,=0A=
Robert=
