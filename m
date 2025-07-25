Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE0259C
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421445; cv=fail; b=Mo45mfcaTBoQ14v3fTn3CMbpBV0K2hzjawtQ+9ElPGI2W9wVOl1aFUkvpghwHs/hKzvOVCXvBzm+R1C4iY9QTXCCbiYQ/2677tQwzAVLf+9hAGFGgRFQD809Uz8NwsL9ifq/Q0/fSh2zUtNANdPYvtTv9sXzKEniKn6WXtHEeSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421445; c=relaxed/simple;
	bh=Yg0oqSdi7+n9Pn/YZqAW2CnSGqAsGAKqv3Wks4w53Iw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ceQiuRusUcrzI1i1PMAJmzR+HLdG+sFQMZT/dlOOy94+5aYOs2VGr8xBC+lrExdhqe9NrkWdxEv/g5ty4y8x5kGs/pH6UpY4CTosj8qQrfsYosSkx9OqoscRQGz0sU8nRjYnSSYZq7hNkbRUcFIF40Y+k2BJ3g4anI6DwB0AZhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=mjuUDzBH; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="mjuUDzBH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIeb4ORSuWLWVhFq7wqol0vlBltpJaA2Bog4E2zN6bZwRETIj+jp/nijekYU1C+9E3vz6dcG8lzSEbZMXeeLh8LyS+PXt9SLXTymbXYL+qSH8dCsUnLZpepnf1JZqpYRtt9rAdkVvbPJ8Og0N5jHc67J1FP2PE4JKZUFiud5s4WIp08l7DMuyzsFsFCKPl2JpjfoVanXgu1U6Boa79VmY+J3iLgriAqin9K7Lxd1LMwmdM67JyiKgjckCGRRERsFKT4LYDSLAznoBqqHzHFAPwHL8BYO0S+81dLCK3eShrv29pm7gfjNiNp8uw6wgRIGIiz1JNeoWUnMf2ReD83YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg0oqSdi7+n9Pn/YZqAW2CnSGqAsGAKqv3Wks4w53Iw=;
 b=qR8n6m/5elS1If3ONeDxpUrfPw2gYpbk1a/c3PMv1GiAPhGUPSfdgp21oYEB9BIFO3BtULk+HJgIaxnJeu07nPVHDZAQ5DD8olLbW4IJMeVS89lQZTz5+LTBTNdB7AgUmuYMZF3cGZYQxMfiaeNShlKND5FgPKaxItY6UF6iWrkxYw+oBKm20wpFRTb0lvtc0TCo6cpvd4z2Qxd8ro+dXXws3zd4ffW2uHRYgpSrvag0OQyyr7yPKsDbomsvYKoZ5YRQ48iwBMdnGUYaZeCn1lF/fabIDhsAX9qBq0fnRZt4YCb+LKJ+7cCZf3RCyl1ITytgyLN//NExVD/b3VpXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg0oqSdi7+n9Pn/YZqAW2CnSGqAsGAKqv3Wks4w53Iw=;
 b=mjuUDzBHkxgrAkbeegpqUA6HOYKhQbn6wzYRTmVA8bfttvhkFw9idkgss5e5wsWaS02WRsIFa7St6zBNF44AC3ypqqp5SpYbmsFcQjLmvS5asnxn5eYEQfX6gH9MRI0ZhYKuFNjHqvHr24SJ8hwYZwYNzBezgA8g+LcffKG0d+VO9wWP5N+HvoidsXULEXGoCPjeaye/vpl10RBsxrDbxs/h3M/phVr6esXEeTzeSicJl3NdIiT7VeEXh6dgtVDNOq65BcNlHnzXhWuTLH3nbqYT10evAgW30Z5y2GXY4nXjTwQFyKo2DgDPR0T6UwPuYDKvvD/3GG1kRKw8/hEEgg==
Received: from DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:322::12) by AM0PR01MB6401.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:16f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 05:30:40 +0000
Received: from DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 ([fe80::27a:7a68:5d97:fae3]) by DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 ([fe80::27a:7a68:5d97:fae3%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 05:30:40 +0000
From: Alexander Krabler <Alexander.Krabler@kuka.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Dennis Schimmel <Dennis.Schimmel@kuka.com>, Daniel Braunwarth
	<Daniel.Braunwarth@kuka.com>
Subject: Realtime threads delayed due to kcompactd0
Thread-Topic: Realtime threads delayed due to kcompactd0
Thread-Index: AQHb/SUMECAAoxVz1UW75TJas4YXXA==
Date: Fri, 25 Jul 2025 05:30:40 +0000
Message-ID:
 <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2025-07-25T05:30:42.376Z;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=0;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB10385:EE_|AM0PR01MB6401:EE_
x-ms-office365-filtering-correlation-id: 5de81f4d-48a5-48df-78a6-08ddcb3c64c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0Sr8cpNa9zx2VqyjDL9zPsfax8qETdDwZu1YA40q4Y4/g/xPwbxiqDEtij?=
 =?iso-8859-1?Q?CeV9KqGjDN9ZlaSXI9UzWeOSjdbq60+nd0tJNN7/u+4Rtt5LCbSnCGfBlN?=
 =?iso-8859-1?Q?30ovoTCKyZJ1VdWVFQ5Xr5R2UOZIoHoWk8PABdUfPp35IECE8sXsTIYQTw?=
 =?iso-8859-1?Q?g09H3rBftzBSizpjW78sE4V8OoNaEO+7WCgFbuQVSNH8kbF4eBOwpZ55EC?=
 =?iso-8859-1?Q?ONolZwtTdPZYUKnQaGswnk7kPvNTzGsep/xumETEBhnjb07/HSY1xXzXhb?=
 =?iso-8859-1?Q?HZ5UfKIL/LUlZ9/x/7JARdAcwQKrlSc5FSUa6DTTsCzyoKI7wZ9Fz+vdVh?=
 =?iso-8859-1?Q?6gRsaRvRpRRDU/OGM92b7XbcaQGQgL/uR/0kUZGPiCcLdSzPRVNEVA2aPy?=
 =?iso-8859-1?Q?tS7fBznuyy/mAAvszewNi7ycGEvwHnAIzy1FxvpSYg56i+IAbTrITG+1XM?=
 =?iso-8859-1?Q?5HJate0jcLGHR2vh8Ox87+r0amnAGZtU8XejmH8qezOUQZGJvZl5qzwodK?=
 =?iso-8859-1?Q?9o+blAtVE4B1jEXrZ3L6v+QcXXZia9wJreHLmV/ba4NxSdmhLVP2ory5W8?=
 =?iso-8859-1?Q?tvNcW3Ai7FPsE1VSOQrj9f49alhdsSoywy1Tmah7C6UAPMIyv4enLjW5Vv?=
 =?iso-8859-1?Q?t8Qjqps8Ga6xV8/0wnNdQ0XiH3Z8AiLFj0Z4uVTZ6GayOTwMyaaK5H9Sxz?=
 =?iso-8859-1?Q?CK0RdPlg4e/O9GcFvWGyH2soPXzUi0qhMGFpdoURFODM0dwektVM7F3Ain?=
 =?iso-8859-1?Q?zCjJHHRBhmSVfvfCIoHYP1I/s+lNcaXlutiOsdj9rloEYNb0Bv4UKGO/q7?=
 =?iso-8859-1?Q?AYcsdrN98KjtOvzMyvRYmj8yPlBdySczMTYpJiuhwOw6I0Ls4Dc5juzW5K?=
 =?iso-8859-1?Q?TCCUffX1oZxmQGgX+Kvsf+8vdYPEW6uYTsnrrykYUdEY/HOjcryblbk6uo?=
 =?iso-8859-1?Q?EzF20BDes8lqoKWBVThoNEMD8zazp0mrFF5/iZOeZNfgkixfull2vGWG+K?=
 =?iso-8859-1?Q?9YcrX6zJE8fJveYCLKXst/P4xv7RB367j+8A9NRArvx0Z9qZObM/UiJ7+2?=
 =?iso-8859-1?Q?IpoC9ytnpSadIFyNt9Op2IhYxXNjjSoTGkE3TqF2xBGxeQxEr01qV6GmSG?=
 =?iso-8859-1?Q?HjuXd3jM87Gfcu23JAHaK5Q42FQtiXq/U3EnNwZV1AoOe2eYn+JlY7V7G5?=
 =?iso-8859-1?Q?wPv/te/kr3SwVFqEgJo6fmoioVSvCN4dz74TYUGi0XgnTloxZq8SCuaRZu?=
 =?iso-8859-1?Q?RBJ28AyTnbv+8Vo8U54mEmX05nKs3p3dIQSrCVCgUtWzuZGKam26fhDvtF?=
 =?iso-8859-1?Q?86ZP/uHq5DOgE3jVipz0+nEfSZuLjv4pAWk+N/W5n+4OfJ8FNtjvvq3huH?=
 =?iso-8859-1?Q?Vw0TlCkwgKTH6ZjUezWgtyTReN5DboL3APIsJoN+Ic3uqVw850L0dO0hdo?=
 =?iso-8859-1?Q?PmhkU00mPV+LcbhWKNIDFGMfmnR6ocn8HS9PK0Vdoflmy19RcvLJtHb4vP?=
 =?iso-8859-1?Q?MTpfVFpQE/k4M+hHIypRLqwy7xU2oxW6LXx9YI6FMOEQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB10385.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZEHdN1g3l23kL4DodeY8N3h18wmKvb9KYiMuq23Hy2KOWxsETLerr8Gajm?=
 =?iso-8859-1?Q?tBjAHTZ3qBJTisRayu240J/enFK8BNjyFnn5T5NHE6UsWSPVAPMtxVV6uW?=
 =?iso-8859-1?Q?lvHxqGBvi5CTwVe3uL6AUbuHAP9ozIeinK6JsSxAzplbMWjIF2axTOugVy?=
 =?iso-8859-1?Q?0qf6Zj/zkx15BwD0b6w7ZLzGydX3wsujnZJfOxIP7gTGDStqT7vpptUljA?=
 =?iso-8859-1?Q?/0mLpLMj+iXZmLjhzfpYXSq/DHRmEfOiRoDhTj1WpuMcY/BnhdfFq5hx2U?=
 =?iso-8859-1?Q?yodnpQ48/maTQa59p9iwSEV+Uq8l+Y8hr7QA5s/fBmFjY2aL5VT6XYntfW?=
 =?iso-8859-1?Q?9eREUGeafBExA7Y5Y0EGRlSNiExG9lqTZrz+V3k7xqZTJJP+0jG2ynNra0?=
 =?iso-8859-1?Q?FeM2PKfEmxiR0O5eU63L5d/tTnEyqR3eozbIVmh8Z+G4m7YJ+CxYAPfQJ+?=
 =?iso-8859-1?Q?RdvfXor54QlAImHlCUYYeBeOeJ5Y7+XUUGkMFsC4FrQEbB3oiHdJFgtaWw?=
 =?iso-8859-1?Q?cGttpg3399nNSh4jJFpjMpCem/KvhodfH9eTmCzfMBrvsdQR5Fap3Lt8qc?=
 =?iso-8859-1?Q?TktrA4vV22H5gRvOfNfPdVlOTj8Ri+xbt9b4LnJ8FyqdrS1OL/nbucqPbs?=
 =?iso-8859-1?Q?p65T6gh8nY3Ri0Eyfv+iFtDtVArSTvImCZwrQ8KDjhLfuv1vMmf64sEvYR?=
 =?iso-8859-1?Q?wzu87rYg9nXL5TZW0RPuv925Cptiy1XfY18AJJqZ05BjfIR5+rI8lBlcB1?=
 =?iso-8859-1?Q?oqc73pEMVIknkSfQcWqT/LgW7Bd1TmGTsevhqzbKr7kaucawreZ8AFqG58?=
 =?iso-8859-1?Q?7TcmdOugOiJiUtEiXfc2ikJEKoutOqC3/BlsljBTVF8MDiZQ8xtANoiz85?=
 =?iso-8859-1?Q?yzGFdTs199aCGVAEPh+SP/kOOCWgF6468B65TWUXgIn2RirxDz8dJr6ayL?=
 =?iso-8859-1?Q?/jrjrDj1uBSC+ueTpG1k4JcKqNHXFw+Pe61kd5sVdIkyfiRZhaHqJf8uHt?=
 =?iso-8859-1?Q?/TQX70xsTqn6XQiIZbzQQz/esNJQwEKS4LhciEdYpt7w9IPVXYAJRhu/W5?=
 =?iso-8859-1?Q?rbnGzJ2xx/E+iYTGFuiMzFHwcmV+JiXs1vjnhi5f5L5sYrvb4RMkJ5lDu+?=
 =?iso-8859-1?Q?Xjd47BGJTCeZS8LA1gy4f1vkQV8wBvrtpK5KKfVSwMIexpksljOwuvrFDD?=
 =?iso-8859-1?Q?aY1IEmK7n3pGioEA7InjLDidjCHufqjDjlI0zy/9D1VU2D7YBINoZMOzlP?=
 =?iso-8859-1?Q?Sz0pm5ekhLwRwQ4pYRGhu6SQIcvpqIwgs7y/MpTJzoit55cbR1YJfFB6ei?=
 =?iso-8859-1?Q?DooKuZHw3GTVELmLJnT63O18c0FDGZy0tuaJ8t0u/2FpML/AdblPBpYEhs?=
 =?iso-8859-1?Q?Uf0SqD2jYF5yiNXrXcZLxiiqY3VUJSzkWedSlXNSPmGiuLdOFgk953e9Bh?=
 =?iso-8859-1?Q?WXRB8EZUtTTjaSYOYgf+phb8sG0lhWMojjHadMXfibQWmliSJcBkOTbL+L?=
 =?iso-8859-1?Q?O4q7iEgXD29KZY8nBJBkkQddbyLzj4RJS2dEguJJV7khRzprxNx7SuDhsC?=
 =?iso-8859-1?Q?dggt+yCHv014Lw41WFjtfUVDUNSF2+OghHSSIm4KanO1jH55SDho31BePe?=
 =?iso-8859-1?Q?f2DnOBbN3x5B8JhyDFlzkhbpcP2JD34OLcm+1meoQ/cqbD1wCzeLT24Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR01MB10385.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de81f4d-48a5-48df-78a6-08ddcb3c64c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 05:30:40.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbDn55OxMJ2CuQKT6/MM9U4YXgEWYuDy995Au8MC2L0cjW7pbL+bIJIh3B6ekam/fsNaw5FXKq64zRT3SNx0ks1UVhRjzmYVAn4K4hnWgJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB6401

Hi=A0all,=0A=
=0A=
some=A0of=A0our=A0realtime=A0tasks=A0get=A0delayed=A0from=A0time=A0to=A0tim=
e=A0due=A0to=A0activity=A0of kcompactd0.=0A=
Out=A0of=A0nothing,=A0realtime=A0tasks=A0go=A0into=A0uninterruptable=A0slee=
p=A0for=A0some=A0time.=0A=
This=A0delay=A0can=A0be=A0as=A0much=A0as=A01.1ms,=A0which=A0is=A0not=A0acce=
ptable=A0for=A0us.=0A=
=0A=
Our=A0hardware=A0is=A0an=A0aarch64-based=A0SOC=A0with=A08=A0A72=A0cores,=A0=
kernel=A0is=A06.12.17=A0with=A0PREEMPT_RT.=0A=
We=A0have CONFIG_COMPACTION and CONFIG_MIGRATION enabled.=0A=
=0A=
Here=A0are=A0some=A0snippets=A0from=A0ftrace:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.100041:=A0mm_compaction_begin:=A0=A0zone_start=3D0x80000=A0migrate_pfn=
=3D0x80000=A0free_pfn=3D0xffe00=A0zone_end=3D0x100000,=A0mode=3Dsync=0A=
...=A0=A0=A0=A0=A0=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.159782:=A0mm_compaction_isolate_migratepages:=A0range=3D(0x85800=A0~=A00=
x85841)=A0nr_scanned=3D65=A0nr_taken=3D32=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.159810:=A0mm_compaction_isolate_freepages:=A0range=3D(0xddc40=A0~=A00xdd=
c48)=A0nr_scanned=3D8=A0nr_taken=3D8=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160002:=A0irq_handler_entry:=A0=A0=A0=A0irq=3D11=A0name=3Darch_timer=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160012:=A0irq_handler_exit:=A0=A0=A0=A0=A0irq=3D11=A0ret=3Dhandled=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160121:=A0mm_compaction_migratepages:=A0nr_migrated=3D32=A0nr_failed=3D0=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160122:=A0mm_compaction_finished:=A0node=3D0=A0zone=3DDMA=A0=A0=A0=A0=A0=
=A0order=3D-1=A0ret=3Dcontinue=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160185:=A0mm_compaction_isolate_migratepages:=A0range=3D(0x85841=A0~=A00=
x85a00)=A0nr_scanned=3D447=A0nr_taken=3D166=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160204:=A0mm_compaction_isolate_freepages:=A0range=3D(0xddc48=A0~=A00xdd=
d80)=A0nr_scanned=3D312=A0nr_taken=3D196=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tRealtime-16499=A0[004]=A013112.1=
60511:=A0sched_switch:=A0=A0=A0=A0=A0=A0=A0=A0=A0tRealtime:16499=A0[25]=A0D=
=A0=3D=3D>=A0tKRC:16479=A0[39]=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tRealtime-16499=A0[004]=A013112.1=
60512:=A0kernel_stack:=A0=A0=A0=A0=A0=A0=A0=A0=A0<stack=A0trace=A0>=0A=
=3D>=A0__schedule=A0(ffffcde843022d6c)=0A=
=3D>=A0schedule=A0(ffffcde843023464)=0A=
=3D>=A0io_schedule=A0(ffffcde8430235ec)=0A=
=3D>=A0migration_entry_wait_on_locked=A0(ffffcde8424a1ad8)=0A=
=3D>=A0migration_entry_wait=A0(ffffcde84254c400)=0A=
=3D>=A0do_swap_page=A0(ffffcde8424f7fac)=0A=
=3D>=A0__handle_mm_fault=A0(ffffcde8424f8b64)=0A=
=3D>=A0handle_mm_fault=A0(ffffcde8424f9bc0)=0A=
=3D>=A0do_page_fault=A0(ffffcde843030380)=0A=
=3D>=A0do_translation_fault=A0(ffffcde84303072c)=0A=
=3D>=A0do_mem_abort=A0(ffffcde84222f674)=0A=
=3D>=A0el0_ia=A0(ffffcde84301eb20)=0A=
=3D>=A0el0t_64_sync_handler=A0(ffffcde84301f020)=0A=
=3D>=A0el0t_64_sync=A0(ffffcde842211514)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160557:=A0sched_pi_setprio:=A0=A0=A0=A0=A0comm=3Dkcompactd0=A0pid=3D88=
=A0oldprio=3D39=A0newprio=3D120=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160569:=A0sched_waking:=A0=A0=A0=A0=A0=A0=A0=A0=A0comm=3DtKRC=A0pid=3D16=
479=A0prio=3D39=A0target_cpu=3D004=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.160986:=A0sched_waking:=A0=A0=A0=A0=A0=A0=A0=A0=A0comm=3DtKRC=A0pid=3D16=
479=A0prio=3D39=A0target_cpu=3D004=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.161412:=A0sched_waking:=A0=A0=A0=A0=A0=A0=A0=A0=A0comm=3DtOther=A0pid=3D=
16520=A0prio=3D40=A0target_cpu=3D004=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.161457:=A0sched_pi_setprio:=A0=A0=A0=A0=A0comm=3Dkcompactd0=A0pid=3D88=
=A0oldprio=3D40=A0newprio=3D120=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kcompactd0-88=A0=A0=A0=A0[001]=A0131=
12.161465:=A0sched_waking:=A0=A0=A0=A0=A0=A0=A0=A0=A0comm=3DtOther=A0pid=3D=
16520=A0prio=3D40=A0target_cpu=3D004=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0kcompactd0-88=A0=A0=A0=A0[001]=A013112.161654:=
=A0sched_waking:=A0=A0=A0=A0=A0=A0=A0=A0=A0comm=3DtRealtime=A0pid=3D16499=
=A0prio=3D25=A0target_cpu=3D004=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
=0A=
In=A0our=A0setup kcompactd0 gets=A0enough=A0CPU=A0time=A0(on=A0core=A01),=
=A0however,=A0it=A0seems=A0strange=A0that=A0it=A0doesn't=A0get=A0the=A0prio=
rity=A0inherited=A0from=A0blocked=A0realtime=A0tasks.=0A=
(It=A0does=A0for=A0short=A0amounts=A0of=A0time,=A0which=A0seems=A0to=A0be=
=A0due=A0to=A0the=A0locks=A0inside migration_entry_wait_on_locked.)=0A=
=0A=
Is=A0there=A0anything=A0we=A0can=A0do=A0here?=0A=
=0A=
Thanks,=0A=
Alexander=
