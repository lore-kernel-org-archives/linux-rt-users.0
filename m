Return-Path: <SRS0=RmBq=2R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288CC2D0C6
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Dec 2019 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEEC206F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Dec 2019 09:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="OiySrtD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfL0Jdo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:33:44 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:55754 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfL0Jdo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Dec 2019 04:33:44 -0500
X-Greylist: delayed 6147 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Dec 2019 04:33:43 EST
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBR7o2ji026549;
        Fri, 27 Dec 2019 01:51:09 -0600
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00010702.pphosted.com with ESMTP id 2x1ht0v0c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Dec 2019 01:51:08 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+AiQgLZphcwJnylMm+ovqtqVeOylcayZUxR0y6ZDzia0YP43eZovbqBEWAh+/JVgUUe+CY2M/ojhWbI2qZ7D8J3/Sx/s2icOrTWeG19DNw4scpxm8iYTER30ioSUylrBnbnmCoWqCgBXwNM4milA91WBIX8RkNo5nNU/ZL92Ee+XlRvRstz7gTKvlt4A4XkDUuvuHz/4VWzHfKy1+HaC1nMkAQ9aEPhBrGuTu0JL/M3gezYh0EKYrSBtF45MQ4gFodT5nDAZ0LFY/fQuARpQ7ZaCcDwZ7dE3+a5JNodpIDLpA57hMAJ9sSKbbKw4FdFzzdO/9QQU88pNhadZ4ilNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr+BKJ/WykkDsomNLPJmm9XgEnfsmA8LK65nPBeP5aY=;
 b=nNBKE7hiCL5KNwoeQCsjp6ijBbzTkVYLLxQFAi7/MtxuqBWvRNP7BB5cyPjzVQX0CTpYe72v5S4RBK3BV1tkBU96rZV4eftH2loC+DtbhYubhlEQTqx/9MO3mWJxUqRKtha4DEGgPfwVq5wweffxRHUVKVvi3fTUC7iuJYhVh9FL54x++zfv0jqNLVdP8YNj0XiTdCUzJ4XNxr9/NGt8lJ76MbdDO5hQyVK4GpxjiJNoovC9ZCDAfBkfIhwLHPgMMaCtG2M9nOc/JXkJ4X1PxuFaEmI5U6UVv9cAmY8a6oLj4p0TYyUzxwOyaDtR2XVIAUHv7BNsvVUuqbj+3TMjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr+BKJ/WykkDsomNLPJmm9XgEnfsmA8LK65nPBeP5aY=;
 b=OiySrtD7toWV15O/tzNxt1QqjvzWyD63d4YIvJlGct8Xw4YO8IgeebK+AWyAjP2qW77lmyqpH5IriXbfPPKuIzTGjs9tsJPanrZ7ruq5cv5g5xvxFwgB6ep7Isjhn6GKYvzMPjMKqzVk6DT0SamuiRubSpmwWE4uBU7BXWsNj8k=
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (20.178.245.75) by
 MN2PR04MB5821.namprd04.prod.outlook.com (20.179.22.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 27 Dec 2019 07:51:07 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::9868:19c9:2875:b0ab]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::9868:19c9:2875:b0ab%5]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 07:51:07 +0000
From:   Kar Hin Ong <kar.hin.ong@ni.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     Gratian Crisan <gratian.crisan@ni.com>
Subject: "oneshot" interrupt causes another interrupt to be fired erroneously
 in Intel Haswell system
Thread-Topic: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Intel Haswell system
Thread-Index: AdW8ilVAAvaA3JdCTRaY/KqJbPF6vA==
Date:   Fri, 27 Dec 2019 07:51:07 +0000
Message-ID: <MN2PR04MB6255567B0B0060B0A8954605C32A0@MN2PR04MB6255.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a12e843-41c6-4532-7be0-08d78aa1883c
x-ms-traffictypediagnostic: MN2PR04MB5821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5821FE42D9C4C633F8BB90F1C32A0@MN2PR04MB5821.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(478600001)(26005)(7696005)(966005)(5660300002)(186003)(52536014)(86362001)(71200400001)(64756008)(66446008)(66476007)(6506007)(76116006)(66946007)(66556008)(110136005)(316002)(2906002)(8676002)(81156014)(81166006)(4326008)(33656002)(9686003)(8936002)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5821;H:MN2PR04MB6255.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjVcvvOEjNneDlbCK7nrN+EPn2kTDVt5CKSFA11jw5tpl3ZqCd4No6ANoPbGfsn1+CH8XSIo20DMHGbiCFFI75dt4blSFxtzQJxsXl2dxB3bcnRK5rtA2Rtk5nZ92UZyE+s3aXOfNcJoTuSqgetRfAQItC9Td254/11P7b7jEKCbFwLZu8zLF74sSD30PrMc5dtS5jyiSljh+0235EtOWLDsS48fuqikC8Vo9o12G/42o2EU/WBveYMcl9cSuT2k/uqbpGUVzPasc58JQVgWLfdprAafdamZlGfPL0hznmalnkvypdtge3oSMZFHNrCfP4oS4IhDsbzkvJdQMVDG1GKxXTJh1ZVhyxR/HeDLu+Ph+wOOgDu2k0Ex2L2+ufNSQmZ7sZVVXcEQ4JpXRYUZX6TY9tFrghX2IRPUVJ+2RozmpbHCc0ClXt/0yBFXZutmyHLiFgpPjtp/XwPqVyAkQciXd3zqTMcFX5eVrpZe2ek=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a12e843-41c6-4532-7be0-08d78aa1883c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 07:51:07.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6maJfPBHzb90lxtLYWCyCH88hauxx0d/+Vb4N8ILuQ/bjnXxkeXVq7vONZe7zKzeo2H4+IOMQd/BMqx/Jhsqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5821
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-27_01:2019-12-24,2019-12-27 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=687 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912270063
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I've an Intel Haswell system running Linux kernel v4.14 with preempt_rt pat=
ch. The system contain 2 IOAPICs: IOAPIC 1 is on the PCH where IOAPIC 2 is =
on the CPU.

I observed that whenever a PCI device is firing interrupt (INTx) to Pin 20 =
of IOAPIC 2 (GSI 44); the kernel will receives 2 interrupts:=20
   1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
   2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED, erroneously trigger=
ed

The unexpected interrupt is unhandled eventually. When this scenario happen=
 more than 99,000 times, kernel disables the interrupt line (Pin 19 of IOAP=
IC 1) and causing device that has requested it become malfunction.
I managed to also reproduced this issue on RHEL 8 and Ubuntu 19.04, 19.10 (=
without preempt_rt patch) after added "threadirqs" to the kernel command li=
ne.

After digging further, I noticed that the said issue is happened whenever a=
n interrupt pin on IOAPIC 2 is masked:
 - Masking Pin 20 of IOAPIC 2 triggers Pin 19 of IOAPIC 1 =20
 - Masking Pin 22 of IOAPIC 2 triggers Pin 18 of IOAPIC 1 =20

I learnt that kernel will explicitly mask a specific interrupt pin before e=
xecute its handler, if the interrupt is configured as "oneshot" (i.e. threa=
ded). Source: https://elixir.bootlin.com/linux/v4.14/source/kernel/irq/chip=
.c#L695 =20
This explained why it only happened on RTOS and Desktop Linux with "threadi=
rqs" flag, because these configurations forces the interrupt handler to be =
threaded.

From Intel Xeon Processor E5/E7 v3 Product Family External Design Specifica=
tion (EDS), Volume One: Architecture, section 13.1 (Legacy PCI Interrupt Ha=
ndling), it mention:
"If the I/OxAPIC entry is masked (via the 'mask' bit in the corresponding R=
edirection Table Entry), then the corresponding PCI Express interrupt(s) is=
 forwarded to the legacy PCH"

My interpretation is: when kernel receive a "oneshot" interrupt, it mask th=
e line before start handling it.=20
At this moment, if the interrupt line is still asserting, then the interrup=
t signal will be routed to the IOAPIC in PCH, and hence causing another int=
errupt to be fired erroneously and unhandled. =20

Since the "route_to_pci" behaviour is documented in Intel spec, I presume i=
t's a feature rather than a bug.
If this is a feature for intel processors, should the kernel irq handling r=
outine be patched to handle it?=20

Thanks.
Kar Hin Ong



