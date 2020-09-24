Return-Path: <SRS0=aBkN=DB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D3C4363D
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Sep 2020 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEC6239A1
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Sep 2020 10:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YTLnyBWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgIXKHN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:07:13 -0400
Received: from mail-am6eur05on2045.outbound.protection.outlook.com ([40.107.22.45]:58469
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgIXKHN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 Sep 2020 06:07:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H128sFHn1UqJQqFfgGKyYIL1BTcH1DCQaRsgdMfErMIQjaEJH05nRtlM5tkLvIN4iHFfDdvBCswIAuxtF/HC6h+xnhKYCPCgV2fRL7KoxoGnH6QD+lSH89mJpzkNGeOboZgg434CPMu16QTnV4WSVR28CRtcf+0G4Pn+tQxeuGzK7J8009bOxxkB5iXWesfv6pNllDotw7saX92ceZ1cFBoMaN59Ly/n/nXx3E9glhj2rqhKAh+g1MI8J4q0XQItaTreG1yFwQWJf8pGj9/d3BeBSVOP9BYlMNPdsgbClpX5HZLUUjwU59zAsiW88/uJieILKZT35FxI+ZOG9HChtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/dlWmDyUVxGIpcZB7u0s3IofT5GC4+/uM+A2Fm6rzk=;
 b=DtukOhR08lCVMJ1AfCVsqrhC5TW5vHfLJcGQub6on5Gw569cg/iYH3lcjOOk2MOfw46VElOjypLYUDppfThZDSaeUIXy6Kd3VJ6CxX6G7P773vgDIhDznUBv2IUSwAeKV+WAL4jnG/39FfezchA/PLDwHK3LsZ9tjKX38J8HiuVFYfYHroRfdGr0YbYBYalo7XvkQ4GsmdmiFIVonCmRnu5UIAoOEaArKZiNubCrZ2SlaBDpNgE/Mn2CbuDWJbhP4GUgqztKw7iCFDFgZvenJPxUKd6s7h5O6qvr0OacxHZuuROZbMsqwcEu02/FwYqT/FPyNU5h+GZKft7ufqTPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/dlWmDyUVxGIpcZB7u0s3IofT5GC4+/uM+A2Fm6rzk=;
 b=YTLnyBWTwNjcmOz5R+zBuC/cOsaEvl4sD0XxTVwadjF9rP5MLc7GNvVe/eiKNpwUe+nsjv3vsZ3PExVwEU9sdVrhhsJpxpxf67BIF0ej623HEsBMYS+TtBEvXDfBCWoVSYxnhdpqubIxs8g4Vhc6kBYdEj+lRje5Y60CQRn4RRM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 10:07:10 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.022; Thu, 24 Sep
 2020 10:07:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?utf-8?B?U3TDqXBoYW5lIEFuY2Vsb3Q=?= <sancelot@numalliance.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Jailhouse <jailhouse-dev@googlegroups.com>
Subject: RE: running it in an hypervisor
Thread-Topic: running it in an hypervisor
Thread-Index: AQHWklolRNXOvO/1PUGbAGg5M+1orKl3j+Mw
Date:   Thu, 24 Sep 2020 10:07:10 +0000
Message-ID: <DB6PR0402MB27604D6E2BF8080D40BCA6A788390@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <bed0a3c7-6b1e-117b-0dd6-f91230161bd3@numalliance.com>
In-Reply-To: <bed0a3c7-6b1e-117b-0dd6-f91230161bd3@numalliance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: numalliance.com; dkim=none (message not signed)
 header.d=none;numalliance.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a44d4d4-f31a-4da0-10e8-08d860719a14
x-ms-traffictypediagnostic: DB7PR04MB4091:
x-microsoft-antispam-prvs: <DB7PR04MB40915C4909FB89D7DECCACF688390@DB7PR04MB4091.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GeLK9aQrNG8i1GVnfMDBKxwHtnUCva1tVdAusR+oSxnHA0VvvtdDcMpstWqOfwBBz3oYUDlF/2tcCMB+1Gb2eLNI74ILHroN8jmjfJ3FQKh5vedydnH//r+xX7+z30hbUNrWCFubhpf9Yt9E1xXHYfbVlZrmf4V0JqvkRoM0DiXUy6mF3+X+t/t32ZCEjUdRmdwIu8S2x59r2xVGKXpoIVj4FcSft/dpvvEarGu+z8bkxv/4ucLPC1pB2fqMx+aN/BXFaC6WjKWaYP/whiHksCqaFvT/fazBwDqRJeWz6HWW2NhNMQkS2Gqa1Bs5DcsxlNSxYbovueHCHWtLEFy93w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(110136005)(86362001)(9686003)(44832011)(5660300002)(316002)(52536014)(478600001)(66556008)(26005)(186003)(66446008)(71200400001)(6506007)(76116006)(33656002)(7696005)(64756008)(66476007)(8676002)(55016002)(2906002)(8936002)(4744005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wzz/hdWAwApwKKjg1jyINuvg/9GXcb2d0r/e3IxvxomGlGyDb3F9yvNQqVbgAMHyln8qPnPhFpRr6zs0en8gohFLWss+m6y/sp0P6vjBFElR1kn9z65NktIJqotMS0h7grRSUB/uKaUObkbfTierQvnJxSco8tIt4BpgxJ26NQ/3uULWcfevy5Zlf+qKjmykcsIThxSDLVJn3Ytou21dgN0pF8hWlyhd1piCTkBA5kyjc1/q1gyYinaAGwDRHT2m7jXt4mdGr99dIxyvFKIqAC3LVuu1KjY2koZ4z5fzcUzyTgEBZP6rxXzoHGC9dMlaaF3uuQ3TRVgG5MP/+ZE8jE54kfyPvAqMSSqvS49MCN88Bx+GqObDl87TqK270nevUurd9KoEys1Hw+A8XG5gsag2Ub20JMtoxpOxQdlD1tVQuMvwQp2JKb5jHRZDGCao/TwtNJqarzgTa//wnhrHyaGUwtxiDKSmwgjiM9dMCMQwX3+wo7HNFQbndMcEpv0PYKlRJBHdZ+arTnWoFAh3PgXPzX+TRrQIArfuwLuY3P3nX8tSc6i4u4JgftnekMErB89KZ5HJeAYwu+k7EjKu2AT7pzvxqSyA6dV8am/MqDnOcxr9y+GWGaMke3LvM9N5jzwu9eY4HQ+AnFoslalbZg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a44d4d4-f31a-4da0-10e8-08d860719a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 10:07:10.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NT7nqjCxyjCQBFTiEaMc2TBBSespRQPRoAng4iRUrwoQKrUJZhBn9zH9OoOqAgBNRUVESj87CEZS3MGyG9ykAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

PiBTdWJqZWN0OiBydW5uaW5nIGl0IGluIGFuIGh5cGVydmlzb3INCj4gDQo+IEhpLA0KPiANCj4g
SSB3b3VsZCBsaWtlIHRvIGtub3cgd2hpY2ggaHlwZXJ2aXNvciBhcmUga25vd24gdG8gd29yayB3
aXRoIHJ0LXByZWVtcHQgPw0KDQpNaWdodCBnaXZlIGEgdHJ5IG9uIGphaWxob3VzZSBoeXBlcnZp
c29yLiBJIHJhbiBBUk02NCBSVC1MaW51eCB3aXRoIGphaWxob3VzZS4NCg0KUmVnYXJkcywNClBl
bmcuDQoNCj4gDQo+IEluIHBhcmFsbGVsIEnCoCB3b3VsZCBsaWtlIHRvIHJ1biBobWkgaW4gYSB3
aW5kb3dzIGVudmlyb25tZW50IHdpdGggM0QgLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IFMuQW5j
ZWxvdA0KPiANCg0K
