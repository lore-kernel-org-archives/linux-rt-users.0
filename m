Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37374C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084602184C
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfC1WSP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:18:15 -0400
Received: from mail.manjaro.org ([176.9.38.148]:42096 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfC1WSP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 18:18:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id F33D530F3988;
        Thu, 28 Mar 2019 23:18:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KjKbJlh1UBWE; Thu, 28 Mar 2019 23:18:11 +0100 (CET)
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
 <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de>
From:   Bernhard Landauer <bernhard@manjaro.org>
Message-ID: <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
Date:   Thu, 28 Mar 2019 23:18:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190328120022.bhwijbp2roizysiw@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> and check dmesg if the kernel says anything out of the ordinary after
the crash?

This is all I got. Not sure that this will help in any way ... ;)

[   38.970923] audit: type=1131 audit(1553811118.623:61): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   71.377402] audit: type=1701 audit(1553811151.165:62): auid=1000
uid=1000 gid=1000 ses=2 pid=1692 comm=57656220436F6E74656E74
exe="/usr/lib/firefox/firefox" sig=8 res=1
[   71.426246] audit: type=1130 audit(1553811151.215:63): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@0-1936-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   72.892044] audit: type=1131 audit(1553811152.679:64): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@0-1936-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   74.147791] audit: type=1701 audit(1553811153.937:65): auid=1000
uid=1000 gid=1000 ses=2 pid=1902 comm=57656220436F6E74656E74
exe="/usr/lib/firefox/firefox" sig=8 res=1
[   74.164974] audit: type=1130 audit(1553811153.953:66): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@1-2016-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   75.691743] audit: type=1131 audit(1553811155.481:67): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@1-2016-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   82.813829] audit: type=1701 audit(1553811162.608:68): auid=1000
uid=1000 gid=1000 ses=2 pid=1981 comm=57656220436F6E74656E74
exe="/usr/lib/firefox/firefox" sig=8 res=1
[   82.830137] audit: type=1130 audit(1553811162.624:69): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@2-2096-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   84.831242] audit: type=1131 audit(1553811164.622:70): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@2-2096-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   90.422327] audit: type=1701 audit(1553811170.217:71): auid=1000
uid=1000 gid=1000 ses=2 pid=2038 comm=57656220436F6E74656E74
exe="/usr/lib/firefox/firefox" sig=8 res=1
[   90.439593] audit: type=1130 audit(1553811170.237:72): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@3-2147-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   91.920716] audit: type=1131 audit(1553811171.717:73): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@3-2147-0
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'

Recently there were several systemd updates via Archlinux - maybe this
could be related. However, as I said before, this issue is not present
with 4.19-rt

regards
Bernhard

