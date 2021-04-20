Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB931C433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Apr 2021 11:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8081C61354
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Apr 2021 11:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhDTLg1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:36:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:38701 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhDTLg1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Apr 2021 07:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618918555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xo5zs+ILEckB7jkcWZ+Bp+ImbzaDaHdbT8owpwXju5k=;
        b=BGF206ejpowMBOMmb8+2bUK40cxnJv5oRVETu9brhp3yM6JsDmWuRoTPcJN2PJw1iseH4w
        37qG5P6C62DpLJgbhZ5Wf52Jt6dzH7MIdHYSf+0JF1ECvkYmO/9nSY/qH0CH4YFauuUkKU
        yVYfXUWir/VOVN6zTJF+WX1WujS7PFg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-yyJas4seOBG9bwhBUEi_eQ-1; Tue, 20 Apr 2021 13:35:54 +0200
X-MC-Unique: yyJas4seOBG9bwhBUEi_eQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a19zsaMuUvVIRoTiO5JTOLK8zXT8m7+qwfjSTRt1OACDtBvbHWEHpxQhpprPajJO4bS1IsU8Opd9/iaywbNnrgBq+cnNUT52xnf1uqavA0l4UYd0Lj3g6s6L5UD39o6WfgfvYgMzj3XNQpG4/sTHj+M7pYeNQRrPLWtY/hpYtOOdCqTFpNehw5Z0Xe6QBBcR3EMKkKkI1BcV44Q4UzRj+RIy2Ec5h30oVZ2+3wHVnGgEwk0BdWFaoAKIqIr5IDjM4GyH5QdEdgx/xj+pk/ryGM/J8jJOdzYFbNSKm6BWAjWVCrX9eJScKfCSjsG9uwokgY+qiuNnts2jwHyxt1LSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aah2wUEBXX3+RUQ9XUkXfXgy13XtMn0HWYCigLTWREg=;
 b=gpsgPTwjgDFIqmF8u4GCD4zhoQJ8VX3NSrAz7q/t6J6CYmzqmCQQzR9D2SwcUcpxyGpiNlL7wWyFdivcCdEyCtVkPtt22sTZEUC2mdjaKwVPr+xlpqjs4OMCyfjyjo478EPNog9cLvRYODSS+FnVHeY++RjiqxVdD/KVz1cPVAnfZzxPYLG7Xt7pDQ/kAd3Qd8AUkfPqvrOgjnfHWp312lXWX4Ofb+9XM6KT0QB3b8iZp4FqCzszFvmk3aNrqLmAmJpY92wu60oTS7FQfzgG3u9wrmet+igkfiGK+77udCZzPvclemwvBCa5Wth05fROR6ir/iegIGd+cOQ8kYZ55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM9PR04MB7507.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Tue, 20 Apr
 2021 11:35:53 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 11:35:51 +0000
To:     linux-rt-users@vger.kernel.org
From:   Varad Gautam <varad.gautam@suse.com>
Subject: inotify watch not triggered with PREEMPT_RT=y on KVM
Message-ID: <186e6d50-36ae-ba6d-bb81-d90fb0152fcb@suse.com>
Date:   Tue, 20 Apr 2021 13:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.179] (95.90.93.216) by FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Tue, 20 Apr 2021 11:35:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdee15a9-9931-4ecf-1c1a-08d903f07334
X-MS-TrafficTypeDiagnostic: AM9PR04MB7507:
X-Microsoft-Antispam-PRVS: <AM9PR04MB7507F5D760B075B13B8EDAE0E0489@AM9PR04MB7507.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pf2KB6TkEHH2r+37RDtPyab35sUpbSzrE8xnicOP+VDhlqhu6Dob1ruJQ1Djw58RdzE45yCZjUbmSq1wyVztHfsi0hdvY9SQ597CwAOoL30zb+YQrL4MAVL5EsWi9C7MR55xd9ofn/1SXv9VLOHATUZyE32VxXRNLJuK2e3CAQ4nufN3fhSQjn3U1z+VLSnT5ntn3FK0RROQIDV91MjVDdrI4hhLGDWWPY3MOgpV/RQ/svYshUiuY3hYpYvj9PPJe3XAHFYJ+4ekA4yCJNRa7923B0cWmlwbKSj3paiOq56Z5onOaYSqAsZ/ejF3gy4SsgPfMj5F3vcSHxYboojhqlIGnrKVK8kd1UbbUAxg0A7bijFlTrtUDqsicI86e1snTEpHOM/wY8jpkXm8XdI3ap9dXRMLGNt78HAZi0b0uEa3tf2v5WLfQ6iMs4JesyKbAbnHT9ubz1spSDzeOnd8kfS43u7DxUsLqLUR1V+ivjC+QI+/Z3Q0wkjYNH2BjTaIzioZAa/jvxV69BVG2rx9osCe3kYziPxhuYL9gdYnapGqVTylIoSZaLLnQK9frSSdlEAsXPdU1U/RKsXsZKP6ix0ZenjF94FCrUaEQcugsXQ5XoM48Aal1eFLiwPfsUfHipCfp49qWKGuThV5oWZSk5qmaecorKYcuQx5j6UdZOySltscNgzMhBX1l8LO3mV7WVnFKVDN4QkSbMr97jWzZ48fA/tYuwHIWfvx3cElczs81XIwcJG7ZZD3Aw8XleMrSQbMJFs/iMnyIR+nXZhWhnLA+XM6KLhInZtaL0uduEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39850400004)(6916009)(83380400001)(31696002)(6666004)(66574015)(44832011)(86362001)(26005)(16526019)(38350700002)(316002)(8936002)(8676002)(186003)(5660300002)(66476007)(6486002)(31686004)(66556008)(66946007)(2616005)(478600001)(966005)(16576012)(956004)(2906002)(38100700002)(52116002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?adp+zKzLjSTyXG3e4QyZJfmfr/fgfSMEgwr7x40BvBIqgbgekF110IXBZlzT?=
 =?us-ascii?Q?5o9pn0AQf26yR5Du3opTJ4LfHORfSWr7PTnMHCjLN+Xx5Glo5ouTKS0L10c5?=
 =?us-ascii?Q?thXIrku/QFf3hrKxjeDpqj75LOcjIJepKp444XKEHLXrQW/eduJMqQxVKv2Z?=
 =?us-ascii?Q?CTH96lL6zfqRI3pHw31WX6PzJ32fsi9ye8Sm5QKbawPbV+2ir0xZ0z4ahx87?=
 =?us-ascii?Q?nCE0KfW3slbGrglJPaCmhDQ5efvWoTZ/I9jpiHccLGJjAHEZy4IzvkRTlcrt?=
 =?us-ascii?Q?ld+y/hcT9qGuLM2bSDttvN3Ij68SzvQrbnwj9HZ/1Hmbl9wrdcH2c0GOP7C8?=
 =?us-ascii?Q?gIFgV58z7cmBIIiB/Btq8/3zpBoRyzufvJ1w1a4VHirAO+8AV+8ZCe+nPRzR?=
 =?us-ascii?Q?MNY2AMZjUK9OHP7zJfkp4N3s7h5KW/Y6AKknSVa2KP4Il+BHJ3tlzgdV8Vdn?=
 =?us-ascii?Q?mzgAni9e85LwwNKf23MVFixkX0LyfuF+Z9H195qer0A3GVEe1PTO8lSbFmie?=
 =?us-ascii?Q?Xg5bl6ws8OiB3nS+xRLhXTn95BppC87Mqzgt4DSmiCm5j37eyg8pzS/NRIHy?=
 =?us-ascii?Q?MwC9CAUf8PHPPOjwA5zDcUy1wG30IKoJJq1LVqJp/jcurAJv8zRW7G2Q3XSO?=
 =?us-ascii?Q?3A3APzkU760y5nAz00Jjh3BqdIM0maL+fjcsvuovWeSaMAcvZWlRrpJWS5LP?=
 =?us-ascii?Q?G+2aiGSxwo/jX7RFmz5TBhc+4yEfiOzs0+K3TIwb7Fdt2MMX6C6DXi8foFF3?=
 =?us-ascii?Q?wzr6P0kcBdqk28VLp9bq7JaTPYjq0yHz1QwBsZS2Oa1ocx9daRMoC1GLsvDA?=
 =?us-ascii?Q?9INjsao5ZblOx5uPALmvwqtJjImScHSMs/ySmtmT9YQ9Ebc4dQp/u+B4N8HX?=
 =?us-ascii?Q?nvitEuWZj1UF3+c1fU2SYOxeoMCiM+QaHBkHT7IS5BdbvfUhghGddFKj/ppa?=
 =?us-ascii?Q?y/J8cVdKoJ5NjTetZBZz4Z//+9n+XY8LCgNNH47f6aF/i5x01gr/oyPN4LKE?=
 =?us-ascii?Q?jCkj1EmGiySO+i0dPW9UMcPpIybuyziVyoNpNYr7CRPxsXmjE5aFGrIKX55w?=
 =?us-ascii?Q?BUoCHm3Dbf4WdV4jxWW/spt55Jy7mkoC41zuTY7tAoKClvWDQNXKi/NLuDJJ?=
 =?us-ascii?Q?yzcFdCXLetPNzVOF9PJmQY1kuzpLoTBWClG/rI/QqKgq9peKSR5Ez1dni0Uf?=
 =?us-ascii?Q?LPXBEy40tr41zSlPQsKfm/QR3zLY//ZWy8P+H9tlKLlai4sWlYmMMCmtuUYx?=
 =?us-ascii?Q?TmooDZ+MS5WOQwRXoHp4tJRZdIEvrYu8LkpJLyDUhg3X7xr0IaCWs3OHBZ67?=
 =?us-ascii?Q?Bqs+TktCScfPEZJGtW5z0Bh3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdee15a9-9931-4ecf-1c1a-08d903f07334
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 11:35:51.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3558JbPdU9t0DLrAW69EqVQVuMCH6uhQAst/DJwO9YNt/jAXh2F7hVXUPgjoFYMJJoBqTOtaYE1h7KoYR2jnVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm building coreutils on linux-rt-devel v5.12-rc3-rt3 e164cb00df1 [1]
running on KVM, and I see a consistent failure in one of the coreutils
`tail` testcases [2]:

FAIL tests/tail-2/assert.sh (exit status: 1)

I see that on deleting a file, the inode gets dropped, but the inotify
watch that tail registered on it sometimes does not get notified. This
is unexpected for tail without --retry.

# touch foo; tail --follow=3Dname foo & pid=3D$!

# cat /proc/$pid/fdinfo/4 | grep inotify
inotify wd:2 ino:123a2 sdev:fe00000 mask:c06 ignored_mask:0 fhandle-bytes:8=
 fhandle-type:1 f_handle:a22301004fb29f63
inotify wd:1 ino:1239f sdev:fe00000 mask:784 ignored_mask:0 fhandle-bytes:8=
 fhandle-type:1 f_handle:9f23010072246970

# ls -i
74658 foo

# find . -inum 74658
./foo

# rm foo

# find . -inum 74658

# cat /proc/$pid/fdinfo/4 | grep inotify
inotify wd:2 ino:123a2 sdev:fe00000 mask:c06 ignored_mask:0 fhandle-bytes:8=
 fhandle-type:1 f_handle:a22301004fb29f63
inotify wd:1 ino:1239f sdev:fe00000 mask:784 ignored_mask:0 fhandle-bytes:8=
 fhandle-type:1 f_handle:9f23010072246970

I can also reproduce this on linux-stable-rt v5.4-rt-rebase (0dc167c2b2) [3=
]
running as a KVM guest. Non-PREEMPT_RT builds work fine, and so does PREEMP=
T_RT
when running on bare-metal.

Any suggestions on what might be happening here?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/c=
ommit/?id=3De164cb00df1c
[2] https://github.com/coreutils/coreutils/blob/master/tests/tail-2/assert.=
sh
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?h=3Dv5.4-rt-rebase&id=3D0dc167c2b2

Regards,
Varad

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany

HRB 36809, AG N=C3=BCrnberg
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

