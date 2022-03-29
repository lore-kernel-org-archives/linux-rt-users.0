Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A4C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 02:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiC2C3R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 22:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiC2C3Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Mar 2022 22:29:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF61637C4
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Mar 2022 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520854; x=1680056854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6yWnU6L7HWi3rplFpWg/1uqQ6nXXznHh+Z6uWMok5Jw=;
  b=QLqc4mDZqOHiRGXeC7hwfANtESGkfOIT4dg22iQwKrca5rNToe/Pl6r3
   zLLQkn+JCxD26ENpOjxh9Wd8YqzFAPRXCKgPrm4xYClj0dHb7LfNbAifO
   /FC9mbpomkoK4pQ5em39Vx8rbs4bgdMzSzhciym8lH49MVNaPNDwKnisX
   31j90E8zDaYggG0O/3rgrVs981nUgzPiQtCgHSG2hseseKICg79XBuuVp
   S/fei1hx5au5oOpNX1u59vueMN3j0aBONk0GUXoGOvc6gqxPn89a2ltwX
   IttYRNXN4XJoydlAjkx2swtrbf4v11UZbHnmhAPiPRNjTWYDTJs5jmJ0h
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="256721024"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="256721024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="649280178"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2022 19:27:34 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 19:27:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 19:27:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 19:27:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 19:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/x1MGmKthYRjtkNE0an/zJZYlL2LzAKykhueXCPSR1DbNQuOSZb0K6jPGymr/0VQHm2VCvJhkd+xO+rNP3ddqcaGuLd+LqT4DOCeIMTonQ+b9Wt6viozrZhvL5mv4a8IO8N+qC2p9XhpXmO9N23GJXoiOHfnQp9qOGGcGvQqA+ImOFyK6l5ad0Jci3AZxH8TKYOHJ1pk2ioSpWz34Z9v72tbInTKgNJyZsLYSunqbdh6C0Rv+lSfDsji0/aA5Hce7xyCv3zM91Vk3dX67BjsrrWcRhfsstJQs6pkmtZMxN+VP/mVH9d0uVCmC7ivRHJ2R6eZG5b5eNklkVemUXBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yWnU6L7HWi3rplFpWg/1uqQ6nXXznHh+Z6uWMok5Jw=;
 b=bYSkYOI8pyOxT3id0O390OoaYiJRha/7haoCBsmy1dezqw5Qj5IpnOwda41sIQmZS7JA5ueoVRjv2DhHHfbm9ibqEMq1Y7fOnltUCnMkfgJXbeBprMa1d+6bnbOPNfX+tZuWNoulH7CYMGX7CmPr55k7wryDcJ6PR1xYTjRTyQ7M3yoa2Ig4Tjlvtb16+PM9ra1n/+Qe0JeYPP39dAnHLK5wwK9kqN/HZijojejPAvKSN40z9MPBkka2/fkuf43U0KdDMnF8yWOjNbVJW4TRzpAtII4rKY+Smeymc/91dkvIPUWqix0E2Dpkt0Br1pR3RsfPr6d0iKhjWH0X1pUOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 02:27:31 +0000
Received: from DM6PR11MB4596.namprd11.prod.outlook.com
 ([fe80::5a0:cecc:2762:cb1]) by DM6PR11MB4596.namprd11.prod.outlook.com
 ([fe80::5a0:cecc:2762:cb1%3]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 02:27:31 +0000
From:   "Chen, Angus" <angus.chen@intel.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Ung, Teng En" <teng.en.ung@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RT  kernel video playback issue (screen freeze)
Thread-Topic: RT  kernel video playback issue (screen freeze)
Thread-Index: Adg/WV4r+S4DvCwuQSuPzVnN6R3xtwDt8mxAAACHFvA=
Date:   Tue, 29 Mar 2022 02:27:31 +0000
Message-ID: <DM6PR11MB45963AAEF4717C359986FBCB8F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
References: <DM6PR11MB4596027F97399B46BCD7681B8F199@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB459605ADA58FBEAE43EDD3468F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB459605ADA58FBEAE43EDD3468F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be296d6d-bb0e-4095-a17b-08da112bad70
x-ms-traffictypediagnostic: BN9PR11MB5356:EE_
x-microsoft-antispam-prvs: <BN9PR11MB53566C5CB9E0864CCE540B008F1E9@BN9PR11MB5356.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umFSGCqvlnL9rlW37g+uscZ5lUjImOFvjmTuvvJykNNAUjKCYJ7UiVSep5kEa0WFMvbzrVQF2wDd/1X8Oevzhjmi+Nk7ITRwDdfpowVV9OaeHAeEI6fIVRGwho7da7qCbX9UoSB8mqJcsUBGNWLdE6ucInxO5C5f3bDKRfW6yjFXpDdHtQ1kvRYiuV2LkdO0y+kxwLeMeH0xVzCrVSfU6ljKgegKxIJTJLU5BnZz+O3Sgrcsj58SxsfH48YMbDAeUgoNJuCfs781gl7hReWvbxmT0wEPybwpxcRliKf5ORTcFFuhkJ19vr2nDOQkSNkwiejczB5hNFlUAbGWJw1N9l8DTv3EwMLPGv12wD/ZE65ueGXZgbLTtZ2+ZVGIt0AXvwdB46Pr94uTOV9yrNoSLk32OXJBzA7iR3XH2eeWyK/MYqh24/7aqL6HmDwD8yH52DaX81zjQsSOzflRlgu8Y6GIdTSTDgdfLjxBNBnGg6ZF7wFB8LySDxcKF4fuOUCbh4EEtwD3vUTx5Avtrt4tqQgr3Uqqq9STZQvFtdi1ga1f213X4mV3i0LlSVSkD483ykW2ni1vw+9J9G69qZDNCKN7lH7L1+37umfKLrDd2HieaiGSzlHeca4+d0gySdwr2xF4EoujUUIhxBHyqaOVvFS3ZUI9yNfUpm1MshXae5mNyVrlstuIMv/PR0ZmafN+DaknZfHO32JTsdjsd7awBHFFOsz7KpJmkiCH4NCytbbALl/F7zwrTdWlQJDTpGmh1nV2Kzz0pVIbHmHGNmh30FWu+4d6OXxhRATSQ9a0m5twzBtxdCnsf49036cKKpuuMssmwhWRXasLjr58qgq4qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4596.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2940100002)(6506007)(82960400001)(54906003)(7696005)(2906002)(6916009)(8676002)(76116006)(66556008)(66446008)(66946007)(508600001)(4326008)(66476007)(64756008)(9686003)(38100700002)(122000001)(26005)(186003)(316002)(966005)(38070700005)(52536014)(55016003)(5660300002)(71200400001)(33656002)(8936002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bgz7XgxzbJibX6GhqCoVUlF/DWrivno5+uzqxzL6JmndLKhuWTQgaAT0Ry?=
 =?iso-8859-1?Q?M5FkCl6jlIo2ovK9Li/0/CVyW7aRDzEXcs6EEGh89gip821QtOyu2/nbB2?=
 =?iso-8859-1?Q?0CcBV5PHXEu7apw/2Y6GIaOgXAsREEbjG5g7bjZUko6ixDlksfvQK2RE6Z?=
 =?iso-8859-1?Q?wD895KcUCbyjGc6yBsUmgLN17L+Fkb1tAowPH0f3Ju+5iReKx3UO379UlN?=
 =?iso-8859-1?Q?12dyOmTleIzM9U11P8gwbSHq93gBJ/U+U05G71AII2fR3Z61+KG4nJvBSL?=
 =?iso-8859-1?Q?zPJAMCNoO/rXFC0TCps2bWaqygzrnXKNQBrInILxF9UYS7De0Rr9Kq6Ymk?=
 =?iso-8859-1?Q?vZNL9FVxzTxzrCS/9DpBelQQkQtekcaQVw9zk62ZtX9zck6wspEyeDh96G?=
 =?iso-8859-1?Q?bSBRHhBynQsfbAqVT+r8TuJNADWxZRHbW9NaNaTH2olyf1PKFDtnYcDnRF?=
 =?iso-8859-1?Q?TpjCUp9gS3vCQJ3wlpkSDndrB/bX82MwYPhDpIy4PUdR0FEGk4kCO4Fe7h?=
 =?iso-8859-1?Q?svXxK6d85AltbL54fLWMDBLjNHGc0TTPijrlpUMVIhmKSRHz2/GUTJ75x5?=
 =?iso-8859-1?Q?TOP5YNNHEQq2zrqjQpjNp9OZuT9QFUiqYxK4LYZazgPtstiPvd8ReH6+rT?=
 =?iso-8859-1?Q?atMyrzCwvYmXgzk18pWUEB0qXQ7E5CSIoDLCM5JCWNSffu3ZeA1jPa5JEG?=
 =?iso-8859-1?Q?vgWjFdKFiqk8bhskPpm0yzcvU0m+Rv1RTuTXLASwhm8Ywkx+1Wte+RS9n6?=
 =?iso-8859-1?Q?zGh69VHwyxN12qN0UwRtlbB9H0MWH/g3zwxPH58XHAt3uP0BtDxG8dTlg5?=
 =?iso-8859-1?Q?Pbgv4vYgBwuwT5d1DHrVcsVtwcgOLlsUQjcKrfT69IQ0PhGkxFRVkoUifV?=
 =?iso-8859-1?Q?k2yHfAB9ysRSwwfZo+WvcY3EKy5kNTQg3pefT0DGTr6lu5umUX1Uz8o0xn?=
 =?iso-8859-1?Q?1daXZS9+RhjJOowWmG8Ow8QoZOKoNW7I/JMaxxU8C91JjfRphmr/qzM5xB?=
 =?iso-8859-1?Q?MbP6CfBgyERu01J6/kt+BJzResiCNK1TXk1nSO4VbAsMy3phfBGrdjHbIL?=
 =?iso-8859-1?Q?uw4aUU7s4QBg2ijfdgrsuf7BvRWDp6PXwQG3+T9VhWJR5wWnNw/O3zTHJW?=
 =?iso-8859-1?Q?yHJebQtkJ2OxXTh3z51VJSXWPejmFs1peSQthBwBYxgsVr84sXJZkRDGgL?=
 =?iso-8859-1?Q?31A3l1o+y/Yx6wopPbf01jsUmzvpoVOWmmyEsMWJg+BcXKyBiOfLaW0C4O?=
 =?iso-8859-1?Q?XfImsdpWZBJECZzTjCe3Ils9I5dGabefvDh8DlGNBlOV7wu73QgDawUgZJ?=
 =?iso-8859-1?Q?oa9l2vvAkyogcHxxEfizjo59WZn7GiW1bqrI1FO5N0usN6i+YWqL1+456q?=
 =?iso-8859-1?Q?VnY/9JLqwq9vB4BLLRhY98cxOEutSGuCnimQw+l+NFJogHPzgA6SGvxtzU?=
 =?iso-8859-1?Q?HVihlMbG6r/hXYHiHq1o2SPb+Pm1ld0kuleQQ94oSvx6kRPOR85kKRGMIb?=
 =?iso-8859-1?Q?pIRWZK6gNh1ouVJpVUFuBQKvDpoBwP3BRVgrkwEFeK10yMK1pk6pGZvuP3?=
 =?iso-8859-1?Q?7l026/uKsq1pFHB4Ujtu6GjYxQSBxWphZ4FxUKHeaOyvfglv2xrf5AZGPz?=
 =?iso-8859-1?Q?SRAqa3q8BqA1l+nd4ddeeQoRNvgubTCuO8giikQ+r2phZvvqTsMSRnUryr?=
 =?iso-8859-1?Q?d6F541GPy36imBtfM3LOMCgWnrkOPSsYUB9b1T3sVl9RjOn2OH9GFnumS9?=
 =?iso-8859-1?Q?ibcgWlRsxsbkURQM+q5PBYJFQ1snOVL6txus+N2HMfyCRcD+pR1GlZlryC?=
 =?iso-8859-1?Q?JP3CqBhcig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4596.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be296d6d-bb0e-4095-a17b-08da112bad70
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 02:27:31.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMUmclkwfZkRU59SSofq44lGHNvuELDKf3oS7QbvCpRtmwO/zPLa1OZWgmS0cd6Kdg2riQUfodFXfEjDt4UFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hi there,
Sorry to send this email again. My previous email was rejected by email sys=
tem because it only accepts TEXT/PLAIN content.


We use 5.10 LTS kernel =A0with RT patches, but recently we encounter an iss=
ue.
When we playing a H265 file on our Tiger Lake platform (OS : Yocto, CPU : I=
ntel=AE CoreT i7-1185GRE Processor (12M Cache, up to 4.40 GHz)), =A0we enco=
unter a system hang/freeze issue (without enabling GuC submitting)
We use the following command to reproduce this issue.

gst-launch-1.0 filesrc location=3D/mnt/media/Duck_3840x2160_10mbps_25fps_Ma=
in_at_L5.0.mkv ! matroskademux ! h265parse ! msdkh265dec ! msdkvpp ! 'video=
/x-raw(memory:DMABuf),width=3D3840,height=3D2160' ! glimagesink


We also can reproduce this issue on upstream v5.15.27-rt35.

The dmesg log from UART port.=A0 After the log showed "the sched: RT thrott=
ling activated", the screen freeze.


After bisecting, we found that it was related to the following patchset

https://lkml.org/lkml/2021/10/6/367

If we revert this patchset, we cannot reproduce this issue.


And we also found that=20

If we revert the following patch without touching the RT patches. We cannot=
 reproduce this issue, either,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv5.17&id=3D2b2985a417c7ca1752a4f0b2631cf916dabd43b5

but this DRM patch was merged into kernel mainline a long time ago.

You are the RT kernel expert. Maybe you can help investigate this issue.


P.S.
Our RT patches are always from https://git.kernel.org/pub/scm/linux/kernel/=
git/rt/linux-stable-rt.git
DRM patches are from upstream community kernel

Best Regards,
Angus


