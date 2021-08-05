Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604AC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 03:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3977460560
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 03:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhHEDBh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 23:01:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:43275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhHEDBg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 23:01:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201242135"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201242135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 20:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="480511318"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2021 20:01:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 4 Aug 2021 20:01:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 4 Aug 2021 20:01:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 4 Aug 2021 20:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjDsFkCVrXQ0fiusrzkJIdXqytG7dGAiyDuIfgIUu21+JT4Z+z+zCkvQda+Yf8WVCzdkJ1RNRZWPGE1f9RYIZWVc80mVxNJNCWlKCEOFahKplJXVoZkErZI53CQnmYQZ+eLwFddqHfJ5yA4f6lz1LB/sug9ppJS/LwGfQNj8soUOnEtvj+eMH51JXVOBl9x4RbbXXFBK5k3EcJwgfDa7zt3jIL0chUdNqLeZ4NLch3dqVFimZP/cr5NhsOonSgC6BZZwSmleVdCZ2m5BniqHKHBzgG45Pp6c2wUdVPrRC5E8BaiHuN1RL1MVO/a4l+TMDw8hGalN8v9ep6Be6ceqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/3KHjMBWcf8iM7x2ihv/ZLOwd4lem0tXXnkpO9SXu4=;
 b=e2pC1Da44MDwjSF7Bi9MAQEVXjhoOsxH3AbGipQbfbu0aXm6/tCR9cvzNqNpKJIfWkiOvWTFdD0yamflvdcWSdoaVK5Z/PNM9gbzvK+vaClnOPU1EfWPc4spFnm6IbxT/rG/dATTuHva4mlrsopkNlwJqk/AMXLb32qPTqQgL1DWeuOHDQmpF5IgOG64r2y2TchB7Keiphg6wYJxPjNKBXpk0/PJGXS9aYUKwDjHFKGCFQgulfNUiBI85TbVwtir1gAHoT5bUW9bslX9Hy+ixbgjd/mXYjv/OxDOfSr7p5u8warQps7WCv6s5o32bWQsjBkyOQxaqdCi6m08TH3w5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/3KHjMBWcf8iM7x2ihv/ZLOwd4lem0tXXnkpO9SXu4=;
 b=lLc6BX/JBpxW7p8Oo+iiFzj9FlzRK2riWtqAsAEVBP7saVaufWbthrRGXxaFcREDWtU4oE0+B/I0jWeYeoWcmQO8ZUJY64M/sfVNMhsXN5QhiuR16k0eHGK/PbSvid+mfgEl3gsA06MZo/3pVeBEicFIW3dwXwvDPgIB6jk+tIo=
Received: from DM6PR11MB3802.namprd11.prod.outlook.com (2603:10b6:5:143::30)
 by DM5PR11MB1963.namprd11.prod.outlook.com (2603:10b6:3:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 03:01:20 +0000
Received: from DM6PR11MB3802.namprd11.prod.outlook.com
 ([fe80::69c6:1b3c:1597:cb37]) by DM6PR11MB3802.namprd11.prod.outlook.com
 ([fe80::69c6:1b3c:1597:cb37%6]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 03:01:20 +0000
From:   "Qin, Chao" <chao.qin@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Mei, Paul" <paul.mei@intel.com>, "Li, Lili" <lili.li@intel.com>,
        "Qin, Chao" <chao.qin@intel.com>
Subject: RE: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep
 in pr_flush()
Thread-Topic: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Thread-Index: AQHXfEaHiU7PgYfePkWUMKzzHnOuTatLw7eAgAAjuoCAGGuFwA==
Date:   Thu, 5 Aug 2021 03:01:20 +0000
Message-ID: <DM6PR11MB380275B5125531E8EB9D019B92F29@DM6PR11MB3802.namprd11.prod.outlook.com>
References: <20210719022649.3444072-1-chao.qin@intel.com>
 <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
 <87o8axm6ae.fsf@jogness.linutronix.de>
In-Reply-To: <87o8axm6ae.fsf@jogness.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 863588b2-53f7-40a5-96a1-08d957bd4d4c
x-ms-traffictypediagnostic: DM5PR11MB1963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB19631B96661827E29EA5737992F29@DM5PR11MB1963.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hi+3Kz58my6BE3GldhMP0VpgcCIeoO7/T50MZqEmzTbsDfbLP0CTSSAeGbFqv0ZLxcTgd7gPGjs7WtDaQoui9xWie7N5k+NhLZwRbGLf8c7pw6/GLVoox7Npo8W7gv0VnFGFXvN/w8IZK45cJy4bJlJf7MDZTXqhZSR1KZcQfiTipAJL7TiDbQk3Tu20r+CURnL3wVdz+EuGDcVaMhmF2LsqwqsvZ3trBcAmJNwDtwXRFKRGpw6BoUkKQoDTmsXzAc+qFWLhS27Ad+63FemKVbu0WVCIoI4/v5vhg0t8jMRGVulx/85USN30OqrrUVeaYMWxWm8r6CCT2sRf8UeoVsxL7eWQnQQXlqzsZW9Y63/KzqLVp9I4jpZwzAEPdujBkJMC/y1zNfLN72cFJJ6Lp+YHEGUP0HD4HKwWSybQrKvUFehD67wLvyaytvEff9zke8d+7keEeepCb9TViEptrr428QD7jDYbGuhVZubxH8zANJkMnUf0VkiRFJjUxBVZQ+MpcaigfMacVTNITVQxcGcGiU11Ww7eQMQTdhaq8KqXKjvSz77QLHfSifyd+L5nLjlWYTs44DJn39oU/vFCyL2K2/o+arHA1h6R3nrHvmPTVLeoNJpUAYJDde6hvRMHJ7DfTdmCy8ZUXsrKjGwvGjyb5H7j8+19YbLUP7ebgo0JEtImS9fRwppgIKqtjIyxS+tKiuTP33hLVPCOJV1w8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3802.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(66476007)(26005)(6506007)(86362001)(54906003)(38100700002)(4326008)(76116006)(66446008)(33656002)(186003)(64756008)(66556008)(8936002)(66946007)(55016002)(7696005)(110136005)(9686003)(52536014)(71200400001)(478600001)(2906002)(5660300002)(316002)(83380400001)(53546011)(122000001)(8676002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/xU5gUlnqw49f2xsS99SKxmAA7UdRjp6Hem6mIJ8jbFWesNzExnOyNfwtWwT?=
 =?us-ascii?Q?QBtiluMyTZub1uiVnSLAs/fmksbdCnx7wxLVhTIo6iL+v1AVj64db2l9vehH?=
 =?us-ascii?Q?jxWKsI61yn33YTTLuMp/SmBkglfmhfcMK36Z0ErkRujVR87iu+kCiLIql7JC?=
 =?us-ascii?Q?GFp9WVLtboFXeqtq0wd8N1qjVRnER6f87ZrNSUuokMwI0Xeh+1sIc+f5YvW8?=
 =?us-ascii?Q?ia5q7ISbvAt4sWGhoMIodc3NLeLE8XUhMCyOeuzeGW+lUnLaA0txFOylJDj7?=
 =?us-ascii?Q?BcwxOpdpEKLY1tOw0xIKBmAwNf35MrI4cWiOg57gTHi4PPaw28JQ7GO9e2aZ?=
 =?us-ascii?Q?wQbSKnnVQoCxevHeVlwGupR5ABIk8EMDAXpX9pL07l6uqWY7C3FIGsraT+td?=
 =?us-ascii?Q?Nsx0ywTmc0pnO2YX3d3UfNxHyObebw7onSXE2hiRivtyHzfM/zWpb+gKnhnf?=
 =?us-ascii?Q?IvyTuB8LwlzUCEa5LQnCf3+0shAii14mNK+TFfN2pzZu+askv0rtAYFqhdQK?=
 =?us-ascii?Q?Wc2ivoSa/mrhAw2B2vHWgw4NtrU75mGkwpIOUkVrvAvEMOMkFS+czV2voqIO?=
 =?us-ascii?Q?w2d+TyT31+3yaHJWlbQ9/Lj2pA7Ifxn2rhNQ47jrY4HsHmo9jLPmF/KnczvK?=
 =?us-ascii?Q?d8wATbKjh0hCaD55xxpfkAsBw9GZQPBgt/P7oKLnRM7N+2IsGGHpqMFz82yV?=
 =?us-ascii?Q?J8bzn6jIZOPCWF+BUZlUN0VzhD3yvTzulhZgtRCIV8JFIHbsFqdpoqiP2reB?=
 =?us-ascii?Q?0wiKy7UqTSqs4xUEx9swsFuEcmnAyKE8+c4zvYeSVMKnlbhIx+9FJ31U7HQk?=
 =?us-ascii?Q?ZzhZTjnbkrn2etTIQbZI3H0ShrC/Ve0HcDc+s5KswZejfeB6qhYJHRQcdBxB?=
 =?us-ascii?Q?aYhBLI/SZd1XTYfgQl/LKBg2VPeUs3FFANawHB1lvRwEez+IcE0vF7uEnxVD?=
 =?us-ascii?Q?r8/emeEW8WmS7mB0kYeCRlrbSHtbxy947Qn99jv88sWqKOLqjeevW0S/fKuk?=
 =?us-ascii?Q?tcgB20kdLNnOkPCG9u73UflT/2VV8dq+kdYAusfu5Eu1a7wR5uq0SWv2LPt7?=
 =?us-ascii?Q?JXBtyy9A2sJ5QgPEqY2+XqDtBoszDM12fdihtZ6F/Ixr/SZRMGHBDeOLFUWv?=
 =?us-ascii?Q?8XgDWLwiAGEMHCW/3zbrCgT+HF95aFWN9QS/v3HyEzhEUiW8LqSxILgrn+bC?=
 =?us-ascii?Q?jRaMQnQbXOZnHT5vxSXQy/pyLM1EY7TDW1I7YeJR36bXo9eqUIjK0Y+EOoAv?=
 =?us-ascii?Q?cXup232ShFl8fwaXCi/Qlije2MsOTCY+XbDJ2NfDF9qg8Pk+CdhaJ+nInXeb?=
 =?us-ascii?Q?Dp4adhnp6gov7uDgnX60a6fb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3802.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863588b2-53f7-40a5-96a1-08d957bd4d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 03:01:20.6086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok4DBoFdW5shgRJWK9XnNw9y4MPBxIW+ykrIn9BRnHVP6l+laAA3TstwDxhzAquHfbhzGISEBQiCu35Y8I7k+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1963
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John Ogness,

Do you have plan to backport this fix into v5.10.y-rt kernel?

Thanks,
Qin Chao.

-----Original Message-----
From: John Ogness <john.ogness@linutronix.de>=20
Sent: Tuesday, July 20, 2021 10:03 PM
To: Joe Perches <joe@perches.com>; Qin, Chao <chao.qin@intel.com>; linux-ke=
rnel@vger.kernel.org; linux-rt-users@vger.kernel.org; bigeasy@linutronix.de=
; tglx@linutronix.de; rostedt@goodmis.org
Cc: mgross@linux.intel.com; Mei, Paul <paul.mei@intel.com>; Li, Lili <lili.=
li@intel.com>
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msl=
eep in pr_flush()

On 2021-07-20, Joe Perches <joe@perches.com> wrote:
> Logic continuations are typically at the end of the previous line.
> And there are few too many parentheses for my taste.
>
> Maybe exceed 80 columns in a single line
>
> 	may_sleep =3D preemptible() && !in_softirq() && system_state >=3D=20
> SYSTEM_RUNNING;
>
> or align the continuation
>
> 	may_sleep =3D (preemptible() && !in_softirq() &&
> 		     system_state >=3D SYSTEM_RUNNING);
>
> or use individual lines
>
> 	may_sleep =3D (preemptible() &&
> 		     !in_softirq() &&
> 		     system_state >=3D SYSTEM_RUNNING);

The kernel now has a 100-column policy, but I decided to go with this third=
 variant for easy reading.

Chao Qin, your patch will be part of the next PREEMPT_RT release. Thank you=
.

John Ogness
