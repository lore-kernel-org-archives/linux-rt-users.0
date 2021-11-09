Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6407BC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 02:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C022619E4
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 02:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhKICjD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:39:03 -0500
Received: from slip.yi-enter.com ([178.79.146.7]:58930 "EHLO slip.yi-enter.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238593AbhKICjD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Nov 2021 21:39:03 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 21:39:03 EST
Received: from localhost (localhost [127.0.0.1])
        by slip.yi-enter.com (Postfix) with ESMTP id A841763B5
        for <linux-rt-users@vger.kernel.org>; Tue,  9 Nov 2021 10:26:48 +0800 (CST)
X-Virus-Scanned: amavisd-new at yi-enter.com
Received: from slip.yi-enter.com ([127.0.0.1])
        by localhost (slip.yi-enter.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vCR3tqca6j_x for <linux-rt-users@vger.kernel.org>;
        Tue,  9 Nov 2021 10:26:48 +0800 (CST)
Received: from across.yi-enter.com (unknown [47.75.127.17])
        by slip.yi-enter.com (Postfix) with ESMTPS id 7091D63B4
        for <linux-rt-users@vger.kernel.org>; Tue,  9 Nov 2021 10:26:48 +0800 (CST)
Received: from run.intel-email.com (run.intel-email.com [101.227.64.242])
        by across.yi-enter.com (Postfix) with ESMTPS id 44A38E3572
        for <linux-rt-users@vger.kernel.org>; Tue,  9 Nov 2021 10:27:45 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by run.intel-email.com (Postfix) with ESMTP id EFA373FFC8C5;
        Tue,  9 Nov 2021 10:27:42 +0800 (CST)
X-Virus-Scanned: by SpamTitan at intel-email.com
Received: from run.intel-email.com (localhost [127.0.0.1])
        by run.intel-email.com (Postfix) with ESMTP id 9DB813FFC8C3;
        Tue,  9 Nov 2021 10:27:42 +0800 (CST)
Authentication-Results: run.intel-email.com; none
Received: from FZEX5.ruijie.com.cn (unknown [120.35.11.195])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by run.intel-email.com (Postfix) with ESMTPS id 9C0EE3FFC8B8;
        Tue,  9 Nov 2021 10:27:39 +0800 (CST)
Received: from FZEX6.ruijie.com.cn ([fe80::81ab:68a2:5882:ab67]) by
 FZEX5.ruijie.com.cn ([fe80::f133:c96b:b8b4:690f%20]) with mapi id
 14.03.0123.003; Tue, 9 Nov 2021 10:27:39 +0800
From:   =?gb2312?B?0+C7qrH4KNHQt6KyvyC4o9bdKQ==?= <yhb@ruijie.com.cn>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: A question about the PREEMPT_RT patch set
Thread-Topic: A question about the PREEMPT_RT patch set
Thread-Index: AdfVEVyMHI1fNucARRWKID9r18uV/A==
Date:   Tue, 9 Nov 2021 02:27:37 +0000
Message-ID: <80B78A8B8FEE6145A87579E8435D78C3023AB9B631@FZEX6.ruijie.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.32.135]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGVsbG8sIGV2ZXJ5b25lLg0KSSBoYXZlIGEgcXVlc3Rpb24uIElmIEkgYXBwbHkgdGhlIFBSRUVN
UFRfUlQgcGF0Y2ggc2V0IHRvIHRoZSBMaW51eCBrZXJuZWwsIGlzIHRoZSByZWFsLXRpbWUgc3Vw
cG9ydGVkIGJ5IHRoZSBrZXJuZWwgaGFyZCByZWFsLXRpbWUgb3Igc29mdCByZWFsLXRpbWU/DQo=
