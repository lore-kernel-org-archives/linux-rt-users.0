Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE14C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Dec 2021 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhLQW1P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:27:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:61503 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhLQW1O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Dec 2021 17:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639780034; x=1671316034;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kk+nig5wYNlAJs+zXnHz8lvQVTIz774vGHvnoPPV/eU=;
  b=AqD12Db+X55kqksEeXx+1GarFaMAx4tNaz6DPBjOyI4mns1RlFA1ergN
   8C668An4jMETD0nrqJRAfJtxxLNAZRh0DFBm07jpQGt9Gc1oOzO4QN0ot
   5/Q/ndv+5gRcSSygkZkKd2QQM6jfwitK7O5jT072GQSAEJHVcJxXVqS/o
   I8w+TZFVxKWskQYiqIfer1EiDssJpBZZw0CgJxivYXD9FwY0CIaNUXctd
   AtfEA75on4kwl5sswNLeLi4PR/thMr9SkGVOblJkxvkQwnvsxfvCheuc0
   5O0BGjdGpdS0kPzadx+iuo7ewgHe6AVd13r8MVz0K3RtkmcwQPb/VrB6r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="226703299"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="226703299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="683538458"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2021 14:27:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 14:27:13 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 14:27:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 14:27:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 14:27:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/V7xDnC5AZllAH8BaaZVXAIi7WI38uRTHt+PiWhtgFQs34W3gAB1Y22ZGXX9XNRb0y5ssCtygkd0k8x+9si3b8LAs82IY8kTaImE50tJfipsDXifqp9mfUaZX0XxRC1nhCsU5nX9Db8DeyinBioSQfnw/CU/z7MhNJP4kPNDYt94+TwQdydILM/mi2h0f7dyJWDApFC3Cy7b8SKiC3/AnlGbt88FBABzji6Gg02b2iBj1DwdctroGx45bQLozShJgkNashWs8AuTZ5WRra3eNgNYBtH8HzN2HaSQuckh7W1E8LjJCQ5g+in58LjtDUYY7JpyP8NJG8r8NDHYalTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk+nig5wYNlAJs+zXnHz8lvQVTIz774vGHvnoPPV/eU=;
 b=HMKIDnUAUpsd9vkRmzEOprthbZj6AR1WFDcfgL4BzQwny0DLyZJ1MNmjaXB/3mOcVy7TJffl1bpOA/5VLk2rLX92a3UnuAglU2uTXxLsVgwFG6G8lpICV0rw4seCu0gnhY7vbfv/O9m1hXokidFF5RxpvcmSvOCud2TaxrkDjbVRkv8N27NzCoBLyG4fhsJAdUecUFM3i7TfE2Z3rUUtIHVu2vhi19tJu0Apvvai1RS65Z+qyPZXRlRqc5WgC/uder+Ouun+gBonSWO93k9BbWB/o6jqgKhIZZAyRxthtr3sNw5W6WYW7cjOKsG5oFhFUbAqttCTKbqNGUlWMs4utw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by MWHPR11MB1869.namprd11.prod.outlook.com (2603:10b6:300:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 22:27:11 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::81ee:9484:b782:b6ac]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::81ee:9484:b782:b6ac%4]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 22:27:11 +0000
From:   "Koppolu, Chanakya" <chanakya.koppolu@intel.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: unsubscirbe
Thread-Topic: unsubscirbe
Thread-Index: AdfzlTqiIfpW2qOrTyGhpMNRbilecw==
Date:   Fri, 17 Dec 2021 22:27:11 +0000
Message-ID: <MW3PR11MB4651B2B62415B9FBAD2E482285789@MW3PR11MB4651.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebd081d1-ec1c-43e4-4499-08d9c1ac5e8c
x-ms-traffictypediagnostic: MWHPR11MB1869:EE_
x-microsoft-antispam-prvs: <MWHPR11MB186953720D0DE07CCDB201AC85789@MWHPR11MB1869.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Q4F0c7Ib/mVbQa5nBPpba9JJyP+gfIhUluTd1hy4Jf9t2HGmeK9Yf+c4bOQkZPlNNYuLbX1sB9lRRR1sq33fomZ0j55Pgj6/0cbQRqmF1tgE8t94+XKb2JPmbi5gp3+a/pnUGCPfOdWPMJ978EBkUkyuakTbHozCH4jrwBNGDdYpvQ1wefZeF63kFArSVLTzj+fdLTpPpOBDOujZu7L97O+GW58MXiQ5hZsTVOQdgG+zo9u3Xs1qafEITjbMHqc1340ALEmA0WTmnBURfIuBgBlFjtUTsJkxZGyfKWt9Imk/2Kkj7XvQ47YtO5R2dmjSVdQgJsriewTHI/d4U4ndGurwdnFtYMY9ok02uxveYJq7fn2wEtlZCpLVAExWJhDA4e5Eo0o280r7sQLPraDQ8dYTkds4VjeIsCUE9m97fE8o9WTlQ3baWL/wjJtLU96QgC5Qdzw76d0QJUHD9hMQ95QTimwo5CeXLH+PvtWzR+nP+0PWadUMscDW+24JKuJnD57DqTQuEJDDi2KvjxAIVONNG1hOpkbnReXv2ZKpPCQF1SLdo1uv+DeeAwc+DxA5/epZeUkOzTjILe78/ImrcmIHbO2TuFSppV5G8KSo64pSpopCHDVfSdFTq/cb04miFH/Xvn8kGHRpJt+v8vRzQCRuZORzLS35oIivMoWoq92FUX+P/XA1rfdBR/OfneV39+84YHqmuvoem5CE0HzfAv7pFgHjm57/NqtJlYYQQs83nJfBTiD+4kyawBcoL8YEdJY7bc+7niFsf68jcQcTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(6506007)(38100700002)(53546011)(9686003)(86362001)(122000001)(3480700007)(66556008)(8936002)(66446008)(5660300002)(508600001)(66946007)(186003)(66476007)(8676002)(76116006)(38070700005)(316002)(71200400001)(6916009)(64756008)(2906002)(7696005)(55016003)(83380400001)(33656002)(7116003)(4001150100001)(52536014)(82960400001)(166393002)(220243001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDZTemMrTlFCWHo4Vzg0Q0V3eFR2dHM0OUZkZDZmRlBCOU0xK0lpV09wdTJ6?=
 =?utf-8?B?ZnprUTZKa01HdGxUL0t0Sk04NHEyR1lrRFE2d2RpaS9maVZOS0NlbTEwdUQr?=
 =?utf-8?B?Y0hkZWpxN2h4Nk04M094Sm9OOXNxRHBnZVFZKzQxZWdXWlBmdDZKN1loOC9Y?=
 =?utf-8?B?NEo4d3M3RUtRb1lRNVhKd1pWZm5jWWVJMjBnOSswM25pSXFWY0w5WVZBVXE0?=
 =?utf-8?B?eWs4K0J4ZWovN1VzUkpyLzVTSFhmdW0yeHZJajQyVlhwM09TN1kvT2lxeXlz?=
 =?utf-8?B?aTR4TG1HRjkzcXJCaGxqMmZPdVNZRjk5RDk3Q1BmZDAyb29TMkFCZUZtLzRa?=
 =?utf-8?B?OVFZK0JPWmhGV1FRdktYNFUwUGt1V2NwNlU4NUlOYVh4dE5uZjljWHNRRWRL?=
 =?utf-8?B?d0ZRT0xHUXFlcGJ3TE9CWmx4TnFEYldrZUtTQUthZ1c3RFUzUmhMZ3d6VDE0?=
 =?utf-8?B?VG5GOFVBNmVFUHgxMmx3RVNtQmRZdHV2Qk5tZWQ0OTF5Q29mUjBjcVF1TU5j?=
 =?utf-8?B?UG1NZkE5VG84bkJ3NUw3OEdXVUpCbjBwUWZrWE9ZU1BHR1V2U0pKeEd2N0Ja?=
 =?utf-8?B?S0VPa1k2UUdOaVo1NWcxMFRFcXdKanpJbFdVczBHSTRCcno0T2FOdjlqZWJN?=
 =?utf-8?B?WVZheG13ZnRLVEF2d3lmQ1U5NTE1V1YzSXBiYU8yRXhKTktwV1NBNXFVOEU2?=
 =?utf-8?B?V0dTSWcvRkNuaDZIQkx0QVNSMCttTU1yUVQ3RGsyYVZyY2kxQ3YxWldia1Z1?=
 =?utf-8?B?aHZuelJCRmFNSjZYakhqWkZsVER4d0pOcGJjMVZzZVkzME1JNFY4eDgwdldY?=
 =?utf-8?B?SVdPMGp4YlZoSWNKYmRXbzFaWDdUOUg5L09VeW11cUdGWFczUVFDWUc0YVY5?=
 =?utf-8?B?VkRyYzlQMFZEaUIwRWVidGlGaGhPejhVVGZSTTZpYWhZR2hscUNzclRHMWdv?=
 =?utf-8?B?NUNDYkVDNGx6T0JiMVZZTWg1ZTlrZ3lLYUp6MCtzVW1SbHZac1VSZjRQTE1T?=
 =?utf-8?B?UW9LakRaMVB5K3hkTkRyaDRObmErWFI5cHZyQ0h1bXFaSkNLUnMwSVdVSXU1?=
 =?utf-8?B?V2J4aXNMdjRLdnJ0d0FrRStPV21vcjVkQTVldW1GYzUraG9QaHVTdHFxeHkv?=
 =?utf-8?B?WUNmcWRQMGhWV3RtamYrZ2Y3dUx3dExVOGZjb2V6eVJwVUh0OC9QTEJ0dVFh?=
 =?utf-8?B?QlEzajlxeG85UlQ1VFdpVjBESjdNVng3V0U1R0Zqbkh0N1RlMEZ2WXpBZlBh?=
 =?utf-8?B?Uy9kRThXY2I1Y25mR3BFMDNzdktPRkEyK0N0WVFzUm1tdU1CVWdtU2FtY0wv?=
 =?utf-8?B?cU8rRUhORlFOejRwMDlhRnQ4T2syWDdBRVJ6bmhzejBleTVpTzNTV1ZzRlpE?=
 =?utf-8?B?OFY2Z3MxM09yS2l3dWx5VGIvNXFqVzlqQXRQVFJMN0ZZeUVrTzlPQi9qaVJk?=
 =?utf-8?B?cmdyajBaSmhtalFoMnNJNmxWWU42eDhvQzhPU0J3alRCZkNwVWpWNG1aUjB5?=
 =?utf-8?B?TlJCRU9YRWgvWmlvM3RBWVpyOFdhNVVlOU9XS0xuMzdBS1ZpYjlZdDdkRXVH?=
 =?utf-8?B?VU80OGxwelJQdmU5MlFoZDM2K2lhcEJFeTIra2VWcjlvczZyU01yZU5zYVhX?=
 =?utf-8?B?SytyR1RoZFIyUTBFOXdVbXh5WTl6YUxFYWNadWtNM1ZNeEpERkVlZy9HcHc4?=
 =?utf-8?B?NkRXVkR5bkdDZXZvVlZQdE5uVzhYY0NudE93Wm45MnpKeG5IZ3VVRFF1K3c0?=
 =?utf-8?B?T1lueFo5SW9TN0MyT2VzeTh6TURVeGYrSzRUNkhCeitvRFh0SFRMUjlvTHZC?=
 =?utf-8?B?VXNpY0dBd004MlR2b2ZKR1d0em0ra0xQQ1hRVTcrT1pXdklUTnYySlU0ZDFs?=
 =?utf-8?B?ZTkyREt1Yk5ua2ZXdXg1NjJCV3BwdDdWNGRFTUFoOWw4RjBvUHNLU2FBeUdK?=
 =?utf-8?B?NDFkcjJwMzF0bWVpQVYzcUtNWElxYzBYOGJPc1RiUTE2MGN5WlpWUUJqMmRt?=
 =?utf-8?B?VGI0enBlOXM0M2ttaG1LYUdsb3RlYURmOGVIWStZdXRzeFJ4MzZ1Yi9JK0tU?=
 =?utf-8?B?ejcwVUpON3B0aE13L0E3Uk90R3N6QWNobVo4aUg1czliZHBFS1JSaW1ONGt4?=
 =?utf-8?B?OWJ1Q1Y3cjZ1V2dJOU1JeVdWdUtHQXNzdzVwd3N6bFhjRURMY3pBUWNSN2FW?=
 =?utf-8?B?U2UwYUFtK0FnOFpQb2U4Sm10amtNNHhnWWVaNTNJT0ZibjZoKzlMMFBabkZo?=
 =?utf-8?B?T2NUN0tlQTRWN1lEUFVtdUdrOVVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd081d1-ec1c-43e4-4499-08d9c1ac5e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 22:27:11.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EH6h7JuOLIl1Yun6TdvqCnrIFnQSzfC0dN1NR1EE21XxZM2x8UjoDP3C1Relr1VuXo6zL3gWkDoL74F+zRqJUQKHPrqbXZeI19S+w6bbXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1869
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW5pZWwgVmFjZWsgPG5lZWx4
LmdAZ21haWwuY29tPiANClNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTcsIDIwMjEgMjowMSBQTQ0K
VG86IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQpDYzogU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgWWFqdW4gRGVuZyA8eWFqdW4uZGVuZ0BsaW51
eC5kZXY+OyBtYXNhaGlyb3lAa2VybmVsLm9yZzsgd2lsbGlhbXNAcmVkaGF0LmNvbTsgUGF1bCBN
ZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IGxpbnV4LXJ0LXVzZXJzIDxsaW51eC1ydC11c2Vyc0B2Z2VyLmtlcm5l
bC5vcmc+OyBsaW51eC1yYWlkIDxsaW51eC1yYWlkQHZnZXIua2VybmVsLm9yZz47IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmc7IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KU3Vi
amVjdDogUmU6IFtQQVRDSCB2M10gbGliL3JhaWQ2OiBSZWR1Y2UgaGlnaCBsYXRlbmN5IGJ5IHVz
aW5nIG1pZ3JhdGUgaW5zdGVhZCBvZiBwcmVlbXB0DQoNCk9uIEZyaSwgRGVjIDE3LCAyMDIxIGF0
IDEwOjU3IFBNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPiBPbiBGcmks
IERlYyAxNywgMjAyMSBhdCA1OjQyIEFNIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgDQo+IDxi
aWdlYXN5QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjAyMS0xMi0xNyAxMDox
NjoxMCBbKzA4MDBdLCBZYWp1biBEZW5nIHdyb3RlOg0KPiA+ID4gV2UgZm91bmQgYW4gYWJub3Jt
YWxseSBoaWdoIGxhdGVuY3kgd2hlbiBleGVjdXRpbmcgbW9kcHJvYmUgDQo+ID4gPiByYWlkNl9w
cSwgdGhlIGxhdGVuY3kgaXMgZ3JlYXRlciB0aGFuIDEuMnMgd2hlbiANCj4gPiA+IENPTkZJR19Q
UkVFTVBUX1ZPTFVOVEFSWT15LCBncmVhdGVyIHRoYW4gNjdtcyB3aGVuIENPTkZJR19QUkVFTVBU
PXksIGFuZCBncmVhdGVyIHRoYW4gMTZtcyB3aGVuIENPTkZJR19QUkVFTVBUX1JUPXkuDQo+ID4g
Pg0KPiA+ID4gSG93IHRvIHJlcHJvZHVjZToNCj4gPiA+ICAtIEluc3RhbGwgY3ljbGljdGVzdA0K
PiA+ID4gICAgICBzdWRvIGFwdCBpbnN0YWxsIHJ0LXRlc3RzDQo+ID4gPiAgLSBSdW4gY3ljbGlj
dGVzdCBleGFtcGxlIGluIG9uZSB0ZXJtaW5hbA0KPiA+ID4gICAgICBzdWRvIGN5Y2xpY3Rlc3Qg
LVMgLXAgOTUgLWQgMCAtaSAxMDAwIC1EIDI0aCAtbQ0KPiA+ID4gIC0gTW9kcHJvYmUgcmFpZDZf
cHEgaW4gYW5vdGhlciB0ZXJtaW5hbA0KPiA+ID4gICAgICBzdWRvIG1vZHByb2JlIHJhaWQ2X3Bx
DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBjYXVzZWQgYnkga3NvZnRpcnFkIGZhaWwgdG8gc2NoZWR1
bGVkIGR1ZSB0byBkaXNhYmxlIA0KPiA+ID4gcHJlZW1wdGlvbiwgdGhpcyB0aW1lIGlzIHRvbyBs
b25nIGFuZCB1bnJlYXNvbmFibGUuDQo+ID4gPg0KPiA+ID4gUmVkdWNlIGhpZ2ggbGF0ZW5jeSBi
eSB1c2luZyBtaWdyYXRlX2Rpc2FibCgpL2VtaWdyYXRlX2VuYWJsZSgpIA0KPiA+ID4gaW5zdGVh
ZCBvZiBwcmVlbXB0X2Rpc2FibGUoKS9wcmVlbXB0X2VuYWJsZSgpLCB0aGUgbGF0ZW5jeSB3b24n
dCBncmVhdGVyIHRoYW4gMTAwdXMuDQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBiZW5lZmljaWFs
IGZvciBDT05GSUdfUFJFRU1QVD15IG9yIENPTkZJR19QUkVFTVBUX1JUPXksIA0KPiA+ID4gYnV0
IG5vIGVmZmVjdCBmb3IgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZPXkuDQo+ID4NCj4gPiBXaHkg
ZG9lcyBpdCBtYXR0ZXI/IFRoaXMgaXMgb25seSBkdXJpbmcgYm9vdC11cC8gbW9kdWxlIGxvYWRp
bmcgb3IgDQo+ID4gZG8gSSBtaXNzIHNvbWV0aGluZz8NCj4NCj4gWWVzIHRoaXMgb25seSBoYXBw
ZW5zIG9uIGJvb3QtdXAgYW5kIG1vZHVsZSBsb2FkaW5nLkkgZG9uJ3Qga25vdyBSVCANCj4gd2Vs
bCBlbm91Z2ggdG8gdGVsbCB3aGV0aGVyIGxhdGVuY3kgZHVyaW5nIG1vZHVsZSBsb2FkaW5nIGlz
IGFuIGlzc3VlLg0KDQpOb3BlLiBJdCBpcyBub3QuDQoNCj4gPiBUaGUgZGVsYXkgaXMgYSBqaWZm
eSBzbyBpdCBkZXBlbmRzIG9uIENPTkZJR19IWi4gWW91IGRvIGJlbmNobWFyayANCj4gPiBmb3Ig
dGhlIGJlc3QgYWxnb3JpdGhtIGFuZCBpZiB5b3UgZ2V0IHByZWVtcHRlZCBkdXJpbmcgdGhhdCBw
ZXJpb2QgDQo+ID4gdGhlbiB5b3VyIHJlc3VsdHMgbWF5IGJlIHdyb25nIGFuZCB5b3UgbWFrZSBh
IGJhZCBzZWxlY3Rpb24uDQo+DQo+IFdpdGggY3VycmVudCBjb2RlLCB0aGUgZGVsYXkgX3Nob3Vs
ZCBiZV8gMTYgamlmZmllcy4gSG93ZXZlciwgdGhlIA0KPiBleHBlcmltZW50IGhpdHMgd2F5IGxv
bmdlciBsYXRlbmNpZXMuIEkgYWdyZWUgdGhpcyBtYXkgY2F1c2UgDQo+IGluYWNjdXJhdGUgYmVu
Y2htYXJrIHJlc3VsdHMgYW5kIHRodXMgc3Vib3B0aW1hbCBSQUlEIGFsZ29yaXRobS4NCg0KSSBl
eHBsYWluZWQgdGhpcyBpbiB0aGUgb3JpZ2luYWwgdGhyZWFkLiBBbGwgdGhlIG9ic2VydmVkIGxh
dGVuY2llcyBhcmUgcmVhbGx5IGV4cGVjdGVkLg0KDQo+IEkgZ3Vlc3MgdGhlIGtleSBxdWVzdGlv
biBpcyB3aGV0aGVyIGxvbmcgbGF0ZW5jeSBhdCBtb2R1bGUgbG9hZGluZyB0aW1lIG1hdHRlcnMu
DQo+IElmIHRoYXQgZG9lc24ndCBtYXR0ZXIsIHdlIHNob3VsZCBqdXN0IGRyb3AgdGhpcy4NCg0K
QWdhaW4sIGl0IGRvZXMgbm90IG1hdHRlciBhdCBhbGwgYW5kIGhlcmUgaXQgaXMgcmF0aGVyIGRl
c2lyZWQgYnkgZGVzaWduLg0KDQpEcm9wIHRoaXMsIHBsZWFzZS4NCg0KLS1uWA0KDQo+IFRoYW5r
cywNCj4gU29uZw0K
