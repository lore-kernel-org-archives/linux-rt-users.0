Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022087.outbound.protection.outlook.com [52.101.66.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2881A8F6D
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038028; cv=fail; b=XBeKHNjZKgx5PWxLKvruLh6dvVX3Rn2oh4KyaRc+orHwcE17m0fub/CVMBjzB7HU3p3XByQFps1C9NmdtqvFk06AeziyvQRafqmifEmgm1R/70LQ8cGJLRHByCb4g3erBkZREOPx4AOJEAIrh8MbETY0cnMH4UMZmBcPMyptELA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038028; c=relaxed/simple;
	bh=WVV7pJpmWJS4NOWWE5Q+94IDVJqjWA6HjfhJ9jJKezM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sh51mk4yLYCz+LKduxWXFJtRz7DkMLCn9C/f6uRTtZWFktrF1E09EeZMzXVVg4/5/jeuIYoiEclkQop1QGob9hmPxFhK/eepKu8pMo4g4lqSiQXHabT6lllf8XMa5DpfNZwuK6q5LjilUoz4DnDdonEhImnHg0O6B6mMveOrOvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=adXa7Ff5; arc=fail smtp.client-ip=52.101.66.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="adXa7Ff5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaZJiR6q99FX0rPmH88RjkJzOQpHaScnffhJWnVIZod1zJr2vdrl+7ILF1d3L8gozWAVaufk3bcJ4r0/jHqrfu1ckI7Bpc6KTaFv7H2neJrGVYF01F7ZE+xkxc+ysROMkBtBbUYn1tKcb4TGGiJuwIVDl6aASnwIHLYhD/a8/Tx85p0/Mi7zFbSofn75ulu0aZ17fPWNsXCe/G2udCsPur04ZS/NINsPD3gIf1WBrgVOGS5gpCySvK5CrOn6/YvS44sw7n+WDxH0VkqxobOpy3E76AaAezCufS3tPKqYzgcAgsOsQDNjCO16EZcy+xkS6LkaFJmEoz//pywgG85Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6P5KU8lzFfo4X8+T7H8oWxI29fWO69OmWDVz/J2C9M=;
 b=eT+kASL7K9SRlLeIOxsDZ+UNxYglIfOfdinXd7PkevzJLqgWmpf2sGGHkE5QfQwcdPoY9oCvm+wgjGbD5fsHokqHzygh5Ay8JiDQXssFJpv0pMDKQg7M1lYeLGx7vQ4b/30vm1PAiHID9FfZhWdzYD+tLhjaOZZBPWhTW0tsyJ+3LRxWiBwdA++8YdIVbbuKzEMOz1iUC35HXGb3pVDFa1Bl5MOvFnpw+R/7DkFRGcd0hhNtF+F1pbQZzuCPsc0yjdPuaSBPQuTwTGfcZdhkpWbdpO/wWKSMP8e9wn3sSpYDDvdyGdX2USabzYIPK53/aHFY5kzjLv+Q4FK3fVFQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bachmann.info; dmarc=pass action=none
 header.from=bachmann.info; dkim=pass header.d=bachmann.info; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6P5KU8lzFfo4X8+T7H8oWxI29fWO69OmWDVz/J2C9M=;
 b=adXa7Ff5xZjEYte9i+KZobb6fuow9hRMCkJz8YTnk4jz2ZjBtQvWW9oxu/Q2m9coNHK/+Qx4YZhuqr1dWgb+kySe1fVOJ9/moCJ6LM6HkF3rdpNokTZQqrZvSHq9GoZ4/4Yp3hA0EIg4pcvmODl8fChmuBfixItJD68cviOcmyY=
Received: from AM9PR05MB7777.eurprd05.prod.outlook.com (2603:10a6:20b:2c5::23)
 by DU4PR05MB12200.eurprd05.prod.outlook.com (2603:10a6:10:616::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 09:13:40 +0000
Received: from AM9PR05MB7777.eurprd05.prod.outlook.com
 ([fe80::d665:3290:112c:6431]) by AM9PR05MB7777.eurprd05.prod.outlook.com
 ([fe80::d665:3290:112c:6431%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 09:13:40 +0000
From: KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info>
To: 'John Ogness' <john.ogness@linutronix.de>
CC: KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info>,
	"'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Re: Realtime throttling and Real-Time group scheduling
Thread-Topic: Realtime throttling and Real-Time group scheduling
Thread-Index: AdxBnxqoeZajMXCUTqifMz23qmULoQABeTGAADCk3vo=
Date: Tue, 21 Oct 2025 09:13:40 +0000
Message-ID:
 <AM9PR05MB77775F0B030DB96B505F00FB9BF2A@AM9PR05MB7777.eurprd05.prod.outlook.com>
References:
 <AM9PR05MB777740C6836026CE5A7F5F1C9BF5A@AM9PR05MB7777.eurprd05.prod.outlook.com>
 <874irt6hk8.fsf@jogness.linutronix.de>
In-Reply-To: <874irt6hk8.fsf@jogness.linutronix.de>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bachmann.info;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR05MB7777:EE_|DU4PR05MB12200:EE_
x-ms-office365-filtering-correlation-id: b4386e96-cf81-451c-7451-08de10822044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QTkZwipVH/9RCOZ1rl/1NaweE/lEQDr+J8h5CSpuI7pTyI3vcwI+N3bIBL?=
 =?iso-8859-1?Q?sGxTdlZsO/03jOKrkJMrSQvw/MHnlWWDQ4zPimB9NlGuMi6C3QRWeO3a6F?=
 =?iso-8859-1?Q?abuoCqmOdjLWmK4AsfblvNj7EOnbchyT7b0NUnN2LURaz8QjlDoBHJmpwL?=
 =?iso-8859-1?Q?hKsLpJz+U7G3ixyuv1+L8rMRreakXJBnbwhmutUn0Mw7KOvKKgfJf4boQ5?=
 =?iso-8859-1?Q?n4hMwTzxYsVRz8eeHXL3O3LKqPCjgqk6m3+2BNiVEoPuXkf9x4XjZRo0YN?=
 =?iso-8859-1?Q?QuZUlQR/y5nJK01NC8e8s5cuyixFcvUNDRY+MAuNjsiGGQP3A2D3Xmy4x2?=
 =?iso-8859-1?Q?65qM7DieCRtI4q8B5285ywcTe7KjYWIruj7n3fNCl0YQw9x5zivRiIABzb?=
 =?iso-8859-1?Q?oa+JlxgcPjVzJ6J1WMg20kQxAtUzc9pmdUfHrf7Gz2/jsT9H2i5Ytz0MfR?=
 =?iso-8859-1?Q?3L83GGY+yIiQzr5y0idbafwCkDfS0oN3STqMB9aT2b3QHbG2bP9UVd6xuu?=
 =?iso-8859-1?Q?PHdZd9aXNFOQK+50dmlVz7xquXzzgObn8KMlGu+TotmhgrM2eFIyrCNC0R?=
 =?iso-8859-1?Q?0uQtjp4QndzPoVXT/svR9jYXtQYTHoVapNcLqtVEz7eVnnxIt52dZ8hV9U?=
 =?iso-8859-1?Q?QqQ2NA+aJ7ImD3WXo+zY36GGjw/rNL7vlrJciMcr+CrM+8d6Y4ZTX/2H+J?=
 =?iso-8859-1?Q?lX4Bq+/zEaBseYvadaGodfC7sxNU/ZYtcoCtqbq5P19vnlWFJXk8GbM3K7?=
 =?iso-8859-1?Q?b9iti5UFeedwtQMCVT2EgW/kzYo7wkFPt1QU9Rk0H+zh06fI36c20UjYzN?=
 =?iso-8859-1?Q?6Fm37dW+BVVCO5UhxtQgfs0Pijsi5mn77a89kSdk8VDZ7BV8zJBGR2Flgu?=
 =?iso-8859-1?Q?cKGDdvCW9u2uUVmTtok/tD6bRiEYFd9SuKM/ApFW+Y2o5HWRzBfkVygvBi?=
 =?iso-8859-1?Q?IBRUmuULnpOBolV4IeB4/10n5H46qQMt831FfFv88r3EoBEdXPY5hkvejM?=
 =?iso-8859-1?Q?rkCBbW1CSnaI1Msh4rUclmwzOZTPczIvYbNedhx55eQXzAZHnIcG5/8gWE?=
 =?iso-8859-1?Q?w652yMx+olWrd4sHoleTP4cXBpAp/LYJou2/VVZVtXR683lcXKpNxEhEPH?=
 =?iso-8859-1?Q?aaqeO9dgW7E0XE2w1QOinoeNI7rgg0yKJ6UtdVNDjck9A8f4X1wtFTH/Om?=
 =?iso-8859-1?Q?oaxL+bccwhsi1A1u8amIEcI2AkrbH1mDJ3D0JVIrPYu1fm2+zsBrC2sdc2?=
 =?iso-8859-1?Q?mhAxzWo7/+TsRc5yDSiUDcVAJCAjz99x5NMJ8tx+35WttD5R4xottHO1zT?=
 =?iso-8859-1?Q?W0GD2rCPWto+caevz7St5JUIxtgebUJ3Nc9yRuwo+mMvyxB3Q9w6qeuWNC?=
 =?iso-8859-1?Q?IV3LI0dzytHTH34dIRnjTRBCSZ/9HgVggNE0wR49631Qbgmmaks1EQbsMR?=
 =?iso-8859-1?Q?hrVxNnp8vwNjkco6jLqXyUTE1hOQ3XVP4H6Fad6Azqkt5SHzh2Rm1YyPqs?=
 =?iso-8859-1?Q?Xxu4UdDozQ2gGWuszJI+2Ph36uZswIxmCUsTVdY8I6u+MxC7rbkqXS2UTg?=
 =?iso-8859-1?Q?IScec/npW59o71A/rIW0EZ52bOJr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB7777.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tSF8puKd2dfPDoCe2zgjqhfE9Kqrf1CGklMzx6p2DNVBkmohuqv4yfh0OU?=
 =?iso-8859-1?Q?m2aqa4gpLH6PvacCmeVqPqkNxRTk0IlgvUEbIXaYGAIP4+fJLDqH6h8ROp?=
 =?iso-8859-1?Q?aVc0HHyu1EfKMAZa2c5x5JV9rj3ZuB5B6/6c8pXCYackCSXbt2jtju638Y?=
 =?iso-8859-1?Q?z2cUELuwvWowHlLbaZaB4bSY2RoHjcRgCR8KxvKbZcmrxS0TlMB71wDK4P?=
 =?iso-8859-1?Q?mM4w3fg4vikMgcCB8bGmU97hMiAnXD39+9YXvWF0BFId4uTA2hRfaZ3fCk?=
 =?iso-8859-1?Q?j3ZNRDD8U18fYiLs3qVgUqxFFHrY8Hc8tDVdF6n04N4d5D7nIK4YTCKnvy?=
 =?iso-8859-1?Q?7Qy32+tmCnJJ84PwDukrFXIV++mkG21V85KnTHTEFJD+Z2LngeDd/bKlJE?=
 =?iso-8859-1?Q?loz9OlRlYlegQH29WfP/au0k51qI9EEgqZPTX8mUp7woK3BJxbdukOYEHJ?=
 =?iso-8859-1?Q?JKzzFF1EI1MqwBxb1aY4GJdFTbyQ8z+XzqMg+VDWtkSYqu42N1JM62Fnet?=
 =?iso-8859-1?Q?iOAbORLEk9H8NYy/fbS9KpsQSkO8duoWueKlY/tcN6w/X5dVTWXjxqYSFd?=
 =?iso-8859-1?Q?WCb0M1FdCD1/x/uQUwIjld50TjUCWPqHf1SZTBfz/FqE+7Lr0IIsz5ILTG?=
 =?iso-8859-1?Q?UjMeILM18PbkUzB/aMu9Ux84vmaBm0irBDzCeVrapT4oIz5Eztk+h8dCpV?=
 =?iso-8859-1?Q?l7DLr4n8iBNYptTVTFXQwpyHktjRN6LI6ilnCfSMvjq5h1TQ9OpnI2Yd+z?=
 =?iso-8859-1?Q?s236UYPdcXZvV7CIRiWyK4vsbyfLrVdwsTfZjGgGx4v1M+wg1SXTRKbC07?=
 =?iso-8859-1?Q?1HwT4uAwNibH5EGKnisBQyPfvLPWr39AP8nclzXGO6ZB8H5cXAhGCdleon?=
 =?iso-8859-1?Q?ygDRr8DepfOP+I6Uwu6i/iev0rpS8oXiF0cK69cx4Is975w4dcB66wMgo3?=
 =?iso-8859-1?Q?qUb+3f/NbM3zmzDNWUArCvPzgr3Qs6YCuXxHrLGnaBMc4Duz4yxMn3fFRV?=
 =?iso-8859-1?Q?yYO9M7ALQ07y9vZRekSEOVKIMnkxNt8a+bvUpss9x7FhrtZPFEl0Ol1ldW?=
 =?iso-8859-1?Q?5QRfphPnuFkOgDz63KJHBJnYK0I55Bl/TLltoZ9yJ9N7kgCD41PxbCU3CO?=
 =?iso-8859-1?Q?3HBpbDbOYRWCVBK6biDSUkihTRtlv3z9c32o2yHDrhcoLo4gbypetzkKfK?=
 =?iso-8859-1?Q?09YgLqGk13OKhx+g4xC31e509EiTZo4cenH6fxFM8T8xDJLgZ++wXMLrWt?=
 =?iso-8859-1?Q?4Q26dfYPZ9dJCk6n1pD2Ka+9UIKMkryy/RGII3zjbIiXZeb/JfO/XpUpAW?=
 =?iso-8859-1?Q?S0vsQho+lDfyNtR5thNt8YdplUinMVOppfqY08lcpmhuwHbaUcnaOOKMuM?=
 =?iso-8859-1?Q?7CBXtXQEjXAQLebqxy84L+rVwV7zdr1LwxzAekmSOkTv3p0zzDg3SfNH0p?=
 =?iso-8859-1?Q?wnf2DP7jl5vGYZ+LsFT7nAviluu2DxOWKO7Fe3tI+gfuQHUwFGOv4sUvwc?=
 =?iso-8859-1?Q?128ay5in/skSsr2XF3vLIkKjykEB1NnxmbO+ZVOv/D4vrj2mG11vvbwLUY?=
 =?iso-8859-1?Q?Si6zoLtJACLQNY9yJol6tG5dc7jYDE5OHQM7L9srwcrFaifYA4bGSilpWS?=
 =?iso-8859-1?Q?ouX9e1a5gRwq8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4386e96-cf81-451c-7451-08de10822044
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 09:13:40.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLeCPl7BHsLzRCJTsKo1tf/sj1L8AejanhV/Y5zuwfyryoSEqsi8wff9JYbTC9mzGfoaprYPqb8rL5msiFqHPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR05MB12200

> -----Urspr=FCngliche Nachricht-----
> Von: John Ogness <john.ogness@linutronix.de>
> Gesendet: Montag, 20. Oktober 2025 11:36
> An: KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info>; 'linux-rt-
> users@vger.kernel.org' <linux-rt-users@vger.kernel.org>
> Betreff: Re: Realtime throttling and Real-Time group scheduling
>=20
>=20
> Hi Gerhard,
>=20
> On 2025-10-20, KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info>
> wrote:
> > I'm running a 6.12.39-rt Linux kernel and have been experimenting with
> > runtime throttling on my embedded hardware.  However, it seems that
> > the settings for sched_rt_period_us and sched_rt_runtime_us have no
> > effect. In my kernel configuration, CONFIG_RT_GROUP_SCHED is not set.
> >
> > Is my understanding correct that CONFIG_RT_GROUP_SCHED is not required
> > to throttle real-time tasks?
>=20
> Yes. But instead of adjusting "throttling", you adjust the guaranteed
> bandwidth for !rt tasks. You can read about the fair deadline server in i=
ts
> original commit message [0].
>=20
> Basically you can adjust these debugfs files:
>=20
> /sys/kernel/debug/sched/fair_server/cpu*/runtime
>=20
> to guarantee bandwith for !rt tasks.
>=20
> And yes, we are aware that proper documentation for this is missing.
>=20
> John Ogness
>=20
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/Do
> cumentation?&id=3Da110a81c52a9de73e2e57e826dd3bf0fd4c22226

Thanks for clarification. So this means that if CONFIG_RT_GROUP_SCHED is no=
t set, the parameters /proc/sys/kernel/sched_rt_period and /proc/sys/kernel=
/sched_rt_runtime have no effect?

Best,
Gerhard
