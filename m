Return-Path: <SRS0=JPb9=DF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F5C2D0A8
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460D6208FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 08:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DdRynnx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1Ixo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Sep 2020 04:53:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:49071 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgI1Ixo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Sep 2020 04:53:44 -0400
IronPort-SDR: Nz1K+txKVGn7h2ci4FF8nIPKg/aFTKFNwVTHs3LDbNNG6FvgY3jSQu/Q+qBYAsQDBFwwSbwK1x
 yEOv2JL0mgoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162847670"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="162847670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:53:43 -0700
IronPort-SDR: M/2mLNy5eyM7eCdVZcUYqAg69JU4UxN97WQENnp0vDUD5m2WOKkft5L6RzD1QL+BGJw90p9GgY
 THx2ndo1BXxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="293811338"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2020 01:53:43 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 01:53:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Sep 2020 01:53:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 28 Sep 2020 01:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJHbcNFtGdL5VF7surdV4N35DrNdefWRm8iRw8xZl/TS5skZjQYXqbnE4cEerb2BgtBk+pBplRt45X1JGk1E2lAYVmlk0mg1ikKf6PSzPLyDOc7MJ2besRfRlxHq6GhpXCyChUPa5DQI4QykdeOuWtdPVNV2ca3Gakw5IyM6y4QsoSuKfr8CEo1nWIOHNzpJ7ZRLyfLm3i7Hd/qUaExtNHKqMTH1qvlv3MaWkxqtxj+RqLHswEp5DDPORqq2rAwkPYfwJ+D2dUXqvrBJ4ur54C+mwXhKi15FZ1MxODB3Ag5XkHGJ8L9ph/X9qTnvBSupkN1+MVA/Kx/6DCAqmz+EUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcI3M+/DtcWxEGhlhNjlBIslKGl48RWlGupLRIBxlpM=;
 b=BBOu1m/HziJei8gonPP0vIlQhbhGfi6QE2qFFfMFWNQg/TLAZICj2AXKxipPmcGPw8MJbuFV9Cb6nhBqI8TH0BfxVmu7l2BFaBqEZVTU9LzKtZ/uz5ZCvT/4H9QhHoiEfwXSrgJ+KEuLXU+G6DRwsV2QSKzg7XMk5o9ArrH4xk5xjkzolvCWKs8WBNMOHhlRP1414bMipPlxTHesT0O3d5sVJ4FucnUJsoQElv0NOb/23P1rFO6ezF0g6DebRvfy04zz9wer24k8LOlk84pkW9iElXW4nl5syBFKpr7SUsIrr2JTro8toIxKGIusbAgago6LuY8YWg7ClSH48YncGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcI3M+/DtcWxEGhlhNjlBIslKGl48RWlGupLRIBxlpM=;
 b=DdRynnx+A1RC07DDQyMU3ksJz8RmKoy2XsKsIfk959NT9zromglxcvW94SqLztf0qXFZt3iRzdJv45MbjJ3/R9NFV1+xxn/82Fj9r0+Vbpysl7oZubSj0LamrfIOpE24fMncalD7HTYqHvOwkSB0fuDiquXohpWSfBNX4cImkGA=
Received: from SN6PR11MB3213.namprd11.prod.outlook.com (2603:10b6:805:be::12)
 by SN6PR11MB3357.namprd11.prod.outlook.com (2603:10b6:805:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 08:53:25 +0000
Received: from SN6PR11MB3213.namprd11.prod.outlook.com
 ([fe80::4b5:6a26:dbc:7802]) by SN6PR11MB3213.namprd11.prod.outlook.com
 ([fe80::4b5:6a26:dbc:7802%5]) with mapi id 15.20.3412.028; Mon, 28 Sep 2020
 08:53:25 +0000
From:   "VanCutsem, Geoffroy" <geoffroy.vancutsem@intel.com>
To:     =?utf-8?B?U3TDqXBoYW5lIEFuY2Vsb3Q=?= <sancelot@numalliance.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: RE: running it in an hypervisor
Thread-Topic: running it in an hypervisor
Thread-Index: AQHWklovUFitgGQDi0qoKA750+TWUql5modw
Date:   Mon, 28 Sep 2020 08:53:25 +0000
Message-ID: <SN6PR11MB32132C51E6A322B100658B7088350@SN6PR11MB3213.namprd11.prod.outlook.com>
References: <bed0a3c7-6b1e-117b-0dd6-f91230161bd3@numalliance.com>
In-Reply-To: <bed0a3c7-6b1e-117b-0dd6-f91230161bd3@numalliance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: numalliance.com; dkim=none (message not signed)
 header.d=none;numalliance.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [77.109.101.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6012b571-ddc5-455e-2209-08d8638bf61d
x-ms-traffictypediagnostic: SN6PR11MB3357:
x-microsoft-antispam-prvs: <SN6PR11MB335708A62CE6F68F540C56ED88350@SN6PR11MB3357.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GRdllASav16ZDc0quqylNWzBYOBpVvFAA/rZ8ra7f8tdCRbKK3hCurc2bt6OirLLyD112UqTrxReG4L24RRAtg0NTCVbXbZdmS4EqyAhInea2lpch0E7LcGONhOipK7vbbORqrQTuCZP5rP1ECpopIfq/l0EelCaRdcJxxuOqdBtWYGjhwsgdQjUJeXfoysPBYgjZKLfsq/GqOxZrp+TFFt0EDB5+OccxvocJUkgI8RIVXnmP0dfkJJ49k2S2RMT7LGdmwhdwQc6bHhdka/EZwZi3EmOs59QF+fdtRr7KBwjGCrnOt86aa5YwyZivYWIq+EXGIqxt5wyyGyAsEnxf6LfvZS7oZkBP2PdoYXTskReGXh1YurzDnEFjLNi6GvxxQWt89u8Oy8T0dPzC2S86kGLpLyW+iU/BxqAnZREBmkSddx0LmMWSHNwC1Q6gXv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3213.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(83380400001)(33656002)(66574015)(110136005)(83080400001)(316002)(8676002)(2906002)(8936002)(186003)(86362001)(52536014)(5660300002)(478600001)(64756008)(66556008)(66946007)(66446008)(76116006)(66476007)(9686003)(7696005)(6506007)(966005)(53546011)(71200400001)(26005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CzgnzrQQnyDYeeajXvp62f+v1LeeGj/xAuNRKPTnZsTejk4XutJB3bF391Q2Kw7GYKEIIhOw7DJK65+IClzcqAhPco5cYWgZKA4abpHqKW1LneQ5drGcE97bSjV3qNAY6ph6jRuQG9E8NNz6jGnMUoWaQ+NNPmMqqWe3pzuHkjiowwPgMizI4lIluPxgXEKMVrt9T3allevyRezFhJs3AmCSjegLI8ZHHyD6YZezIh5wc8w2Qg0odyZOvLeI64QKIv53Ki1G+eTS3ws8wbxORE/zTzvNKghka1oGMOB6YcMfDy0I7x5N+5PCmlFLXn0o0g28e+HU0mHMG7lamzYqrPl10o8QJo/kODmPWWImXgu6qSIWLW9BNC9inOmI7SO683N7Bw+c/MxeQXvHuT4429Qn67/TGEcN8mFdxirBlu029Qjd+ChvDfAto4aj8IrtFS71//s5GDX2/tk6Mspd9FEqZRkgwSuiQk9G6wZO+7XodwFyrerbZ3OxmeizPNunleM0XL/I5CcGL/5EOOn8A0qH4Mv/qsFscWM2ihobTsRVhvJIS3ldIth0fdw6ZorVx65OROeyAzVeoTu0o9PsSkoppYFsmlWVg3KNEA9xSWysp/HiTRtG7zPn4v/1JbaVnl3Y3VKeZlP/YEN71R3htQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3213.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6012b571-ddc5-455e-2209-08d8638bf61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 08:53:25.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeD8EMvIjoCotanWmBs8ZD34uyT4pVGo8MjO8biTZTouSBcpr6Iibp19pJwtzlssTWSuehmshhr3FX6jJiAKtAkXZHl/hjAMpbLJd1MU6H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3357
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3TDqXBoYW5lIEFuY2Vs
b3QgPHNhbmNlbG90QG51bWFsbGlhbmNlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAyNCwgMjAyMCAxMjowNSBQTQ0KPiBUbzogbGludXgtcnQtdXNlcnMgPGxpbnV4LXJ0LXVzZXJz
QHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogcnVubmluZyBpdCBpbiBhbiBoeXBlcnZpc29y
DQo+IA0KPiBIaSwNCj4gDQo+IEkgd291bGQgbGlrZSB0byBrbm93IHdoaWNoIGh5cGVydmlzb3Ig
YXJlIGtub3duIHRvIHdvcmsgd2l0aCBydC1wcmVlbXB0ID8NCg0KQUNSTiAoaHR0cHM6Ly9wcm9q
ZWN0YWNybi5vcmcvKSBzdXBwb3J0cyBydW5uaW5nIFJlYWwtVGltZSBWTXMgKFJUVk1zKSBiYXNl
ZCBvbiBMaW51eCBQUkVFTVBULVJUIGtlcm5lbHMgb3IgYWxzbyBtb3JlIHNwZWNpYWxpemVkIFJU
T1NzLiBGb3IgZGV0YWlscyBvbiBob3cgdG8gaW5zdGFsbCBhbmQgcnVuIGEgcmVhbC10aW1lIFZN
IGJhc2VkIG9uIFBSRUVNUFRfUlQsIHRha2UgYSBsb29rIGF0IHRoaXMgcGFnZTogaHR0cHM6Ly9w
cm9qZWN0YWNybi5naXRodWIuaW8vbGF0ZXN0L2dldHRpbmctc3RhcnRlZC9ydF9pbmR1c3RyeV91
YnVudHUuaHRtbA0KDQo+IA0KPiBJbiBwYXJhbGxlbCBJwqAgd291bGQgbGlrZSB0byBydW4gaG1p
IGluIGEgd2luZG93cyBlbnZpcm9ubWVudCB3aXRoIDNEIC4NCg0KDQpBcyBhIGZvbGxvdy11cCB0
byB0aGUgQUNSTiBpbnN0YWxsYXRpb24gZ3VpZGUgbWVudGlvbmVkIGFib3ZlLCB5b3UgY2FuIGZv
bGxvdyB0aGlzIGFkZGl0aW9uYWwgZ3VpZGUgdG8gYnVpbGQgYW5kIHJ1biBhIFdpbmRvd3MgVk0g
KHRoYXQgc3VwcG9ydHMgM0QpOiBodHRwczovL3Byb2plY3RhY3JuLmdpdGh1Yi5pby9sYXRlc3Qv
dHV0b3JpYWxzL3VzaW5nX3dpbmRvd3NfYXNfdW9zLmh0bWwNCg0KDQpIb3BlIHRoaXMgaGVscHMs
DQpHZW9mZnJveQ0KDQpTZW5pb3IgVGVjaG5pY2FsIE1hcmtldGluZyBFbmdpbmVlcg0KSUFHUyDi
gJMgU3lzdGVtIFNvZnR3YXJlIFByb2R1Y3RzDQpUZWw6ICszMiAoMCkzIDQ1MCAwODUxDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpJbnRlbCBDb3Jw
b3JhdGlvbiBOVi9TQQ0KS2luZ3MgU3F1YXJlLCBWZWxka2FudCAzMQ0KMjU1MCBLb250aWNoDQpS
UE0gKEJydXhlbGxlcykgMDQxNS40OTcuNzE4LiANCkNpdGliYW5rLCBCcnVzc2VscywgYWNjb3Vu
dCA1NzAvMTAzMTI1NS8wOQ0KDQogDQoNCg==
