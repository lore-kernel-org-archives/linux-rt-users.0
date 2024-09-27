Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2120.outbound.protection.outlook.com [40.107.94.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81981C0DDB
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Sep 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449018; cv=fail; b=TTKZ7SmrkuJte1ct3Svna4YqtojanT0Dy7xVW2xYlzUo095roakAm/uHyceilgztH34GM+LZ24N5uDQuH6dw5+6zsxUaEauZ1j0YLT7mx2IExQq1pbnnNe+k9c5JNgs10L2sGsp2/U9Rah5ouvLnbzhysZp8xOPCpj+sd1NUUCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449018; c=relaxed/simple;
	bh=ei7JZ3uOuDT4M6a2noR8wB8MVM/qCScVH2hRonPl7Rg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CG3Zb1bw/KdqAQhXuMKuY/6sF+Si7Ab9N6Yz3p0GldpdEZ6Z4t7YnWgHED93fdpiQ4EhBuIqdHVjsg3PnNIlVgVYE6DwUoYi7Ivy1Q1OTMs64G/bkChNwI3VdZ9YqcmK/MX1N5jYzsKuQf6vPrzt0BH69dVxDny/i5bORCupVY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wayne.edu; spf=pass smtp.mailfrom=wayne.edu; dkim=pass (2048-bit key) header.d=wayne.edu header.i=@wayne.edu header.b=ZKRlfxMD; arc=fail smtp.client-ip=40.107.94.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wayne.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wayne.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wayne.edu header.i=@wayne.edu header.b="ZKRlfxMD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNJfrhC7Q3Uxw+NaUlJ6EBTbuKyQ5xAq79FwVTE6mUcsmA3e9NiJMIeIgEu47KRq56FujmcA0bEttFzcRNpsKWQnmP2Qu0c6gVEy2NKz3ipL6y7DI1x4ZqL1/QUCMiIpWcoM6+XbFKDnV2nBedLrov5i48wjqPTX2Aaaxlri7L2qgVxTAqYLD+iS9fc8eOGxvavKqzBeqzdsy7cSqyYSuvZ7XCbM6UcRF4JnlNwe4b0WmSiVdtUXXrrE+4QxBi65K6WewD6f4nvPfiJ5+VCiKVV007N74tJ6qqnGfXpcIccf6eB5Ve3pZL/4FK3SSj6Poot9/cNbCm+buGshCRiLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei7JZ3uOuDT4M6a2noR8wB8MVM/qCScVH2hRonPl7Rg=;
 b=pzCNNi/V3GZ0AVJ77QIH4uUfT6vGuqj8QTJIFosGl78PZTNFJdon9fIY6eblJG5LAoJX2E2g+Gzcpj25t5viYgKTZ+0CfOumPCW2Tq5a5NuhlO7ZpT+mQRRLX5FlEqBJ3ZXUTWKOCHhAQf7xtFcT36VffR28k/fiRlzI/UxmtX2MPNOLisb0rYpEX/Ygeh+SkebdbEvG29jYYZkgE30vtm/7h1kxkDqdE0xSENYZyBoRXygxbSdUVlKF65K/ElLphJwNqAcjBl9hR0z4L8bwLCg6q1gOtGus+aLne2rizWDzfJ4qa+xd2iQRorDC8L711YXJzHqK1219bcUI26RN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wayne.edu; dmarc=pass action=none header.from=wayne.edu;
 dkim=pass header.d=wayne.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wayne.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei7JZ3uOuDT4M6a2noR8wB8MVM/qCScVH2hRonPl7Rg=;
 b=ZKRlfxMDKkqxPedZ4AGaEaSsIQBsKDUpIvVXNmiY91K5ED/hUGbh34Jq74b1zTIA6PpJV7uoeBCgEIH5LLy1+u3GbBb/IwiMka/cGw6Ts26SkxEptoxOQg718dhDbQrr0x921kXl5Uo4gdVapWPn6m1KG3CJD3unNq+pGRQRU966e0opkl2+Jdk+/XTWU3SN+1hW0KzH1qdJ6mugN2PGxfFbn4o10HQkc5UOfUQAszSfzJIA7CP8rckpY//r/RVvIGTxrqSsXAuJr6ThGczwoaZkWN6Msn8BdPcwIarC8eWY9y1yESbNYNNeRpaWLHhGpeAAyV1+mD6buSrs2CvgrQ==
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 14:56:51 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%5]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:56:51 +0000
From: Mohammad Pivezhandi <pivezhandi@wayne.edu>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Problem with using CPUSET along with preempt-rt patch on jetpack 4.6
 linux kernel
Thread-Topic: Problem with using CPUSET along with preempt-rt patch on jetpack
 4.6 linux kernel
Thread-Index: AQHbEO1oXbX7PQYGHkaZdapTvMB3NQ==
Date: Fri, 27 Sep 2024 14:56:51 +0000
Message-ID:
 <PH0PR11MB5830EAFF75D55F0CF20B035EDE6B2@PH0PR11MB5830.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wayne.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: b98b539b-29df-464d-ca6b-08dcdf049e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EigZ1uxy7q4KQAw2LEVqPXG4UlLsOucZG1wRXpqzTOqEm3BcQLgg1mEiWT?=
 =?iso-8859-1?Q?Mqf2tegpX9Xjb3zSO56ZxOxP5ZnCYZGhRehK3wFnt7eP5SQddo6STubetC?=
 =?iso-8859-1?Q?SujNQaBJNFw9AM+W9VMIyVGHTuMTsHfhzL/AqTCOkV8YjudhIH07r7lU2N?=
 =?iso-8859-1?Q?uEYgYM3KF2Z7lab/MwPU3Od2E6rl/NTtvr+SCDKAaRjyWc/Tay1SWErXsP?=
 =?iso-8859-1?Q?e3iqo9DuS4E/VWN8RNAny23R2l0p3i9Tryrng37NcKsJw75DQUNgc1fffU?=
 =?iso-8859-1?Q?j5BbhikiuEYvKMtvJ9AYOICjStVz4eG+w4ykllAb4ku0xbwRs4tmMvsGj6?=
 =?iso-8859-1?Q?GQW8OlwZKOZeRhSGBuP4H8rJVZfTaQLebosFumT+gh+Pg9KiHlnVMXAJNs?=
 =?iso-8859-1?Q?R8l/8VD57wKrrek+2QfL/avgpK90NEVqJRAoAs1vQy3sM1k6vrx5x9buF3?=
 =?iso-8859-1?Q?jHEjLZGyHA9BBoE7TdarsqKTOCsx1Y4Nwgnu2emRrZNz0pLNodYYD1gGKH?=
 =?iso-8859-1?Q?OZAICcVab/+KNlcRmCXzbUwPDvUIIpy3N/7ABLj1pELe+ZpquEKk+yFEM2?=
 =?iso-8859-1?Q?902P+8UVGhAQqioCYOZZ44SBAYvjl5auBhpkfsDfMTw20+TMCwqMmdzCQh?=
 =?iso-8859-1?Q?8A4EUXm4olWrD8cGHEqXJ1s8kzyMwLmn8roLAqIvuAW5HM10Ca7gldCDSZ?=
 =?iso-8859-1?Q?eD8mLRbLrny7ESyIxNGOiXvQP/e/6afYM/mZYM9p+8iN8j1GVUDlpnDNTX?=
 =?iso-8859-1?Q?0BVfYmO7yhpH1j9rRqIX74oUzyvUqjY9tWz2jJTk7i5ruYCncAenfeo9N7?=
 =?iso-8859-1?Q?houFsBjrF8iUSKei2j91MaGGkKjP6x66kbQKnBV15DdFMVlybNDmPqyRUW?=
 =?iso-8859-1?Q?orW1dFsMXVVXkJdfh3ltG4DezZQ86UUKsJCw3gxLJEbd1yVFB1Jp7Snm6l?=
 =?iso-8859-1?Q?7XvoxU83X5sQKPlcBq/SeJj/HdXOngJ4QfzlSNJ8JW4EAVcSqyeibHi+BS?=
 =?iso-8859-1?Q?iosjZ8NLPCBTPkJeKIkWEJuTRK031+MyU32UgZ4Fu3oz2MX2pKS+clXh1B?=
 =?iso-8859-1?Q?/riwCAH4VJOPfiHxCyTKRjzkEEuWPH+q+YaXji5FnrRyz6H8x02ntAdbOm?=
 =?iso-8859-1?Q?YFB8/peuu45x1D2/fu82UML6c/ZiA207IPBcfSYpHw1+SZPzQxQ56wNKGd?=
 =?iso-8859-1?Q?6vjTBITB0PbkJc9EjD4zkTp02Qp9Khwb0yUQVf1QK1+sqL7tk9VuyVamyC?=
 =?iso-8859-1?Q?qr+k77tpATLp7nvFf8jAkYCdPYM9cwGsFvmACNfxlGMSo3RfJ8B7pKs/Ob?=
 =?iso-8859-1?Q?y7ZuUPDmFxjELq3jJ+17ZtE7Md6iD4gtuHisOhza8oA1qjd2qGrYk1Ymu0?=
 =?iso-8859-1?Q?V9o//5uBv/lyaBLa6TvO50Pa4vJYgiZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WBhK+XXSfPBfKJ5ItEtaYWxMsS5fhGApPXLWPiMABze1bHjODmWvZqmb7r?=
 =?iso-8859-1?Q?2TYl8+89aK2W7OYMUp0iVSSgnF2vsc3YaQYhhkmRmeRSbpts87XPrESv2L?=
 =?iso-8859-1?Q?uMSo4eU1YGVeXXRBZ1GEut0caEIycODklfhoXt/J+lY0HCW1k29d9fAIVZ?=
 =?iso-8859-1?Q?JHOEqths0I0leTbNkZ+WwrQRRX1bZpilc9hfiBf+D/l2bxqC+dfVMW+ttm?=
 =?iso-8859-1?Q?gqsSEewEGN/wKu8jN1Qx0cNvrooTmbwBbWV/j5aKlT6D3CnuSsbwW0DDjY?=
 =?iso-8859-1?Q?wIgOUsPtepGg9cicNnU2s76Osf0/EmOk+dyMNodzVQsuxXy0m/vw4LIVIX?=
 =?iso-8859-1?Q?AjNn75Upp4yE/HGCldwv0QYxRxmVoiiJb+u29Pu93whzR6D9utcjDWNsvr?=
 =?iso-8859-1?Q?Vk9PAPUucm+65O0cCxoL6uGP4hz0ABQBQpAzHQ3MJmCYPqhFsdwkWTARIR?=
 =?iso-8859-1?Q?RXvd0m/V4RWDkzDo9EdNzRzXlXgbk7zqte869/9Wj2AxbsyEf1vuJYu3pp?=
 =?iso-8859-1?Q?Do+sTYr7eV6D1zXjd5UlXnCScUHWOijdijWak9CPvdHJOEYFrjZEwBi8rQ?=
 =?iso-8859-1?Q?zbi0/J3veZtRiIFqnLim3x/6abOwVoZtkRqNxYldYCXmoIAUuNFtDQ5g7Y?=
 =?iso-8859-1?Q?p94vX+4HwBt4JbI9SdnvFw1/ry+F4wEswKFHseCFPh10z0Pcj5XREiUHvD?=
 =?iso-8859-1?Q?3LvjlG6huds0oQwvCd4WW5zFEwH4IoQOSHnr8r5G2ms3aFRnkuGgzENENO?=
 =?iso-8859-1?Q?FOTvNkJuJEQif7FY0a5qi8Skh6TR/+AYxOhAGX2rJWa7OldTNJXv3tQmaC?=
 =?iso-8859-1?Q?62NXHGV2vNsYPEYEoeHHpqriFEonwOtgkZzddCjjkF0hex23TaJYIZSL9S?=
 =?iso-8859-1?Q?wSskh/k4CkBU5qrG06z5s91EO9oXiTaEL+uXDpWBkDNqNJKvnR17MU2rxE?=
 =?iso-8859-1?Q?mTOSmUKixuijvagZ7Ovjt8fKj/Do1xYnvpCRXS5BTaS6QkTOkhZhJIuvg8?=
 =?iso-8859-1?Q?oHWw6xrmYUCxuqm/E4kSs/NssUMuBjMW4SxurFvRlDd4qXvgE+TN+ZMSJi?=
 =?iso-8859-1?Q?V3lgq/DDvUZAk29m43LsUxxALhaM9JMxZgeYrdT7ZhzH3ew7gDDnAiX3cs?=
 =?iso-8859-1?Q?iN9Fz45Z3qc5FRgATq4Qs7h+4WcOIXLIIFxlZ+Fo7vlHaDfhTORtfJnB+z?=
 =?iso-8859-1?Q?MnjcEypC7LOEEUgXirPvYwHpiJwHHviUZCO4Yk0LEkRJH/KTFwDZP16URP?=
 =?iso-8859-1?Q?1Rm73BlQ0ER2Dcr84G3MdbLh/pBJLjhDnX6mj4PwIK8ZICt3CIWNagfid3?=
 =?iso-8859-1?Q?9yk0h5JEm8dQ1K/r4NikTxMTWuNz/3Uk9GJP+V/V0tIqDT51Y7vVyCc/S3?=
 =?iso-8859-1?Q?xSzNWutcBNMGBTpesXGPFQZDUJEaMJbc7qb17FS+eX7/GRzJJGKktzgpCL?=
 =?iso-8859-1?Q?Jlkfx9j7A8D6GsEO06svtT8gXIZoV4E1om79XbUJDgVgdCR+20mW4jvTRt?=
 =?iso-8859-1?Q?KxH9/2+2EpsQWnCcnlQWYR8wuuC7RG9vbSmSwMuMqCwfTZUFZuXxVuVeLz?=
 =?iso-8859-1?Q?V9IsePd4OdAMpvhk10NpfMqGpNwJBCZYuzzepzaorZBKb660M3xeUlrZtj?=
 =?iso-8859-1?Q?BcWiUuDiUf9jg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wayne.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98b539b-29df-464d-ca6b-08dcdf049e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 14:56:51.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e51cdec9-811d-471d-bbe6-dd3d8d54c28b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAamgdD8cdELHWyBxjQOgmJglTMHGQfiDVuuRDiDrSZI/ivWC9c5oGh2rkDvlnFUudqTw0FH+i+0q5AJNSFjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056

Hello,=0A=
=0A=
I am working with jetson tx2 and got issues with cpu isolation through cpus=
et when I apply preempt-rt patch. I use jetson linux 32.7.5 from jetpack 4.=
6.5 and after applying the preempt-rt patch it disables the cpuset for assi=
gning core to the tasks. Without preempt rt the core isolation works perfec=
tly, and I am wondering if there is any fixation to my problem. Thanks for =
your help in advance.=0A=
=0A=
=0A=
Best,=0A=
Mohammad=0A=
