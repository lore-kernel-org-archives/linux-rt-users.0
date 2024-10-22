Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227319EED0
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Oct 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607226; cv=fail; b=Z7kOyzlScUDtKrRcb/9+NUHo119Rz1wcMJ1qCBz6HCy7vB/BjNF/MQaaW9SiFwJcvyQI+0smXOZARMXLgXsSUiKMvm9wcbUvFKbCnTSHkMeGzWnI3yIevRFpoTm7CwHW0cmaT1kw3mXc3vZ/bycBbAW+Qs1WH/FbERG14vQpKz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607226; c=relaxed/simple;
	bh=sDgfIk7i3ALWKQY6AHvlaWpQYzPxm51NM0nXt5JIOTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aKaYiRiM66GCioUIQwwpR25RHstxZLokmypIqZRUlhjQaN+DKRZddb8o0Unid6Y0cCzuxSTv6Mt/XXnebFDaKEcTYdYlDp3M6bYphIzJYTfSlrsNfQpSygcbTJbwz1Fjb+aXe3ePsEpC2U1OlaP4Is5zlyccvEBzMvqRBd6oVOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wayne.edu; spf=pass smtp.mailfrom=wayne.edu; dkim=pass (2048-bit key) header.d=wayne.edu header.i=@wayne.edu header.b=v2XQ4RVB; arc=fail smtp.client-ip=40.107.94.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wayne.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wayne.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wayne.edu header.i=@wayne.edu header.b="v2XQ4RVB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYiLgY1bXMTgWjrx0wrvz0MQtgOyHZwbmFLtfTTS82vBGXX58eBtbYx8FpDuuJ/AOguphIbkVa60XKxjezOXtuPlI58n/HPohjxk77YxfWnddpINGVtnNpzqpck4zH9QLoloyP5iL+zX6Si4KHkAxEh9Px6gpe/lbE9MHHqVtm05JeznZwFcr1QkVQHXwg4Lk5sKDP/+0/XCZOnKnBdmqircZxUQ0wZVBBCw0NF8lDlp49yN2lwj87OvvZh+8dfHLti34vbui+M+E20BqfsfIsZYQin88G9hyZO80/ctzH3zaNZReKuzappzoCiNNlAvqeFelVjIvAIoFcXCM1lY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDgfIk7i3ALWKQY6AHvlaWpQYzPxm51NM0nXt5JIOTY=;
 b=rzRToY3JK2YLhU4zN5zDv7yJbzrhITv1IoVzTXfzDxbZ9sb0NbhGNF3PKCfSharUfGAa7P8NNTEI2fHJFAR+eyWAUpZP/a5242o+KJu32yVxWw9E/NhOSyaYtYCGN5T8k+g4kWjvKVRvV8a0YtzECmCOkhZOv6YFQnbPnalqjWN35dsBA1kHCHdp/+bJuGZSQ//trctNmHq5mnhalr3q7y+BAcg8Rcle+wZR7k9l+/HK/7w7lT88OG2WtzoLaHc5gjo8uku4kH6wBhyBt1K8RjHS0/MoommSeQMWqylaeBamdORJHxuh6QYOUGe5bl09f6wL/S3ObVZkaxDWImwKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wayne.edu; dmarc=pass action=none header.from=wayne.edu;
 dkim=pass header.d=wayne.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wayne.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDgfIk7i3ALWKQY6AHvlaWpQYzPxm51NM0nXt5JIOTY=;
 b=v2XQ4RVBKaZcaYTHbfkeNqarPAb7LvXtPeJTvhYV5luFzgGmc5moWUZhNKk1n5is0SZaVJLQ4HtZvcx873eUNj77yV6cDkStjfFq13v6zwi4DfvJQe4zrUQ9Ca1FXg0jak+7KbaEzbxFO8rZucPXdDe/umyDgtycXxSuZ3Ev661MBtLxfgbSKCL0BpRRE4EZAGZ3kNLio4NkXMecwrCalD1Ok0SOjBwvhnpZU4vY/fF8DWvZJT7VzjWsfGePYYFVGFV+8F1r9Wh691W+DQoyio0eVYwzW4Cost1rS1/T6C2Xq8E6s0/GUAmV9EGCtCeLTtWYoT8ZIPH51PCJQo/+uw==
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:26:55 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:26:55 +0000
From: Mohammad Pivezhandi <pivezhandi@wayne.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Problem with using CPUSET along with preempt-rt patch on jetpack
 4.6 linux kernel
Thread-Topic: Problem with using CPUSET along with preempt-rt patch on jetpack
 4.6 linux kernel
Thread-Index: AQHbEO1oXbX7PQYGHkaZdapTvMB3NbJ2OFqAgBzCG9Y=
Date: Tue, 22 Oct 2024 14:26:55 +0000
Message-ID:
 <PH0PR11MB5830EF5266EE9F931790C2E7DE4C2@PH0PR11MB5830.namprd11.prod.outlook.com>
References:
 <PH0PR11MB5830EAFF75D55F0CF20B035EDE6B2@PH0PR11MB5830.namprd11.prod.outlook.com>
 <20241004071451.-lAqS4qJ@linutronix.de>
In-Reply-To: <20241004071451.-lAqS4qJ@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wayne.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|LV8PR11MB8698:EE_
x-ms-office365-filtering-correlation-id: a36b2afe-7d88-4422-a523-08dcf2a5948b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ad88U+m56/aWnhqLpEFvUE7pRcf069Gbdv64AHs23DpmyCyKvI6W1kl/kF?=
 =?iso-8859-1?Q?pNDV6hjReG0rdwyLCWPDd51NxaIJ0iNlZcYk8lTaWeYooDrWXMo+xT3mA/?=
 =?iso-8859-1?Q?4eksL32mKHdiHfFz0oKLslVd+MJHutVPpc3yKW6bVuQVP0kmeWN4nntWrT?=
 =?iso-8859-1?Q?Nyi+2Fwgk9XmTyfKufvQvaf/l7BTcgbkNvYEqDSGwVSe9egIhA6yoggybx?=
 =?iso-8859-1?Q?vJswAHRTQMT9j3P5cpeOPPbfErmPF6O25YFcj0YPvQAdv55kxa76rWJQUb?=
 =?iso-8859-1?Q?IJ8eYIVa2HOCphyw2HNnUjocjB3UKpNycy8srFDhJcFC7QGdcZDe0bWWzg?=
 =?iso-8859-1?Q?CfT+WhuAPOLbXP8lr3HpTHokjgwzYPRA2swlri0XqkJAZrTpWkndGqP3UV?=
 =?iso-8859-1?Q?nLu1ertvsv8sB+FQTqUHyBA3GMU3nnqy4xl5ZWswRMRAVUMDgtYjcXGqdp?=
 =?iso-8859-1?Q?XOBAwpvcOuO1YRVIw9wmprwzono2hfBlorAjG8k3ugmsDw2aPc6dhRHLXY?=
 =?iso-8859-1?Q?bBfu2Wuw+QAcnuMw/XOaTVA81sFjAhINT7qeqibGRzrdiy0JYvnBOpzJet?=
 =?iso-8859-1?Q?enOBc01qc0xfDKIyiCFYwsa0qbceeqg88PB2/mLzyPTsg4J9RvAKMVqyqZ?=
 =?iso-8859-1?Q?4I9hdshrj1NIRohhRGORrRXhvtTA13/LuOe/SoL6niPr27+wVF6g8rXWIW?=
 =?iso-8859-1?Q?d3IEqzt9Opbe4mGGbwFvd/H+HIM+13YoKalPqI/Uffe08B6kEN+Dc4J8+7?=
 =?iso-8859-1?Q?pcTH/ygNFdVUwUA+xcLIvETZx5V8dmqdNankkQ519Fmi28D5rYqtIn40ju?=
 =?iso-8859-1?Q?ZwvGbLkhDe42N93AmHaYi1OX0+uxTiGf+34eH/DyZFxZ1LyQj98fZG/+ue?=
 =?iso-8859-1?Q?TckULKZ9Zp9BW48/kb7rVnnhqYO1k/bdUVmOAJZFGswT5Is5ZeKUNYMkpB?=
 =?iso-8859-1?Q?BgYSvmYK/0oohp+L+i1lE1+qZIAiQmET8QoT82dKKfjyNQZN9vExPCBJSL?=
 =?iso-8859-1?Q?SU7er8adSwLSZqga/KUspPbxSI/ISNPD2zZXNy68tHzO1Xg1dvRIff+sjY?=
 =?iso-8859-1?Q?8zRerg31RKma7VMPFyaVs490q/9qpFyWi9PPOMNO2zzSvbwRENDQecGxco?=
 =?iso-8859-1?Q?+IKKOJRImDzc1JYxFmGK9FIo0OhHnJl8uA/BRZBbXjKy071ePMSw3OodJ8?=
 =?iso-8859-1?Q?JCG/PImUxG2krVx8wKmDxAYfYLnSX2vW3xR5IkYoMHMVZtzaDut8KSzaBf?=
 =?iso-8859-1?Q?+MZBTV8IPZ6o0bfWpteG0qGZmijixKDqVUQwBGIQPRe36A9qD2CxUkDiJH?=
 =?iso-8859-1?Q?fkZNBD6l/Ltx5l3O8EbVAAouBMKbPKv6sEwtBhz0SDKi6+ThI9LODib8KU?=
 =?iso-8859-1?Q?w+CNpJ2EwCnXsdSVfWu6yJWP6Faf/6onaWQIOgviWcGLqfJyAYUnU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3Ak8j7spwswVd8cw5EHEA7ZkePWxoh9OKsRW0093QNyYSADIUh520Jv9AT?=
 =?iso-8859-1?Q?nX66KIzkQSFoyB+ZfeeCEi8DAOKTvtExoYRCBoxiMYmS+AYeAgNrFg5b9I?=
 =?iso-8859-1?Q?4R3L8pIJDOWzDBjLNZAxon6dqFVVzGBRat/I5pu6ZiKpVnzAsqrId9d0fl?=
 =?iso-8859-1?Q?gcAa1d08I2JvHJGZM23qQoLdUnbcC+Hn1waPPHeZbT6IZE/G+vxnqsqVLM?=
 =?iso-8859-1?Q?dlUnhyWLXlz3Owbj6yfF41SZBL40+W3TbhwtgNER5NOVjkAVReSEZ558KS?=
 =?iso-8859-1?Q?JD+30uDGSKPZWiskQTcq7MZ37pz1ASGhMVvFnwmusGoUUK5GTb8RIOZfIB?=
 =?iso-8859-1?Q?LEjIL9dMHEJD42amtIuZFEmBQrfokO6LN1nwUOqFD5Vni083Iqpmhzwt4q?=
 =?iso-8859-1?Q?u3qWtbvbmdFsSR6VfYUeBjmhCTcwcHNX5+ipIUBpkZJIjr89MBnavGQGfY?=
 =?iso-8859-1?Q?YPNeqZ6Exy2VM0E92Di7Afdv8QV3vyyC+CRXuef7o/VpCDNzSwxHVDV929?=
 =?iso-8859-1?Q?Ai0egF5PZxFWELGuHmPkoFXm5gRFMbHAIXc4Nx4zJ+Koz1eihCT6KrF6QZ?=
 =?iso-8859-1?Q?y628XkfpTY44qDYVqE1qJXHty+abnVx2JdEbHKJImRaVOvA6Om57D0nizQ?=
 =?iso-8859-1?Q?EDskCbaiUxfyZYf/oz2DpUCkIR+zvbmmQ8sq5xmtcdzrDBoIoVH/QPc+sp?=
 =?iso-8859-1?Q?29Gq6FrGzenNQE9771GysaZEnGVmHKshXBR26q7t13agI9HMYylxD5mKQB?=
 =?iso-8859-1?Q?9XYdxJxXcxdQoQKRbtm1+toc/t3wl2bmyZWX9pXB4A35ly8xKbsNnmMZhU?=
 =?iso-8859-1?Q?t/iwo96Yu0n0tQeRPzEdqcYLFqrHACTjmdQz+T1siGYYASIykDOfCCAN/Q?=
 =?iso-8859-1?Q?5BmUT7jYnb49x1RuzsJpSlE/SDDT/4IC6IgGiUQ6jVkBx3AcbC0p08LyW5?=
 =?iso-8859-1?Q?yI6ID4Kqaax0nVitSKxeeoVAYgmOtKicMn3mleMhaIY6JNvaZKmipaQ+Zy?=
 =?iso-8859-1?Q?SIPbrrGHS9xtcILbpFS5nr+PHEOyheFdbDO8Y78kir035Y4yZVxbsmduS4?=
 =?iso-8859-1?Q?4wkdOpASvzQkXU73UKgziGqzZbMGi3Jb0sK5xzzc5Zp9leROwFW+OPPDLS?=
 =?iso-8859-1?Q?Wf8CeJ6bkUtTfxEq2o9WGW07eFBMDEr+C1QFFdWCyudu6rXoVfD9hh6FKh?=
 =?iso-8859-1?Q?0r8CRruvRTcJKHAc+/dktD++n8yEm0lQrRVwct3QH27J0ZiZDDZKsr50AZ?=
 =?iso-8859-1?Q?j0C1Tximq+n9P/hxHHF6RQI4yQVRkioR4Cy/NTZBr5Q64Tt8k9flAGfwKB?=
 =?iso-8859-1?Q?bOdjqgX99E9sLmjp4sJLOvsQXxrbQ79N5m/ylFza37xfknq6t6QjT0fyWZ?=
 =?iso-8859-1?Q?WeEwr/nAgZPCMMjW0Jz1dZWAi8UXsiMI0ybaHLm8FA9Nd6L1+gNHZnsM/1?=
 =?iso-8859-1?Q?TndNraIKz9ECpuwycUj4YiTrYyP45WSEdYVIn0xwCUqyO6wl1L5S6mXESD?=
 =?iso-8859-1?Q?8pp6cSR5i3cuRzxZyjEF9nvbv1OPBZCN01Wyzb0VYGwW/rE5k8fOhbVpiQ?=
 =?iso-8859-1?Q?xDVJuOMGuEgebywEI1awYqCSqKtlG8QWVdmGhpGd9ml+RIvieMVU7zkKKY?=
 =?iso-8859-1?Q?X6tHcC9JDvq3Hr61yZLwZLrTLaKIdvA2w8RdoFnAVhqvF4TodGfXblRt4L?=
 =?iso-8859-1?Q?A11un0l22psq2XlOxSU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a36b2afe-7d88-4422-a523-08dcf2a5948b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 14:26:55.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e51cdec9-811d-471d-bbe6-dd3d8d54c28b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfMVjC5qvNY+co6w7U1otFsrheHEQj7JxyyX92k4kY80i0/SvE0zsdll37GsgQZMWnHDEPbNedfN34iYjgp0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698

Dear Sebastian,=0A=
=0A=
Sorry for the delayed response.=0A=
Yes, I=A0mean the cgroup support in Linux. The change in the path value ref=
erring to the creation of sets of cores does not take into effect although =
I checked the CPUSET configuration to be enabled after installing the preem=
pt-rt patch.=0A=
I rechecked whenever I reinstall the kernel without preempt-rt it becomes e=
nabled and works perfectly. I figured out how to use the application level =
of cpuset configuration like assigning cpus through cpu_set_t on a c-code b=
ut in kernel level it still doesn't support. However, I checked the preempt=
 rt in my laptop and it seems it works perfectly with c-group and this issu=
e is only in embedded system Linux kernel of jetson tx2.=0A=
=0A=
Best,=0A=
Mohammad=A0=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
Sent:=A0Friday, October 4, 2024 3:14 AM=0A=
To:=A0Mohammad Pivezhandi <pivezhandi@wayne.edu>=0A=
Cc:=A0linux-rt-users@vger.kernel.org <linux-rt-users@vger.kernel.org>=0A=
Subject:=A0Re: Problem with using CPUSET along with preempt-rt patch on jet=
pack 4.6 linux kernel=0A=
=A0=0A=
[EXTERNAL]=0A=
=0A=
On 2024-09-27 14:56:51 [+0000], Mohammad Pivezhandi wrote:=0A=
> Hello,=0A=
Hi,=0A=
=0A=
> I am working with jetson tx2 and got issues with cpu isolation through=0A=
> cpuset when I apply preempt-rt patch. I use jetson linux 32.7.5 from=0A=
> jetpack 4.6.5 and after applying the preempt-rt patch it disables the=0A=
> cpuset for assigning core to the tasks. Without preempt rt the core=0A=
> isolation works perfectly, and I am wondering if there is any fixation=0A=
> to my problem. Thanks for your help in advance.=0A=
=0A=
By cpuset you I guess you mean cgroup with cpuset support. What do you=0A=
mean that it does not work? I don't remember that something has been=0A=
here.=0A=
=0A=
> Best,=0A=
> Mohammad=0A=
=0A=
Sebastian=
