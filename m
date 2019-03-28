Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4B3C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F10720700
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 09:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1J37 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:29:59 -0400
Received: from mail.manjaro.org ([176.9.38.148]:45502 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfC1J36 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 05:29:58 -0400
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 05:29:58 EDT
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id E8E1630F2180
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2019 10:29:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aWi2UGUwN8ew for <linux-rt-users@vger.kernel.org>;
        Thu, 28 Mar 2019 10:29:55 +0100 (CET)
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Bernhard Landauer <bernhard@manjaro.org>
Subject: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
Date:   Thu, 28 Mar 2019 10:29:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The following happens only with Manjaro's rt patched version of linux50.
No issue with the regular version.

When firefox tries to recover tabs of a previous session, they crash.
Normal operation of firefox is not affected. Only these specific tabs
are broken.

Full journal with core dump here:

https://pastebin.com/W1mTnQ6N

kind gregards
Bernhard

