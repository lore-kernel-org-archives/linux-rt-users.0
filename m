Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE0C83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 07:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F25F206A5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 07:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="cxeQbMuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD1HDP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:03:15 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com ([40.107.8.103]:59277
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbgD1HDO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 03:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXAqeqTOZEO4tleXQP4Ehbsh+Cehk00pr91cWHOOoTtWSIWYRyixneRLNvwW4+923MF/ep41ZDt21REF1llOmlUkJhbQ/XMiUgA5RCj7hfZPicXDIZiHjx8W2HzgZ/9+448ACrUT4tWc29tCZehVuwuvL2N8ewS22UxzSaBSWmV7INXdKXF+CuvTaMfzVo48flF+mp/5+rjf0GkYZ3kMNDZzV7aJu0NWNr2Eb2M+8YybB6fTlVVe9RvaYPmaWauMqMDd537lDziK7kcC5G5oEaf/flea4Chpa2yD4P5r9tSHQTz6vGe+BuEmQ/CvL+4rI0xSuQIM32+bc/J3ryjwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijAOCe8U6hc6KJscqxtUgTFs3vEMqx/lAfnYru7ZgOs=;
 b=oQQEGYjB+/MpsEGykc/wLvBEYoKwdj+cOdC5E6DV13DMYMuyVKJs1m8hlCXch2g1RJVop+tuR5Sjvti2SkLoBdW6Sfq2LEaEg+ch36QUvXESO9FB5YJieZCnW1MefGprLS4eG08ea/Qe9CbdtbqSwabp2CSHu2uhrkYJnFCNrOmRQ10DAMMF9PtoQORXs20AZ2IuUAjJcbloez2nzskd6q2CUImArGPnIW7CnHh1xdzLCs0rYrnOLGBm/0iUI7BS0IIxdaZrRcpweQ1sjq7H8CNrVCeRly+712diTrOZmZYqVYBFHP4V84YCKvJw3/RgMGnz82y3hcPxDQOtNzPZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijAOCe8U6hc6KJscqxtUgTFs3vEMqx/lAfnYru7ZgOs=;
 b=cxeQbMuCQkt6wc9J/XOX2dM0N4/7iUg/q4Dgi3jVe/vTN5/7UzIGbwMbFpYILjHFxqgfRYoq5QTqaihF6jm+fMp05O9lZVjBRCJ6yUcusTSDp+WxIRfg/zSBt/rstrTpWxyKAH91lGzEHxUG+6jKVjfGbn6D3itvt13K7CBMaM4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB2606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 07:03:11 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 07:03:11 +0000
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julien Grall <julien.grall@arm.com>
References: <20200123203930.646725253@goodmis.org>
 <20200123203943.749508731@goodmis.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <1a5e52a6-39e4-ac9a-e11a-5df261e83068@prevas.dk>
Date:   Tue, 28 Apr 2020 09:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200123203943.749508731@goodmis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::49) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM6PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:20b:92::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 07:03:10 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a4c24f-f622-45e2-9fb5-08d7eb4236b1
X-MS-TrafficTypeDiagnostic: VI1PR10MB2606:
X-Microsoft-Antispam-PRVS: <VI1PR10MB2606C576E3B81D70EF02E72993AC0@VI1PR10MB2606.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(366004)(39850400004)(376002)(5660300002)(478600001)(956004)(2616005)(26005)(81156014)(6486002)(8676002)(4326008)(44832011)(86362001)(31696002)(52116002)(7416002)(54906003)(8936002)(31686004)(2906002)(66946007)(186003)(66556008)(66476007)(36756003)(16526019)(16576012)(110136005)(316002)(8976002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foXKJ59VW1tLc4Txr1IeIFcCTy6ymIT/qlruPumPzcCUPtXrrKaSa87bEqTgFla55vL//n7DyJBZo53HLmfCSGwZ/LQe6Aev+WLGQR2XbHq9iHH0wS73xMr1T/aIf2x1WCc3AXKjmPATBjS75BHyrAxEO9PUQHeEGucbTq4CyjYGQE7Cu6vcM4IGV5fj1kLa4o98TVNI41PMn1vwRcHny4c1VKH9go7vbosYDFYUBpqV45/usjtTvu+T/c4JtLptGy5Wrp5jZWhEcyabMo+yCnkpnC2tfb3PwB0JSj2dC0CFpp6kGr3+7RU848sdmeg/fCO2mYRWlkMF38xttLvrv3BJ9xAuD3sGXgf62FBU3P6l/gaqkFvGPuQHVBoSe+RSTk+zpdnDyEa0n0/lA3IvV2sAYBVn7pmFsVtFoq+ks4EKOt5rFla3piaSjIDhR/3c
X-MS-Exchange-AntiSpam-MessageData: g0BNCR/xF3rb2PIubZuHSpUjKMBx9BLRqwW5rq9Qvst1/8HHxxgdsEarItxIF1sb8EykoSEmcWuGgSNQZaMLgGbUOR4OFj/cSyo3zREPl4BjnDibIa925vRGqe3EVltEj/biOV6z0m3Dou3fAjSn8RJPzUA/pPyz7x9UgtciEa/TbMSgTc6KXA5xxQH0CKZfzGzY0JgvGH3Rj2jdFP7JuYGixLxZ4D9YK1/sJjGJ7QOpWNSHx4F5THUYIaUneXOT37oHIFsycJeOzL5xnMWnaTKKv+tdfrAnMAu+0AWmCzHPQxf+W/UVnEXtE7HqKCkly5krl10PdfPrMkLpWP0EPzu1gV3vT+1B84627iHXiBAcFLZQ00wRtj5AymH2tkb52aeL0rVaSojuhj9DOysnRGVL55obOvfEomzlIveaDQCA3GIKttMrbeS5TPFK3Xrcq9pmKDwgU/hNPnbaef73x22uuffd4rc75VFddZs22Cp/9q6Y+1v52nU4no4b2OABx7o/KylT1FSOqDQd4BVU34h1YHEFtfDQhNaw/A1T0vRkYWXI3EZbZx4LkXv//bEEeeWOrT3MST/La5jL4mQ/1S/UXNeCu3j029djoEah6gGxxvqwh/7O/l9nPq3JDr85yBJJPmDclOkQsLatncqs7gEJw+9kK3ozsb8RDC5oMitzYhq49GYwa/V/6B+s4ETGDPNq2J4ZIoD5EL0NP11b/WOIpeMywwsJH+0hAQ1YAsZ2+6BFYA1T2GPh2wVKr9RTB9MwAtI+JtXhsiUNQb/aHRQpQs2Ugf+OPHAMfgq6eSw=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a4c24f-f622-45e2-9fb5-08d7eb4236b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:03:11.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTGRhDEuI6UpWUa0tJ2EQU00655Kp73gc5bc9e6nKZuQpc1+ojrCo5m1xz0+aHJiR86R+RovWAyWEQpga9o08rTMKlEYsZLHgtVsM5IHQes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2606
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 23/01/2020 21.39, Steven Rostedt wrote:
> 4.19.94-rt39-rc2 stable review patch.
> If anyone has any objections, please let me know.
>
> ------------------
> 
> From: Julien Grall <julien.grall@arm.com>
> 
> [ Upstream commit cef1b87f98823af923a386f3f69149acb212d4a1 ]
> 
> As tglx puts it:
> |If base == migration_base then there is no point to lock soft_expiry_lock
> |simply because the timer is not executing the callback in soft irq context
> |and the whole lock/unlock dance can be avoided.

Hold on a second. This patch (hrtimer: Prevent using
hrtimer_grab_expiry_lock() on migration_base) indeed seems to implement
the optimization implied by the above, namely avoid the lock/unlock in
case base == migration_base:

> -	if (timer->is_soft && base && base->cpu_base) {
> +	if (timer->is_soft && base != &migration_base) {

But the followup patch (hrtimer: Add a missing bracket and hide
`migration_base on !SMP) to fix the build on !SMP [the missing bracket
part seems to have been fixed when backporting the above to 4.19-rt]
replaces that logic by

+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+
...
-	if (timer->is_soft && base != &migration_base) {
+	if (timer->is_soft && is_migration_base(base)) {

in the SMP case, i.e. the exact opposite condition. One of these can't
be correct.

Assuming the followup patch was wrong and the condition should have read

  timer->is_soft && !is_migration_base(base)

while keeping is_migration_base() false on !SMP might explain the
problem I see. But I'd like someone who knows this code to chime in.

Thanks,
Rasmus
