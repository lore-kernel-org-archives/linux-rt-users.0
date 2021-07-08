Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CACC07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 07:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C32B61CE0
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 07:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhGHHpv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 03:45:51 -0400
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:20033
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229838AbhGHHpu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 03:45:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3w0/aeYpTL1oWmSvCh0sAzZpzi3K+kb4D1P0vNvSE8wL+TgEzyrR8pBJVpuV0SI+alPgQasZaiPfz17b/2SMWcZGj2Aex+P8iOrnjebdMSzHZ5wZacOV3P48NFcAZPcNy2zN8oxBb1i3YDKJ09Po/Htlp5xZez6xSOSwlaxsnwS7ioMhZQe39WJZk5scXPbx7qho4TQCn90TkAt4EsMRUWdtXWtrx9SCfHTGg2JyfilTP2ld+YZb7RWIOWBbMoI08BdirExFx1TxSpmfXbE018W1KLJegVPjzrBM/26+0oCe46VUbBJ8O3jzgOp34rZSJ75vQvW0DlbrjapCt8hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrN3ALmCKxAteWBM57DuJ6fQV1AVeoVzyQfQmAVhbB4=;
 b=hCX1j+k/xvkqbMHzk2xMqqUhxixEoRXbSNFKu1YJfxE1n8Z6t4XFu1osSRhUboEoCxL8ncwnq0ueHmC26lCF+v9lTCZcaFe5PxJEmuwLOMR8fZRmTF33xcQTLNCkAhft+5lHSk7qe/ghArm4jkJBjxKb+kR9nWCPz5141q+9ANxaDexOWk3PFDr882Pf7AJ7Jw5vEb/Dwkzoe7mdjW6N13RxYyBz7cZN4FdNbeWeCAeMMkBgplvZDc9X5wyNVbKvwOC2J2f8Fd0doC++5QnycQkC1vr9PWQblj31oiRgRh8QiQbO832Vi6CsCbA+cBghO4pUmAqr+PuWWC8a0265rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=optimeas.de; dmarc=pass action=none header.from=optimeas.de;
 dkim=pass header.d=optimeas.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=optimeasgmbh.onmicrosoft.com; s=selector2-optimeasgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrN3ALmCKxAteWBM57DuJ6fQV1AVeoVzyQfQmAVhbB4=;
 b=phxnFKQcfZYKA5fWvJWHHUJ4ThXbLYfVyHcWsTOijRez+d9c5DuhIXH1EubG9Ie+lH2zLDrcnghPwZmVjFoR5kAn2sW132BG4SToJoKETaHU3Nsq3vrQ0fDQPCrckkhzDHYA2fMLZUMSoFUKanir6q5Uuv/q3btP5tF6asOETN4=
Received: from AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:128::16)
 by AM9PR10MB4546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:272::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 07:43:07 +0000
Received: from AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::850b:2ba:d349:c53c]) by AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::850b:2ba:d349:c53c%7]) with mapi id 15.20.4308.023; Thu, 8 Jul 2021
 07:43:07 +0000
From:   Matthias Klein <matthias.klein@optimeas.de>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Working sample 5.10 kernel configuration for an IMX6 board?
Thread-Topic: Working sample 5.10 kernel configuration for an IMX6 board?
Thread-Index: AddzzOCsqFtf+wLtSaGNGDf4F5E2SA==
Date:   Thu, 8 Jul 2021 07:43:06 +0000
Message-ID: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=optimeas.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4bc07a6-e265-40b3-c69e-08d941e406bd
x-ms-traffictypediagnostic: AM9PR10MB4546:
x-microsoft-antispam-prvs: <AM9PR10MB45469DC58A5613F8A6F2868A99199@AM9PR10MB4546.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N09UhMv3esFpEYqwZn2jHbV2LcnYc6BJYDPKK5ywxYH+3q/GrK9YY9Ib1cc07FD9OCJ5247Uvb28XMHZztY/AgohBpi7rba+9GCi8Xsgac8f7LQvz4s+36syQanmuQOA/foSIwDiyUUhnC1Z8saUfA9vcvg+mMpgzeVoVB9YVpP5wHyEY5KmcqP96B4a9rFGr/fUifUCcRJmDNtlf1BFTaGMGcTILHf2HWa/UXHfk9kmrYQguyMkZ/bn6tGpww1XwhuvXtrq7PAyRPdxXbTUf/Nm8HYLkRNN7ftF6wYD7U+LNkTeTgqz3xp9B0uRsfOe5PsS7Gw96RmIKRdwIu2mjWUPW/KTtyY/+oE5rvQNXI8ur2dB6ArBrm3nsxIWRWakG/ycZ0Ks2VWZvXMbtJqO+v9/cN9OHxAWlTBZ3j/OTALO/4z91zCqMAnWMx8r3g0RRqMAaJ2ERKiqRNRu5Xyi/zX2H2HRrYQYW+KeWGW4UjTJ+TrbhWphQocJd3gp040jWZXR1Ik5qscjlHOnIlOfeUGI9frwuFOVAPkk7Oss1C1NS60MyxDTZSY79T6F/lcq2V9Akx6iHCN0p7ZvT38nl7XHmJLrY6r/VwH2q8xfYuwISY6EZrZgG71hMonBnX5iOAduI06MTUducLCHn+D4Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(366004)(396003)(136003)(7696005)(52536014)(66446008)(66946007)(66556008)(44832011)(66476007)(64756008)(8936002)(316002)(76116006)(2906002)(71200400001)(55016002)(8676002)(9686003)(6506007)(122000001)(38100700002)(186003)(5660300002)(478600001)(33656002)(86362001)(6916009)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YF28oWJmNQAfJjJLPHDF9Etg5WCpCxeyaT7CEVbzxdrrrpYlwCE90AfxUNhG?=
 =?us-ascii?Q?YCA9GbLnYTvSyFpw/eIMFv3XAs6bwOIrRFW5D8wIu9/SnX6/UQALblHl9zGu?=
 =?us-ascii?Q?pEy3orXTaIULW0WcuEH8BhUUHPe/KP3uamMfEK9ERniKhouMsiMRe8fsRNlq?=
 =?us-ascii?Q?F5zVh38ld/uNJfbvugE/qBcLW31QBSbJpf+WUS2MatSVlziVNcyqF19HT1o/?=
 =?us-ascii?Q?1glNDB29wWPmtW62kla+YKwoJnaZTD5/DoWenFIsZ61h6JKTTbnHAqyCLPxC?=
 =?us-ascii?Q?yofz6bsUyTspwG3eXDLEmJM3usXPzXo+KeYnvkHn4Dfw4aXdemHch967rE3L?=
 =?us-ascii?Q?PWGQRV4VqYNE+ug1mSl48G1UamktQA9Kfk4x9KnEQM4pv1WBnoxqlOSspayc?=
 =?us-ascii?Q?o+dPLxG4CERQyx/cakfz308aqBS3uhev2gr0pTSIkU1Mf4op4N/fWyRRNPno?=
 =?us-ascii?Q?ryhTakhNlR8+T20+p9WKlZYKTAeXWcrvTGjrRRn0QsUlCn+sCNOtnHgzwByY?=
 =?us-ascii?Q?fIQCph2EiGIiCT8Hnh3NmAn4S78eC4VRA7Q2CxULD4uya0IMc6xQWyDGBXuO?=
 =?us-ascii?Q?YG2XRxpdEVNJXuZuAKLWtnjy2qObkecdl4ZDadmvubAEitkWEXirPYwTYYKG?=
 =?us-ascii?Q?/6PvSnzoalo3IOEWiECGed+pTRi64GP0/hATYAz6U+3AUId6rjc8cGgWy4IG?=
 =?us-ascii?Q?9Ijomv/SnRiHIJAxgL44TWFK/bwgmH1xdkYt+gweixW1v0ts/PuQFS+cCGRx?=
 =?us-ascii?Q?tYCR6zEHUltW5aTUOMjrlbgvPooEepRMD8x9DzTGs3p/x6uSSYVXIgNxHIKX?=
 =?us-ascii?Q?Fcin9Oik8Zyc+kmd/WIIJrN6/A+0Mt5//pYcASpo+YfCKSAQrAOZoGkaLbgg?=
 =?us-ascii?Q?90+L0hR+1n5rZVzncrlT342sVUSEqECaKIxfTWHj751juAaAMy6xOuSOdb7P?=
 =?us-ascii?Q?zpybOITIHS2gSk9FQvGppBDIYVdAtSbzCCNILa/lhoVd6JAj/Y+5qMTFCsp6?=
 =?us-ascii?Q?q2dv8m+pjVl044fulDIdUqoTPMMOwQ/fL75ifJ8vqFay4d8Nt6RUYpnfVDFL?=
 =?us-ascii?Q?VGCWmsTwhre0imagxVkfMV9c9ufY86GYsIPiBCTQ483Tn4BPv3nsJcxeMkXa?=
 =?us-ascii?Q?Zp0/ncMeFWn/Nwvgjg5VfQiMcXGWPRIsA94x0pOw1jPIwS9wMdeEnG0ttA6B?=
 =?us-ascii?Q?CZeZAHSMsNF/Q9ytEFssXUvCACczXScA+scBYjAM9DAgf7P9eU/yYLIluOWW?=
 =?us-ascii?Q?Kq56cUSepq6A6ddsIu0MRoLJo6ZQ9ntSYF3WAETrEN49p5ExkLTFDjVYfe0w?=
 =?us-ascii?Q?nt+1ltKg+fQrZLPihWIMbtJvXns1jSU+DqPJmHnClOMsk0cd6doei/3KG4m4?=
 =?us-ascii?Q?9LLyJnqAIklCcv07e3WtJ4L6UzGb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: optimeas.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bc07a6-e265-40b3-c69e-08d941e406bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 07:43:07.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 91b33c5b-e584-4ec0-893c-2a9180ad0602
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpEvUtiIIQrSxexZnYvrl2P9MCgZmARQwdNLNHRJkNVADTRMvyxATZTCxutUrWwwFx8Bg92FiY4aAak9KssA+b/kVhsFzZY9FMEVQuyJK5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4546
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello together,

I am trying to get the PREEMPT_RT patch to run on a Ka-Ro TX6U-8033 module =
(800MHz i.MX6U7).

The kernel boots and basically works. But I have measurements with cyclicte=
st with maximum latency of up to 2..3 milliseconds with only 100000 runs.

I would like to compare my configuration in a first step with a working IMX=
6 configuration which has no such outliers.

Can someone send me such a configuration?
What should be the maximum latency with kernel 5.10?

Many greetings,
Matthias Klein

