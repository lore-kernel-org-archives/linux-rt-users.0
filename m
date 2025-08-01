Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D802E36E5
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Aug 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047422; cv=fail; b=iLQyTgiRNOlVe345pnYw81sJuvAIW7z2gP+TuFvPl1/hDeNXzLAW2BMLykG52iaqhDZFYceL3su4tGaylf6ReW0sKCreQmL3MxOVLDILEQJu7SxTye8Px7kQYLo3PPacT/JGKxV69yaycDLm5qn5fszHv8rf05ocYC7yR8PItTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047422; c=relaxed/simple;
	bh=Tf0XP3vnZS+yIUUwPqEa0R57frZDkmzyYxctXSBvdR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzMUeVm9tJ2CcwHb7qlgVDez5aId7m0h2hx7bSk+InpqmufuW6Thf7qQhKrBE2vQpr6JcI2RsWRRuCSvMe15YJvg97+nvbjRRszc5wvRxvCW/hyiJ2MQBdj/n3mMCD7KgxWV+3ieK8zQUHcJx9NBmE2p9Sck32/UOC4Q6mNBqPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=0u7iZDlU; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="0u7iZDlU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2DxJiCsIKFz6asNnwj0tGfFl/TP8fLFBri4UUc7+WlxCY+Y0FRZXuRD0ZTr9N6p35FZmCfUZ/Pf0mK/Fk+8fYYd92NzQgRTgxVgA6P/DLB3fiKiau2M8rzEdU6xFREHrEmrYFlyW2X5dGGUHkT3Rg7BQ+g5PjGQZvyPR4cmHQQ+CvB3/96KKtiGEJgF03OkMjnZMgEvvd7fnPXVCuH46IACuuAyJ9+J6Mt0tJAJFoEASp/YVyb848mtxsKEMikNnSeBYxxDJ9deDszBGInA9uwMj7sNlgM5ZKDYLmaK9D14wkQK9DjdpZHwTchGShlY1+xqb0CD60nVprpxea6OrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enCxvAYp2RBnpD5YdyzKTQJKaFdPxVItCFe73pGs/NI=;
 b=S1iMxr0igUTRGLTKCIXqpv9DJtIUDDRxDDgtktzJgDdjdS2jl4fp+zVJTvutAGpvyold4D5W4CJfxV5abdwcV3a7Kxw8z4RWMiL6noWfK4bCrBMtvOdMZEkPARKQXeqCM8xhLxNczqngkYUhJWOJJIdHvK0Vbo5S51HsyjiEV2C6Mj9dpO8JuJt0SkibDD5w0bLHnARWt/iVvHGHYN98Z/KsBFL8bTp6iXLYYPYL2pH5RbtBqaLTehNul8m6sCMNwK70tT37697Q1nXqEQXKCv4gvc88AMjT5DAAIVX4Yv14F8KXhrvu3V/C8fdcavDz7ySc3/d1RvFDJ8P+T563Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enCxvAYp2RBnpD5YdyzKTQJKaFdPxVItCFe73pGs/NI=;
 b=0u7iZDlUrPttXje3ry95bzIFnWB6ls7QUoMB2HaxtPKjBm9VImTDfkmljvnDzPUpjh25lh3gXtYH3rjKwwRgzO1T4M71j+DCOP4O803873QpUKYXhpufjkPXNi9X0b43/kBqaX+Cp2s8UgikwAYgTtnqTr2n7m+grmrxvlB7OUqYLe7FudKLWrVqrCh+jGCtMwBQPid1TUjGwBQ9O1JrikY8OllBF2WZzU0r5ZfSLnYDPgKmJ7QqXrj4ht2aTsnbnLrxXCRKB+C2CkS9ywdIDpt2FUD7fniKGVPCbCbmO9iA9X/RtobIOiNRP7pLQaaWSCuWiRbpEXKbEcITdTmacQ==
Received: from DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:322::12) by DBAPR01MB6725.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:188::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.5; Fri, 1 Aug
 2025 11:23:37 +0000
Received: from DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 ([fe80::27a:7a68:5d97:fae3]) by DU0PR01MB10385.eurprd01.prod.exchangelabs.com
 ([fe80::27a:7a68:5d97:fae3%5]) with mapi id 15.20.8964.019; Fri, 1 Aug 2025
 11:23:37 +0000
From: Alexander Krabler <Alexander.Krabler@kuka.com>
To: Vlastimil Babka <vbabka@suse.cz>, Mike Galbraith <efault@gmx.de>, Frank
 van der Linden <fvdl@google.com>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Dennis Schimmel
	<Dennis.Schimmel@kuka.com>, Daniel Braunwarth <Daniel.Braunwarth@kuka.com>
Subject: Re: Realtime threads delayed due to kcompactd0
Thread-Topic: Realtime threads delayed due to kcompactd0
Thread-Index: AQHb/SUMECAAoxVz1UW75TJas4YXXLRMmU4AgAABygCAAIeOAIAAeK4AgAAXRlk=
Date: Fri, 1 Aug 2025 11:23:36 +0000
Message-ID:
 <DU0PR01MB103857873A56FD121984568148226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
References:
 <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com>
 <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz>
 <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
 <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
In-Reply-To: <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2025-08-01T11:23:36.331Z;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=0;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB10385:EE_|DBAPR01MB6725:EE_
x-ms-office365-filtering-correlation-id: da8dca1c-f12a-46e0-8d18-08ddd0eddbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VL9cP5AHOI1o9HdDFRCHTiZzLVNb/DTuQ7Jl9d5qMaHW0/DZ6iVYuMRCg6?=
 =?iso-8859-1?Q?V+2naSAZxGE5t5HKhjgOd7n6Vcztyi+kw0Qg0L0jAONaIX89ieNvldmyFH?=
 =?iso-8859-1?Q?XuT12hPAapvIMM3IyTiaxPD1RJv6G+UjG+mwT/43b39BpObKR2UUXoqmga?=
 =?iso-8859-1?Q?N3AyEG0wP8OgRWFtE3uTBPKhHUPc5bCPESmkRsQ3CWyNK6H+oyFQr26HsW?=
 =?iso-8859-1?Q?bWqBBp+xRf1d2iFQwpvzgAKVMcT2Z2gNczGBD04u4nFtCpJXBlYcy+OnwM?=
 =?iso-8859-1?Q?yyU+x5MynSayaSYqxAnm/xtQqIJpubwFnyaw0QHjWVXJ1JqS000/xwqwsY?=
 =?iso-8859-1?Q?U17jyznKVAtm1U2godOY3of7vV1fYxdS1COm0Dujs1ywy1ra61pXwtc/29?=
 =?iso-8859-1?Q?nINHY92SGuhA3nPtYmz2iulGOcXXtdv4YxwEq3l9lXK+L7qNn9m6AImYzY?=
 =?iso-8859-1?Q?tSbH/4eMGEN2e2Xyp9vBE5jnw2qPEr6Q13NVczOwNkDeWNziQtsBoR0+0b?=
 =?iso-8859-1?Q?odrxWZ4O/QFTgVIkjETI6YVrVJIdkla3Q7WC+8PFWjM/RREuY9OG4gesgF?=
 =?iso-8859-1?Q?zB+pB3vmIiJo33N0miLOhvimddb+5NVtfPYqQmjh3VqlA7jcGrNG+qEgOC?=
 =?iso-8859-1?Q?NJ36L/MANB3RnB7In77tzbvxZJq4zTPyFoOjlM2jEQMaqgJ2pfMlfCBjLQ?=
 =?iso-8859-1?Q?YfHV4OwgzjgzuUQxu9V/yHtXgu8yFjROeL4JdKPX77TBTYV1UNtpkiW754?=
 =?iso-8859-1?Q?+XoQ57HlgI6VKiLgtV75lJ79i1V8SsQn60DF20kYvkNiud+DqjtmXJglHY?=
 =?iso-8859-1?Q?1olR2GVHf/1SdP/sQdJDusGkX+sZjP8gXN/i7yb5P/zKY9twpjmea/WMFn?=
 =?iso-8859-1?Q?iyc1bVBNAJoF83uGWbCLbxCFDaRsbhJbFpQ1Uaen+ouhnhsZ8jI4mY71yV?=
 =?iso-8859-1?Q?sdd9z3E0Y3mBYU6T/TQvMN1+gmN26qZmuX3gz5DTe/15bXrhda+NOmB8rj?=
 =?iso-8859-1?Q?LJsmvapg7Bo9TM8qRngnFyHh7/POohst9HjEZVZpGV8GJXixmovSXxdzyK?=
 =?iso-8859-1?Q?dFF1YXd0lR5gQvQebH1bTBajPXeqVWwBDu89LD/FMrjB0rrgj9YFTjL98O?=
 =?iso-8859-1?Q?tSlRDmcbc5hzIIzfcBV3cm5Pqu+s6CDRbCCp4VqLJzCxGhInUrIsJTnWMT?=
 =?iso-8859-1?Q?qJTmFFRVXPfof3tO4K545PRjnxjCzl8qvQDgqNgpSvwneNahwwZ4basSwa?=
 =?iso-8859-1?Q?ymNF7eNjq46j7hDmmJ4iqKcUmAcdoJx8VM3VG2agHgareoqN0m0YNuwR6w?=
 =?iso-8859-1?Q?1+DVj0Fsd160bdPhYF/GCltY0AbIoui/b6L052qHXDI/YI1XUhmxoujCOc?=
 =?iso-8859-1?Q?15bXAwVm51NpId7Yq0xSwRL27mjobsnyWSxW/jFpcAcXy2vhm+jn66glRy?=
 =?iso-8859-1?Q?QqJ8De3B2RiX5lUajQy18RGSo5dTkbp2YioYC6JObu+vOswrO69H/In6mA?=
 =?iso-8859-1?Q?j3vQcL+9SFsGQO7qH+LWTqPie59zNRRIWr1FD3ayhyVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB10385.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KbWEsjtO2vfB4pp9aiulziPU2+CdhVJ8aDX4k7UATxY/c0efyE8VYc7aEh?=
 =?iso-8859-1?Q?lSVyh1A7MXht36WtQqHhvE6PeM8hSLbKZ/mSR118rqvn7wJd3xjieCMn5v?=
 =?iso-8859-1?Q?W77PCUxH+GMZZ4ZE529Hx4Js2gzQ4vORfAP75dF4hSnJsRD+QZ+ljBz6Ek?=
 =?iso-8859-1?Q?WfIR/wzo5TDzGNWmefdiWua+V9cn/9zPCitHwshwj6cXVDPo6VQJsX0Vnk?=
 =?iso-8859-1?Q?MigzghrtVWvNZigR8hZjCKgL62RBbOCeeg2FaNqLiPY8ZPVL3Ec3/WuQ3S?=
 =?iso-8859-1?Q?bsvFdfO8hMGv8a2ovX+WV4NAVN/v58lzmGvOPBb1BJAtp4ZGEBm6OybcLQ?=
 =?iso-8859-1?Q?r5e6pYRaRqYdrj56GxhVf90713PIkxoKPtJM5VHQlb7zWxRKWN0TBLxvwo?=
 =?iso-8859-1?Q?v4CP5+uq5fWymzdhh7VV+qbpHKKnlPZZjZkOwxIsnCmnNeET6MjWw2rg10?=
 =?iso-8859-1?Q?9Sw1zCK+QZHAT80DmmbqYL/WWH4jnOjYEv0PYQrf8SLD7pkN3V6XVGtaPo?=
 =?iso-8859-1?Q?Mr2b246ccF60rnmSwQSjHFEDoGxwdyAyuN6za+/wLh/wFklHubQHTDzRQE?=
 =?iso-8859-1?Q?GXEL6cG1VdGeJ82coaNXB5busTWrCxYGtvnPNjtTpV1W5micMjMvD23ao+?=
 =?iso-8859-1?Q?GZl/6/aVliAkMvsoJrxAMJJQQTNNBJtf0Wz33CnqMtyc/PlLwVDRYBmwpf?=
 =?iso-8859-1?Q?6iYjQc9PbLybghMBBo/EUgm+mHrLYzhmhDf6IeuUs5kIXSeGg98ugA6ZzP?=
 =?iso-8859-1?Q?zE9gxE8Em7wSDBIGMFsSiqK3iUik+xh2AXNoPuajyO/OJWkXX6hiukhdJb?=
 =?iso-8859-1?Q?kN08Y57hTnGCkDzT3svpBRdZankob8dRWDjjPYs0WrmGiawBxomXBpH83u?=
 =?iso-8859-1?Q?3/2NKyGAfiWGzeVL20s3pQoAcy/gyo5KxuZOC8Y2133v6v0UpPMjJWpD06?=
 =?iso-8859-1?Q?FLGEav+xHFVlN+NQicAx5OyvQTyNKrTZ8q4DLHQu893Ra/NnBj0obDfwdd?=
 =?iso-8859-1?Q?+Bs6K/lZt+laFvFg24AGVw3H60F8YGzlLrNaO8F+Pk4lwd+RbVn5KuG6mU?=
 =?iso-8859-1?Q?X8GenK4MIgpPvc4FjUVqv2J7bHFsNNwiR2SW53CAN+ATnHFs0zinsi78Ml?=
 =?iso-8859-1?Q?Ll+aUT31VO/6NHKD+lc9S20P1AMchuIvDOA1yQ9M0DasK7Vypc7dAbj61S?=
 =?iso-8859-1?Q?YsOOPDIgezsHfkJiyYfl8kZNrraKLstxd3GQ90q/1Ivg7lgaP2d+WshL03?=
 =?iso-8859-1?Q?8haYfdwJwP9nuEHGB1q8xKbnv5htqgYRpamKUK+Bhn1XEwopdR3izCbVhE?=
 =?iso-8859-1?Q?dy8P1RCg7FIEibPiYOHf27842WOkiUE4BKw04lgqFCdDk3Or0/oxcDs+eb?=
 =?iso-8859-1?Q?iPA+RVf88wX0fwGskolPTYo+rqaX8hah32hbS1Abk3NH7YAjsx2rJq/msX?=
 =?iso-8859-1?Q?ILchM+XUeiYLZDerWadak9m0x3Umi+LwPxi6MVgpU8pNRfJjGzxJ0MNlXy?=
 =?iso-8859-1?Q?008ZeTQW93Kc4Pk/uDydNibEwFpg4oIH/5AxRYyO2jloIlPmuLC8EJ6SXH?=
 =?iso-8859-1?Q?9Tmk9hfYeF702TXrNV8WhkdV4BrD4cihctjdgbSt8/Ya60pvMLwVhNVej3?=
 =?iso-8859-1?Q?pWNsJz3Fr1T8Pn3Ob/N2BVf7niAT1JYptC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da8dca1c-f12a-46e0-8d18-08ddd0eddbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 11:23:37.0004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHXY3uO6OYTkiuf9huQagpWYR1CV+bMFKoMffDGPpTDSvY+wv1ZFHwHjHZ078Se3xmaiFo7MRFJTMPr7Sls4XQfjFP9uqGFI64pwlXnkQzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR01MB6725

On 7/31/25 20:35, Frank van der Linden wrote:
> Not sure what the right thing to do would be. Either explicitly boost
> the priority of a thread temporarily during migrate_pages_batch, or
> mitigate the issue by dealing with 'busy' pages more quickly in
> migrate_pages_batch.
>
> - Frank

I think it would help if priority inheritance would kick in as soon as
another thread is waiting due to the migration PTE.


On 8/1/25 11:58, Vlastimil Babka wrote:
> On 8/1/25 04:46, Mike Galbraith wrote:
> > On Thu, 2025-07-31 at 20:41 +0200, Vlastimil Babka wrote:
> >> On 7/31/25 20:34, Frank van der Linden wrote:
> >> > Not sure what the right thing to do would be. Either explicitly boos=
t
> >> > the priority of a thread temporarily during migrate_pages_batch, or
> >> > mitigate the issue by dealing with 'busy' pages more quickly in
> >> > migrate_pages_batch.
> >>
> >> There's a workaround for realtime tasks. If you mlock[all]() their mem=
ory,
> >> setting sysctl vm.compact_unevictable_allowed to 0 should exclude thes=
e
> >> pages from migration by compaction.
> >
> > Hm, per documentation that's done automatically for PREEMPT_RT...
>
> Oh I see.

Yes, vm.compact_unevictable_allowed is set to 0 in our setup
(default as we have CONFIG_PREEMPT_RT).

> > On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fa=
ult, due
> > to compaction, which would block the task from becoming active until th=
e fault
> > is resolved.
>
> So it's probably the mlock() part missing since that should otherwise app=
ly
> to kcompactd.

We use mlockall() and I verified the pages have the lo flag set.
Which means, that we have exactly the issue this sysctl flag should prevent=
 us from.

>
> > ...but rummaging, seems other stuff can step on it (contiguous alloc?).
>
> Yeah, there was time CMA was just something for mobile phone hardware. As
> usage increases beyond that maybe we'll have to tackle it. Ideally by not
> having mlock'd pages in CMA areas at all. And if contiguous alloc is
> attempted outside of CMA areas, respect the sysctl there too.

Yeah, we already thought CMA might somehow influcence our issue.
We have 256 MiB of CMA, which our hardware probably uses.

Is there a way to tell a process to not allocate pages inside CMA area?

>
>
> > -Mike
>

Alexander

KUKA Deutschland GmbH   Board of Directors: Michael J=FCrgens (Chairman), D=
irk Busch, Johan Naten, Hui Zhang   Registered Office: Augsburg HRB 14914

This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure or distribution of contents of this e-mail is strictly =
forbidden.

Please consider the environment before printing this e-mail.
