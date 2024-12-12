Received: from clt-mbsout-02.mbs.boeing.net (clt-mbsout-02.mbs.boeing.net [130.76.144.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99A216E3B
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=130.76.144.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020676; cv=fail; b=B1D49hhtySOAYKKIVc3YtV8VXmdnHz5/NnpUowFCNSd5StoH7LaoDh98qXzflbsFkSsWdl4kYFvwpzS+Ijs9/fQYBtKTL7HckOfqs7kivu+RalFejnG1IUI2YNneeW+cxalCL9oHXwIeV9OyOcEi5o3HeV4w2VtzEgd5efFQdbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020676; c=relaxed/simple;
	bh=CEpl5+TRmV7woq+n+yCldJ0D4BF6BTRc/VN025Meako=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=casgR6OSGU0EyA3qfB0d8jXSNkRiTKs6UPuilRmpvfemV/EsybXM5fAjJ4Bdn/zuRB5I42zvhKUI3rY7EIf7/RzdUOGimhFWr5bvGScK9ZVih9Cr8pBWnVA3eWIQvkohdyBxln3enxG1q45H1ONnE4X6bwqJpBMDyYDDaun6hLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=boeing.com; spf=pass smtp.mailfrom=boeing.com; dkim=pass (2048-bit key) header.d=boeing.com header.i=@boeing.com header.b=F6tznfnq; dkim=pass (1024-bit key) header.d=boeing.onmicrosoft.com header.i=@boeing.onmicrosoft.com header.b=Z4GrtEva; arc=fail smtp.client-ip=130.76.144.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=boeing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boeing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=boeing.com header.i=@boeing.com header.b="F6tznfnq";
	dkim=pass (1024-bit key) header.d=boeing.onmicrosoft.com header.i=@boeing.onmicrosoft.com header.b="Z4GrtEva"
Received: from localhost (localhost [127.0.0.1])
	by clt-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 4BCGOV1r009867;
	Thu, 12 Dec 2024 11:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1734020672;
	bh=oM5p7YszPy50bYXSLuThs5na2gl1Hi7Ifdmo4rA/P70=;
	h=From:To:CC:Subject:Date:From;
	b=F6tznfnqpugFt11WG6ZvG4Zrh9xlOr8LfQg0Jqj1vfwOLfAC8dzqfWtQ27nYpgb7a
	 0jt17zASnYzySxq52cL6LAOxqCdGPwOFI7lJaHBiS1rK73Z7u8qJrJ4iM0P0NKE00G
	 aNlyyup1YL+EC3srh3g5yS6Nq2OH/oY6gzkQS9ICWJsLJ/BKERFgGXib//6b9Dh09/
	 4l2Yl9/4TBbw+qGTK/OoJ2nGdO1dZ3G7L9eqcs/ps0FQzjWDQj4lKqR+1TB5is46oq
	 TXMoPzVwv16l84VSliXXmzkjcGOM4qlYCsH8ED0OfRMkD1VVqNEsQ7PlY3l8663z8j
	 nyxLL8Vb6GSZA==
Received: from XCH16-07-11.nos.boeing.com (xch16-07-11.nos.boeing.com [144.115.66.113])
	by clt-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 4BCGORtf009807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 12 Dec 2024 11:24:27 -0500
Received: from XCH16-09-11.nos.boeing.com (144.115.66.160) by
 XCH16-07-11.nos.boeing.com (144.115.66.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 08:24:26 -0800
Received: from XCH19-EDGE-C02.nos.boeing.com (130.76.144.198) by
 XCH16-09-11.nos.boeing.com (144.115.66.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Dec 2024 08:24:26 -0800
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.181)
 by boeing.com (130.76.144.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Dec
 2024 08:24:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Oy9Gg/aQpHsVrqayPF/td/4bpslmvBlff78MG08ALwQidoS375e6oYdnws3rqfcV56ZHGDpS1cPOSYC7ySWIjxlmd4wDetpiPJYlrnj59dcFM6yMNH14/D1JlzQ77SlpV5QifH2eRqjLKnuxcInRE4a3rRHElC3GUIhBr7QsQSMxtxAvAhmqPygwBJzavPjxX0aSmpMozkOpZkgARnnurtgMxqYqK441iq9CwbeBckEvzqSBVApHixeV8idi8Mf2q/Vj96b2hAsfrd5lhHB0YAhnHA9JHvD++5VbbA7GK3yVFmz5+adOc7knOUILJWnKjZBKF4L8OfRqAGhpZ9dzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM5p7YszPy50bYXSLuThs5na2gl1Hi7Ifdmo4rA/P70=;
 b=aHyTGwd0KdWGPVMAXdoKXrTy+PiefL1XSoIoQsx7XwznWPgkIr1wl1lCO9g76znwSqU1+XaSXMbiFwcLmCdsNfAfbyySxTkbDjw9BKlO9MLuCYmIY9B3YZViwDXQgOHoYWkxdaSmLVE4sxccwG5KtpWvGT/2Nw8/DkWWkkf494jQM1DU/ud+y7tjfR3MO0pjTDUT/njZb40zTrc8Fr/dobd/1fMqnqTAqmyO1PDdjJYsfeAZUQKpBdnaAhn1QXl6XuPubwFun+ExHl21EEsvg+s/6sZWUyi5/fHNL7xlsQ76u7NLpXaPADTLdbUGb2kBJHxWVjQfkje1u3QOUDTPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boeing.com; dmarc=pass action=none header.from=boeing.com;
 dkim=pass header.d=boeing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boeing.onmicrosoft.com; s=selector1-boeing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM5p7YszPy50bYXSLuThs5na2gl1Hi7Ifdmo4rA/P70=;
 b=Z4GrtEvaSb1rbP3H2YntQVpfwNUN5itTK3LGhAGQI87EgmnY6iVzaEOCZmP1wS8ewy7nRqDziGujXs+5zaJwZw0tJwJLwiSuwOdzpkb5+Jv1YQPuRE66GAh2Hi1lU7XumsFGJKA/3T5i74UlPWdh09bNK/itGYeFNnXGVAw6utc=
Received: from BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:19c::7)
 by BN0P110MB1500.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:186::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 12 Dec
 2024 16:23:28 +0000
Received: from BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM
 ([fe80::34e0:4442:7be9:6519]) by BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM
 ([fe80::34e0:4442:7be9:6519%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 16:23:28 +0000
From: "Weber (US), Matthew L" <matthew.l.weber3@boeing.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC: "john.ogness@linutronix.de" <john.ogness@linutronix.de>
Subject: Real-time app developer documentation
Thread-Topic: Real-time app developer documentation
Thread-Index: AdtMskE7YrJ3XEpgTQW/eM051JU1hg==
Date: Thu, 12 Dec 2024 16:23:28 +0000
Message-ID: <BN0P110MB20671E1AA07D1F79721DB0B0F33FA@BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boeing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB2067:EE_|BN0P110MB1500:EE_
x-ms-office365-filtering-correlation-id: f859219f-2836-4842-6f91-08dd1ac94f78
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?36Zm7uGdbZ/fLXt2glBoCXbFYXExfz4BYIneaEFqbvnLl/BkgEwzjtBiS4vS?=
 =?us-ascii?Q?ntCvJge5DQ1ULkOAZdKcj1kaD9blpUXgPt+ujMA8ljPQKml6PfPSBeoSb9g/?=
 =?us-ascii?Q?ZIpXBpqCnDpROILpbGsWDJEhdcuBN3UA2H47tCeXkaooGrTR28+sVly/MpFI?=
 =?us-ascii?Q?E513I/ARUIPoJkD09+lgntNcqvBbJXXt/pghBo+r1EDqEWCaUU65g+PZxtnl?=
 =?us-ascii?Q?sMkuE5dvnBkWIASSbksHYmCooZ8YvFeZoaQ4XRoxtMIkoHcDmSoZWU0K5F3H?=
 =?us-ascii?Q?hAGtQGN90yST8zFAFyZiCp7cUow8AmtBHrxQ+Gf5d0RvkqRTDtdavBRuX6vb?=
 =?us-ascii?Q?NkLCLq1J3JKjVJd7RO5Hy4ETuOOlVR0lpY8eUYYSJRxMmXU9y+zfkcyJJvNn?=
 =?us-ascii?Q?d4mTVuzmIGA/nOzVmp3I0ViqCilmF1tenIjA4xnT1PYVnBRMdcuV7+PDzkol?=
 =?us-ascii?Q?SgYkg7I8K+HjVlQCuKj6iKHAHlV18B6wgahnh8DcZrgY+gNLKsMsSNFk/+DH?=
 =?us-ascii?Q?wp4F+WWC7Yo+DGnDK9KjlbsK5tJwPO8vjsia9R2y+dYgCThoNExrWV5MGOR3?=
 =?us-ascii?Q?18w+mLXkxU+ca2gx0php3ZW3Fje/Y5fM5/i5FdtCuRVq2e/SyZKuTP+cJ3X0?=
 =?us-ascii?Q?Xj243cFaKV1bfXLmZi5/1cdyeuHLqTZDLJzQGL5hGE3YgXN2vzwJJnBOdvRW?=
 =?us-ascii?Q?xFMoZfo0gr2vUsy9x2UsIT5SECNw3e3EOVYljeUuDD6FPRXhCqz8kvrB721l?=
 =?us-ascii?Q?yOEA+qxY7Hgzkj5cljel5VCLLJWRUiDpzvtwW/Dj8Kse/UcoIribPwA0klDC?=
 =?us-ascii?Q?syM5VBmrJbKPeTWx4zElTvGwKyzGg/MBZadw+PJ7g16OV80abJU5kjh+Z1zb?=
 =?us-ascii?Q?Adq+e5PLgnn3/TJbSGGWsVNCG6mEJ/1TIRvkyrKtoyPm2E3XSzaNpWV9uvy6?=
 =?us-ascii?Q?aUidXth4kXPKVXyUKm5g937xJZXS9jym8XJBYsBNfZATqql47NibCdA0Rxds?=
 =?us-ascii?Q?nORe4VFzLB3KCBOxAGD9KzPTR4fvzXy7CKe2XPGpp3MqTIS55p+bZxv1K2OR?=
 =?us-ascii?Q?xUqzasFLC93qN6Bek+9Old3vsw5qPGwfPdxOTR9qeAON0oXYiJfY1tt/539+?=
 =?us-ascii?Q?CWbNldK9BO9Zk5sIh8P2MbetksgFoGAObqa6LhcFAzmZBCPChkfKXrBW9mfy?=
 =?us-ascii?Q?Js8vmEc49DO4Ydz18LKFylNmpuXV3YnazXyQjXv1yk0uXoyW7UhPTtLuU4uw?=
 =?us-ascii?Q?cmalSWbOQ3I38DI1a6wphJ06vZLEm2482HthaWcUMIIdQ1j2y0RwehV4oUGa?=
 =?us-ascii?Q?H7iWSfKHiLCfsR4k/yGJtWBs7dzRkQE+F83nnfPLhoeMt2LZIWHORwIau9o4?=
 =?us-ascii?Q?FpgXUP1KxHVtof7m+7DxAmL+OEWh+OU/Bl0mqi0fnY6ACnQa8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gh1fS74RbdNIXS3KK86wBChjoV1cbfq49uyu2X4QfnxgxVI0TLnvxWiXXDey?=
 =?us-ascii?Q?1I2hD+vyZ2QVE20WpNan78A/usnW2WXKASSjsmb2CaeIwr+FGrsizVvb2RK/?=
 =?us-ascii?Q?5eokFSeKuaXC3Zmxbn/iE6HlrNQ/wHeTUhudp21D+sYV5jAiuCzcgC8byJ3N?=
 =?us-ascii?Q?tWozBIR+HGVPOqH+LJM8URR0iPogN7ONxRMTsgmfBsteIbsWXMXq+C+KAmYk?=
 =?us-ascii?Q?Xp0UP9crz02u2k7c5RppAY60Bs49xL/JrnUf/nxGUiP3s8JU172uL5KDUiMr?=
 =?us-ascii?Q?sXnPab29DAW4/Wxoys8Oy8NWub48fe74elxiAx2C3VeqHU/9D7hK8E6bvHHs?=
 =?us-ascii?Q?fBee0v85FJv10sxopgPK69dQEGt4+Qz65bPjVCPmi4Hr9h+T/5YDRkepgTW8?=
 =?us-ascii?Q?MCn+43kUhmGTBLZ7CG7uoiwedOBMmDiwqXSn90WI08hQvrN8HJi3FOUv/y9t?=
 =?us-ascii?Q?6cD3SH8Mjpgchj99sX/ZufnxOnZpHibLioxXZBZKnA05SjhJf45hjyZhQW1z?=
 =?us-ascii?Q?PXwWcgCmNrbkKEvw7PATNxoQ77vGXnb/rRC14SGp14DbqcM50W+eB9dQWSu0?=
 =?us-ascii?Q?5d1a5epLGUD95ItV8I8ymBmYH5jqfGMgBn0YPir7PxDLXiCIxlm/v55pCh6Z?=
 =?us-ascii?Q?TINKfh8+yLpfhOGB2UYJpyrqdIyDAicz/Uwz55BZu9VARcM6fUSFkrP7uiTw?=
 =?us-ascii?Q?K4UBwAmYfyLd0joYl3w+i0y9sAbKlu5CJQF2kxFyQYgSvxCgB78wOzeTmzGZ?=
 =?us-ascii?Q?zVXWpqHA1CThVUwFLHjXyP/QsfujGMg9hKjqc4wHUOKQWxHKk5anetErsCE6?=
 =?us-ascii?Q?igZNzOvePJgTt5w6V/4QlxhPtJIaDgp+fUZP5+HON08NYx1r1fYfV3mhjKt7?=
 =?us-ascii?Q?aVI5fI7EcIegmcIK+xnpFMxRWrKjZOTZyKSCQl/o1KCrPCgsM1NoIDvd2b6c?=
 =?us-ascii?Q?muveDIrE7VmQ+7BuiTncZDuqBhc7YWEPsk6JhiySkdVjjhc7q44F5k3GVp86?=
 =?us-ascii?Q?WaLoJuLJsj7iUJh2hDdxEKkH1ijyNqGfF+iPh0s/gFRsRQb1hTOANC1PGavJ?=
 =?us-ascii?Q?TUIP5Jf/XcXF1y2OL8YeIQ9j5ulSSGzMl0jGn2TdAZLCe5I3DC3H6XEUbY6G?=
 =?us-ascii?Q?07jfCSRJsGUvPBRyhV893uX5SUk8+13rCHbRYVKcVUK77/9n1jnb5FMGkAhV?=
 =?us-ascii?Q?aoK+l7Ljl4cw7dpP0MMSr4OQKajrod4+r2vzEjc5KkpvodXJL7hKhNJJu73V?=
 =?us-ascii?Q?TvmYP7golD1MNIfoUBjP/+KYBPx/kDouQwVZl/D0BD+0rviArkgoSmh/6RLr?=
 =?us-ascii?Q?orgRGXuXOhuITorPWcWOoWr4NAPXBoslavh3kLIgeHxaKjhXnaklWg1AlvY0?=
 =?us-ascii?Q?umVJbOTrn10aDb6mygS8PDIIvj0SSfUoo0tgj1kB6F5yTjYsrzDvMZ8J4m9L?=
 =?us-ascii?Q?lFimJRF4Ft8U30lkMH6DNtPGOknauZgcny7F7D+RiMlRukDoMwKxs37zJHBe?=
 =?us-ascii?Q?djFptUOZTT5QyI0HhRWWraTOMrKBcDvlsJ1L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f859219f-2836-4842-6f91-08dd1ac94f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 16:23:28.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcf48bba-4d6f-4dee-a0d2-7df59cc36629
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1500
X-OriginatorOrg: boeing.com
X-TM-SNTS-SMTP:
	7950F7CFE3A0458C02224A7487CA2CB5ABC1592F11C70E3AAEEAEE6F2FCA4D3A2000:8
X-TM-AS-GCONF: 00

Hi,

The ELISA (Linux in safety applications) foundation had a workshop this wee=
k with NASA and the topic of RT focused documentation came up.  My team at =
Boeing is working on material to help application developers understand how=
 to integrate their source code on a real-time Linux system.

1) Has anyone else sent a RFC with something similar that we should look at=
?

2) We'd like to collaborate on this if anyone else is willing to contribute=
 parts of the material.

3) Suggestions on how to start?  Should we RFC to this list and work to bui=
ld up a submission for the main kernel list?



Hi John,

I've CC'd you as we noticed a lot of great material from your previous talk=
s/checklist on real-time.  Do you mind if we use that as an outline and for=
 some of the content?

Regards,
Matt Weber
Chair ELISA Aerospace WG
Chief Software Architect Boeing Linux



