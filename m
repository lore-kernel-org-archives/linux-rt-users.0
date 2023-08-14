Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C7C04A94
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Aug 2023 09:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjHNJAd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjHNJAH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Aug 2023 05:00:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151F2120
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Aug 2023 01:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmWrAAdME6CxaGldM/xP+CiXkCskTWCPaQ0kJil9MQ7WiqWM/ghxuQDGYdnlGpy3s7BlLwPBd6bNrKk5w2rlESzp2H2Vhq11aYP1fTaAwgg1g/6DSyB2YjLvumoirRm9mOA8Uup2vczpjkZQqa5mSE367wOrSpGdRzewD5tl+n+GsGPWBdlZLb4qvFGydj5EnEIICRF1aCuPNcPc5IQL1+nfMal6fLfz+sagQuVYEb16hFs0ytxFlgZq8lZkHxyDkU8QeJZx5ufF/o0UJSALSiUdjUFExJjlrczB+0/ghxan9f/jEb0hBJtVl5nA4ru7r8gNfrxftOmtqYzK+rRm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfkiPk7RpCsWikr96WfRqLRHDDcCnZXSPQW9ofIm+EQ=;
 b=PmkxyTGsOO4B2PhVKD8gb/hQdxaklLQsbCbASwTtr8XfIK9o73PMzYFBt2Bjx2lcPO9NVilshIqS4lgEQAW3pBrKzN4Iyjfy58igMkTd6eW1NR8c/EOQhbKBq3fUdidPK4KTkFfEpF7bTlhWikluRStHdmAEcmcCJwT+rl7pw3DCyQfP7cOkIq+qhNGPBHWtTRgnFv+E8/plyFmv/90i5kH6G2yR6dtP83ZiEhYMUkeWd8kh1Fe74jCOqWmQR87xFRhxq/RVollLN+lLzb2SdVwNbYHcaxZItFtJFTxZMHVcsXtdOx9a6g11m7O74LGMkCCw4TeAIKPr9OkHIxTKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfkiPk7RpCsWikr96WfRqLRHDDcCnZXSPQW9ofIm+EQ=;
 b=xXNLLgTIYSnc1spwCMLxoKV5W/TGcTf9rDjMXDWUymrQvDpQNXOmbOWAiER5viZH5RGM6nSuzVkmTu4KFxzyTJpyrBqmESGjNGjWqzYaUm3oEtL/9qTwroueJm/YscyAerFzTMm+012BPmnCBoaaA4+Sc2k8yDlXDajm+Y4snZQ=
Received: from VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:5::26) by DB9PR01MB9487.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:361::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:58:32 +0000
Received: from VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 ([fe80::5cbc:52a5:47f7:bc5d]) by
 VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 ([fe80::5cbc:52a5:47f7:bc5d%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:58:32 +0000
From:   =?iso-8859-1?Q?J=F6rg_Sommer?= <joerg.sommer@navimatix.de>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Wrong link target for 5.15-rt on website
Thread-Topic: Wrong link target for 5.15-rt on website
Thread-Index: AQHZzoziK6u2ErmGaUCRFnS4xpM1Sg==
Date:   Mon, 14 Aug 2023 08:58:32 +0000
Message-ID: <VI1PR0102MB3136359075B0312101B31333FC17A@VI1PR0102MB3136.eurprd01.prod.exchangelabs.com>
Accept-Language: en-DE, de-DE, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0102MB3136:EE_|DB9PR01MB9487:EE_
x-ms-office365-filtering-correlation-id: 55b865d1-6c3f-4cdd-2ebe-08db9ca4a2bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPmmPMlRrK5F9b8CHGv9tdft7jeqLUzVQBn5pbB9B7k3sxikdzfuP7o/EYDQYKuetHU4e4l2kQ8kZe9PEwd93zV8OFTexydBu5Fnz8Gq5DtSAjIalgbPVGHaSFN2n+FvAjzVCgADLPQXh00ouTpmK3G8Rtb28kkU5GIRdJNPuFrSDrRS3iwpBsoZZy8fpEeTdqnChR3WgML8LFyb4yYvHsmRONzzrgYWiAqnwlSdg8YfC+XDgkp1VanCMFCUD8uS5U1Ell0pIrxLppuMnxNgodJeyibCP9+1FC15aemphZ/GjoWxfiKnmFuqvoOndnL+o3WnPVJFxrI68YceyqIWOIwqNwxk6hGkflmQRH2AartxXCJnZ93Jowp/3np+fRJM7JXzpqojwdvVpS7W3A8S4TrpCJ7V079G3+RFFq7928uviUIEpSHD01Nou4mwFWmH97/077a6lRwkzoN3nOs0MqbhzzVW9ZgD/k+B0TuWtce3UxXGtKOg5XXLntI080CweaQDB+FV8N0oaKanDQ3wRczYfJenUO5pZ+m9a2wsrkO5cgTURK7n1VPyhPgtW7v93Qb29fPN3BKNVannpF7vhRFEk2qwRvny3elWs2yLaG0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0102MB3136.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(39830400003)(136003)(1800799006)(186006)(451199021)(26005)(6506007)(41300700001)(8936002)(91956017)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(8676002)(9686003)(966005)(71200400001)(7696005)(122000001)(508600001)(38100700002)(55016003)(4744005)(33656002)(86362001)(6916009)(5660300002)(2906002)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tQaEw32hLVUAH+heDE/oFs3052RWohsOVEi8M/bTJitMKZM8EGEReRZxne?=
 =?iso-8859-1?Q?cLewE4WBkIC6y1oNIxdyPwajM+eP8h0bqgf0mvfyQveqmxc9+pb7XleU3g?=
 =?iso-8859-1?Q?GouANhRG/3m5oPiTZrIT7Ipc0eYBNSc0Ko8twSEhGEq+ksm7If5S0fy2Lp?=
 =?iso-8859-1?Q?jIAxhh0FFYC2iYpHw5iKehg0Tqh10/d9sjlH6LVQ+kqorT72r2q7MlZy+q?=
 =?iso-8859-1?Q?FBc2GJ+qlY4me53YT3wS40AUOxNmSGmxF/mBagpnbv2khZ5wpyffCl8sF0?=
 =?iso-8859-1?Q?V5hKvakjDBvvpzHdc8Ur5E2nYH3O0oTseHY55ZfUx1H/kpoRP3/kJobtMp?=
 =?iso-8859-1?Q?ahoVxz6rjRvLl9c8tRgOYmuT/l8Lv1830WJVUUghgiaTCO8twAGmJpzhlG?=
 =?iso-8859-1?Q?yZAQoXrX5NJ8TJNZj9+cz+ZHTfT3R1+DshMk4tgHh/kFZ+puyyUCMfGyFh?=
 =?iso-8859-1?Q?jsJJq4gSrFNXWV8AgHrEdo6IMc8gM6cnZURqn+Ege8HbSlyoVbRfoYIZXx?=
 =?iso-8859-1?Q?C2O8GhgSG9ZHDm0m8wqcmtvhoRxqs8YLcBH9I690Eh4AAWso7mRCfESF5o?=
 =?iso-8859-1?Q?WSXGFJyFDs8iwxmnTwOs+kHlBzIjOWaRUrE8EnRLCFz+iA8vQ5+vrRKo4O?=
 =?iso-8859-1?Q?f3y0lwMMFZW5IGDsxbavJEBZf6gfNsNpqxI/KfTsYhQ4Ob1Djio0ZneAjT?=
 =?iso-8859-1?Q?zsRx7xcj4YBteXWcLooR2XVCEdLs4rhjLAKlXq2VHfBOvN+DBoxPvezVhl?=
 =?iso-8859-1?Q?0X+/GDxejrx9PRBff6JokRO7H7h8/BjvHKyDj1bmun6gdVANxOaXlCOAB/?=
 =?iso-8859-1?Q?cuLUBMvQnmQP2YN8SJQKfORB65qoNl3IQ5el6ksiZYU29jYklRzZhN4fqZ?=
 =?iso-8859-1?Q?JUmJ//miAV4p11G0NZrxFNKAAT6BReVeoKt3/OY90HJhQlm6jzhlc5W8qF?=
 =?iso-8859-1?Q?Y4+rAgIep0tjU1B5FFtLjXiUncJJWmigdgvsPycqw6Z4qexQcDZzz7lRyh?=
 =?iso-8859-1?Q?xCROhETzcHQoviqe0WzjbPZj3cgfOdJZViQMS7tES61IXVnk9jdOi7CxEi?=
 =?iso-8859-1?Q?FRy3fIp2AUlwPQ5duyECTDfgQZmnwDNc3hzjjqrDG0yWOGj7p43nkXPGXz?=
 =?iso-8859-1?Q?WxbyJF8yk598sXixHwdGihVUi86jOjNxuX6CzkJYVTIgD3SYjMd1r6h4xG?=
 =?iso-8859-1?Q?c94aL4gizltmbuv8WL6R6o6LirvB1XT0gN1hTt7RnUbUDVGr3FCo2spNkj?=
 =?iso-8859-1?Q?uxY1WfxUCGZ94OK5/cMM/EbwFIaiKSfLT5+Gc71IDMILlq6TCvm3xnbvBr?=
 =?iso-8859-1?Q?SlHpWf6JQgMWZEMDqZ9HtP01xEBtSCTpvAbXWAwr9lpvZvLzvDYLexD1N7?=
 =?iso-8859-1?Q?Wb7Rqm87KWNQFv6UcgMGU05OBN3/YlJWobRGKu0PGdNTXqf+g1Tz4sA51/?=
 =?iso-8859-1?Q?OWcx5fn9kJPLlxZCFP0+DbR9RvLEx56UapomzJflr3IMbXA6Se1naNwNxQ?=
 =?iso-8859-1?Q?YrhyZvHdO+M4eMOR+xeyDlA4nAif3BMLmZQuE6prgPId9y1FMwdbpz+V/B?=
 =?iso-8859-1?Q?Ce66OXxdBmnklyAoJc1UK6Abq7OX/KBbEyIi0d5rmdcdQ1l5+CJJegmYJz?=
 =?iso-8859-1?Q?ve91/sWaitU5PL41A8i354KN78W1eJJnw6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b865d1-6c3f-4cdd-2ebe-08db9ca4a2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:58:32.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IawqhiNeO+WWGNk2PeQgfPZ+ZJKZvBNb/P+ZWEIJvanAZYJYyzAlPiKUikV9jfQmmbcB23mjWJJW7LU/YFOx52zlMdWZA1cVKCltYsjPLGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB9487
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,=0A=
=0A=
at the page https://wiki.linuxfoundation.org/realtime/preempt_rt_versions, =
the link for 5.15-rt on the right side points to=A0https://cdn.kernel.org/p=
ub/linux/kernel/projects/rt/5.10 and not to 5.15. Can someone fix this?=0A=
=0A=
Kind regards=0A=
=0A=
J=F6rg Sommer=0A=
=0A=
Software Developer / Programmierer=0A=
--=A0=0A=
Navimatix GmbH=0A=
Tatzendpromenade 2=0A=
07745 Jena=0A=
=0A=
Gesch=E4ftsf=FChrer: Steffen Sp=E4the, Jan Rommeley=0A=
Registergericht: Amtsgericht Jena, HRB 501480=0A=
