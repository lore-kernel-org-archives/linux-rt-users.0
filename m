Return-Path: <SRS0=SXCv=EB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE725C4363A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2C22400
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 10:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771833AbgJZKv1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Oct 2020 06:51:27 -0400
Received: from tux321.hoststar.ch ([136.243.22.237]:9210 "EHLO
        tux321.hoststar.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769869AbgJZKv0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Oct 2020 06:51:26 -0400
Received: from BillySurface (46-126-68-227.dynamic.hispeed.ch [46.126.68.227])
        (authenticated bits=0)
        by tux321.hoststar.ch (8.14.9/8.12.11) with ESMTP id 09QApOib032523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Oct 2020 11:51:24 +0100
From:   <dieter@bieler.li>
To:     <linux-rt-users@vger.kernel.org>
References: <006101d6ab85$88d32f70$9a798e50$@bieler.li>
In-Reply-To: <006101d6ab85$88d32f70$9a798e50$@bieler.li>
Subject: AW: Error-Report rt-tests
Date:   Mon, 26 Oct 2020 11:51:24 +0100
Message-ID: <007501d6ab85$f3369910$d9a3cb30$@bieler.li>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQ9DcvlKySq10ClPTTSgp0r/xIs6i1IiqAgAAA7vA=
Content-Language: de-ch
X-HS-BS-Header: D0/VHvWkDxko+hnx3Vdkug
X-Scanned-By: mimedefang-scanned
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hello,

I tried to compile the rt-tests-1.9 on my system:
Kernel - 5.4.70-rt40
Gcc : gcc cc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0

Error message:

'bld/cyclictest.o: `stderr@@GLIBC_2.2.5' can not be used when making a
shared object;
recompile with -fPIC

Any idea ?

Thanks
Dieter Bieler

