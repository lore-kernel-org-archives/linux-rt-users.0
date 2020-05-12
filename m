Return-Path: <SRS0=+khU=62=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D7C54E8E
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D371206D3
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mobileye.onmicrosoft.com header.i=@Mobileye.onmicrosoft.com header.b="z0Uk6kdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgELNac (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 May 2020 09:30:32 -0400
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:7808
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729901AbgELNab (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 May 2020 09:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU9trWzI0dvTyegrhM1I4eKjzNPmfWnTiSQv0+GDyTp3SqB0oFZlPqTNRqaxevj0lIaG7dDvf/GQDcyeEaAC8clI8FuY6YP3gl8ezfo3cIq6S/8g9qJgmYjw8rHcGtoFCYNkoTGTH8rR3rZIidka/3MgFj2CZDnppsgpeJDl9IrZhFDgnHwV5pJEaxaQfuYHrEzbMQMPP9m3SAqva7sz+NbNYAHq53Zlvgfk7pSqcQ3y7IuK1T4cjPT4cAYSddKEedPddhlIRDisjGeutCOM7eUvQmWAbXMEXaPZyBMYSAunMTiFWYbQww5XKRHnsHFS1IwakjAY6MrFVBoQPzh/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICXoKcZURZ5fq9vMhLhXlthwoZWlp0NTnSeDYiqo290=;
 b=KEV59j6yGpsr8PbD7V0fs4OWnZfHDHb9oKeK6GlSHb2LI+VoLy0QAcpNr2d4MKyS2ahzC1BiJVniSbqrDOiPnSbJ/epAEw0TqzVehv/OmIgP81rX5E1EdM7qN3PS4HPhGO6XEyd7sdk0Xar2nEqDuvEmHu2grcDjRKU5FilycgrSHu4NUmqUku69GdVNioPeH3tdwUnh6JFFbO5zeqvOIvsYK8WN5FmyI/xZmpnHT/MtEJd07vii4BaiSko98WslspixoYoeVK1n9KuxwIdxRUuPWhhZCB54ubNak81wN0OjdEAMSAlRz94TJA2E6azL5D+QkXwPNcIQk4ikQ2YAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Mobileye.onmicrosoft.com; s=selector2-Mobileye-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICXoKcZURZ5fq9vMhLhXlthwoZWlp0NTnSeDYiqo290=;
 b=z0Uk6kdqVQuGd6e8QAMORvCd1tXpLO8og23khQXLMLYzZIATZ6ORZ0z7pgB5zlttJWA1Dhu0W9+Usn6PcwJO2FPhduxZgspdPloOgwZAgxBniXOqNwE3FGiiP/oyR426yGTBVgZEXqAwhxfU0FglqMbmhzeKTzaT29y/2eXsE20=
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com (2603:10a6:208:181::15)
 by AM0PR09MB3985.eurprd09.prod.outlook.com (2603:10a6:208:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Tue, 12 May
 2020 13:30:27 +0000
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c]) by AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 13:30:27 +0000
From:   Elana Copperman <Elana.Copperman@mobileye.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Vladimir Kondratiev (Mobileye)" 
        <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
Subject: Re: cgroups CPU time management + PREEMPT_RT
Thread-Topic: cgroups CPU time management + PREEMPT_RT
Thread-Index: AdYkm/M/lU1yRRU5Sia9bqNtzqcgHQABswywAO9u+OsAADfTaQ==
Date:   Tue, 12 May 2020 13:30:27 +0000
Message-ID: <AM0PR09MB3794A1DA3C38B31A4A16E9DD99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
References: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>,<AM0PR09MB3794E9CFE8BA31852B712DAD99A50@AM0PR09MB3794.eurprd09.prod.outlook.com>,<AM0PR09MB3794F5E857CB761859BBEF0B99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
In-Reply-To: <AM0PR09MB3794F5E857CB761859BBEF0B99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mobileye.com;
x-originating-ip: [134.191.232.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd0f79e8-eafc-49e6-2cdc-08d7f678a26f
x-ms-traffictypediagnostic: AM0PR09MB3985:
x-ld-processed: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa,ExtAddr
x-microsoft-antispam-prvs: <AM0PR09MB3985B53675E22F463E4D028399BE0@AM0PR09MB3985.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjeJ9cAKguU1Ph0sQc1oD9FNDvtUSdR/xT2kTun2rL9iYx2ni3goPUA0b86ol0T0zQqEOLftveK8Bpf0Nc+hHUJ87QXw8T7cqtho63ve0gELoVhDq3woGBBy3tMy4kXTzZnA3ceCmvZTQX1Zre+2S3coEqB7e2ivlr3uI1xWFdoMZG7v8IGCwql2B2pZhfrIVlH+npt+0n6/grTrSQ5wX8HtJMYGEk66lORK3qe+3L4WnkurmyZPOp9oFU0PF1+RO0QmQw7S5Zw511RpUnVc5mpVGk85M4pzOlLeG1QFg4vFfUxjcQ/FSaQ9S+VVyeKJAV2bQxXOLSl1dCLdN7rplLt6lKKrqIYxHuyJuzjBpN0tV3//qFzulUG7mJJLeK0sPt4ZkTJQwtNaLhGh5qR8bc7Qh2dJoB7zfZ4oIijxo8IuYfGtwpqMfCEANOVP3uXpyA4bW3Mm/cZgkHVQ9XpnW2yjgp4FlIEke/Trisae4iYHeUA+vJ8R2yNlshSjhnKjS/5WbV0oMUfQ35gBBh+aHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB3794.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(33656002)(478600001)(86362001)(26005)(6506007)(71200400001)(33440700001)(186003)(110136005)(2906002)(7696005)(4326008)(66446008)(66556008)(66946007)(5660300002)(52536014)(64756008)(8676002)(8936002)(316002)(66476007)(76116006)(9686003)(2940100002)(53546011)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xEz8wXBJ6Tz6V2EOM3hhhn+tdbOqdjt2MGrX4BdekOjZx9xP+WThZNwmODNhUSetznye+GhBev2gNOTX+N9i/yKGZfqAAn10o1NQYt4POqXhQBkTy8mnDDMKInzaVCck5HsX8f3P+2vSk4uNlDfs6W5SBjjbSC9E598xrhiHiYZUBS8FS9YLuOnsYf0MuoKo00ZsilYZkiYZRA+WORbc1lg9bCL1vtt9X6j5XS4BbOC1b72txA0L0M6rZA5BR7BtGv1SQc9YaMBDCBDjCqNIbGL/yJCJiXSTe8AW4ox77O6IDsN6jhoFVN0y2vhxGSWy+F5PaA0EtSBz84rBAz/EfrooJq9a7hoXl19bVN38De24IwCwWzPhkbng3e11m7SF3+0HsMom1TKqlXZhOItyxcXjFYZulcMDnwLNm56cSzNTUhZA4TEXZmE3aQCL1seFpfuBw5xdRp6c228so9U2pQZaPdYSGMIBRATolNtIwDv4UPnqWovdgeOhYrMQAy+K
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f79e8-eafc-49e6-2cdc-08d7f678a26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 13:30:27.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diKdZ78zhxa2Yx+1ZQC8deJqRC7+4gMFddyA7JggRWAZ8RCuuDoj7OFi1BuNg9yT/cy8fvrBv2yf2weDH8LbOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3985
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, can you help to clarify if there is any implementation support or evide=
nce on configuring cgroups CPU time allocations for RT tasks in conjunction=
 with the PREEMPT_RT patch?=0A=
=0A=
Or are the two requirements contradictory in essence and not jointly feasib=
le?=0A=
=0A=
Thanks=0A=
=0A=
Elana and Vladimir=0A=
=0A=
=0A=
=0A=
=0A=
From: Elana Copperman=0A=
=0A=
Sent: Thursday, May 7, 2020 10:08 PM=0A=
=0A=
To: linux-rt-users <linux-rt-users@vger.kernel.org>; Vladimir Kondratiev (M=
obileye) <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>=
=0A=
=0A=
Subject: RE: cgroups CPU time management + PREEMPT_RT=0A=
=0A=
=A0=0A=
=0A=
=0A=
Hi,=0A=
=0A=
We are new to the mailing list, and new to PREEMPT_RT.=0A=
=0A=
We are working on a project with a safety requirement to configure cgroups =
for resource management, as well as functional requirement for deployment o=
f PREEMPT_RT patch.=0A=
=0A=
cgroups in general can be used in this context, in particular for managing =
resources such as memory; and even for managing CPU time for non-RT tasks.=
=A0=0A=
=0A=
=0A=
However, we do see a potential problem with RT tasks, and how the CPU contr=
oller would work with the RT scheduling.=0A=
=0A=
There is some obvious concern here, and this seems to be backed by what I f=
ind online regarding this question.=0A=
=0A=
=0A=
=0A=
Can you help us to clarify what is the current state of implementation, and=
 if there is any support for cgroup CPU controller configuration to work ef=
fectively with PREEMPT_RT for RT tasks?=A0=0A=
=0A=
=0A=
Thanks =0A=
=0A=
Elana=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
