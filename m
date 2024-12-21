Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C02594AE
	for <linux-rt-users@vger.kernel.org>; Sat, 21 Dec 2024 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734759374; cv=fail; b=QZKRXLZLDPh4mc8VKjufJ+3CWgYOFQv4UCUARADa6LR0s34SoiLNc5lA+m/ZT78OrNkJ6q6pBWpUBTkizz8G+kD3b52IsZQ1huKcATUpBj6xe9YZnj77q42hy6K8XnLDJqW7hr0MrEavwNfS+4Afz59tPa9T/ysHM+R7y/Y1v/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734759374; c=relaxed/simple;
	bh=eLg2+qrwWs/rOKnKdeh4y+4+qarSyi9Di2qDDCq8HfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/Zt8CT0vi+x/9Co1S8V4J4F4yOtgpFyiP210SpUc3FnJXJ6XiD+YhTwfz+47KUwopJGrexeXRufDTmomO3XBdpxCzSoRweaeLE8gDcgWu62swYW/yU50vPJAxDdwHDRQ7+wII0wu9XjQlOWoDhpZwMRB5al7/aKUFk9YeaeQ7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDqdNX+IlGBwgftToabIp7HkMzMq11dqDE/z5XmVMQaBK0XPGt2l7QaLh88TPS62IAki7YegrArC0U33spN/LfbRfj6gzzg6k/9jLLGcX8MOgrvsfkUmJ+X2IWrJQOce4I3unZrclxbH5qvutu4t32QetIqpwI/x+MuSgypVBb6nvzujkQIWlbYVAgTH3H3Zglg7zBDJUUcGBY1gYkDhRhsmtsfL1zR8F19EKKEbBcCrvVOSO6rgSPk3OS7JXcIkrpI7dA1IuRjo1deQ14mO25NpB8QLWBrqUOpW3Ozo+DMVO95PcGstqrbWfLL2g5z1irco+rsihCRTexuVDr63Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLg2+qrwWs/rOKnKdeh4y+4+qarSyi9Di2qDDCq8HfA=;
 b=D6t/LtKn5+DiOXEIpFGiQu/TtUkvSXhIo210KkA0UhrAH6yQQhHgpJr8sFfSh7cXPcf3uwexrCRz1hI1yLHQylkJMvvNeQQUc+bR1FUhAOuaaW3aDK3dizH0qj9nblbqtGu+OWfK5opcZTUs4SO6LFoFyxOxxYVuKWzZznJuG4cFXBUcL0zQGHn2YJTPYet4ivmHQ0ziddemHXngFVHub+WEYQcNRaNXrJkeujMhLjPFXjeTM/coAZ0HxyXh8q+8MUoGCNIP4ujjDZWZS38vOLOSA4O5T2hB8MxY9mh//NfHAQZ7blWAgMmpUnqzNwyUBryHgr/VSCjwWpLddS+kzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.8; Sat, 21 Dec
 2024 00:00:15 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%3]) with mapi id 15.20.8251.015; Sat, 21 Dec 2024
 00:00:15 +0000
From: EnDe Tan <ende.tan@starfivetech.com>
To: John Kacur <jkacur@redhat.com>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"mtosatti@redhat.com" <mtosatti@redhat.com>, "williams@redhat.com"
	<williams@redhat.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	"endeneer@gmail.com" <endeneer@gmail.com>
Subject: RE: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
Thread-Topic: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
Thread-Index: AQHbTLJ65MuI5ooh40W2DRIvOXZbvLLver0AgABgdyA=
Date: Sat, 21 Dec 2024 00:00:15 +0000
Message-ID:
 <NTZPR01MB1018DC8219CCB88C2D7106E1F800A@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
References: <20241212162453.2618945-1-ende.tan@starfivetech.com>
 <2536ec36-44e3-e88c-1333-678dc41c649c@redhat.com>
In-Reply-To: <2536ec36-44e3-e88c-1333-678dc41c649c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1018:EE_|NTZPR01MB1001:EE_
x-ms-office365-filtering-correlation-id: 45718325-b473-452a-0c7d-08dd215272b3
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 lbsxhKlJoTorqzNJ9GvOnTamePv7pXKow2gzIFAr6F2lV3kHFtfjmp3PjQ/qv8w78yp+PfvmKQt2WIITs90K0D2/cmTaK02yGZ04vcfF0TXnlqdxyXCPOcXzSQ5567jvRy3vInBzFGM9dLJBBmxHRp1JrKn8YfFPiXo+/LvD9g+J903ut1wQJcPD+4/C3LTtNRDPzLD3HBBlxkIaSiXC5ZosSvmPn+t6gmb/nqEgMf1gcpNE78fXk6FZJwAlOapdGC5QyEvDd6Z8+wUV+/RwcB1KCZAxGLKkOVFagTzrb1qU5VOx/XvAvIwlcbJfu8oURzNMw6g6iXRIOKZikKwSmkE8PxW3+8TBc0KBFqVwndfgYOFwcfNttlgqw5NhCrKbsCUQeeU5dkhhR9C9BInNJocJeb4Cz7jwNhapH52SvpehPjhM/NGGHdcF5FlB6eQCmoR7bQyoUmYL6OfnzF1b2lmpDwKWSMlldEVbiYASnPTKV+sinEbvXt+ShKgWyhcCC5/C3uBbgZ45sSC5CwOWsKUBXh/Iqujf8MRr4CyU5f5cgSD3D0ukj4FUg24O1Vj4qpS/mki2mY0p7G3vl+LGEsbaqEzbZhVj/QonwFakSMg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3hWsCGiy5ruanEKW8r5GRO9jLLocmQsxo5qDyGjDzLehbSB3vsByR/ax6dWe?=
 =?us-ascii?Q?1pKUtIvN9Qt/jcTYAzqQLmmBAHTCQJXWcysLp4pKkuYY44k/3zCjiM05pH3B?=
 =?us-ascii?Q?eoMtjFS5nucMIhg7DLThhbqrAY4r0j16UdAh6MknOC1BusMnZV+EBhbJ7/cP?=
 =?us-ascii?Q?t3Lp/bOn2+cIlMUx/AsHCTcPDT2r/96ekBOcmQATzthGiK3OPCwXJpzUrcj4?=
 =?us-ascii?Q?ZuRCySmnMPLZxTGtBO7XU853v3ANBhAVx3rZkKt+yI4NgMJwdp4wVF80fWUs?=
 =?us-ascii?Q?DARJcVlx6cVoBtFXjExDHq6tAg4PIfdBGCIzCo5YOiWmlpbX7NLQr3cPLHvQ?=
 =?us-ascii?Q?Uc1imoFwfPZymxOHLB0E8GRMSuksVxn1k3jTrGGkvHJ9JfzYAuf7VOFbOMtO?=
 =?us-ascii?Q?XA+yNzKC1xIQXUAZuFCC13d0U2oO39OXaHaHy3q9pkOuYOzOQPtG5vwRAY7M?=
 =?us-ascii?Q?DHt5qcPmbftiTrXW4vhkwXjfxoBViw1Oi/LOWQDHIvvmrS5E4tAOIK4/Kk4o?=
 =?us-ascii?Q?vas/aVYuAyEMV5Pu4cZrXIjRLh++csZkpQo/xwWDIe0rlJoRGUEhD/qb+ZWI?=
 =?us-ascii?Q?BfxSVRb1xH7ul8IuG0MSqMDh1Wf4CE7uFQeHB++sp44BYswd7er0KEFvC5BO?=
 =?us-ascii?Q?L2JNsvjmL4PCdzyBnHVfZLwMfa1T4uplWAFLh1HZhqqpK7DWMys4npt+TiMF?=
 =?us-ascii?Q?ocUSfQPp9/4/rWE3sKA3viCYcuRPeQp7sp1GuaRZZZqOpbWoCQxEJ3b9D27B?=
 =?us-ascii?Q?1BqDJQhcGzZ/SaLc/Ageipmk15QfknG215eDZBbM0K+6pNiL5w4CazANQbZD?=
 =?us-ascii?Q?xiuwNjM7Rdfmbm35arno3jYhXBhNFRfMQlt1/tzbTW84krhXIdBCjyH9YIvM?=
 =?us-ascii?Q?RBAVg1Cg53TfmEftrafX5sqrKxiJ6hnhNgBPbUF5/xcG9Tqn02oM9KqHdp2r?=
 =?us-ascii?Q?LoSp3ylL5XC5j6isDtkMV1ARoFdFBF9Usdmoq87aBJo6KXwgvbYY/7ggDgWB?=
 =?us-ascii?Q?3yxjb7FNGSlsndbJdSyLhQjBn4A/sRGVGKoEDw21n/MLsDFxt4Do9PaH3XRx?=
 =?us-ascii?Q?rCKenq31TCE/dypf3QqaFV1OXCJLvplcRNHu5BegUa1l6Kzwi5xLIHpnn5+q?=
 =?us-ascii?Q?FCVR368BB4KMlDHUv/5ifowq5hwRijhwJvjEz7nrSL/0HUBPQsYu8aq7AWJb?=
 =?us-ascii?Q?EV3AlSf64/37w8yneBOmvq4I1cJ87D2w9O7+pcYepxI/SuAHI6KabxyI+WDu?=
 =?us-ascii?Q?bsHyoUxIww6v6M2KDY4kQrkWO0aRMYg6yJ4NBQg7x2VdOwKihQMxTXStfD7O?=
 =?us-ascii?Q?36MermnXDG2CVS1PJmZNBSBZhEYiHfekXVoupGMOl7sU/tmDYkFoq2dGYM6G?=
 =?us-ascii?Q?Wz397psGzONrq9ytaf9lUrQw4ZG9MVc27nkTy5EP8msfpPV1RGFZLnBI02Yy?=
 =?us-ascii?Q?GH7DJhDigtqXPwwF8bFdb3yZj3lS+Vl5mjiWE3AqzAEj7XM8kCc56GLn0RXo?=
 =?us-ascii?Q?pYg4ymAkiZhHbx+l4RMiterSHrqsaPZO/DrIT9kqhDzlCKnWXDks7AERieTN?=
 =?us-ascii?Q?QKGbIi2eQ3TVuvrF9BYS/Pfx6P9WSiZCFPCJzXgl2V8KOHqVrRs32A0lLWUU?=
 =?us-ascii?Q?p6fI0f0+sKofujQLoAkFAduDwv94so8dhBKWOp14dJlz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 45718325-b473-452a-0c7d-08dd215272b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2024 00:00:15.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJ8vqf/zqgbm8UAtZ90Vg/ByVR8qjrQGi/7ppghEvSp09cPgaGQYYI5vnDR2DFkOCNjcbcIHprDPw4QvZB6DPh/PcupI6+AZs/hL+ZDIdNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1001

> WARNING: __always_unused or __maybe_unused is preferred over
> __attribute__((__unused__))

I tried the `__maybe_unused` using gcc 12, but it didn't work.

It looks like the `__maybe_unused` attribute is only available in C23 and l=
ater
https://en.cppreference.com/w/c/language/attributes/maybe_unused

For backward compatibility, maybe we shall keep the existing `__attribute__=
((__unused__))`.

Regards
Tan En De
