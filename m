Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023134.outbound.protection.outlook.com [40.107.159.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202AA2EB875
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950493; cv=fail; b=o3qzHUGo/6rIDMyidTu4W2dSldI9dlBo4YMB4yOYF4aICKVT0kFZ/epNJbAEMz7GJtRv8TOO21MW22yuDJh6DtXRyEIZM72b/ty2YdmfNnpRyS0G1ytSglk9CC3AgKta9gomw4uMo8VTTcrkHAaIW9PemZT/PZKek+hBRkLm+nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950493; c=relaxed/simple;
	bh=NGN0R0K5SiXNRtR9XArPYkk1UsraGhgN9OnEbjK9ioI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ugkYaGm1Bs6vYUL/MCoGvMgJUkIEOQH63LHj4eDt7n5WxNyP5CvGDrYGF+vSLe8KTwDKJEi+1c+sqaPhPwNFArDfAtdhg97ycCWPabHcUe0Ksb/1HTIXmm/OgWvJqJPSdxVZgXHLHOckucz8Qgh5bUGPBUrJdK6RwMeG7uMuur0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=X2poI4+Z; arc=fail smtp.client-ip=40.107.159.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="X2poI4+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg1H9jQZ6jT63+F3qFzmuBeJvIOPk5qOGFEQNyGfIp44sRxaVQdW4/Udlma3UfYnfCjo7jqKfN9vLsyOjsmoweJlE/9V0bPLMwR7zOZt9xVSM3YXEixwUXugEm/fQTVQBvlV0db0H//Ya+chY+ogPaWzHdsaIN/5T48RXtVGwt7mTBHi/E6G+wMq+IrXPiU09jcKtQhuylLp9KPc6pBfM3zXEZP0W5ckZvJfhSpHOLt0AAWsiLD8/ZS81ps4h0+hz8j5gxlW5JH7mT4+hoJaF4mTaWXwYiOw2Ay/sBWEwhJQGveyTDhxv/wP3odvQR3BepCy4w9AvAQB92qftIhLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGN0R0K5SiXNRtR9XArPYkk1UsraGhgN9OnEbjK9ioI=;
 b=wR2ug+2OuuTrjWhgfzzOn+SK4TyHeT9MhOo17rRt+FpW6uDEaTvRLOBzvTSihaA9g3NJBVlQ1/Wj5mpIyUQnbRkeagCbMtv22thSIVMffN+f8ZHr9ZhVAxlilgv79iVWNWADOP6AwFLftQnia3KQSXprqYUX2pT7Va3jhMyo8rZ5SGZphdpz32IUtCF+K+EKqvo6AXT7j4FabJ96EHwx+ni66+kYb1ilWPfuSIEO8olkptR6Q12Z48p8n4MheNVnfX+PMYa+Sl3fkJivOeB4zMLU4DeR+ASeWVBCltAMpzUdGyq3qeunSuiB+56yisVJ9whs3wZc6iStxj8QWnSWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bachmann.info; dmarc=pass action=none
 header.from=bachmann.info; dkim=pass header.d=bachmann.info; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGN0R0K5SiXNRtR9XArPYkk1UsraGhgN9OnEbjK9ioI=;
 b=X2poI4+Z6zdrdYSkwRGIg6b8qLliGittF1/WKlVKxPIt80xujNXfNgjooOtyH9mpVFBTv1DasodBxcfoe2C+4CyXap92e8iVilSPwfRDOlMd/1bjW0UtdLJTiz0WIL/LUVefx3+RZtVxurqyD+aFDt0UKCZbkgrp9p8XWUQuI2I=
Received: from AM9PR05MB7777.eurprd05.prod.outlook.com (2603:10a6:20b:2c5::23)
 by AS8PR05MB10415.eurprd05.prod.outlook.com (2603:10a6:20b:611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:54:45 +0000
Received: from AM9PR05MB7777.eurprd05.prod.outlook.com
 ([fe80::d665:3290:112c:6431]) by AM9PR05MB7777.eurprd05.prod.outlook.com
 ([fe80::d665:3290:112c:6431%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:54:45 +0000
From: KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info>
To: "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Realtime throttling and Real-Time group scheduling
Thread-Topic: Realtime throttling and Real-Time group scheduling
Thread-Index: AdxBnxqoeZajMXCUTqifMz23qmULoQ==
Date: Mon, 20 Oct 2025 08:54:45 +0000
Message-ID:
 <AM9PR05MB777740C6836026CE5A7F5F1C9BF5A@AM9PR05MB7777.eurprd05.prod.outlook.com>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bachmann.info;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR05MB7777:EE_|AS8PR05MB10415:EE_
x-ms-office365-filtering-correlation-id: 15f54521-3ae3-463c-a4bd-08de0fb65118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tWvUGD0vuiF23tEgiWSeyqNhf9i3QlHKejGqrkM/cKlS2t5G2k6BMAC5+kXk?=
 =?us-ascii?Q?4abFsTa0y0LdyUxHNq8ZqmS2MDgHnwDPmw9nVowezDeGECZqzVuQab8TpqqT?=
 =?us-ascii?Q?2Gn/XWx+as3ru7iLwsKKRAZjLk1d7OSH2FmHm6of2Mj+kz+Z5qmAK1tDlxoV?=
 =?us-ascii?Q?hIe1BRxkkL8G+5vZU8ShAER9fs21Yyit0kIpTO+xkIYQJmF7i/9JUq6dBP3a?=
 =?us-ascii?Q?pQSki9XRU9L9igQaPrntjEaFZaY4cWMGrGrM2NZ4Oj7agNDBfJfeTgjZM4Zn?=
 =?us-ascii?Q?zwq4+PC+qd+j6rTPYquefIhxnrlkqPeWhFJi7QaVqKwZXL1/HZT7P+nznh+O?=
 =?us-ascii?Q?HSlMCUzDGZgkfmy87F/91aPVN4oYd1ezrKhSDK0qGZakwHVlJQc1lAn2G9QX?=
 =?us-ascii?Q?iMRJoRb3pyHJVv5dT19hWRShr5fKQ75a7uNHAbW2w6oXG7t1Pu81jAsUBVG+?=
 =?us-ascii?Q?EAbH9TxFRefmw40z6Xm6g7eJSHGaUJEwS3LzUYNumtz8dDzxa0MwE92yiF4w?=
 =?us-ascii?Q?NvHxpjBtaDUhOmAZBKZ+LOW84xnbseAqX2vsRB+zCCLwrTSlMauQqvGB1cgN?=
 =?us-ascii?Q?T7T22ZpImuF5jfRr7z47R1cLL76aPi+Wal8Lcx0Dzttjd92jGkNHsSxm5Z/T?=
 =?us-ascii?Q?uyYynhW1cHCLEb3rsZU1QtT40q5RGk8ftqQku1ImkmIAQmjoPouo3dKOaNuf?=
 =?us-ascii?Q?z0Pxbn9UYRITH+B6xNorSBsN/FgKyEiuFtv1cmLA0GyvoVyGDLf/7Q6tumRK?=
 =?us-ascii?Q?brKgcQI/hP9ofuRM+M+rnFDHylOoXEfLrVhanONfaGHbJYpVQgZ1SlK+QDpn?=
 =?us-ascii?Q?lM+rboKEaCl5JayaKf1I7yTb4e0s2vgY6vFSx+vQ7DyhsZpVrz+lzMMthS9Q?=
 =?us-ascii?Q?45T8AcxZNrJmMTYsUi4GKdSbOvoi5E9cllqJhwmZLSVzgOy6CoHIucl4wdtU?=
 =?us-ascii?Q?Ab+fkIiVlLPHtXogfHKVt3DILvwe+HawMrIn5Ok00jmrwnoluiDVqKeoIi9h?=
 =?us-ascii?Q?ukmQ1hSD7Hklftu/W62G7FEM3iD4S59bjD9V4JKCQ7VPSWHUUBBOPfBY8dRH?=
 =?us-ascii?Q?N4wy9J+208JzX6oqfxIjrV7jPy6XzmEyhRppaYRCfnWYGhFxCT9GguX+6w+Y?=
 =?us-ascii?Q?5DQAYq8Qk3E8xy2eW3FMgmoGw47BEe7Oif8U/ssmcqd3ypEasoYC9Vg8CY+i?=
 =?us-ascii?Q?qsVOY6CfOZfYsWimoEKjX+nK55+EPoSptbAkIEmNwwzR+V/Usol8hcVMiBS7?=
 =?us-ascii?Q?MRiwzFTYxXXKRKa+21bvd7etufivFx60JNvyoi3BaVxR5LTmQ8ADjOCahVRi?=
 =?us-ascii?Q?dfLjz+nVO9aiZhgIyjZoBB9aGdkKyPt4FXtgEl07KC/aLw7xOJCy5BM0nw+L?=
 =?us-ascii?Q?KIuwmEJL5UQIuU59LWXtNuq8dmQgqoloi2sZoDYcMcHJVMNYIVIMO44Pw69Z?=
 =?us-ascii?Q?v71N58AdEecdxaxpMWkjmGmLRfEwfd0815DVugAOPIGH1L/0IPPeDsDQvnb1?=
 =?us-ascii?Q?CCmTa5r5hhtbzVG0f/F5zWy8EOHq4uwYmprk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB7777.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?By2bWP1pmNfw9NESmeEdBMnnk9xF9+rusq0jGrvg8WjuuWsTmtOS6r8HA5d9?=
 =?us-ascii?Q?y3VYy4Yur6tA16VpXnEHsz8lza6IlidvoZ/Tnycxa+c4Ux5Y6HBNyERFwTbO?=
 =?us-ascii?Q?StXcD8hEq2K09NzkB3RdkI96LkIdm9QVihgpfOaNi8i0n0uxNDebSwT1D2u2?=
 =?us-ascii?Q?+yC7EL2cY/A7TqTz5/Beq9/sqKketZWo+zCl76jfkX3xFUlYQM6rrsR73vAk?=
 =?us-ascii?Q?qefROU23uqfOUALMbczv/RwY6x19ctbzWGFbnqR4qcXxN/L8Ev8lBTz2fFH1?=
 =?us-ascii?Q?bLzZFzcDSW2pnNdykl6Ks/35Ygo2olDCtMqva7jm63zUCeF191cmlM/cQsBe?=
 =?us-ascii?Q?W3pmOhDWMkGVFfZP9zkGJz6DFkUgKi56P0HMbmu9t1JEkNkKf+9tOLowcw+V?=
 =?us-ascii?Q?H0vxN0DJpEKTBkOEddggkc41LtF6m1kasSBNuZ0tmGCLRIIo25OTDID7NJPv?=
 =?us-ascii?Q?okd1sOFNDnENkCuJG1fRC0aVaSHpI7xJOoGb/OGnuEhaBcuqL9/UNkDXiNZv?=
 =?us-ascii?Q?YrvrC1l/Iy84FLfdfItGCZDK1UR7xHgg9W2O1nwrtTAyiMgTOfd64KlSgSUd?=
 =?us-ascii?Q?8Tl+A1UNKT/gXpQgRZymglyDluZngdD+qwLw7jXOKIf0YuzFdLAOdof3aEVN?=
 =?us-ascii?Q?Wj5qwtIt6QB9AEGw5TcZJL9QK0XZF2oCrnpf7JY34iQ+Rlg4LEEIbqhMkZPe?=
 =?us-ascii?Q?EhkrS+DO/Z4h+cn1dzp6HihNjPPhgugnPHEm8pjIOzZvShk2+MFr9pbj2NS+?=
 =?us-ascii?Q?hGIE/NqHaEjNwj1JdHkpyfoB/mIwwQWe2YBwPhtn+o78uq7rjxnEecfJum9W?=
 =?us-ascii?Q?gJWuhs3DMxJJ87EXSm/FSoND3AinEhkf4l3/7ssEswxrlIW4zKOSTt0lQkBZ?=
 =?us-ascii?Q?cyVe8ar7IA0HFZAYT6EiJlRMAwcnYXDznI57+YfeLYtPY62NzuqM4bawQ3Fy?=
 =?us-ascii?Q?nG5R1m+hU8lymCeqN//t/4squ4l8fPXnONi6k8/fxgd9Xca19oDFcY6aSLjt?=
 =?us-ascii?Q?3pK5aVrDkGBtAVKu8LBWMnHlZk4ajOLKlI+oGNzR7pDKS5+HlTnCTQhqQdJq?=
 =?us-ascii?Q?ADaFnQNjpnFcVCQEg0w4werhyvHzgpeB0FT4qa0vnoE517dvq5NlnziT4tMH?=
 =?us-ascii?Q?I30d7D7L//4HaQnr/K7EFYJ2VQ+w8kZMIuA/raf4TWmF8ZjZquiGK4+Lyqvi?=
 =?us-ascii?Q?fxbC+1XJ1o4V+FCOsTxWKVS8wfvWema7/rYA36zucAHJsu+68evpABgDatmq?=
 =?us-ascii?Q?U++comEqSV0TVNMWJmQzO+XaIlv3xwXqkmU0eQye/yvwZreOeJuchVYoKgbX?=
 =?us-ascii?Q?TRMmKb7TyqSyUjNjIBAcow9RPQAE+X4qRrbkilNRuQ0kA9DZ/zydzFX+aqza?=
 =?us-ascii?Q?KUiVyGYIu/DiTwoMmhoHxJpEXgU11cYaVBcfptc7wTZGSvo/PZ7WiJpAgd+6?=
 =?us-ascii?Q?XsnFIK+8xJdeHXzaGdztgkdR5BIpuZGPwQcAlDJsgiP13wicdolY2/4hAvUr?=
 =?us-ascii?Q?xrEeCHv1x/kiACscLk69Q52MQAk2yVxj7JqORNK6tLYMVL1kc8YXCUr7dtdI?=
 =?us-ascii?Q?faTeIQYO8Td+ZCMX4pA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bachmann.info
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB7777.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f54521-3ae3-463c-a4bd-08de0fb65118
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 08:54:45.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cnwNtL+YQl51ZARAf6VWFX3hGyuMXkLdkv6mEHyGNgkOtx1kCRZpvg05cvJCt1RMPSLUI9VUGGFoCH8/9MtLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10415

Hi,

I'm running a 6.12.39-rt Linux kernel and have been experimenting with runt=
ime throttling on my embedded hardware.
However, it seems that the settings for sched_rt_period_us and sched_rt_run=
time_us have no effect. In my kernel configuration, CONFIG_RT_GROUP_SCHED i=
s not set.

Is my understanding correct that CONFIG_RT_GROUP_SCHED is not required to t=
hrottle real-time tasks?

Best regards,
Gerhard
