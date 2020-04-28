Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762FC83000
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3B3206D6
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="UV8SbGzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD1NIB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:08:01 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com ([40.107.7.95]:5156
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbgD1NIA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 09:08:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnW6/KHlCkMSusuFHFB6Eo7N90jhIJICCa+Lj8tlMdSVI1oYlc0xsJ3CJrvzm6lvRROooZwtqohKh5ose4v9F86CNv4rePtSVW7eDZq+MviTqrE9IKyUkt1wN31cYfIStgB2r28LTDERlDcMeT1saw3kwwlt3ubuiY6pCbU0qNbnv4GGqfJF4M2ZGoLXZNN+ClSfFtfc1sc4fAVOJYsYym4udfdKQ+Rzrv3VbIsLeuphQOQWeXe4KtYZK/g56nDQFCWI7Zi0CdJ1QDb/g1VBU0CCfl70psNC/Vtp8meGiVGPYMV10OLKJzApzjAn4EcBvSJM3WuCgpwdgqEOKy+MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYgtue5ALmZyrZ0qSvjVDjS0jeWW1DvnFGoTKM/dvxo=;
 b=aFBsi00W7FAB3W82qxAIo+j0IEBNBaNkElVeAOYOXAhRJk8UPCQf9mJS5B8Si4/Dg/jT04MEir0xESTX5qIFCoYlzjGZY3SmzRllx6YlTtxrXS9CpiopXdNWS9V8Zdnipf/TtswRSKd6k105z5c7Nw3DmshO1oQHZIGeWe9OGNcM2HPsNr3iBW6k4KhCkCdHU2t2O6rJrLMHOkRc/ox+qkUmx+affcSZWuyywQF5GTO7nyv31gKpduvymU4Qxii+IPHee4+DjuE3HXkKnb/6ADMJSFLL7MAFh7mDvfYYlLBnTgc3PiiqLt/uv1KfNZ+a/kN8pX+MltSwLqIyMG3Dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYgtue5ALmZyrZ0qSvjVDjS0jeWW1DvnFGoTKM/dvxo=;
 b=UV8SbGzExRDyCOO0lppk7O6oEleGNh6+kN6dZaGbB1+75QQfRY4yhPoc0WW4seF7mMlpyUGHZOsQgRuB8zwaNgVt/kxZO48B13yMnXYKE/FwjnSOePQ7lFlhvrrlsOXJWVcQVnzfvUXKl3Rb2ZERouzn0kkYxLSAnBC8Nq5FswA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 13:07:55 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 13:07:55 +0000
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Julien Grall <julien.grall@arm.com>
References: <20200123203930.646725253@goodmis.org>
 <20200123203943.749508731@goodmis.org>
 <1a5e52a6-39e4-ac9a-e11a-5df261e83068@prevas.dk>
 <7fce15e17cd3bef1216473386718e3cfd67349a4.camel@kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <049616fa-8908-e845-057f-d9482a483597@prevas.dk>
Date:   Tue, 28 Apr 2020 15:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <7fce15e17cd3bef1216473386718e3cfd67349a4.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::28) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM7PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:20b:100::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 13:07:54 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df3f89bb-932b-454e-6abd-08d7eb752aa7
X-MS-TrafficTypeDiagnostic: VI1PR10MB3664:
X-Microsoft-Antispam-PRVS: <VI1PR10MB36646FFEF1CDADC25DED850093AC0@VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(136003)(39850400004)(36756003)(44832011)(16576012)(186003)(7416002)(26005)(478600001)(8676002)(2616005)(956004)(316002)(4326008)(66556008)(16526019)(66476007)(81156014)(2906002)(52116002)(5660300002)(8976002)(31686004)(66946007)(86362001)(110136005)(8936002)(54906003)(6486002)(31696002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQ+vRukWLkbOTcUJniu7VuHNZhz4sxUqQAhFqbYMLVF0+q6IBdjVOyqltFXYlmUlKkjUD2QXd3IG98bbE2/zknxkdIbTbNLKm3ZQ9SaEeeSCuxOi10Q1O48vA768ipxlLmWl/L+MpgVuUh1A7eB4DN9QY5e9zWHWA1MvVU5WtkBQ+v69hHHdmrVeWFh3/fIugFGayzpmFE87z6CYgyOVy96uwvF92gT9oJq27jxvdUkOvk9kcFN7dacieEghTRqZ12Q8dXOPkDNn5wMvc1PSsh/7Nb8Z0goB84N0+UWtiu8wVJYSqkyb6iep9u3ELesw5lKTBhsrWZJjb3HNVb6h3MlhnzNqAlYa5/2aHByIHBwJ6lv3AkGc9JE+gtqjkR924l11euXIhPVIs4ZzDM6HHTAmSfDAxTuuOYZ3/UckHWpwv/0VxfLp7IYtOE4/T7nT
X-MS-Exchange-AntiSpam-MessageData: GKJ7mpXZ6BbzHM28WvBkCPWLNMZ40WUSt0SJUIDBD2wR7dU+fzGO0ncI9je0YikWfBzTedi5hrTq7T1F5aqlMeXpAFnMb0OeFrn+MhugyHKjI1cAhvthyW1WG146n2IK79jlvLS4zzSPoZ63/hQizy9YOeIvnqaEuUXY2euhqf8gF6dCWAufK173IvqEuOZwdimkw9695EzVbuKRynTZQhZoAARxbhGeQJC3GCcurzMNn9OLnk33JzNyqyHlRbTJNJYeXGuB1r5czamyWhj/YasjcG2MYXuQlto/JRZYePc/ghooOEvFofljwk15MKVWz2UQKRJD83PZCBKnzjQsPbE1FgeuPAF+bLMqQWjFlCUlbEpP1J6SGMyLfZP8dIRn70Zl5t7J1o4kzm1+G7Fgp7ACgE/LxOAdChJ38PGIo2qC/TTLJgRhvbA/E8LvY8r8DbDOzGTl9y/Ve3Cho5/ToQT4c8qYZfsZw0iCfOCytk3DW7RcnthwMQH0vHj8whgPMmXA75KvrRF232XK+UqTuOp32v2hg2tRA0kPEptjHU8Cvs7wgmMfYmMnyWqBFDOT82DtkiCZl8T958psh1puXvdaGgAdJHt0NN3dt24X+jqbFKNWM7W8RQ414Ixx9lycM+6jCctJoSK1lZja8AD7wiJWZpKW0Po/ZmZOJhZVLb4wIrgk29HcdwNy4+d1gWYca65sTpFZJY13oaU5BNnxmBwcdC+LgaO1aAanxg0ae6kIHJRQYzSmmoSsSwKs5lXk/QZqICM29FWk/2pG/frpJvpKVWx57BUMmtmiMAM1a5A=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: df3f89bb-932b-454e-6abd-08d7eb752aa7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 13:07:55.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQzcumqelZ/pOGiqguznwXvXuO/BZjVWnkuI/6SyGGMT/neEYi+ft0wF914SeDRmaguB5W+LsvGvKf0hEhWbNFvX409tZL0TKZZifAulpmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 28/04/2020 14.59, Tom Zanussi wrote:
> On Tue, 2020-04-28 at 09:03 +0200, Rasmus Villemoes wrote:

>> Hold on a second. This patch (hrtimer: Prevent using
>> hrtimer_grab_expiry_lock() on migration_base) indeed seems to
>> implement
>> the optimization implied by the above, namely avoid the lock/unlock
>> in
>> case base == migration_base:
>>
>>> -	if (timer->is_soft && base && base->cpu_base) {
>>> +	if (timer->is_soft && base != &migration_base) {
>>
>> But the followup patch (hrtimer: Add a missing bracket and hide
>> `migration_base on !SMP) to fix the build on !SMP [the missing
>> bracket
>> part seems to have been fixed when backporting the above to 4.19-rt]
>> replaces that logic by
>>
>> +static inline bool is_migration_base(struct hrtimer_clock_base
>> *base)
>> +{
>> +	return base == &migration_base;
>> +}
>> +
>> ...
>> -	if (timer->is_soft && base != &migration_base) {
>> +	if (timer->is_soft && is_migration_base(base)) {
>>
>> in the SMP case, i.e. the exact opposite condition. One of these
>> can't
>> be correct.
>>
>> Assuming the followup patch was wrong and the condition should have
>> read
>>
>>   timer->is_soft && !is_migration_base(base)
>>
>> while keeping is_migration_base() false on !SMP might explain the
>> problem I see. But I'd like someone who knows this code to chime in.
>>
> 
> I don't know this code, but I think you're correct - the followup patch
> reversed the condition by forgetting the !.
> 
> So, does your problem go away when you make that change?

Yes, it does. (I'll have to ask the customer to check in their setup
whether the boot hang also vanishes).

Essentially, adding that ! is equivalent to reverting the two patches on
!SMP (which I also tested): Before, the condition was

  timer->is_soft && base && base->cpu_base

and, assuming the NULL pointer checks are indeed redundant, that's the
same as "timer->is_soft". Appending " && !is_migration_base()" to that,
with is_migration_base() always false as on !SMP, doesn't change anything.

Thanks,
Rasmus
